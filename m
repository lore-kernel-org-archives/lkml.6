Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD48C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE772064E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnT6kMyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE772064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeH1P71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:59:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45369 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1P70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:59:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so600745pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=wWK68CVZFM0MZieNvfaFC2c344XUSBzLW2AAmiHvynU=;
        b=JnT6kMyWDGZ9zQ56ajGUb5v+MGzK5Y3PXkdkyJCBDGYZjaeEOY/dMiEjoyerq0sBMJ
         psq4disu0me58TLFI2iA/pyTi+gObbFpOLo94t9RYRTZFhw2VTDLVqktigwZD2A2AKmJ
         3aY2xZwULiTCb8dupn/AfAXUi/z2ezU8BRLQ/acpJSUo/1M4mSgm9ZcwHWgMWnNJTYNK
         5vPq3vWIkrmplLpSqz9/VicWBX88Gr89j158MlfEzjqXAKXlepCP4Kmaz8PTikqb2VN7
         Jb6SKLfbb8p312cYe90IKYxKHGVBYFSQc7lbfTV9J0tBD1jFj5aWpCfTNR4teocEcHfY
         HFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wWK68CVZFM0MZieNvfaFC2c344XUSBzLW2AAmiHvynU=;
        b=SbP+JQDp81W66o+z/1lc9AnAiwDlka4tcUv5VSAopL8DU3e+ildYpVWBQEF+tF8a1D
         q5zn4KCzYKOZHY1VQK9Q0kBrii3d3E/L3Yk19La5/MVqGvX9Artoc4pK+fN30gQw635b
         JZE58OiACW6H9++cOBIhQyle5AD5jQeTEx1T3QGvJymBFX8Cl+ukOZCwJVKr4RAIQG9i
         8I5c6RqueD36k6vrGWfxzsf7gJiny4jqkrxSKP1afyfIlZcTCy8N4KwUrtuZL2Ttx9CD
         EgppENzpy7eONzFFGoVpd//9WPNdDnyhwUquEVKXbMG9RIqqVF0JeIcgPIWZqQAovuDJ
         LAWg==
X-Gm-Message-State: APzg51A03slvTuYoKpmm7ynoB09wA65HACtXPbEbD8e5CNhw6iA9Sn6g
        WsEEjo+CCngTleNfcWDeL1I=
X-Google-Smtp-Source: ANB0VdYxhyShooXIbyKBF8hpyxnGPp4HK6b7jtcF+K+Yk187WHmEgEbWi/VWpu/E3gJSAHvDGniPjg==
X-Received: by 2002:a62:b20c:: with SMTP id x12-v6mr1259859pfe.201.1535458085318;
        Tue, 28 Aug 2018 05:08:05 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id b126-v6sm1769219pga.49.2018.08.28.05.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:08:04 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3-its: cap lpi_id_bits to reduce memory
 footprint
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jia He <jia.he@hxt-semitech.com>
References: <1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com>
 <865zzuyijp.wl-marc.zyngier@arm.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <a28b854e-3bc9-0c10-2faf-63e4d44ec14b@gmail.com>
Date:   Tue, 28 Aug 2018 20:08:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <865zzuyijp.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2018 4:58 PM, Marc Zyngier Wrote:
> On Tue, 28 Aug 2018 05:53:26 +0100,
> Jia He <hejianet@gmail.com> wrote:
>>
>> In commit fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs"),
>> it removes the cap for lpi_id_bits. But it will cause more pointless
>> memory footprint.
>>
>> There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)
>> ============begin===============
> 
> [trimming not-so-useful trace]
> 
>> ============end============
>>
>> In its_alloc_lpi_tables, lpi_id_bits is 24 in QDF2400. Then
>> its_allocate_prop_table will try to allocate 16M(order 12 if
>> pagesize=4k). Thus it causes the WARN_ON.
>>
>> As said by Marc,
>> Capping lpi_id_bits at 16 (which is what we had before) is plenty,
>> will save a some memory, and gives some margin before we need to push
>> it up again.
>>
>> This patch re-caps the lpi_id_bits.
>>
>> Fixes: fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs")
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks for doing this. Small problem with this patch:
> 
> The email comes from hejianet@gmail.com, while the sign off is by
> jia.he@hxt-semitech.com. Your email should start with a:
> 
> 	From: Jia He <jia.he@hxt-semitech.com>
> 

Thanks for the pointing. And sorry for that problem.

---
Cheers,
Jia
> Other than that:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thomas, would you mind picking this up so that it gets into the next
> convenient -rc?
> 
> Thanks,
> 
> 	M. (/me goes back hiking...)
> 	
> 

