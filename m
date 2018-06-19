Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2790DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD639205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrbAQWiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD639205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967153AbeFSSRW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:17:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55678 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xlog6HnpcH68/dKXzvjM659CErpZPHjyr3/cT8T7oFw=; b=YrbAQWiA6pFYySqBtodnJxTS2U
        37L0unVQODVVbSWmdMi0QTvha24/2ftuVY92TEZDqqXyHZPGE6mnjnsOI6j+aX1W5hQJjFXIuHoDk
        3DHDewxOBEzW4CZmsA/9q3WmT3ZToVYYnlQWD0+FDLsUAvFLWIHmWxMPhKhdceiOR6u3tnPkYDV+o
        /fq3hmSy/Mg5bkIMAvR7zzXTwkkXhcV3xotq4eqb8k6VrEjOPotOyxVd7v1RqHsyP4/Zfq+M8/Qal
        XilmHLkSrtgh2kd1lq/CdNELUMk5ySxur1oyhSlYVHE8R3x9ShgpDCd3CgF51tubgf/UxeimVdGiB
        +oxJlyrQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVLBr-0006qu-L6; Tue, 19 Jun 2018 18:17:15 +0000
Subject: Re: uapi headers userspace build results
To:     Jayant Chowdhary <jchowdhary@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com
References: <8b90457a-5b1d-818c-d2d6-ba3d16ad3eaf@infradead.org>
 <1ef3a7b9-5172-9f7a-01fa-4866e765fbbe@google.com>
 <b5a73c3f-b70d-110f-896d-82fd81982cf8@infradead.org>
 <8a36d3ba-977b-49ca-c431-90ef53071f88@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b76d1b6-08a4-36cf-4fc8-661b216ca433@infradead.org>
Date:   Tue, 19 Jun 2018 11:17:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8a36d3ba-977b-49ca-c431-90ef53071f88@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 06:47 PM, Jayant Chowdhary wrote:
> Hi Randy,
> 
> On 06/12/2018 05:07 PM, Randy Dunlap wrote:
>> On 06/12/2018 01:39 PM, Jayant Chowdhary wrote:
>>> Hi Randy,
>>>
>>> On 06/11/2018 10:49 PM, Randy Dunlap wrote:
>>>> Hi,
>>>>
>>>> Here is what I have so far.  It begins with a makefile and some
>>>> template files that are added to.  There's a good bit of Perl also.
>>>>
>>>> I put all of these files in tools/uapi/ and run them from there.
>>>>
>>>> There is one .c file generated for each .h file in builddir/usr/include
>>>> (O=builddir).
>>>>
>>>
>>> Thanks for this! I wrote a small Makefile (uapi-compile.mk) which I'd put in
>>> tools/build (I can change this to tools/uapi, if that is more apt).
>>
>> Your makefile foo is much better than mine is.
>> Yes, I think that it deserves to be in its own sub-directory.
>>
>>> uapi-compile.mk straight-away compiles the uapi headers, without pulling them
>>> into any generated c source files. It may also be invoked with an environment
>>
>> Hm, I didn't even know that is possible.
>>
>>> variable 'UAPI_DIR' specifying the directory, for which the user would like to
>>> compile headers. This way we can test a directory at a time as well. In your
>>
>> Yes, good, I was planning to make a way to restrict the build to certain sub-dirs.
>>
>>> opinion, would this be simpler to have rather than having to auto-generate c
>>> source files including each uapi header and also autog-enerating the make
>>> targets? I feel like this approach would make maintaining these makefiles/
>>> scripts easier as well.
>>
>> Sure, this is much better than my scripts.
>>
>>>> Out of 889 header files, I see 45 errors.  That is better than I expected.
>>>>
>>>> The makefiles and scripts are attached (tar), as well as the output (I used
>>>> 'make -ik' so that make would keep going after errors and attempt to build
>>>> all target files).
>>>>
>>>> have fun!
>>>>
>>>
>>> I did a 'make ARCH=arm64 headers_install' from the kernel source's root, and
>>> then a 'make -kf uapi-compile.mk all > build.log 2>&1' to compile all the
>>> headers. Out of 864 headers, I see 20 compilation failures.
>>>
>>> I'm attaching uapi-compile.mk and the build.log file along.
>>
>> I have some usage comments.
>>
>> Since I ran 'make ARCH=x86_64 O=xx64 headers_install', I had to modify
>> uapi-compile.mk to use that SRC_DIR:
>>
>> SRC_DIR :=../../xx64
>>
>> Also, I first tried to make BDIR as a sub-directory of tools/uapi/ and
>> uapi-compile.mk did not work (when using BDIR=BDIR).
>> Then I did 'mkdir ../../xx64/BDIR' and specified BDIR=../../xx64/BDIR and
>> that worked.  But:  that sub-dir is not used:
>>
>> gcc -I../../xx64/usr/include/ --include=../../xx64/usr/include/linux/posix_types.h --include=../../xx64/usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../../xx64/usr/include//linux/caif/caif_socket.h -o ../../xx64/BDIR/../../xx64/usr/include//linux/caif/caif_socket.o
>> [see the next comment]
>>
>> Oh, this makefile builds the .o files in the same sub-dirs as their
>> respective .h files.  I don't especially like that, but as long as
>> make clean works, it will do.  [and make clean does work]
>>
> 
> Thanks for these comments. I'll take care of them in my patch-set. I've got a
> couple of questions for you. Since most of the errors were found in the
> include/uapi/linux directory, I tried investigating why.

Please also repost your latest patch-set.

> 1) I found that multiple headers depend on the definition of types such as
> pid_t, which have no definition in the set of uapi headers. There is a
> definition (of pid_t) in include/linux/types.h, and I thought we could try
> exposing that in the set of uapi headers. One problem I can see with that is
> that the header has some definitions which depend on kernel configs: eg:
> CONFIG_ARCH_DMA_ADDR_T_64BIT. Since user-land programs shouldn't really assume
> kernel configs, I was thinking we should re-factor this header so that
> appropriate parts can be exposed to user-land.

Sure, that's worth a try.  Mostly on a case-by-case basis.

I see that (at least in the distro that I am using)
/usr/include/asm-generic/posix_types.h has a typedef for __kernel_pid_t.
I wonder if that could be co-opted, but I expect that this would have
type/size issues.

OTOH, 'man getpid' uses pid_t and refers to <sys/types.h> and <unistd.h>,
so there should already be a pid_t for userspace.  Just #include more
headers files.  :)

> 2) Some headers try to expose information which should probably not be exposed
> to user-land. eg: wait_queue_head in linux/coda_psdev.h (this header should
> probably be removed altogether ?)

I suppose that header file describes a kernel-to-userspace ("Venus") interface,
so maybe not removed altogether.  But the wait_queue_head_t part of it should
just be some padding/reserved field (of what size/type?).


> Do you have better ideas ?

slow and steady.

-- 
~Randy
