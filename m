Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DF920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQPT/P4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DF920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbeGYUek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:34:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33414 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:34:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so3703800plb.0;
        Wed, 25 Jul 2018 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AnfbF7gJlwrQ6Dn1QC/QHK7dDh0qGUr0FVPf5v9nAJU=;
        b=RQPT/P4buUPPqBpslKWx2kJCnCZd1zUimgyrvuHwnzG3+yc3PgAkZi/w197NzPZG6a
         uZynFFXFTLQGfSSvVWEiX5dE+nlodHg6lrJA8/hlnJokKreAgufPe7MRIB5TQDKJft2A
         Fmu6IHCiVTdllTy3SxfFn4sTE5j6FP81HCrs0fLSgu6nXrzT5PaUZh6PblKWyQhPHMkP
         2h+Il7eTucaLYc3530sqRtlGFdXDdGGuJCEB3cuAahldbqaTVAkG6gicbe8NvkAFmA8C
         aIyHSkmmIHNmTeWTQGeO9UkPe3TGLrMkW3XrNg3d1KJ6svkJ7v/+tdSW0Het0BSo1hrR
         RO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnfbF7gJlwrQ6Dn1QC/QHK7dDh0qGUr0FVPf5v9nAJU=;
        b=XEuSPmY3p75lEul+2j7OenjPkRhtx1f69998sep73mu7uV2Ein0ve2YDQL4rPANrsz
         VklAxZHZkmP3dVa3JQZu09FlTWEc4Jnc27iiwdrlJ+2wt7PJpN0CxPXHAoRfiUozcL/p
         dE+B7h6ChfvCQVhOUXftV+Ha4QgO+MkZ+oo7mex4llrqgZdJwVz5sK9DQJZkur9qcUA5
         Ey4XzPfmcZEVqUVH3Lb3BEF4rrnip5DSE/SEIUc4ovvGAroykYAIBPTHzjpLNS656w5q
         x+5ZW8IBN2cNSAphyQ/TxgWqFPlm0SQZ0JPb1+q+AdTaEpRZD5Jq+zEmtZrvleU1KTyD
         eftg==
X-Gm-Message-State: AOUpUlEHOIdi3+MYm3IP4Mrxo9kQK6FMhtSKKIP8XCvO/xjderP3+P4k
        rrr1Rsl0TspZX6lFMs0HZSk=
X-Google-Smtp-Source: AAOMgpcrHMQTSzGmBCAkx1jOIavnwMlegkxkUJjyvM/pJnMD0kYfT+HOIZnXY4jZaJ8NTnbb05yy3w==
X-Received: by 2002:a17:902:da4:: with SMTP id 33-v6mr21941512plv.193.1532546496720;
        Wed, 25 Jul 2018 12:21:36 -0700 (PDT)
Received: from [192.168.1.60] ([14.63.106.128])
        by smtp.gmail.com with ESMTPSA id q85-v6sm6070720pfa.151.2018.07.25.12.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 12:21:35 -0700 (PDT)
Subject: Re: pahole + BTF was: Re: [Question] bpf: about a new
 'tools/bpf/bpf_dwarf2btf'
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Thomas Girard <thomas.g.girard@free.fr>,
        Martin Cermak <mcermak@redhat.com>,
        linux-kernel@vger.kernel.org, acme@kernel.org
References: <47cfb90e-a9f4-8127-2b89-0e20d9fda2f0@gmail.com>
 <20180725175231.GA2121@redhat.com>
 <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
Message-ID: <592c6325-23d0-771b-cc28-6a66842a1265@gmail.com>
Date:   Thu, 26 Jul 2018 04:21:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/26/2018 03:27 AM, Taeung Song wrote:
> Hi Arnaldo,
> 
> On 07/26/2018 02:52 AM, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Jul 26, 2018 at 02:23:32AM +0900, Taeung Song escreveu:
>>> Hi,
>>>
>>> Building bpf programs with .BTF section,
>>> I thought it'd be better to convert dwarf info to .BTF by
>>> a new tool such as 'tools/bpf/bpf_dwarf2btf' instead of pahole
>>> in the future.
>>> Currently for bpf binary that have .BTF section,
>>> we need to use pahole from https://github.com/iamkafai/pahole/tree/btf
>>> with the command line such as "pahole -J bpf_prog.o".
>>> I think it is great but if implementing new 'bpf_dwarf2btf'
>>> (dwarf parsing + btf encoder code written by Martin KaFai Lau on
>>> the pahole project i.e. btf.h, btf_encoder.c, btf_encoder.h,
>>> libbtf.c, libbtf.h),
>>> BPF developers would more easily use functionalities based on BTF.
>>
>> What would be easier exactly? Not having to install a package but build
>> it from the kernel sources?
>>
>> Many kernel developers already have pahole installed for other uses, so
>> no need to install anything.
>>
> 
> Understood, but I think there are many non-kernel developers
> developing BPF programs and they mightn't have or use pahole.
> 
> So, if providing the 'dwarf2btf' feature on tools/bpf or tools/bpf/bpftool,
> non-kernel developers can also more easily build bpf prog with .BPF, no ?
> 

Or, if tools/lib/bpf/ have the 'dwarf2btf' feature,
I think BPF developers can just use bpf programs that have dwarf info
after compiling with clang '-g' and llc '-mattr=dwarfris', even though 
not using pahole.
Isn't it good way ?

>> BTW, Daniel, I just pushed to pahole's main repository at:
>>
>>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
>>
>> with the Martin's BTF patch, so no need to pull from the github one,
>> I'll tag v1.12 and announce the release so that distro package
>> maintainers can update their packages.
>>> What do you think about this ? Do you think this is needed ?
>>> Or, already implementing something like this ?
>>> If it is needed, I want to try to make 'tools/bpf/bpf_dwarf2btf'
>>> based on the pahole code. I'd appreciate it, if you reply to this
>>
>> The way Martin took advantage of the work done a long time ago to
>> support CTF out of the same DWARF reading codebase was really cool, not
>> that much work to do, just add a new format to pahole's codebase making
>> it more useful.
>>
> 
> I got it !
> 
> Thanks,
> Taeung
> 
>> I was just so far overly picky with testing it and kept leaving for
>> later to have a good documentation about testing it, vacation and perf
>> maintainership duties kept making this take like forever, grumble :-\
>>
>> - Arnaldo
>>
> 
> -- 
> oh.. :'(
