Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7662220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfB0fz3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7662220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeGZHT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:19:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41208 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeGZHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:19:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so449332pgu.8;
        Wed, 25 Jul 2018 23:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WYF+YMfquKObGVOwAGLMpemKA36i2iEw/LCMKNMP48g=;
        b=WfB0fz3TlFEBNk2iQkGGFLYlY0dugUEFZ9XnljtB3pI+LzJd+8q19wEWj+W53pYZfP
         OtgxAl8EB7R6vINKMtSlPGN0Ul0G6o+hZS58o+qPCEV4QQ91tGPMVgGC3BaRO5QK7bA3
         NzQyqj1t3aXySXS7+zmv69Zbs8NVAou27GWeqyqiyFo//fOBPSKvIFTWV0lFqFgOVPEt
         noTLNCBL61fiu1IWmYietO2uaKWhC8Up7ryxiTu5nIQhx1FJE0IBkRmdELp5fsh8CJfn
         HwZ1mvrd0wI/4oEPGQDTPboNwiiWIM6xIhf0G6laFbzSzU6WkPIwlCPiGOfSNiJaam8x
         3reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYF+YMfquKObGVOwAGLMpemKA36i2iEw/LCMKNMP48g=;
        b=lZ7P5rtKaT93IlIQ/9kiDWNE9TSbPgAUY79h9tKZ9bZrr3eWMGJYnLJ3SkyYvE7eiv
         F6Ny7DmFOUzqEOzSYyj45k+IhwvFp56CHgHKE1W1mND+zuPBSi9xQ00Vj38SdG+vwLrF
         eX429Vp52qN87OFTa9h1sE2c/XoJHtif2LbF/EbdCtTA22okpaCs6xTfeqFUjQdb8KQp
         DcpQ8Hk/6eLeatv/3/sP0YPWy5LyMSqWGipl0EoQBgxKiNiXQg8GRweHh5gZYlyuuhhW
         /4AiixmcygV1Tqb6zVGSuMpoPUpkk92xPpc0F8478FzgBg2FfA+4Dzh9U2DDDMCMAz2X
         T/+Q==
X-Gm-Message-State: AOUpUlHhyy5gLxN++Dr1kUsNuDbMm9OUvkEQj7hxNrOVPg51PAKL9/dv
        ytPJ7X8oPpTdckR8ZRcwN1A=
X-Google-Smtp-Source: AAOMgpc2/5Svceg7H6UK8ahZKST7ENGnrZBuHisZ9A1+ao4tu6CDoQLVNFW6IfZPcU5tTnoETAHVYg==
X-Received: by 2002:a63:1722:: with SMTP id x34-v6mr652256pgl.268.1532585085303;
        Wed, 25 Jul 2018 23:04:45 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id p8-v6sm751569pfk.186.2018.07.25.23.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 23:04:44 -0700 (PDT)
Subject: Re: pahole + BTF was: Re: [Question] bpf: about a new
 'tools/bpf/bpf_dwarf2btf'
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        Thomas Girard <thomas.g.girard@free.fr>,
        Martin Cermak <mcermak@redhat.com>,
        linux-kernel@vger.kernel.org, acme@kernel.org
References: <47cfb90e-a9f4-8127-2b89-0e20d9fda2f0@gmail.com>
 <20180725175231.GA2121@redhat.com>
 <35663517-26e1-c2a2-1554-5dd90be2747f@gmail.com>
 <592c6325-23d0-771b-cc28-6a66842a1265@gmail.com>
 <20180725201122.h7ostqw3qtfvz7sn@kafai-mbp.dhcp.thefacebook.com>
 <96728b5e-8e41-a1df-be63-becbd9606307@iogearbox.net>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <bcabe9a0-df3d-d57a-92aa-63267b3b7dd5@gmail.com>
Date:   Thu, 26 Jul 2018 15:04:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <96728b5e-8e41-a1df-be63-becbd9606307@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/26/2018 09:26 AM, Daniel Borkmann wrote:
> On 07/25/2018 10:11 PM, Martin KaFai Lau wrote:
>> On Thu, Jul 26, 2018 at 04:21:31AM +0900, Taeung Song wrote:
>>> On 07/26/2018 03:27 AM, Taeung Song wrote:
>>>> On 07/26/2018 02:52 AM, Arnaldo Carvalho de Melo wrote:
>>>>> Em Thu, Jul 26, 2018 at 02:23:32AM +0900, Taeung Song escreveu:
>>>>>> Hi,
>>>>>>
>>>>>> Building bpf programs with .BTF section,
>>>>>> I thought it'd be better to convert dwarf info to .BTF by
>>>>>> a new tool such as 'tools/bpf/bpf_dwarf2btf' instead of pahole
>>>>>> in the future.
>>>>>> Currently for bpf binary that have .BTF section,
>>>>>> we need to use pahole from https://github.com/iamkafai/pahole/tree/btf
>>>>>> with the command line such as "pahole -J bpf_prog.o".
>>>>>> I think it is great but if implementing new 'bpf_dwarf2btf'
>>>>>> (dwarf parsing + btf encoder code written by Martin KaFai Lau on
>>>>>> the pahole project i.e. btf.h, btf_encoder.c, btf_encoder.h,
>>>>>> libbtf.c, libbtf.h),
>>>>>> BPF developers would more easily use functionalities based on BTF.
>>>>>
>>>>> What would be easier exactly? Not having to install a package but build
>>>>> it from the kernel sources?
>>>>>
>>>>> Many kernel developers already have pahole installed for other uses, so
>>>>> no need to install anything.
>>>>
>>>> Understood, but I think there are many non-kernel developers
>>>> developing BPF programs and they mightn't have or use pahole.
>>>>
>>>> So, if providing the 'dwarf2btf' feature on tools/bpf or tools/bpf/bpftool,
>>>> non-kernel developers can also more easily build bpf prog with .BPF, no ?
>> Some quick thoughts,
>> IMO, I suspect if it is in the distro's pahole package,  it should be easy
>> enough for kernel and non kernel developer to install.
>> BTF usage is still evolving,  we might re-evaluate going forward but at this
>> point I think leveraging pahole's existing capability is a good option.
> 
> Agree, if there will be a future use-case where pahole might not be well-fitting,
> we could add it to bpftool then so I wouldn't rule it out, but for the functionality
> right now it seems good to reuse it. Presumably BPF developers have it installed
> anyway to inspect struct padding from BPF obj files.
> 
> Thanks,
> Daniel
> 

OK, I got it, thanks for answering my question so detailedly

Thanks,
Taeung
