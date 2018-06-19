Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336FCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022DA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbdEUNje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022DA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937109AbeFSBrH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:47:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35724 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeFSBrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:47:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so9098397pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=muloq8m/z0GLbSGl9q+tWuLPoztrdNlJKhvIyBAZsCI=;
        b=QbdEUNjegKDuzbnTFQPiS3/jaNW/0YhAfTi4Lc4/Wvk8rHA81Xhuz1iDTuZtumm9ST
         AI3zpGOXN479Y5pDJrLK1dQ8TkpHi7nS/AF+D1Q+HeCEBYM09bMSIoOpNqQh+nEee1lz
         oI/opzf9u7me5JYD2NNiT+ZEdmujn51xmNlU1P0Xg6PUjwAeVvNikNkwmSQdClndnta7
         TaTCmi+dFkBC1KpJZzI5DtCVKGDHJr08uP1hmf4h58Id4qB9wJlWrcBpqu2a/rlK/8Gg
         REanddDpK6jaFN7iBZ5o1NBQ68e6GDlL1eGl8CJ40iVmG/O2x94UaYEKm+cNzvil7+R+
         FrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muloq8m/z0GLbSGl9q+tWuLPoztrdNlJKhvIyBAZsCI=;
        b=GqqTzDrZe+SB0nYwyIPBswSQ0p2NVnDRLQed/5NfMng9yIzj16qfOFRZfqKJfuHj78
         9amoJurV3L5vq7RLrJEPU2ciztbRWeTcBL7WwsjOIcIUJLYyY26QEPr8LgUpVIQv+2D2
         DZ7IFkorb5BQYFJGtVjggZGGdyxUvK+LOjJHq24/WOYe3vk3sOsN+69yoQMQTuYV6Az+
         Z99EAeK8qhRyMCFu00KRIZ6BnKPls5QLj6avVXYZ7YsoSkrdiwyTjlN5vHHhONmQHJWA
         OtW+QrmNeihApSkOYLRvg0u2P3bYBV9XwKpKzZOeZOOllfFApAprpV9G3uGoq0quWFCB
         j4xw==
X-Gm-Message-State: APt69E2dX3jKmPOaAgdRDiBRYhcW2slWAmk/F3cPymG4gQkfQXZtp81H
        /xwcmeLK/VbqeDulGUScMsV27g==
X-Google-Smtp-Source: ADUXVKJ/qcHbYxRjD85+guiXhh26KM7OU/GbLTXC8TBoZQpF9KNJOzL1BFLRXNNMuChOgSgadMtlmA==
X-Received: by 2002:a63:6741:: with SMTP id b62-v6mr13137400pgc.5.1529372824432;
        Mon, 18 Jun 2018 18:47:04 -0700 (PDT)
Received: from jchowdhary0.mtv.corp.google.com ([2620:0:1000:1612:de71:f59c:9968:92ba])
        by smtp.gmail.com with ESMTPSA id g2-v6sm27170525pfc.4.2018.06.18.18.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 18:47:03 -0700 (PDT)
Subject: Re: uapi headers userspace build results
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com
References: <8b90457a-5b1d-818c-d2d6-ba3d16ad3eaf@infradead.org>
 <1ef3a7b9-5172-9f7a-01fa-4866e765fbbe@google.com>
 <b5a73c3f-b70d-110f-896d-82fd81982cf8@infradead.org>
From:   Jayant Chowdhary <jchowdhary@google.com>
Message-ID: <8a36d3ba-977b-49ca-c431-90ef53071f88@google.com>
Date:   Mon, 18 Jun 2018 18:47:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5a73c3f-b70d-110f-896d-82fd81982cf8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 06/12/2018 05:07 PM, Randy Dunlap wrote:
> On 06/12/2018 01:39 PM, Jayant Chowdhary wrote:
>> Hi Randy,
>>
>> On 06/11/2018 10:49 PM, Randy Dunlap wrote:
>>> Hi,
>>>
>>> Here is what I have so far.  It begins with a makefile and some
>>> template files that are added to.  There's a good bit of Perl also.
>>>
>>> I put all of these files in tools/uapi/ and run them from there.
>>>
>>> There is one .c file generated for each .h file in builddir/usr/include
>>> (O=builddir).
>>>
>>
>> Thanks for this! I wrote a small Makefile (uapi-compile.mk) which I'd put in
>> tools/build (I can change this to tools/uapi, if that is more apt).
> 
> Your makefile foo is much better than mine is.
> Yes, I think that it deserves to be in its own sub-directory.
> 
>> uapi-compile.mk straight-away compiles the uapi headers, without pulling them
>> into any generated c source files. It may also be invoked with an environment
> 
> Hm, I didn't even know that is possible.
> 
>> variable 'UAPI_DIR' specifying the directory, for which the user would like to
>> compile headers. This way we can test a directory at a time as well. In your
> 
> Yes, good, I was planning to make a way to restrict the build to certain sub-dirs.
> 
>> opinion, would this be simpler to have rather than having to auto-generate c
>> source files including each uapi header and also autog-enerating the make
>> targets? I feel like this approach would make maintaining these makefiles/
>> scripts easier as well.
> 
> Sure, this is much better than my scripts.
> 
>>> Out of 889 header files, I see 45 errors.  That is better than I expected.
>>>
>>> The makefiles and scripts are attached (tar), as well as the output (I used
>>> 'make -ik' so that make would keep going after errors and attempt to build
>>> all target files).
>>>
>>> have fun!
>>>
>>
>> I did a 'make ARCH=arm64 headers_install' from the kernel source's root, and
>> then a 'make -kf uapi-compile.mk all > build.log 2>&1' to compile all the
>> headers. Out of 864 headers, I see 20 compilation failures.
>>
>> I'm attaching uapi-compile.mk and the build.log file along.
> 
> I have some usage comments.
> 
> Since I ran 'make ARCH=x86_64 O=xx64 headers_install', I had to modify
> uapi-compile.mk to use that SRC_DIR:
> 
> SRC_DIR :=../../xx64
> 
> Also, I first tried to make BDIR as a sub-directory of tools/uapi/ and
> uapi-compile.mk did not work (when using BDIR=BDIR).
> Then I did 'mkdir ../../xx64/BDIR' and specified BDIR=../../xx64/BDIR and
> that worked.  But:  that sub-dir is not used:
> 
> gcc -I../../xx64/usr/include/ --include=../../xx64/usr/include/linux/posix_types.h --include=../../xx64/usr/include/asm-generic/ipcbuf.h --include=stdarg.h --include=stdint.h --include=stddef.h -c ../../xx64/usr/include//linux/caif/caif_socket.h -o ../../xx64/BDIR/../../xx64/usr/include//linux/caif/caif_socket.o
> [see the next comment]
> 
> Oh, this makefile builds the .o files in the same sub-dirs as their
> respective .h files.  I don't especially like that, but as long as
> make clean works, it will do.  [and make clean does work]
> 

Thanks for these comments. I'll take care of them in my patch-set. I've got a
couple of questions for you. Since most of the errors were found in the
include/uapi/linux directory, I tried investigating why.

1) I found that multiple headers depend on the definition of types such as
pid_t, which have no definition in the set of uapi headers. There is a
definition (of pid_t) in include/linux/types.h, and I thought we could try
exposing that in the set of uapi headers. One problem I can see with that is
that the header has some definitions which depend on kernel configs: eg:
CONFIG_ARCH_DMA_ADDR_T_64BIT. Since user-land programs shouldn't really assume
kernel configs, I was thinking we should re-factor this header so that
appropriate parts can be exposed to user-land.

2) Some headers try to expose information which should probably not be exposed
to user-land. eg: wait_queue_head in linux/coda_psdev.h (this header should
probably be removed altogether ?)

Do you have better ideas ?

Thanks,
Jayant

> Thanks.
> 
