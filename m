Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01793C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B70820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6Uh5jyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B70820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeGZK5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:57:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34743 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeGZK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:57:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so820392pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aI9faliHU3CccrCmycSPUAbLM6SZdYqGHodTm1htIWM=;
        b=D6Uh5jyJvtZn/8/L12MaMcy+ec7sK2agG/lfceZaTyGjo1xdxi1OXH/UVw9giT0Lpn
         DHkTk1Kni6H7RxW+iiWhKoGbWrOwwQoRkrFHGBaOVDNftmd6lNuDeuK3epJcALVeDF1E
         KnNCv9QB5LSefG5EFlw2PCLaxaSzz3hsNg87b016SGWYQ8wKatVTOsdi5sXRcpEAljY6
         DtFD90zIzNmyaHAjegC0numObW6SbYEdMkeWmFUae1pg4wlyTwAE6qKsknaEqVewvtmc
         m8sheR27G079ZxdE7DqC14qZKQp4pcH5ZKAht4yq+IFQ+WwwHfBuQiE4Px87H69yq2M8
         eGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aI9faliHU3CccrCmycSPUAbLM6SZdYqGHodTm1htIWM=;
        b=boXXG+OKaDr0WVuBYVksUwK/2kjVzsnPu+LlHG4yEbs84FtF3zsby2FKNTa9IILZDZ
         LUE9jqJG0KIqmQ5QyyRYald57FFf1rrkYfxQOSEc6KMrtTTBALEk+VI5rGIWEE6k+nu3
         L8SJ2Y7mUmpoiuuY8xCglRrEj1JzNezjuzaVInL+GBjJ4i8grZS8yXba8TWUQEHn7por
         M3nA4EpuvSUkAsosdbGFbqbieLkwgF5KVEnMjZHNSQs6wFVpQeJveKltRYKRvTIGM1DZ
         j7utbw5Tvaknzth1vkkxkOrCfTqmR47Kk4+g3Fk/Yz4HM4JtoEDf32kuJtJMs92NUSr5
         hLYg==
X-Gm-Message-State: AOUpUlFP0tbTh5jgQXzKeIMIYjO+K08sY18v5xeCh9dQTyZTzQzcOCnI
        BqCrZn6Rq6hzPUpxilufNQNhz/XOivENKXkXtqoRWg==
X-Google-Smtp-Source: AAOMgpdoxFi0W6/8K8RufEr+qUaZ0Hv8zmSiUn2Iur5G9jU0WPlIfJ1+sdXODc0j8/WP6NShWmJSsjH/ZX8k7lfYDL4=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr1355518pfx.49.1532598063466;
 Thu, 26 Jul 2018 02:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:40:42
 -0700 (PDT)
In-Reply-To: <CACT4Y+b-=gPGQsbeFf44NTxhBJTAGwu+mUsAZDsquiUvpR9ROg@mail.gmail.com>
References: <000000000000fe1d2b056e997e1f@google.com> <20180619185111.GK71788@dtor-ws>
 <CACT4Y+bnzXgUT39h9PNdGDpOq8W-R-oaYtKEgN-ru2ZnVfAHBA@mail.gmail.com>
 <f1874631-5681-47d0-b9ae-e48632cdd4ce@googlegroups.com> <CACT4Y+b-=gPGQsbeFf44NTxhBJTAGwu+mUsAZDsquiUvpR9ROg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 26 Jul 2018 11:40:42 +0200
Message-ID: <CACT4Y+YwLjzquScZtL=Y0uu1a7qdKQN9Cv2Td7CCp7XR9zV7qw@mail.gmail.com>
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

On Mon, Jul 2, 2018 at 11:30 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Jun 29, 2018 at 11:59 PM,  <dmitry.torokhov@gmail.com> wrote:
>> On Monday, June 25, 2018 at 5:43:02 AM UTC-7, Dmitry Vyukov wrote:
>>>
>>> On Tue, Jun 19, 2018 at 8:51 PM, Dmitry Torokhov
>>> <dmitry....@gmail.com> wrote:
>>> > On Thu, Jun 14, 2018 at 05:47:03AM -0700, syzbot wrote:
>>> >> Hello,
>>> >>
>>> >> syzbot found the following crash on:
>>> >>
>>> >> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
>>> >> git tree:       https://github.com/google/kmsan.git/master
>>> >> console output:
>>> >> https://syzkaller.appspot.com/x/log.txt?x=1775bae7800000
>>> >> kernel config:
>>> >> https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
>>> >> dashboard link:
>>> >> https://syzkaller.appspot.com/bug?extid=c382812c78d98ecd9fb8
>>> >> compiler:       clang version 7.0.0 (trunk 329391)
>>> >> syzkaller
>>> >> repro:https://syzkaller.appspot.com/x/repro.syz?x=13b31ae7800000
>>> >> C reproducer:
>>> >> https://syzkaller.appspot.com/x/repro.c?x=1733255b800000
>>> >>
>>> >> IMPORTANT: if you fix the bug, please add the following tag to the
>>> >> commit:
>>> >> Reported-by: syzbot+c38281...@syzkaller.appspotmail.com
>>> >>
>>> >> RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
>>> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
>>> >> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>>> >> ------------[ cut here ]------------
>>> >> input_alloc_absinfo(): kcalloc() failed?
>>> >> WARNING: CPU: 1 PID: 4498 at drivers/input/input.c:487
>>> >> input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
>>> >> Kernel panic - not syncing: panic_on_warn set ...
>>> >
>>> > Hmm, so there is not really a problem as far as I am concerned. We do
>>> > generate a warning if we can't allocate memory for absinfo,  as this is
>>> > really unexpected, but the case is handled properly by the callers so
>>> > there is no reason for us to go belly up here.
>>>
>>> Note to myself: ping this bug when "include/asm-generic/bug.h: clarify
>>> valid uses of WARN()" is fully merged.
>>
>>
>> No, this warning will still be there even after the "clarifying" patch is
>> merged. It does not check user inputs, it warns that the system is so low on
>> memory that we could not allocate measly amount needed for absinfo. Treat it
>> as you treat OOM warnings from kmalloc() itself.
>
> Hi Dmitry,
>
> kmalloc does not produce WARNING on OOM. The rule is not only about
> invalid inputs, it's also about any transient conditions and "WARNING
> only for kernel bugs".
>
> To put this in larger context, being able to distinguish kernel bugs
> from non-bugs is a very important and practically useful capability,
> which in particular enables systematic testing, but also makes things
> simpler for all kernel users. There must be a very significant reason
> to abandon this capability. What is that reason in this case?
>
> I also don't understand what is so special about this case. If we want
> user message for kmalloc failures, kmalloc is the right place for such
> warning, rather than a random call site out of thousands. Consider,
> the allocation failure can happen on the very next or previous kmalloc
> call, and user won't be warned. The rest of the kernel (including the
> rest of input sybsystem) does not warn on allocation failures, so that
> looks like what we need to do here as well. Or, if there is something
> very special about this particular kmalloc call site, something that
> makes it different from thousands of other call sites, why don't you
> want to replace it with pr_err which would both give the diagnostics
> but also not block systematic testing? Which looks like a win-win to
> me.
>
> Thanks


So, Dmitry, do you mind fixing this in the name of unblocking kernel testing?
