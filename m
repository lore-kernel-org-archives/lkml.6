Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94420ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WD+yklOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D3F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeGRRKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:10:41 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35793 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbeGRRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:10:40 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so4605773iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I+XZstefw372I4vobdJVu6/m2CQpr2IFrQMfX+PGqgg=;
        b=WD+yklOCmwQmLnHKmFYJNoHQ3VMNLEYoAi9r3zKWrONCBpKmJE4NaQjXA+M9/osEI9
         7IRGEPWsWBtjCfMrLtDorHWtYqo3Lq3xb09hnCotpCSXc8PAvHt5/ItaoQvE4i5TVICY
         nyxNnvlHqpltk17QVT3XF3AtiXU/UGYZR/ZfdgVuveOCYvcRZMT94597hhUZtvRQzbT9
         KVTO1tjX0tcR8OGpSUZk2KYr+IcMJhRvgKepEXniFuKZNRLjZbvL03elSchzSm5bqzb4
         cgjv8lVh4tKVsTyzK2bTEV0UzWGnZdnNQFtZ9Lk5MQGuPhtd6/fseUFvzpbT29YaztBw
         kA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I+XZstefw372I4vobdJVu6/m2CQpr2IFrQMfX+PGqgg=;
        b=lopi6vFU8Bvf2p+kgaDNG3LkFnn4t9Je3iewIefRSIi+c+nR3mc/mTvMjipBwZ8XgS
         +0xXbDhdp/B2IFa9ybVrO93wlLdzi9Ox7O03xmzEXdx2p7DMu83YZ3hV3nFH1US/YgSO
         XHIDeSFBSSHnxAggebCIOUTuy2aSVID5cECVfnWkL8BJgWZAusY41eMpLey4vzGsGbEg
         CnXVat4GBX2zd6WO/+gX6eUUbtDVworxQik2HpfJLCR6Ju+ZFz1FfQrqIA/3WFOIFRRa
         bFfxLqtZ5BxD9IJq6xQl3/rWgE8YBvrs0ybHTYj9G0eeL1uagmCDEyTEoSLF+aSWRq88
         PEhg==
X-Gm-Message-State: AOUpUlGHNjs03O/ipPW87/t2EEA7kJoneALtH8nlVGDRdEwKprGCLFOr
        R2bdfA5iaxHKGsz12H+fnkb6gcUpZGAlYZ/VbU2Gww==
X-Google-Smtp-Source: AAOMgpftkyM09gKrdL4HIKSZVr7/BDadkZ9gRIBUvYrOYftaLsZBmuf0yjs/srXf48kwLhMAvY3o2hIIbTGZnG1r6z0=
X-Received: by 2002:a5e:8d07:: with SMTP id m7-v6mr5461953ioj.258.1531931519153;
 Wed, 18 Jul 2018 09:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 09:31:58
 -0700 (PDT)
In-Reply-To: <20180718162849.GA12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-2-brgl@bgdev.pl>
 <20180718162849.GA12477@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jul 2018 18:31:58 +0200
Message-ID: <CAMRc=Mfsty0Yd5X=MkyxzG=_QGwXQbGinrFhO-3tnXcf76gc1A@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-18 18:28 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Jul 18, 2018 at 06:10:31PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Initialize the variables with proper values so that we save a few
>> lines of code before we extend this function in the follow-up patches.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  net/ethernet/eth.c | 11 +++--------
>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
>> index ee28440f57c5..da8530879e1e 100644
>> --- a/net/ethernet/eth.c
>> +++ b/net/ethernet/eth.c
>> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>>
>>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>  {
>> -     const unsigned char *addr;
>> -     struct device_node *dp;
>> +     struct device_node *dp = dev_is_pci(dev) ?
>> +                     pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
>> +     const unsigned char *addr = NULL;
>
> Hi Bartosz
>
> You are now in the net subsystem, which has its own set of additional
> coding styles. One of them is reverse Christmas tree.
>
> You might want to read Documentation/networking/netdev-FAQ.txt.
>
>     Andrew

Hi Andrew,

it's still reverse Christmas tree in this patch except that now we're
taking the length of the variable + initializer into account. I'm not
sure if this is the right approach though.

Bart
