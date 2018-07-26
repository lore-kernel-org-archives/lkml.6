Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA2020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeGZBk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:40:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:52774 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeGZBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:40:58 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiU79-0001VS-1z; Thu, 26 Jul 2018 02:26:43 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiU78-0003xx-NJ; Thu, 26 Jul 2018 02:26:42 +0200
Subject: Re: pahole + BTF was: Re: [Question] bpf: about a new
 'tools/bpf/bpf_dwarf2btf'
To:     Martin KaFai Lau <kafai@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
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
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <96728b5e-8e41-a1df-be63-becbd9606307@iogearbox.net>
Date:   Thu, 26 Jul 2018 02:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180725201122.h7ostqw3qtfvz7sn@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24782/Wed Jul 25 18:44:42 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 10:11 PM, Martin KaFai Lau wrote:
> On Thu, Jul 26, 2018 at 04:21:31AM +0900, Taeung Song wrote:
>> On 07/26/2018 03:27 AM, Taeung Song wrote:
>>> On 07/26/2018 02:52 AM, Arnaldo Carvalho de Melo wrote:
>>>> Em Thu, Jul 26, 2018 at 02:23:32AM +0900, Taeung Song escreveu:
>>>>> Hi,
>>>>>
>>>>> Building bpf programs with .BTF section,
>>>>> I thought it'd be better to convert dwarf info to .BTF by
>>>>> a new tool such as 'tools/bpf/bpf_dwarf2btf' instead of pahole
>>>>> in the future.
>>>>> Currently for bpf binary that have .BTF section,
>>>>> we need to use pahole from https://github.com/iamkafai/pahole/tree/btf
>>>>> with the command line such as "pahole -J bpf_prog.o".
>>>>> I think it is great but if implementing new 'bpf_dwarf2btf'
>>>>> (dwarf parsing + btf encoder code written by Martin KaFai Lau on
>>>>> the pahole project i.e. btf.h, btf_encoder.c, btf_encoder.h,
>>>>> libbtf.c, libbtf.h),
>>>>> BPF developers would more easily use functionalities based on BTF.
>>>>
>>>> What would be easier exactly? Not having to install a package but build
>>>> it from the kernel sources?
>>>>
>>>> Many kernel developers already have pahole installed for other uses, so
>>>> no need to install anything.
>>>
>>> Understood, but I think there are many non-kernel developers
>>> developing BPF programs and they mightn't have or use pahole.
>>>
>>> So, if providing the 'dwarf2btf' feature on tools/bpf or tools/bpf/bpftool,
>>> non-kernel developers can also more easily build bpf prog with .BPF, no ?
> Some quick thoughts,
> IMO, I suspect if it is in the distro's pahole package,  it should be easy
> enough for kernel and non kernel developer to install.
> BTF usage is still evolving,  we might re-evaluate going forward but at this
> point I think leveraging pahole's existing capability is a good option.

Agree, if there will be a future use-case where pahole might not be well-fitting,
we could add it to bpftool then so I wouldn't rule it out, but for the functionality
right now it seems good to reuse it. Presumably BPF developers have it installed
anyway to inspect struct padding from BPF obj files.

Thanks,
Daniel
