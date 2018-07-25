Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0478C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRNogYkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D0C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeGYTkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:40:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43971 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:40:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so1950570plv.10;
        Wed, 25 Jul 2018 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/dBZn6nU73J8W70hnk44SYfz54gVTT2xw3kLrZ1YU3c=;
        b=XRNogYkXdtquEh8j+6K0cHD8KNRnu2/JyasbqCNHzsOWRMTVbnDmteJSj532Ky0sGh
         WnLFtyq3iCQVo036qmJztGVu91wNzjhdDulOpCBUOM9+RCUlPwXazr2kO78YM4Fuuswa
         qNKmN+l9fAZYwa41q7gWRMeC7j0HDhHVNPldgn3JqKA65ae98+ipQ49bHWtojj57nmov
         4Q/Hzu+J5p1qdVpFu4QaS34n/gL9zKYpFKMTdWOOBVEu5q5BUl3p4+cZ7bG9dxHcU3Ug
         vUr2qxCKChQYebLHazlaMSLhiiDAc0LoWQR43K8pct+Dz4DNraoluMKSuc3XLjH64MGU
         gNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/dBZn6nU73J8W70hnk44SYfz54gVTT2xw3kLrZ1YU3c=;
        b=owgPET3uk9yPUso8VOHyPdNeHY2zZMAPcE9XmLbskv+tNNZEBLdjRkPXNXc/LZG0by
         sLq6cCPA9FJbFPNiSkBX16U/8bVe/DPt6SAD45l+O3nlJtlFhzQmNmdljoGHn5VM+VpN
         o6kOJfXKY2ZAFzh4eJp4Rp1l07Gw2zZN5aZ2eFo1eUgWV6HKToXikt625I0dIKHhIQBq
         Qk35zIBSupGYpElS1doQIebxWWmT2TNo3eAbthV9sBQqYHhCZY8rr1TxfWMd2cFk5iC1
         IYN7una3tu1pFZAlv4H3aUrvF4clFaGrfka/eBlVgq/ztWsvgp7Pe6G2aLM350KBwmf+
         G/5w==
X-Gm-Message-State: AOUpUlGVV/6FxjAUWSwTSjgEhYDytu8ga6xt+g5XHeIMYle3cLJEH1bX
        tYxKmybj82tBcS3UT8MAskQ=
X-Google-Smtp-Source: AAOMgpfPRXPKqeqXdL+J9bAruMlpDNXmFtDSMk5D43Z5ic25svSxATWxJzbar7DKJPAammjJHqKIFg==
X-Received: by 2002:a17:902:7587:: with SMTP id j7-v6mr5028484pll.256.1532543227398;
        Wed, 25 Jul 2018 11:27:07 -0700 (PDT)
Received: from [192.168.1.35] ([14.63.105.207])
        by smtp.gmail.com with ESMTPSA id e8-v6sm19045498pgi.24.2018.07.25.11.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 11:27:06 -0700 (PDT)
Subject: Re: pahole + BTF was: Re: [Question] bpf: about a new
 'tools/bpf/bpf_dwarf2btf'
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        Thomas Girard <thomas.g.girard@free.fr>,
        Martin Cermak <mcermak@redhat.com>,
        linux-kernel@vger.kernel.org, acme@kernel.org
References: <47cfb90e-a9f4-8127-2b89-0e20d9fda2f0@gmail.com>
 <20180725175231.GA2121@redhat.com>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
Date:   Thu, 26 Jul 2018 03:27:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725175231.GA2121@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 07/26/2018 02:52 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 26, 2018 at 02:23:32AM +0900, Taeung Song escreveu:
>> Hi,
>>
>> Building bpf programs with .BTF section,
>> I thought it'd be better to convert dwarf info to .BTF by
>> a new tool such as 'tools/bpf/bpf_dwarf2btf' instead of pahole
>> in the future.
>   
>> Currently for bpf binary that have .BTF section,
>> we need to use pahole from https://github.com/iamkafai/pahole/tree/btf
>> with the command line such as "pahole -J bpf_prog.o".
>   
>> I think it is great but if implementing new 'bpf_dwarf2btf'
>> (dwarf parsing + btf encoder code written by Martin KaFai Lau on
>> the pahole project i.e. btf.h, btf_encoder.c, btf_encoder.h,
>> libbtf.c, libbtf.h),
>> BPF developers would more easily use functionalities based on BTF.
> 
> What would be easier exactly? Not having to install a package but build
> it from the kernel sources?
> 
> Many kernel developers already have pahole installed for other uses, so
> no need to install anything.
> 

Understood, but I think there are many non-kernel developers
developing BPF programs and they mightn't have or use pahole.

So, if providing the 'dwarf2btf' feature on tools/bpf or tools/bpf/bpftool,
non-kernel developers can also more easily build bpf prog with .BPF, no ?

> BTW, Daniel, I just pushed to pahole's main repository at:
> 
>    git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> with the Martin's BTF patch, so no need to pull from the github one,
> I'll tag v1.12 and announce the release so that distro package
> maintainers can update their packages.
>   
>> What do you think about this ? Do you think this is needed ?
>> Or, already implementing something like this ?
>   
>> If it is needed, I want to try to make 'tools/bpf/bpf_dwarf2btf'
>> based on the pahole code. I'd appreciate it, if you reply to this
> 
> The way Martin took advantage of the work done a long time ago to
> support CTF out of the same DWARF reading codebase was really cool, not
> that much work to do, just add a new format to pahole's codebase making
> it more useful.
> 

I got it !

Thanks,
Taeung

> I was just so far overly picky with testing it and kept leaving for
> later to have a good documentation about testing it, vacation and perf
> maintainership duties kept making this take like forever, grumble :-\
> 
> - Arnaldo
> 

--
oh.. :'(
