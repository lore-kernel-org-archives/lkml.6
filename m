Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB480C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0D0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0D0205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeJYAdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:33:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:46488 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:33:33 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gFLeC-00020a-Td; Wed, 24 Oct 2018 18:04:40 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gFLeC-0001aV-Jo; Wed, 24 Oct 2018 18:04:40 +0200
Subject: Re: [PATCH RFC v3 0/3] Rlimit for module space
To:     Jessica Yu <jeyu@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        alexei.starovoitov@gmail.com, netdev@vger.kernel.org
References: <20181019204723.3903-1-rick.p.edgecombe@intel.com>
 <CAKv+Gu_AgPv2o4=U0-7pnpgtSufEobnta8oKhhGfCdCxM82B5Q@mail.gmail.com>
 <6b1017c450d163539d2b974657baaaf697f0a138.camel@intel.com>
 <CAKv+Gu-Rk-SQVOQ63L3DkF3=EVik3pHXzpNp5r5TrgDajTM_iQ@mail.gmail.com>
 <20181024150706.jewcclhhh756tupn@linux-8ccs>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7cb6a8c-b7d6-5c82-6721-2b5387da673f@iogearbox.net>
Date:   Wed, 24 Oct 2018 18:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181024150706.jewcclhhh756tupn@linux-8ccs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25066/Wed Oct 24 15:00:13 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Alexei, netdev ]

On 10/24/2018 05:07 PM, Jessica Yu wrote:
> +++ Ard Biesheuvel [23/10/18 08:54 -0300]:
>> On 22 October 2018 at 20:06, Edgecombe, Rick P
>> <rick.p.edgecombe@intel.com> wrote:
[...]
>> I think it is wrong to conflate the two things. Limiting the number of
>> BPF allocations and the limiting number of module allocations are two
>> separate things, and the fact that BPF reuses module_alloc() out of
>> convenience does not mean a single rlimit for both is appropriate.
> 
> Hm, I think Ard has a good point. AFAIK, and correct me if I'm wrong,
> users of module_alloc() i.e. kprobes, ftrace, bpf, seem to use it
> because it is an easy way to obtain executable kernel memory (and
> depending on the needs of the architecture, being additionally
> reachable via relative branches) during runtime. The side effect is
> that all these users share the "module" memory space, even though this
> memory region is not exclusively used by modules (well, personally I
> think it technically should be, because seeing module_alloc() usage
> outside of the module loader is kind of a misuse of the module API and
> it's confusing for people who don't know the reason behind its usage
> outside of the module loader).
> 
> Right now I'm not sure if it makes sense to impose a blanket limit on
> all module_alloc() allocations when the real motivation behind the
> rlimit is related to BPF, i.e., to stop unprivileged users from
> hogging up all the vmalloc space for modules with JITed BPF filters.
> So the rlimit has more to do with limiting the memory usage of BPF
> filters than it has to do with modules themselves.
> 
> I think Ard's suggestion of having a separate bpf_alloc/free API makes
> a lot of sense if we want to keep track of bpf-related allocations
> (and then the rlimit would be enforced for those). Maybe part of the
> module mapping space could be carved out for bpf filters (e.g. have
> BPF_VADDR, BPF_VSIZE, etc like how we have it for modules), or
> continue sharing the region but explicitly define a separate bpf_alloc
> API, depending on an architecture's needs. What do people think?

Hmm, I think here are several issues mixed up at the same time which is just
very confusing, imho:

1) The fact that there are several non-module users of module_alloc()
as Jessica notes such as kprobes, ftrace, bpf, for example. While all of
them are not being modules, they all need to alloc some piece of executable
memory. It's nothing new, this exists for 7 years now since 0a14842f5a3c
("net: filter: Just In Time compiler for x86-64") from BPF side; effectively
that is even /before/ eBPF existed. Having some different API perhaps for all
these users seems to make sense if the goal is not to interfere with modules
themselves. It might also help as a benefit to potentially increase that
memory pool if we're hitting limits at scale which would not be a concern
for normal kernel modules since there's usually just a very few of them
needed (unlike dynamically tracing various kernel parts 24/7 w/ or w/o BPF,
running BPF-seccomp policies, networking BPF policies, etc which need to
scale w/ application or container deployment; so this is of much more
dynamic and unpredictable nature).

2) Then there is rlimit which is proposing to have a "fairer" share among
unprivileged users. I'm not fully sure yet whether rlimit is actually a
nice usable interface for all this. I'd agree that something is needed
on that regard, but I also tend to like Michal Hocko's cgroup proposal,
iow, to have such resource control as part of memory cgroup could be
something to consider _especially_ since it already _exists_ for vmalloc()
backed memory so this should be not much different than that. It sounds
like 2) comes on top of 1).

3) Last but not least, there's a short term fix which is needed independently
of 1) and 2) and should be done immediately which is to account for
unprivileged users and restrict them based on a global configurable
limit such that privileged use keeps functioning, and 2) could enforce
based on the global upper limit, for example. Pending fix is under
https://patchwork.ozlabs.org/patch/987971/ which we intend to ship to
Linus as soon as possible as short term fix. Then something like memcg
can be considered on top since it seems this makes most sense from a
usability point.

Thanks a lot,
Daniel
