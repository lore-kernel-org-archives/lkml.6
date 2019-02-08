Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034F2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C271421916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XmxtA2G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBHJAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:00:10 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51686 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfBHJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:00:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x188xlm3020331;
        Fri, 8 Feb 2019 02:59:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549616387;
        bh=JAWoQZj8VTQbstjNpUCEMX9WOMSN1nX/HpEhdRFugUc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XmxtA2G8N5r8Mz4zK1bzBsTxLjBdYUXR2MfNjU+KGDUsAc3/quYQLGmeDQaMCOX8U
         Py+H8VT42mbyiT53+w77HaP8/usaH+W1PtzKaCEWLMUsmpMenBOaygxqQPRe/wW6it
         rj9insuXxELin5ZjQVa5GT0ey9edny3XcVpx2wnI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x188xl2F064238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 02:59:47 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 02:59:46 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 02:59:46 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x188xhso017135;
        Fri, 8 Feb 2019 02:59:44 -0600
Subject: Re: [PATCH 02/35] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-3-brgl@bgdev.pl>
 <eb09a892-d965-3ee2-dfe7-2dcbbcb03791@ti.com>
 <CAMRc=Me9gqfN6WuWPZ61M2pNC+ZrhxAX_=BzAr4_zxnfdL4G7Q@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <7f5206ea-ad18-86c2-f9f0-3fccaf4932e9@ti.com>
Date:   Fri, 8 Feb 2019 14:29:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me9gqfN6WuWPZ61M2pNC+ZrhxAX_=BzAr4_zxnfdL4G7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/19 9:19 PM, Bartosz Golaszewski wrote:

>>> +static asmlinkage void __exception_irq_entry
>>> +cp_intc_handle_irq(struct pt_regs *regs)
>>> +{
>>> +     int irqnr = cp_intc_read(CP_INTC_PRIO_IDX);
>>> +
>>> +     irqnr &= 0xff;
>>> +
>>> +     handle_domain_irq(cp_intc_domain, irqnr, regs);
>>
>> This leaves out spurious interrupt handling present in existing assembly
>> code. Can you add it back. May be use omap_intc_handle_irq() as an
>> example for handling spurious IRQs.
>>
> 
> Hi Sekhar,
> 
> I started looking at this one and noticed that the manual says
> PRI_INDX field in the GPIR register is in bits 0-9 (mask 0x3ff) while
> the assembly logically ANDs it with 0xff. I guess it's because there
> can be no more interrupts than 255 but I'd at least explain it in a
> comment. Or should we use the proper mask? What do you think?

I think using mask 0x3ff to match TRM is fine.

Thanks,
Sekhar
