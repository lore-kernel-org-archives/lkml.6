Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D454BC46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89400217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5SvWpHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89400217A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeHCWxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:53:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37356 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbeHCWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:53:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so7710637wmc.2;
        Fri, 03 Aug 2018 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=biE0JDjaCsMmnuhy6C8XYD31ZJpnrYHzAMic2aeSTiw=;
        b=n5SvWpHfmvGbg0FQ+aRnW5i4ppfOYX+Cdpf9H8bOdF68rQZJASujctuGSHlU8dNOLr
         /9snjuBpksXk+Y7fF4vWNW7RYCWfcm+1U5623e++UaTKcdrTfIxWO6tZdVWhjRDTHTtJ
         ORaFTruzwUMB+VF5aLwkIvxrnwgx+2OWiPHmrAgovdI+wMC0brd1wMnKZlO0xYk1G0NP
         aePLFZ657uk/7KFt+CtCXGAJZ6K9j6Wp76qH+xchmkprOiJX2MgytlRrTc0SXirZBp+s
         8F2N3AvgXXTkDv7txyejTMMIC+LPpmk1TD/FIt7qibeVsBJDsIkufo4POQD/7J/t2kEx
         3ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=biE0JDjaCsMmnuhy6C8XYD31ZJpnrYHzAMic2aeSTiw=;
        b=CjHtmQeTws28p1abhtlzxY0LiTY4Op4uUZFxBNApXA+QyLGSZKNEmw27SpIadvUKCD
         qH1OnHViN343OsFtiapyuCFBQFcCajh6LxVTPrEWO08V2nuyqR0w7uvP4e/YViPRaY0w
         hDg+J+tLPvOiWVd7WS7ydNwwzgyA9gXZ1hnievHq4Z4a2Nh78lGA+iGiQ2IPt70jUKEA
         CWujyDZImjj6fgRPxTerOYwv0RJ7qsvJApxRTAYoo3iBBJeTHvM4TDZ69GQiuKP/c+9B
         B/7b+cl36GqvXsbI1Rtw+MtTrz/oms1RaXLH8Xj2rlrTgfzR7pTULNAcmNGF+/kHA6Nt
         GnYA==
X-Gm-Message-State: AOUpUlHpUfhn6gNWaLgMcanYXbMDja4qCRUbB2iv5TXphQb1BrvKvgSd
        TndiyAEUMLUrV851RY9cNw+Fhr1X
X-Google-Smtp-Source: AAOMgpepjfigb9WNr9ArAdxHpTVCMhNeXa2u7Y3JoYU7ZDxwhquRA0rWMtR1k3vGX1o3YAJKfFDHhA==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr5660205wmh.34.1533329705731;
        Fri, 03 Aug 2018 13:55:05 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm3346332wrm.18.2018.08.03.13.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 13:55:05 -0700 (PDT)
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
 <420d6476-8ea4-0b37-e94a-f5842b7b0ff7@gmail.com>
 <alpine.DEB.2.21.1808032136490.1658@nanos.tec.linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <96285966-f2d2-c820-7f38-de22deeb8074@gmail.com>
Date:   Fri, 3 Aug 2018 22:55:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808032136490.1658@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2018 21:40, Thomas Gleixner wrote:
> On Fri, 3 Aug 2018, Heiner Kallweit wrote:
>> On 03.08.2018 16:09, Thomas Gleixner wrote:
>>> On Wed, 1 Aug 2018, Heiner Kallweit wrote:
>>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>>> index 4ca2fd46..ba6da943 100644
>>>> --- a/kernel/irq/msi.c
>>>> +++ b/kernel/irq/msi.c
>>>> @@ -289,6 +289,9 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>>>>         if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>>>>                 msi_domain_update_chip_ops(info);
>>>>
>>>> +       /* MSI is oneshot-safe in general */
>>>> +       info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
>>>> +
>>>>         domain = irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0,
>>>
>>> Looks about right, though there might be dragons. MSI is not always as sane
>>> as it should be...
>>>
>> When saying "MSI isn't always sane", are you referring to the hardware or
>> the controller driver implementation? Basically for me the question is
>> whether we would be able to fix the issue if we meet such a dragon,
>> or whether we would have to revert the change.
> 
> It's hardware unfortunately, so it might be a revert. PCI-MSI should be
> safe, but the wild MSI variants in SoCs might be the actual dragon caves.
> 

pci_msi_create_irq_domain() is used by controller drivers for PCI(e)
controllers in SoCs like Mediatek, Armada, ..
I assume you're referring to some other (non-PCI) SoC-internal
MSI mechanism when saying "wild variants", right?

>> Do you think the chance of a dragon is low enough? Or better add the
>> flag only to the X86 PCI MSI irqchip for now?
> 
> I think PCI-MSI in general would be not too risky. Famous last words.
> 
> Thanks,
> 
> 	tglx
> 

