Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A487C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1E3218D7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVPI0elS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1E3218D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbeHGRCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:02:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41957 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbeHGRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:02:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so5568802ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f2BiY+o8tYbE55lKMdN683bfBjOCXmBdIx5t9IMYKoY=;
        b=uVPI0elSOtnRc4POaSrYhz8VeFbemoc5GR6tZBqfEW8g/48zfgmvTq4vUbVPw5u8bh
         IUPPyy7ezlMojEdVHMlmpK0UE1zmYvwVN7hYRg5zFGb0WAy7wNuauUkx2FQTOI1i67m/
         RgfRxBXuwKMGy3JPSExiGjRXsBWRHRSrCufVKCUFNtB1LeIBgUWNgL1Y6brVtKUb7RQU
         7DhdwU52nY4l7nWs8RQokNR75fEvoMDDh1MpjXhmaOON5HORDNYmp8ywdN9L0W4/nbwK
         t46jlmVmHv5PSEJLPlqDkk42z5wlDoIcsMcaT5CIAtdgJoSli7L6A+sSGmjyN7NmaWmz
         acfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f2BiY+o8tYbE55lKMdN683bfBjOCXmBdIx5t9IMYKoY=;
        b=Zyqi/J/u9krU5mFfmk8U++BBH/yemQ1jQgvWKa5ZjCX8cGUOFTZLGBjPWu0Da8N4Tb
         1dskGa1MryQe2diRzuSoRXW29QZoDHhlTfFrMTX9e75ViG83P7nCSJRplBo9+NGGLfX8
         VmabAbTXp8D95yOhRQqtmB97KYkbDpG/L+QJVvZ+P0Wv25ZNNlOrrqW2krCNGWUyP/f6
         u+yMN8xFqK5GsjnSGS0yBxeXAoVC8LWDxB7o6amWHGlwTpair71RY0XGyxTzAaZCFtAQ
         JlhFSRI5HzZgVdL9QWb3LSsGuvu+buey2q6ZPIpX2NUAhhOUjxHJi8fPiCz6UiRtBe5c
         Kc+g==
X-Gm-Message-State: AOUpUlGFUvlMbX2tZOS3tWJgl5SuAWIy8HvzUSpFly/IYaGgN9mvjHA7
        KdWVL6LZOCWSKV0eDJB2wEle969aqOCBXOCIS1p1Fw==
X-Google-Smtp-Source: AAOMgpdEqjUStOGGilouW9j0Pd2k2LNapEUe4YJl7nqcEnXNHPE2QNN5YmbIThYbr9SSlnJGQtvjon1iKxGXxL+tsIQ=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr18237170ply.93.1533653273869;
 Tue, 07 Aug 2018 07:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 7 Aug 2018 07:47:33
 -0700 (PDT)
In-Reply-To: <000000000000271b760572d934fe@google.com>
References: <CACT4Y+a+c6skSwS8WfY9GUs9mnjmf_aa7C5crW-m2Jb54ZbyuA@mail.gmail.com>
 <000000000000271b760572d934fe@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Aug 2018 16:47:33 +0200
Message-ID: <CACT4Y+YAhkymQQAfdMUQnWpQVp6WN=gG1u5Fvgz79eWiw79ZHQ@mail.gmail.com>
Subject: Re: Re: WARNING in input_alloc_absinfo
To:     syzbot <syzbot+@syzkaller.appspotmail.com>,
        syzbot <syzbot+c382812c78d98ecd9fb8@syzkaller.appspotmail.com>
Cc:     "'Dmitry Vyukov' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:28 PM, syzbot
<syzbot+@syzkaller.appspotmail.com> wrote:
>> On Thu, Jul 26, 2018 at 11:40 AM, Dmitry Vyukov <dvyukov@google.com>
>> wrote:
>>>
>>> On Mon, Jul 2, 2018 at 11:30 AM, Dmitry Vyukov <dvyukov@google.com>
>>> wrote:
>>>>
>>>> On Fri, Jun 29, 2018 at 11:59 PM,  <dmitry.torokhov@gmail.com> wrote:
>>>>>
>>>>> On Monday, June 25, 2018 at 5:43:02 AM UTC-7, Dmitry Vyukov wrote:
>
>
>>>>>> On Tue, Jun 19, 2018 at 8:51 PM, Dmitry Torokhov
>>>>>> <dmitry....@gmail.com> wrote:
>>>>>> > On Thu, Jun 14, 2018 at 05:47:03AM -0700, syzbot wrote:
>>>>>> >> Hello,
>>>>>> >>
>>>>>> >> syzbot found the following crash on:
>>>>>> >>
>>>>>> >> HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem
>>>>>> >> pages
>>>>>> >> git tree:       https://github.com/google/kmsan.git/master
>>>>>> >> console output:
>>>>>> >> https://syzkaller.appspot.com/x/log.txt?x=1775bae7800000
>>>>>> >> kernel config:
>>>>>> >> https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
>>>>>> >> dashboard link:
>>>>>> >> https://syzkaller.appspot.com/bug?extid=c382812c78d98ecd9fb8
>>>>>> >> compiler:       clang version 7.0.0 (trunk 329391)
>>>>>> >> syzkaller
>>>>>> >> repro:https://syzkaller.appspot.com/x/repro.syz?x=13b31ae7800000
>>>>>> >> C reproducer:
>>>>>> >> https://syzkaller.appspot.com/x/repro.c?x=1733255b800000
>>>>>> >>
>>>>>> >> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>> >> commit:
>>>>>> >> Reported-by: syzbot+c38281...@syzkaller.appspotmail.com
>>>>>> >>
>>>>>> >> RBP: 00000000006cb018 R08: 0000000000000001 R09: 00007ffe93080031
>>>>>> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
>>>>>> >> R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
>>>>>> >> ------------[ cut here ]------------
>>>>>> >> input_alloc_absinfo(): kcalloc() failed?
>>>>>> >> WARNING: CPU: 1 PID: 4498 at drivers/input/input.c:487
>>>>>> >> input_alloc_absinfo+0x183/0x190 drivers/input/input.c:487
>>>>>> >> Kernel panic - not syncing: panic_on_warn set ...
>>>>>> >
>>>>>> > Hmm, so there is not really a problem as far as I am concerned. We
>>>>>> > do
>>>>>> > generate a warning if we can't allocate memory for absinfo,  as this
>>>>>> > is
>>>>>> > really unexpected, but the case is handled properly by the callers
>>>>>> > so
>>>>>> > there is no reason for us to go belly up here.
>
>
>>>>>> Note to myself: ping this bug when "include/asm-generic/bug.h: clarify
>>>>>> valid uses of WARN()" is fully merged.
>
>
>
>>>>> No, this warning will still be there even after the "clarifying" patch
>>>>> is
>>>>> merged. It does not check user inputs, it warns that the system is so
>>>>> low on
>>>>> memory that we could not allocate measly amount needed for absinfo.
>>>>> Treat it
>>>>> as you treat OOM warnings from kmalloc() itself.
>
>
>>>> Hi Dmitry,
>
>
>>>> kmalloc does not produce WARNING on OOM. The rule is not only about
>>>> invalid inputs, it's also about any transient conditions and "WARNING
>>>> only for kernel bugs".
>
>
>>>> To put this in larger context, being able to distinguish kernel bugs
>>>> from non-bugs is a very important and practically useful capability,
>>>> which in particular enables systematic testing, but also makes things
>>>> simpler for all kernel users. There must be a very significant reason
>>>> to abandon this capability. What is that reason in this case?
>
>
>>>> I also don't understand what is so special about this case. If we want
>>>> user message for kmalloc failures, kmalloc is the right place for such
>>>> warning, rather than a random call site out of thousands. Consider,
>>>> the allocation failure can happen on the very next or previous kmalloc
>>>> call, and user won't be warned. The rest of the kernel (including the
>>>> rest of input sybsystem) does not warn on allocation failures, so that
>>>> looks like what we need to do here as well. Or, if there is something
>>>> very special about this particular kmalloc call site, something that
>>>> makes it different from thousands of other call sites, why don't you
>>>> want to replace it with pr_err which would both give the diagnostics
>>>> but also not block systematic testing? Which looks like a win-win to
>>>> me.
>
>
>>>> Thanks
>
>
>
>>> So, Dmitry, do you mind fixing this in the name of unblocking kernel
>>> testing?
>
>
>
>> Let's tell syzbot about the pending fix:
>
>
>> #syz fix: Input: do not use WARN() in input_alloc_absinfo()
>
>
> Can't find the corresponding bug.

Now with syzbot email in CC:

#syz fix: Input: do not use WARN() in input_alloc_absinfo()
