Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEFAC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395DE21716
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vdZfokMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395DE21716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeHNVft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:35:49 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:21342 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:35:49 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D3604445D3;
        Tue, 14 Aug 2018 20:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-language:content-transfer-encoding:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received; s=mail20150812; t=
        1534272436; bh=nX/6ICXl/UtlfzuL1QZIfQWUE2gzseJ9PaZpgUwC0RE=; b=v
        dZfokMsSq2g3gvi6oHYv6bWPpSUPd4+m+ikMTAHBJ0/JlsgHPug2IP5BYS4BUq6l
        NiL0ZsUW5uFmOQQJzuiyt+YXSNPw/OIViMBj7RuRiFQ20kath1xNvpReOPzUZ/2p
        lKk1YCFOfXwC0VtudkbRQM6Rh1usLTLOUNTTVklfzoj3f7ANQ/zahU/9pDpaFGL1
        exnMj89PyMN9UKoUaYRk8ksMBEZEiCm2eiYbD4PTz/UxMxZ37JJItQKOBJXtJ9hL
        pdy4oHSTwomHwaIPVFlxn4mL8O6gAxNmICZJHwBIHMsDs6XgyNOf91HTzNzyI1zN
        i16zs/3B8OBjUdNpfVlgQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 3fHQsjp5lCLT; Tue, 14 Aug 2018 20:47:16 +0200 (CEST)
Subject: Re: PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180813194123.GM113140@bhelgaas-glaptop.roam.corp.google.com>
 <20180814141926.GP113140@bhelgaas-glaptop.roam.corp.google.com>
From:   =?UTF-8?Q?Felix_Bl=c3=bcthner?= <f.bluethner@mailbox.org>
Openpgp: preference=signencrypt
Message-ID: <540cd923-51b4-ff3e-ffd5-a642400ec22a@mailbox.org>
Date:   Tue, 14 Aug 2018 20:47:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180814141926.GP113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I can confirm that patch. It is the same change I already compiled
and installed and is running on my system successfully.

> On Mon, Aug 13, 2018 at 02:41:23PM -0500, Bjorn Helgaas wrote:
>> Hi,
>>
>> Thanks a lot for your new report
>> (https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134).
>>
>> Can you confirm that the patch below is equivalent to what you tested and
>> it resolves the problem?  If so, I'll try to include it for v4.19.
> I applied this to pci/virtualization for v4.19.  Please let me know if you
> see any issues.
>
>> commit dd4e0ad485e12c9c04eb7a21ba69c24f12cb1918
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Mon Aug 13 14:30:41 2018 -0500
>>
>>     PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
>>     
>>     Add function 1 DMA alias quirk for Marvell 88SS9183 PCIe SSD Controller.
>>     
>>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134
>>     Reported-by: <f.bluethner@mailbox.org>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index deb051583eda..6994544125ff 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3845,6 +3845,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x917a,
>>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78 */
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
>>  			 quirk_dma_func1_alias);
>> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134 */
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
>> +			 quirk_dma_func1_alias);
>>  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
>>  			 quirk_dma_func1_alias);

