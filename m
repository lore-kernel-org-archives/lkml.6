Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795520862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8795520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeGaJRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:17:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36464 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeGaJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:17:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so525551wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bngEjIkawQGTRZAUE9xrYFj/qMnIK86GgMLe9r51olE=;
        b=nasiZB43EQ5s2C/ibRMgfEaTnRtnHuMqvxBdmZ6wCmS4avhSlziac7tfCC253ECPaE
         AoMGOZyiOlNkRDF2VTMG1kKHpjIr4sJdOWXu2Iynw0SYrI/aPkqImvq/rdcWgcQ0qgRy
         XUbOGzqEf77NEn+Kr707HbBReSIFVGGIMD0ei+2Z04PvycJZzgljFZO1cAiK1ataoUIc
         wypavF5bYvWpVHlM4gWumG9Sh6NoT6y46vvkfChGtZ4+J0J2qJ3+R2wrM+jcPa7vfLtN
         mMNyYlL0AaDSfQ4x71H1QY7UWWjUBD6yoIWmtSX5W2PA0E5wYjs8TVKboqda91y9qvaM
         cQLw==
X-Gm-Message-State: AOUpUlFyxYqpStX7ToOBIrifaT9/YO1a181VZOtGOAU/T/SToaNqdrcr
        kgFGZqTA67gpc0AtXuA3B9vTsA==
X-Google-Smtp-Source: AAOMgpfHKhCN6ziLmmAQrUbGY1YKtFm3M8PWuLbMM17j96pvOBuyjWjZ0u9yXgsXB/fC9GYdbNIBNA==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr1560766wmh.39.1533022727071;
        Tue, 31 Jul 2018 00:38:47 -0700 (PDT)
Received: from [192.168.10.150] (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id v188-v6sm1745007wme.43.2018.07.31.00.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 00:38:46 -0700 (PDT)
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
To:     Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, bp@alien8.de,
        thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com,
        peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
 <b24739e8-0833-8509-0850-815758accaee@redhat.com>
 <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1360de2a-5aae-bfd7-ced1-f707b29e7b1f@redhat.com>
Date:   Tue, 31 Jul 2018 09:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 18:43, Pu Wen wrote:
> On 2018-07-29 07:42, Paolo Bonzini wrote:
>> On 23/07/2018 15:20, Pu Wen wrote:
>>>  scrubval = scrubrates[i].scrubval;
>>>
>>> -    if (pvt->fam == 0x17) {
>>> +    if (pvt->fam == 0x17 || pvt->fam == 0x18) {
>>>  __f17h_set_scrubval(pvt, scrubval);
>>>  } else if (pvt->fam == 0x15 && pvt->model == 0x60) {
>>>  f15h_select_dct(pvt, 0);
>>
>> This, and many other occurrences in this file, should in my opinion
>> avoid testing family 18h without also checking for Hygon as a vendor.
>> You probably need to add a vendor field to struct amd64_pvt and
>> initialize it in per_family_init.
> 
> Thanks for the suggestion.
> 
> As AMD and Hygon will negotiate the usage of CPU family number
> to make sure the unique of family numbers in both company's processors.
> As Hygon will use family 18h for Dhyana, AMD will not use family 18h
> and jump to family 19h for new product. So if family number if 18h,
> processor should be Hygon Dhyana. Based on this assumption, we created
> this patch set.

But if that's the case, it doesn't make sense to have a new vendor!  If
AMD's 17h and Hygon's 18h ever diverge, you could always choose the
right behavior based on the family, without checking the vendor.

However, if the x86 maintainers prefer to have a new X86_VENDOR_*
constant, I'd just ignore the fact that AMD will skip family 18h, and
introduce vendor checks along the lines below.  This has the advantage
that it's not an issue if AMD ends up _not_ skipping family 18h.

> If the vendor field is added to amd64_pvt, and check the vendor in 0x18
> codes, then the codes may like:
> -    if (pvt->fam == 0x17) {
> +    if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
> 
> switch cases will be modified similar to:
> +    case 0x18:
> +        if(pvt->vendor == X86_VENDOR_HYGON) {
> +            fam_type    = &family_types[HYGON_F18_CPUS];
> +            pvt->ops    = &family_types[HYGON_F18_CPUS].ops;
> +            break;
> +        }
> +

Either that, or

	if (pvt->vendor == X86_VENDOR_AMD) {
		...
	} else {
		fam_type = &family_types[HYGON_F18_CPUS];
		pvt->ops = &family_types[HYGON_F18_CPUS].ops;
		break;
	}

Paolo
