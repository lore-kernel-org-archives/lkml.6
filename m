Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA36208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obuaNg7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA36208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbeHAVio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:38:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52048 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbeHAVio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:38:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so309516wma.1;
        Wed, 01 Aug 2018 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j0QRR86L7oCVUrR+roc/tA7tGOwILsPWOGSuRDSEF00=;
        b=obuaNg7+wOQ1pfTqxdyFev3+ecngkK3l/e/em6rNTLpHAYPNrnhvD3kFygPc4aNRMx
         3RNI0dU6NsKkCdKjC52lNpuOUm2En1vH1r4HUnbyw+6V7nPxbwVKjlzApKorVstBXyRf
         g1nNti01d43ENbG3fbcmYevB5P5fJO5nSkY6JvXCWNxWFvJsDxe00ojQ53tq9kevu1qN
         pEaXyUYacReM1siDw3ueKYW9S02bP2rBhueI2Rk/OeZsn9P5lYM5FpAcrwlqli/Kxv61
         MPiGMpr/AMEMl8kJsLg5eMxK+GRuMMajbx9MqovHJoHHwoWHD4id8Ce2a9b2VAG0KYDF
         fNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0QRR86L7oCVUrR+roc/tA7tGOwILsPWOGSuRDSEF00=;
        b=mgCpuh5uTXzDnZkME/j0WCcpuE+SJZmvUx4No1LgdKlkXpMz9hY45rO+83XukO8ZGd
         aCoPhUQu8YeHRbIKufgxAIKcuwcvF23foWJaAEltzotd/zCuGCQIJz6bvNxozQCOHGAq
         7fWr6cipBIBXLhJbwcDKgtXRmJUBbAR4ANlR/K0TR+APtSd21fjNGOxdXP9qhN2bfeXI
         in57WwcoQaXVIS4Rqbb3TmZO6uynABUM/p551rjPuE/g/gdOcO95AluC4Zux+d4Q5kMc
         03nbcr/BweT3FemTXzn1s/XZMtDwv4FvwBsZkEdR5Wlpfdorc4MaxDDOvzioWU8t572i
         Y1yw==
X-Gm-Message-State: AOUpUlFC+GPO5o1w9Kbm5vc1bOjQtDPxtDMupB7LHKaEDZKdzbaMwzYt
        fbfXJFOFteRu2Dj24qtuSzKiDE9g
X-Google-Smtp-Source: AAOMgpczHl7C7TYgted8kOka6jtW9hzJUpQBPssyDQmLen1BzR0HVlpsQoz69g09GaJzPiUl2kK3bg==
X-Received: by 2002:a1c:1314:: with SMTP id 20-v6mr151899wmt.55.1533153079160;
        Wed, 01 Aug 2018 12:51:19 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:e9ad:b33f:f5be:2cd2? (p200300EA8BD4D600E9ADB33FF5BE2CD2.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:e9ad:b33f:f5be:2cd2])
        by smtp.googlemail.com with ESMTPSA id y11-v6sm8501wrt.4.2018.08.01.12.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 12:51:18 -0700 (PDT)
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.21.1807310015170.1725@nanos.tec.linutronix.de>
 <86d0v4x75x.wl-marc.zyngier@arm.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0799ea22-70ed-3be6-cb80-449f53fef819@gmail.com>
Date:   Wed, 1 Aug 2018 21:51:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <86d0v4x75x.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.2018 08:15, Marc Zyngier wrote:
> On Mon, 30 Jul 2018 23:36:57 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, 30 Jul 2018, Bjorn Helgaas wrote:
>>
>>> [+cc Thomas, Christoph, LKML]
>>
>> + Marc
>>
>>> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>>>> If we have a threaded interrupt with the handler being NULL, then
>>>> request_threaded_irq() -> __setup_irq() will complain and bail out
>>>> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>>>> being NULL and set IRQF_ONESHOT in this case.
>>>>
>>>> This change is needed to migrate the mei_me driver to
>>>> pci_alloc_irq_vectors() and pci_request_irq().
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
>>> usage isn't mentioned in the request_threaded_irq() function doc or
>>> Documentation/
>>
>> Right. The documentation really needs some love and care. :(
>>
>> Yes, request for pure threaded interrupts are rejected if the oneshot flag
>> is not set. The reason is that this would be deadly especially with level
>> triggered interrupts because the primary default handler just wakes the
>> thread and then reenables interrupts, which will make the interrupt come
>> back immediately and the thread won't have a chance to actually shut it up
>> in the device.
>>
>> That made me look into that code again and I found that we added a flag for
>> irq chips to tell the core that the interrupt is one shot safe, i.e. that
>> it can be requested w/o IRQF_ONESHOT. That was initially added to optimize
>> MSI based interrupts which are oneshot safe by implementation.
>>
>>   dc9b229a58dc ("genirq: Allow irq chips to mark themself oneshot safe")
>>
>> The original patch added that flag to the x86 MSI irqchip code, but that
>> part was not applied for reasons which slipped from memory. It might be
>> worthwhile to revisit that in order to avoid the mask/unmask overhead for
>> such cases.
> 
> Yup, that would actually be beneficial to a range of interrupt
> controllers (only an obscure GPIO driver makes use of this flag).
> 

I'm not an expert on that area, but if MSI is oneshot-safe in general,
then we could do the following in the framework instead of touching
every MSI irq_chip. Opinions?
I tested on X86 and at least my system is still running.

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4ca2fd46..ba6da943 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
        if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
                msi_domain_update_chip_ops(info);

+       /* MSI is oneshot-safe in general */
+       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
+
        domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
                                             fwnode, &msi_domain_ops, info);

--
2.18.0

> We could also consider extending this to support interrupt
> hierarchies, as __setup_irq() seems only concerned with the top of the
> stack (an IRQ provided by a generic MSI stack and backed by an irqchip
> providing IRQCHIP_ONESHOT_SAFE would go unnoticed).
> 

Would it be sufficient if one irq_chip in the hierarchy is oneshot-safe?
Or what do we have to check for?

> 	M.
> 

Heiner
