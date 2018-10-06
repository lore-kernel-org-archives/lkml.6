Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62DC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757F7208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrbwlHAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757F7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJFOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:11:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34554 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeJFOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:11:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so13490211edr.1;
        Sat, 06 Oct 2018 00:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rYdkerL+oEjs8hpavllDRz7I2n00g7VSgU7jIPV6ljY=;
        b=QrbwlHALdWwdRGQ1a0RPqj/G9TwQHFcFE0x9I+5Czvb0+UEgm6lSDKLHci//HjzdGw
         2cJloYuPUsDbJiRjkmMllFb+bTdKvZuPfo9KyKZsnmspC1rlQhB+8BErEbdPv1DOjOSt
         ifyGi08mdfv/iLXmm+p3RgxTmHV9JFYFSVoj/dkPxbQOOCim7u9tHhvhKVBC43siCi/C
         6p8qqkhoiLX1azp6K4OXFwBr5gMIQ3hgBV7P7WeGgR4k3QpTWviGhpZKd32/IFlJkYYr
         OqjcObLK74bNzSt5NJNGtgb7aDQHk+2K/pAZxaeeBDcgGZeyZpstI3k1p0ZsoasbCwbl
         ewFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rYdkerL+oEjs8hpavllDRz7I2n00g7VSgU7jIPV6ljY=;
        b=MzGHZ+kqUIVT4DAvGsSOAqjXric/V83+n5gdeEm5xUC/Imo8H0wma+fHPRASSR/j8e
         trqXMZuXPJq0yOu+CTA0mXIfwQROQMU2xaNr5ZQSlh8OUyHt9GSGNVJkwS1tJZWIj8Sw
         6XJ5kzYqxVciU2FQzfpySPsudVGSVkWEAANvvpwwEVKQloh4kfcoco72DvDILpo5Q6f0
         QdfI+VBPTnRDsHqcYhCNSMGVYi5RvKopi1Y8dKCBE8QEJF3Jcwy3MCNNFMM9yJUYh5pz
         ARZ+eewaBuF6wJq4SWmDRax7awCslBYu6Aj/1CIVQbjLs4c7jhfqNtS9HI4IPUHLhSj9
         T1MA==
X-Gm-Message-State: ABuFfoisRs+X/tPVvQI5jitvVWCtOdLS7nQk28gyNzkdeRem5qc7KQqy
        v5KXCURpjdap2e9JKWMogaE=
X-Google-Smtp-Source: ACcGV63H+NXRVncL2BHJNeSy5byLF8P6H3tY+GfTxOqtwrvqhW2n7F0tkEid6WW0+bezdNsHF9/aRw==
X-Received: by 2002:a50:ac76:: with SMTP id w51-v6mr18152632edc.211.1538809730611;
        Sat, 06 Oct 2018 00:08:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 18-v6sm906476edt.34.2018.10.06.00.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 00:08:49 -0700 (PDT)
Date:   Sat, 6 Oct 2018 07:08:49 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     peng.hao2@zte.com.cn
Cc:     richard.weiyang@gmail.com, penghao122@sina.com.cn,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH]  kvm/x86 : avoid shifting signed 32-bit value by 31 bits
Message-ID: <20181006070849.psgrrhiysnrytbjr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181006021127.zuic7afw42b3hzw2@master>
 <201810061131044868733@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810061131044868733@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 11:31:04AM +0800, peng.hao2@zte.com.cn wrote:
>>On Thu, Oct 04, 2018 at 01:47:18PM -0400, Peng Hao wrote:
>>>
>>>From: Peng Hao <peng.hao2@zte.com.cn>
>>>
>>>  modify AVIC_LOGICAL_ID_ENTRY_VALID_MASK to unsigned
>>>
>>>Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>>---
>>> arch/x86/kvm/svm.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>>>index d96092b..bf1ded4 100644
>>>--- a/arch/x86/kvm/svm.c
>>>+++ b/arch/x86/kvm/svm.c
>>>@@ -262,7 +262,7 @@ struct amd_svm_iommu_ir {
>>> };
>>>
>>> #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK    (0xFF)
>>>-#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK        (1 << 31)
>>>+#define AVIC_LOGICAL_ID_ENTRY_VALID_MASK        (1UL << 31)
>
>>It is reasonable to change to unsigned, while not necessary to unsigned
>>long?
>AVIC_LOGICAL_ID_ENTRY_VALID_MASK is used in function avic_ldr_write.
>here I think it doesn't matter if you use unsigned or unsigned long. Do you have any suggestions?

In current case, AVIC_LOGICAL_ID_ENTRY_VALID_MASK is used to calculate
the value of new_entry with type of u32. So the definition here is not
harmful.

Also, I did a quick grep and found similar definition (1 << 31) is popular
in the whole kernel tree.

The reason to make this change is not that strong to me. Would you
minding sharing more reason behind this change?

>>--
>>Wei Yang
>>Help you, Help me


-- 
Wei Yang
Help you, Help me
