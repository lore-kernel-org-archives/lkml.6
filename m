Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C6EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5AE20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO/Sk28M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5AE20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbeG2BLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 21:11:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51170 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbeG2BLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 21:11:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so9141119wmc.0;
        Sat, 28 Jul 2018 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0PiCaEg4/YhEl0QpWNpJGSEQKSSLlNnod3rG5t/BEcM=;
        b=OO/Sk28M5dbaouNqrs5zKGcYgKafbP6Q7+NaC3rDeiAx47ka8Z/7SJ5vaS3ThWcjcc
         lXBeHwFDoddAfo07U9zm+EKMIcV/R8siS0l7OWNCoar2r7s3I1iPDU64wligCu4SEcMi
         ozbtfpGXv1GFby6R3Zu+aGZhJRGnH1cgndxwFUWG+2r03LiBvyIF2XyYAIYwpRXkFwx0
         sH1rB7hwi1eRwL1DcfSp8QIealYqHW8R5EfP9lH8hy038TIl+5QCxutfxQR5DqZyFtoP
         iFuCjB2p/MzZgtmF9EOnRW6groP9cZDRirHXK1Y6BrN9eI1lfHCZ3och6Se6M+jSiobJ
         fYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0PiCaEg4/YhEl0QpWNpJGSEQKSSLlNnod3rG5t/BEcM=;
        b=PU/rJgMi4LdlFyyT5ok3JW4Kk45kxFiV7KqxhT4ANDwhOl6P9e32OFFs9NTE63362Z
         G5ql/6T33nSBxJ0VNYaMHD77xsWOTJ3jeW/Wwtbi6YJQ78Oih5ghroFLSFWsUzai8I/f
         feKFeCi+0Bl6sdEDMVJyt1KBY57k+8QHtiN9/JwZnSsYUWvvUgc/vJV3m/CoZMHklGIR
         8eSHTZ3FvrLgbbZNd47AZhboNNcGI1p5BFG1TOVh9EgHRiFlhENzzDICSt8k3XsQ8t21
         StTHHh4BFjzfRgyic9QkMcYEADvdLVCAzWhR07P3GDTu7Vbg00Oj5d8Ek5JiVZdqDL9x
         rLNg==
X-Gm-Message-State: AOUpUlF0xPXBBEyj6n1U9R5zlzS6+hF/jXtiQGQZ8J29M4tDrNIdLkje
        7aalgZ7ZYTIiUQFijMVyr2ODRU2I
X-Google-Smtp-Source: AAOMgpeJ5dNjR4CJBRMk1uoLrSKejsTT8H2YUgztKw68+RV7rWvrY1fZVGtuKa1jig3v1Fh01ybOuA==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr9070224wmf.1.1532821369010;
        Sat, 28 Jul 2018 16:42:49 -0700 (PDT)
Received: from [192.168.10.165] (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.googlemail.com with ESMTPSA id h7-v6sm8130831wrs.8.2018.07.28.16.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:42:48 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
To:     "puwen@hygon.cn" <puwen@hygon.cn>, tglx <tglx@linutronix.de>,
        bp <bp@alien8.de>, "thomas.lendacky" <thomas.lendacky@amd.com>,
        mingo <mingo@redhat.com>, hpa <hpa@zytor.com>,
        peterz <peterz@infradead.org>, "tony.luck" <tony.luck@intel.com>,
        rkrcmar <rkrcmar@redhat.com>,
        "boris.ostrovsky" <boris.ostrovsky@oracle.com>,
        jgross <jgross@suse.com>, rjw <rjw@rjwysocki.net>,
        lenb <lenb@kernel.org>, "viresh.kumar" <viresh.kumar@linaro.org>,
        mchehab <mchehab@kernel.org>, trenn <trenn@suse.com>,
        shuah <shuah@kernel.org>, x86 <x86@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-2-git-send-email-puwen@hygon.cn>
 <ed090643-09da-cde7-6edd-970d973afd4d@redhat.com>
 <201807290021145963620@hygon.cn>
From:   Paolo Bonzini <bonzini@gnu.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
Message-ID: <bd73d865-acb3-66e5-a37a-dc4859e5f002@gnu.org>
Date:   Sun, 29 Jul 2018 01:42:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201807290021145963620@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2018 18:48, puwen@hygon.cn wrote:
> Hi Paolo,
> 
> Thanks for your feedback.
> 
> As we described in the patch description, current Hygon Family 18h share
> most architecture with AMD Family 17h. But Hygon Family 18h are not the
> same with AMD family 17h, as it removed some features such as SME/SEV in
> Dhyana.

If the maintainers are okay with X86_FEATURE_HYGON that's certainly
fine, however I think you can improve the consistency of the patches in
a few ways.

Lack of SME/SEV is not an issue, since there are AMD Zen chips without
SME/SEV too, but potential incompatibility with future AMD fam18h chips
is important.  Therefore, code like this one in amd_uncore_init


-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;

 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;

-	if (boot_cpu_data.x86 == 0x17) {
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {

should check explicitly for Hygon before checking for family 18h.  The
same applies to the edac patch that I've just sent an answer to.

On the other hand, in many cases the AMD code is testing something like
"AMD && family >= 0x0f".  In this case you have a mix of:

- duplicate code for HYGON, such as modern_apic or mce_is_correctable

- change the condition to (AMD || HYGON) && family >= 0x0f, such as
k8_check_syscfg_dram_mod_en and amd_special_default_mtrr

- change the condition to (AMD && family >= 0x0f) || (HYGON && family >=
0x18), such as smp_quirk_init_udelay

I couldn't find any case where you used (AMD && family >= 0x0f) ||
HYGON, but I think it would be clearer in most cases than all the above
three alternatives.

In general, I would duplicate code if and only if the AMD code is a maze
of if/elseif/elseif.  In particular, code like this

	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
 		return msr - MSR_K7_EVNTSEL0;
+	case X86_VENDOR_HYGON:
+		if (msr >= MSR_F15H_PERF_CTL)
+			return (msr - MSR_F15H_PERF_CTL) >> 1;
+		return msr - MSR_K7_EVNTSEL0;

or this

	case X86_VENDOR_AMD:
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_K7_HWCR_CPB_DIS);
+	case X86_VENDOR_HYGON:
+		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
+		msr = lo | ((u64)hi << 32);
+		return !(msr & MSR_K7_HWCR_CPB_DIS);

looks a bit silly, and you already have several cases when you are not
introducing duplication (e.g. __mcheck_cpu_init_early).  On the other
hand, code like xen_pmu_arch_init can be very simple for Hygon and so it
may be useful to have a separate branch.

Thanks,

Paolo
