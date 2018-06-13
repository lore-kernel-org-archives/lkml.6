Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8E3BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97726208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QFwv1SPv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IaHV8t+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97726208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936048AbeFMPuW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:50:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935934AbeFMPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:50:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27731606DB; Wed, 13 Jun 2018 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528905020;
        bh=uSFpwtQeOADiMEBtPARH98n2+Mzgx75rAUZiOIManH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QFwv1SPvDwwrEY8XI9K/l20Ea0tvE4lUb1kZzyRloYOIB15ewvjDCKcY7eVqmU0ce
         ae/PP1IyZolaGhn2nuNeB+cbYGtakW9e8wudghr/vV9zXpyvC56LeGEKd6VKVrBX5I
         tVysHCPCfvyJjJ26oOAuFJDbpO50zkiFbVeIftz8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 19F0360791;
        Wed, 13 Jun 2018 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528905019;
        bh=uSFpwtQeOADiMEBtPARH98n2+Mzgx75rAUZiOIManH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IaHV8t+xp8IQOHQ9aCZ7fqw9/7h/ZwnQ31EqYZmDsiX6Eun/rBYgbop/hZVcsdhSS
         IdkNMS4T1OaS2k29uuIJbaXH9HZBDqkqr0aH0rqMN3j6uD1ixvCjUVACpo7V1vHds9
         D7odUvPjiturozVcdlnnA6m/rLwBZCwoHR55wRlU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jun 2018 11:50:19 -0400
From:   okaya@codeaurora.org
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
Message-ID: <7481eea5c856bf0a285776e28a2c3ce1@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-13 11:45, Ard Biesheuvel wrote:
> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
>> A host bridge is allowed to remap BAR addresses using _TRA attribute 
>> in
>> _CRS windows.
>> 
>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff 
>> window] (bus address [0x00100000-0x1fffffff])
>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>> 
>> When a VGA device is behind such a host bridge and the resource is
>> translated efifb driver is trying to do ioremap against bus address
>> rather than the resource address and is failing to probe.
>> 
>> efifb: probing for efifb
>> efifb: cannot reserve video memory at 0x1e000000
>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>> efifb: mode is 800x600x32, linelength=3200, pages=1
>> efifb: scrolling: redraw
>> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>> 
>> Use the host bridge offset information to convert bus address to
>> resource address in the fixup.
>> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Bartlomiej, could you please take these via the fbdev tree for v4.19?
> Peter already gave his ack but Sinan dropped it (presumably because of
> the split in v2)
> 
> Sinan, does this need to go to -stable? I.e., has it ever worked 
> before?
> 

Yes, it needs to go to stable. It never worked before. Issue was found 
during a graphics bring up with AST driver.

It needs a 32 bit graphics card and a 32 bit translating host bridge to 
hit the issue.

> 
> 
>> ---
>>  drivers/video/fbdev/efifb.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
>> index 6daac8d..429cc85 100644
>> --- a/drivers/video/fbdev/efifb.c
>> +++ b/drivers/video/fbdev/efifb.c
>> @@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev 
>> *dev)
>>                 .end = screen_info.lfb_base + screen_info.lfb_size - 
>> 1,
>>                 .flags = IORESOURCE_MEM,
>>         };
>> +       struct pci_bus_region region;
>>         int i;
>> 
>>         if (efifb_pci_dev || screen_info.orig_video_isVGA != 
>> VIDEO_TYPE_EFI)
>> @@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev 
>> *dev)
>>         if (!screen_res.start)
>>                 return;
>> 
>> +       region.start = screen_res.start;
>> +       region.end = screen_res.end;
>> +       pcibios_bus_to_resource(dev->bus, &screen_res, &region);
>> +
>>         for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>>                 struct resource *res = &dev->resource[i];
>> 
>> --
>> 2.7.4
>> 
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
