Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF46218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546628847;
	bh=FeODntf5j4sIiYiALtAO6CeXsgDo2W0b/i+34BPAthU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jgwFFWYLZ6CvfodQqXMH/unDW+zA3o5qSTlA80aHgEPccgInw4qKnMk/jr3Nn9dgF
	 jsZUNuGL3wfFjIM5ATlnCBWyx/3zWxSWlIgtpOkqNnsaNgqBcSrvUjiFkbgxaIVRTd
	 0n7AuU11nBY6DlcCE6kHBepkKzuMJxQezoP6WiFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfADTH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfADTH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:07:26 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96F9218CD;
        Fri,  4 Jan 2019 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546628844;
        bh=FeODntf5j4sIiYiALtAO6CeXsgDo2W0b/i+34BPAthU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=igsrr4r7mTJ/VQyIgkImj/Q8aMuj6xRonux5sEJAv/SpxsMUL4OHmYErSFbW/xRf4
         HBrgnjf5A3+tKTfih7rnoByCxX07TyQqW9a8DZG/yO4jZfsT55/MKqnBOCkZGk+N37
         80tNvNbgplWixuqHzxzLz1XDRBbs/80wBUrfNhBI=
Subject: Re: selftests/bpf doesn't compile
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Networking <netdev@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20170908111923.27434-1-thomas@m3y3r.de>
 <20170908230155.esge2mctk5d5g7gb@ast-mbp> <59B32231.9090406@iogearbox.net>
 <ed20875b-7a01-fbc8-e8d1-3929ba35c8ac@kernel.org>
 <295553a4-aadc-e5d1-229e-22d1966bc9f5@kernel.org>
 <CAMuHMdXRN=mSKTjZNBSxQi-pkgSrKqeANxD-GB+hqC8pDjx7nQ@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e7aac6da-26f0-f700-5ed0-12b8c5c918b3@kernel.org>
Date:   Fri, 4 Jan 2019 12:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXRN=mSKTjZNBSxQi-pkgSrKqeANxD-GB+hqC8pDjx7nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 1/4/19 10:16 AM, Geert Uytterhoeven wrote:
> Hi Shuah,
> 
> CC kbuild, gpio
> 
> On Thu, Sep 14, 2017 at 5:34 PM Shuah Khan <shuah@kernel.org> wrote:
>> bpf test depends on clang and fails to compile when
>>
>> ------------------------------------------------------
>> make -C tools/testing/selftests/bpf run_tests
>>
>>
>> make: clang: Command not found
>> Makefile:39: recipe for target '.linux-kselftest/tools/testing/selftests/bpf/test_pkt_access.o' failed
>> make: *** [./linux-kselftest/tools/testing/selftests/bpf/test_pkt_access.o] Error 127
>> make: Leaving directory '.linux-kselftest/tools/testing/selftests/bpf'
> 
> The above failure is indeed due to missing clang.
> 
>> With "make TARGETS=bpf kselftest" it fails earlier:
>>
>> make[3]: Entering directory './linux-kselftest/tools/lib/bpf'
>> Makefile:40: tools/scripts/Makefile.arch: No such file or directory
>> Makefile:84: tools/build/Makefile.feature: No such file or directory
>> Makefile:143: tools/build/Makefile.include: No such file or directory
> 
> This is due to srctree being "." instead of the actual source tree,
> when invoked as "make kselftest".
> When using "make -C tools/testing/selftests", srctree is correct.
> 
> tools/testing/selftests/bpf/Makefile has:
> 
>      $(BPFOBJ): force
>              $(MAKE) -C $(BPFDIR) OUTPUT=$(OUTPUT)/
> 
> to enter the tools/lib/bpf directory to force a build of libbpf.a
> 
> Note that tools/gpio has the same issue.
> 
> There seem to be _four_ different ways to build kselftests
> (Documentation/dev-tools/kselftest.rst):
> 
>      make kselftest
>      make O=/path/to/output kselftest
>      make -C tools/testing/selftests
>      make O=/path/to/output -C tools/testing/selftests
> 
> I'm not so fond of the latter two, as they basically run make from
> somewhere inside the tree, which complicates things. I believe we don't
> support this anywhere else.
> 
> Each of the four seem to have (different) issues. Especially when you
> throw cross-compiling into the mix. And care about where installed
> headers end up (yes, kselftest calls headers_install internally).
> 
> I'm working on fixes for some of them, but I don't know how to fix the
> srctree issue.
> 

I will take a look at the srctree problem and fix it. I have had to fix
a few individual test Makefiles after ksefltest headers_install went in.

It will be in a week or two. I am taking some time off this week and
next week other than for occasional email checking.

thanks,
-- Shuah
