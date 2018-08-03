Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33997C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3678217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd5q057x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3678217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeHCVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:23:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45150 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHCVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:23:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so6329198wrv.12;
        Fri, 03 Aug 2018 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dlz1x/iM4fVWwTa/+a6McN7Rcq0IxAXef7zzJjn2Enk=;
        b=sd5q057xUyliVGb3GFhDWE6qnFLegEAQcN6F52CHfBUiwYnhI/ZZ+UkqUNPOhXIdS5
         snlsGTymq8i3xk23kihAuN+lBz/YyBaxSmHMQcRiOwjowlNm5t3/g5YUDbQOoBhXRix6
         SfiVOPG4PPsXm5MA2WNNgWG/F3BLlH0aG2X2AtGRjjMzX0T0Qe2ILKxuzQWl87p+IwgW
         2Sbmls6xmzr9vmh5Ka0kwYkVcyld/I79w1fLkXuXLpTNOcQhnh0Z+7DQ0MiRatpie079
         BMwi/qk+3Hxk3WCDmaMaZEOCWr0qtUAxv5QCSeWL5o2R3Ixi8fRofCIadgbyknlzp+U4
         SLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dlz1x/iM4fVWwTa/+a6McN7Rcq0IxAXef7zzJjn2Enk=;
        b=OyRJQCisTGschxF02ehsyZ1SJYNcAX3aEfRyvg6XDR8rn+2pa9P+9sWM9AzWUEGU7u
         JFQsXN1Ltd7l9oqgL5bmZOsLrDYAJzi2MofPpH7d56NzL7OSW0x3AT8SdndHNn+HhSeZ
         3XmBrQBhHhRGKIfUYoqZD88UJzQVak1vjoxicIdSmORsK2l1lkCFJl1igEllHE5U5sXL
         y8a/y0FGJ5hYjkN6jCHlBGI0rjrBI+kyPkNZJEE31NPHn2nl/IV3NmzZoid82hWHiF7r
         DaHjy4eMEgluXDvCatoQf3eyiiaQJZWm5WgNXTGedmkAbKUdbch55/e0n/btBlLIQKNN
         3dXw==
X-Gm-Message-State: AOUpUlE4Tw1Rk8fbsYXl013MuY6osbraxKk0MZY7URHGY3Mhm5T/AvN9
        6CmXgNym0+SSJyhhWiCKsVFkypJ1
X-Google-Smtp-Source: AAOMgpfeUqwW+7kSEiLTesyDowGDKP+K3+767HxN4ETLs0cliE7WaqV2EYPPrhoDko/fBt7sxkNAYw==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr3375844wrd.218.1533324334418;
        Fri, 03 Aug 2018 12:25:34 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id j9-v6sm7940541wrv.5.2018.08.03.12.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 12:25:33 -0700 (PDT)
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de>
 <86d0v4x75x.wl-marc.zyngier@arm.com>
 <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
 <alpine.DEB.2.21.1808031605160.1745@nanos.tec.linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <420d6476-8ea4-0b37-e94a-f5842b7b0ff7@gmail.com>
Date:   Fri, 3 Aug 2018 21:25:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808031605160.1745@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2018 16:09, Thomas Gleixner wrote:
> On Wed, 1 Aug 2018, Heiner Kallweit wrote:
>> On 31.07.2018 08:15, Marc Zyngier wrote:
>>> On Mon, 30 Jul 2018 23:36:57 +0100,
>>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> Yes, request for pure threaded interrupts are rejected if the oneshot flag
>>>> is not set. The reason is that this would be deadly especially with level
>>>> triggered interrupts because the primary default handler just wakes the
>>>> thread and then reenables interrupts, which will make the interrupt come
>>>> back immediately and the thread won't have a chance to actually shut it up
>>>> in the device.
>>>>
>>>> That made me look into that code again and I found that we added a flag for
>>>> irq chips to tell the core that the interrupt is one shot safe, i.e. that
>>>> it can be requested w/o IRQF_ONESHOT. That was initially added to optimize
>>>> MSI based interrupts which are oneshot safe by implementation.
>>>>
>>>>   dc9b229a58dc ("genirq: Allow irq chips to mark themself oneshot safe")
>>>>
>>>> The original patch added that flag to the x86 MSI irqchip code, but that
>>>> part was not applied for reasons which slipped from memory. It might be
>>>> worthwhile to revisit that in order to avoid the mask/unmask overhead for
>>>> such cases.
>>>
>>> Yup, that would actually be beneficial to a range of interrupt
>>> controllers (only an obscure GPIO driver makes use of this flag).
>>>
>>
>> I'm not an expert on that area, but if MSI is oneshot-safe in general,
>> then we could do the following in the framework instead of touching
>> every MSI irq_chip. Opinions?
>> I tested on X86 and at least my system is still running.
>>
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index 4ca2fd46..ba6da943 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>>         if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>>                 msi_domain_update_chip_ops(info);
>>
>> +       /* MSI is oneshot-safe in general */
>> +       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
>> +
>>         domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
> 
> Looks about right, though there might be dragons. MSI is not always as sane
> as it should be...
> 
When saying "MSI isn't always sane", are you referring to the hardware or
the controller driver implementation? Basically for me the question is
whether we would be able to fix the issue if we meet such a dragon,
or whether we would have to revert the change.
Do you think the chance of a dragon is low enough? Or better add the
flag only to the X86 PCI MSI irqchip for now?

>>> We could also consider extending this to support interrupt
>>> hierarchies, as __setup_irq() seems only concerned with the top of the
>>> stack (an IRQ provided by a generic MSI stack and backed by an irqchip
>>> providing IRQCHIP_ONESHOT_SAFE would go unnoticed).
>>>
>>
>> Would it be sufficient if one irq_chip in the hierarchy is oneshot-safe?
>> Or what do we have to check for?
> 
> I think the top most chip is the key, the rest of the hierarchy is
> irrelevant because the top most chip is the one which is responsible for
> not creating an interrupt storm after the interrupt got acknowledged.
> 
Thanks for the explanation, then I'll submit a patch implementing
this logic.

> Thanks,
> 
> 	tglx
> 
Heiner
