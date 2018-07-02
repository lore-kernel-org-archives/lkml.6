Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBDF25451
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+94jQYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBDF25451
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeGBJbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:31:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35004 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933423AbeGBJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:30:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so6887093pgp.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VwVth5EeDDbc1CrSkDMTJDebQoJ23KIQ02bi3QMv8tk=;
        b=i+94jQYTIEFSVXpohrbp4/a8GlbZH0/C8QqCxPIpqD8m3QqgQwF7td1ON7AhTsrmpp
         A2XgtCS0wsmyEHiKj2BO7MdGv+X+XWhe/DPmCsJ2Tyw+A3QKIbCaL7kCf2fG1IVPbHAH
         QE8QJakW0IqB7QjIIR/AJBtaLrdiQ3JNuc9y7Xk622i2tP/yCOkd7HekOQvzskyPMUrj
         Hd9xqMhLen6wGyroMcwIrvRM8eJc1mz/CSCms0IXQdhda+g75/eRUPe1N9lJr1zbLYD3
         rGgQQdC0pGgGnYwQVoPT0KF7mTHf5Ohk6IZNHqee9KH4EI9pVZZPyHlDexPPv1YjcxEk
         2zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VwVth5EeDDbc1CrSkDMTJDebQoJ23KIQ02bi3QMv8tk=;
        b=ZlwdpfQQnkTwsumjzobxFbR/iRmtz1DORtmU5JJemqFbudNl64Dx/ZQlexQdE9g7kn
         6LcCRc762qT5vv8STsf5JS2vwmM0RLNPIlXEliGI7oAZb9s63M2N5GTaHe0Sjb2+0+A5
         AeI4FXVwdSCV4FrhefN1hO0ve9283gGAGsWAM0gixac5Zl12MzybdRFSvffxukgn4kPx
         LIuI3FMFbhn9v/Lq+QCf83C/zaWVCy3uSxvRftqkG9pw38LakQk7s0yjXkN2wlPrQ4yT
         sxNPUPE/DjKfV1yUoomHyZ/2rsbXanxhYCNob25sBUjVkJHHC21JCko+ytC+D1q16t2k
         qpGg==
X-Gm-Message-State: APt69E14arSuOANsxGXEX0fLuTM82W+lFIAfM0aTU2g6KrYkvelczFmq
        v8toZ4D1wVWIQ0pFWhWFFW+imcD8JympwBTNTokkXA==
X-Google-Smtp-Source: AAOMgpdbwpQpOSrWv5d6J3X/l7oKn6gEZ/5gk6gqvEWJaGXqrMYsl5mNzW44ic8GWCHFYstzMmcEkpJXukE9YDPMw0E=
X-Received: by 2002:a62:3f44:: with SMTP id m65-v6mr16965148pfa.98.1530523852242;
 Mon, 02 Jul 2018 02:30:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 2 Jul 2018 02:30:31
 -0700 (PDT)
In-Reply-To: <f1874631-5681-47d0-b9ae-e48632cdd4ce@googlegroups.com>
References: <000000000000fe1d2b056e997e1f@google.com> <20180619185111.GK71788@dtor-ws>
 <CACT4Y+bnzXgUT39h9PNdGDpOq8W-R-oaYtKEgN-ru2ZnVfAHBA@mail.gmail.com> <f1874631-5681-47d0-b9ae-e48632cdd4ce@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Jul 2018 11:30:31 +0200
Message-ID: <CACT4Y+b-=gPGQsbeFf44NTxhBJTAGwu+mUsAZDsquiUvpR9ROg@mail.gmail.com>
Subject: Re: WARNING in input_alloc_absinfo
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rydberg@bitmath.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:59 PM,  <dmitry.torokhov@gmail.com> wrote:
> On Monday, June 25, 2018 at 5:43:02 AM UTC-7, Dmitry Vyukov wrote:
>>
>> On Tue, Jun 19, 2018 at 8:51 PM, Dmitry Torokhov
>> <dmitry....@gmail.com> wrote:
>> > On Thu, Jun 14, 2018 at 05:47:03AM -0700, syzbot wrote:
>> >> Hello,
>> >>
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
>> >> git tree:       https://github.com/google/kmsan.git/master
>> >> console output:
>> >> https://syzkaller.appspot.com/x/log.txt?x=1775bae7800000
>> >> kernel config:
>> >> https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
>> >> dashboard link:
>> >> https://syzkaller.appspot.com/bug?extid=c382812c78d98ecd9fb8
>> >> compiler:       clang version 7.0.0 (trunk 329391)
>> >> syzkaller
>> >> repro:https://syzkaller.appspot.com/x/repro.syz?x=13b31ae7800000
>> >> C reproducer:
>> >> https://syzkaller.appspot.com/x/repro.c?x=1733255b800000
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the
>> >> commit:
>> >> Reported-by: syzbot+c38281...@syzkaller.appspotmail.com
>> >>
>> >> RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
>> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
>> >> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>> >> ------------[ cut here ]------------
>> >> input_alloc_absinfo(): kcalloc() failed?
>> >> WARNING: CPU: 1 PID: 4498 at drivers/input/input.c:487
>> >> input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
>> >> Kernel panic - not syncing: panic_on_warn set ...
>> >
>> > Hmm, so there is not really a problem as far as I am concerned. We do
>> > generate a warning if we can't allocate memory for absinfo,  as this is
>> > really unexpected, but the case is handled properly by the callers so
>> > there is no reason for us to go belly up here.
>>
>> Note to myself: ping this bug when "include/asm-generic/bug.h: clarify
>> valid uses of WARN()" is fully merged.
>
>
> No, this warning will still be there even after the "clarifying" patch is
> merged. It does not check user inputs, it warns that the system is so low on
> memory that we could not allocate measly amount needed for absinfo. Treat it
> as you treat OOM warnings from kmalloc() itself.

Hi Dmitry,

kmalloc does not produce WARNING on OOM. The rule is not only about
invalid inputs, it's also about any transient conditions and "WARNING
only for kernel bugs".

To put this in larger context, being able to distinguish kernel bugs
from non-bugs is a very important and practically useful capability,
which in particular enables systematic testing, but also makes things
simpler for all kernel users. There must be a very significant reason
to abandon this capability. What is that reason in this case?

I also don't understand what is so special about this case. If we want
user message for kmalloc failures, kmalloc is the right place for such
warning, rather than a random call site out of thousands. Consider,
the allocation failure can happen on the very next or previous kmalloc
call, and user won't be warned. The rest of the kernel (including the
rest of input sybsystem) does not warn on allocation failures, so that
looks like what we need to do here as well. Or, if there is something
very special about this particular kmalloc call site, something that
makes it different from thousands of other call sites, why don't you
want to replace it with pr_err which would both give the diagnostics
but also not block systematic testing? Which looks like a win-win to
me.

Thanks
