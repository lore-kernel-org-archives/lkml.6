Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04790C4646A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886FC217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbdCkUDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886FC217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeHCWo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:44:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36206 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeHCWo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:44:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so7691507wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WjBgWTT3nv2pcNqD6EGMZnWQzMwW1Am06kAZNOnhI/s=;
        b=IbdCkUDhNpw69loD9BfcXcu9t94fIRqgtDv+trERJxxhKr+V2W74jEfDykUlrUXklT
         jDsHrTB5MLI+V60gngLHnGTcTqhmGVmLMYYi3kN0XscmsibFvwSZHWK+aIUziRQFMZC0
         okkvCwOPEQBJQXM/f0wX/hH4nRy9JMbqP4exXYxrK2Jce1dPrwBEix/77FHu9t8oyRzK
         XKdseLE1v6CePbZlekGhyHFMb8qK2f5SV/W8VhTwczwR+jllHi4ZQ6hYhy2ukAIce/MK
         hFS/o+H46CbRe11+y0JZvYtzA4k8A0tJUdpbDUa3OBXVykfnaYB443MPiPmNjuLErR1T
         s/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WjBgWTT3nv2pcNqD6EGMZnWQzMwW1Am06kAZNOnhI/s=;
        b=PSZgL3YAkxtEkURVULePaiEG99i2J3UPpgODHiTD5Gujk8wNVsDTG0tSjRhJ1f+2KY
         YhMMxBXjK2k7jzIlmb4EotTdv4CkqWEhk9yOksjccBAriBqkb4/5xtltFgw/7ES3FvS7
         vJK7Y6b25+MzA+n414a2NI29Le0i3mzLY9YQcjl9RelGGc9iGohs5Qa+qzAObx+ZyD83
         bka1BEQoxuAXMu/3B9glM8ddJ02m6RQxVrQ1V5P3n62Dr173jGZuxDi44ZoLGC2c16Y8
         qjyn5stNWxjW+zdut05nUvqC29eTOXlrIxF3bV0sbD7eHppxTRGwzWb/IkVa0Ek/IR+V
         HVPg==
X-Gm-Message-State: AOUpUlEQXj9WFZABPzs1uHiji36IfGNAx7aav2Tt9IP2KoVARGNP9w4E
        lNz/FkUZ6aX0YaB2lONGPIw8bDVy
X-Google-Smtp-Source: AAOMgpcQI13OS2LJOqTyvprEoX9+tY9stKhiuotqmZl/HJD4wqsZFa/HI3x03cQtX/xWX/rnfr+0IA==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr6371495wmf.8.1533329193942;
        Fri, 03 Aug 2018 13:46:33 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:9545:19fe:eae2:90aa? (p200300EA8BD4D600954519FEEAE290AA.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:9545:19fe:eae2:90aa])
        by smtp.googlemail.com with ESMTPSA id c129-v6sm642645wmh.2.2018.08.03.13.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 13:46:33 -0700 (PDT)
Subject: Re: [PATCH] genirq: Consider domain hierarchy when checking for
 IRQCHIP_ONESHOT_SAFE
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <a0407813-dbc3-4d4a-4feb-2c4865dfd4f5@gmail.com>
 <alpine.DEB.2.21.1808032155570.1658@nanos.tec.linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <483980a3-bd1a-1a05-0372-d608db941251@gmail.com>
Date:   Fri, 3 Aug 2018 22:46:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808032155570.1658@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2018 22:00, Thomas Gleixner wrote:
> On Fri, 3 Aug 2018, Heiner Kallweit wrote:
> 
>> In case of a domain hierarchy we may miss the IRQCHIP_ONESHOT_SAFE
>> flag because we look at top of the stack only. See also discussion
>> here: https://marc.info/?l=linux-kernel&m=153301773524685&w=2
> 
> I think you misunderstood:
> 
>> I think the top most chip is the key, the rest of the hierarchy is
>> irrelevant because the top most chip is the one which is responsible for
>> not creating an interrupt storm after the interrupt got acknowledged.
> 
> The top most chip in the hierarchy, e.g. the PCI MSI one, is the key. If
> that one is badly implemented and starts to resend after ack/eoi then the
> interrupt storm happens. The lower layers in the hierarchy down to the
> vector domain are just transporting what the top level chip does. So it is
> actively wrong to flag the lower layers.
> 
>  	 if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
> 
> is the correct check as it looks at the topmost irq chip which is the one
> which initiates the interrupt.
> 

So you're saying it's correct as it is now in __setup_irq(). Then I don't
really understand Marc's following comment from earlier in the discussion.
What else needs to be done if it is correct already?

"We could also consider extending this to support interrupt
hierarchies, as __setup_irq() seems only concerned with the top of the
stack (an IRQ provided by a generic MSI stack and backed by an irqchip
providing IRQCHIP_ONESHOT_SAFE would go unnoticed)."

> Thanks,
> 
> 	tglx
> 

