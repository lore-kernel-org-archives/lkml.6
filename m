Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE56C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0341A2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0341A2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbeHGQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:42:49 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:47655 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389612AbeHGQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:42:48 -0400
Received: by mail-io0-f199.google.com with SMTP id l25-v6so3494678iog.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=N6ie7m31aXAsFcdkPmTIswi9xbjXSJmZgYg5b3kfano=;
        b=mQeN4zxCnuZpCQ4nrFXbaH/Rbhw01tTnpTxW9CyRNoSnIRrXswpkvCPDW6Qz0cDWkN
         1aW38O5Rle2tnxb5kVMPZKXkPdCeohKTD2kEi4f1ekqB9Z09nE9plTOG7+SOEvBOyv2Z
         u4yNp6Z6IOBo9VV9pgoB6+uHLPH42s2YgL7I4ZsLVe9nRQwo5O25o1epYxDwIdeVno1E
         ydbV98/53qu4+SN2z/sUMW8BRqFdmg2ToszguQ/6GJU2yKkMF2mGQZ2ZzdmfyHs7OYLp
         nfL8yXnG0LQOiwILMH8HQW61WpkKukUhln/gWF/o66ieOv1AfTXcR3h2W5789t9j0xQr
         tHvA==
X-Gm-Message-State: AOUpUlGaLWEthNQiAb/XQMuCtiz267oWFiDe87kuQwfRguKDFx1ZGe45
        NMcMp/Hn0oMdaE8l22Q8mFf3Dzwdkf1GoZkKaAC5GpikxFPI
X-Google-Smtp-Source: AA+uWPxkCAy38zsltwocm1mAb4DBd4YnPx84jFo63euWHUrTVM5uP9z3WGn8FEVVtHSMHCt5AhtR0n3IQUJCnR8eCxB3w8MXqTH2
MIME-Version: 1.0
X-Received: by 2002:a24:1c10:: with SMTP id c16-v6mr7064809itc.13.1533652091998;
 Tue, 07 Aug 2018 07:28:11 -0700 (PDT)
Date:   Tue, 07 Aug 2018 07:28:11 -0700
In-Reply-To: <CACT4Y+a+c6skSwS8WfY9GUs9mnjmf_aa7C5crW-m2Jb54ZbyuA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000271b760572d934fe@google.com>
Subject: Re: Re: WARNING in input_alloc_absinfo
From:   syzbot <syzbot+@syzkaller.appspotmail.com>
To:     "'Dmitry Vyukov' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jul 26, 2018 at 11:40 AM, Dmitry Vyukov <dvyukov@google.com>  
> wrote:
>> On Mon, Jul 2, 2018 at 11:30 AM, Dmitry Vyukov <dvyukov@google.com>  
>> wrote:
>>> On Fri, Jun 29, 2018 at 11:59 PM,  <dmitry.torokhov@gmail.com> wrote:
>>>> On Monday, June 25, 2018 at 5:43:02 AM UTC-7, Dmitry Vyukov wrote:

>>>>> On Tue, Jun 19, 2018 at 8:51 PM, Dmitry Torokhov
>>>>> <dmitry....@gmail.com> wrote:
>>>>> > On Thu, Jun 14, 2018 at 05:47:03AM -0700, syzbot wrote:
>>>>> >> Hello,
>>>>> >>
>>>>> >> syzbot found the following crash on:
>>>>> >>
>>>>> >> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem  
>>>>> pages
>>>>> >> git tree:       https://github.com/google/kmsan.git/master
>>>>> >> console output:
>>>>> >> https://syzkaller.appspot.com/x/log.txt?x=1775bae7800000
>>>>> >> kernel config:
>>>>> >> https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
>>>>> >> dashboard link:
>>>>> >> https://syzkaller.appspot.com/bug?extid=c382812c78d98ecd9fb8
>>>>> >> compiler:       clang version 7.0.0 (trunk 329391)
>>>>> >> syzkaller
>>>>> >> repro:https://syzkaller.appspot.com/x/repro.syz?x=13b31ae7800000
>>>>> >> C reproducer:
>>>>> >> https://syzkaller.appspot.com/x/repro.c?x=1733255b800000
>>>>> >>
>>>>> >> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>> >> commit:
>>>>> >> Reported-by: syzbot+c38281...@syzkaller.appspotmail.com
>>>>> >>
>>>>> >> RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
>>>>> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
>>>>> >> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>>>>> >> ------------[ cut here ]------------
>>>>> >> input_alloc_absinfo(): kcalloc() failed?
>>>>> >> WARNING: CPU: 1 PID: 4498 at drivers/input/input.c:487
>>>>> >> input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
>>>>> >> Kernel panic - not syncing: panic_on_warn set ...
>>>>> >
>>>>> > Hmm, so there is not really a problem as far as I am concerned. We  
>>>>> do
>>>>> > generate a warning if we can't allocate memory for absinfo,  as  
>>>>> this is
>>>>> > really unexpected, but the case is handled properly by the callers  
>>>>> so
>>>>> > there is no reason for us to go belly up here.

>>>>> Note to myself: ping this bug when "include/asm-generic/bug.h: clarify
>>>>> valid uses of WARN()" is fully merged.


>>>> No, this warning will still be there even after the "clarifying" patch  
>>>> is
>>>> merged. It does not check user inputs, it warns that the system is so  
>>>> low on
>>>> memory that we could not allocate measly amount needed for absinfo.  
>>>> Treat it
>>>> as you treat OOM warnings from kmalloc() itself.

>>> Hi Dmitry,

>>> kmalloc does not produce WARNING on OOM. The rule is not only about
>>> invalid inputs, it's also about any transient conditions and "WARNING
>>> only for kernel bugs".

>>> To put this in larger context, being able to distinguish kernel bugs
>>> from non-bugs is a very important and practically useful capability,
>>> which in particular enables systematic testing, but also makes things
>>> simpler for all kernel users. There must be a very significant reason
>>> to abandon this capability. What is that reason in this case?

>>> I also don't understand what is so special about this case. If we want
>>> user message for kmalloc failures, kmalloc is the right place for such
>>> warning, rather than a random call site out of thousands. Consider,
>>> the allocation failure can happen on the very next or previous kmalloc
>>> call, and user won't be warned. The rest of the kernel (including the
>>> rest of input sybsystem) does not warn on allocation failures, so that
>>> looks like what we need to do here as well. Or, if there is something
>>> very special about this particular kmalloc call site, something that
>>> makes it different from thousands of other call sites, why don't you
>>> want to replace it with pr_err which would both give the diagnostics
>>> but also not block systematic testing? Which looks like a win-win to
>>> me.

>>> Thanks


>> So, Dmitry, do you mind fixing this in the name of unblocking kernel  
>> testing?


> Let's tell syzbot about the pending fix:

> #syz fix: Input: do not use WARN() in input_alloc_absinfo()

Can't find the corresponding bug.


> --
> You received this message because you are subscribed to the Google  
> Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an  
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit  
> https://groups.google.com/d/msgid/syzkaller-bugs/CACT4Y%2Ba%2Bc6skSwS8WfY9GUs9mnjmf_aa7C5crW-m2Jb54ZbyuA%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
