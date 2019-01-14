Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A63F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7OIgu4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfANLMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:12:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38387 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfANLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:12:24 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so11649680ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nqx74b0TgHjCv4uxfTAn7fW6MmGsvUAeYihfBhSlYE=;
        b=X7OIgu4eEt0vjF5RmCMFe84MnDlwS18fwZy7c9//wMnqw/hR140WxAlPLer/i8OyIQ
         ZT6R7vtQaqCjZNzw7jEhvpRsL8NkHQRX+gLTDfzRZ796VbFtysah0RoJMsQLMWntpVR/
         X5zItbpqXEDEkQhrD5gdDBgWWPRfxDxCdRjHfKSS2RPBgfcspxoKCAeFOhKE+fufAjhZ
         Rmqlz4cVnXaUJ55jOMczdsCbhKuuCQ+oJWhwaeiNskH7J+nm+twhkkhMdoxOtqpZl0l/
         3ACDsgZgnfPYs8vTSMjSRD1fybSyT2/989iasAgMKvEUvkockY48I0CcD7edqFMobL0v
         /6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nqx74b0TgHjCv4uxfTAn7fW6MmGsvUAeYihfBhSlYE=;
        b=YV8wwStypiJByi+xzdxBrqO5EIxLQ5YH4Xg8Qv7eyLUqGD7Q/ZXf5U2NjBqHT+7hO6
         C6HdVaYeuklw8gi7DDCdydhrSocOjaOnKKEmG+B2NeRtzEnaFJch5ggFQ0NTey2p1S0y
         j4fvfDc2rbKv32HdZAbG6midBuT/DatMoZEnZq911y/gDgV1L7kh3IOhSyTTQBxpTSH3
         PWcjPaXxaQY/ooc4KuevaCGvOwAUk9jg2gNGG8q2dLiQnzJn80VS43wTk7un76Vn9Ji0
         B+WrZhOm4rKTz5ygrBNgogi0etGN5x/PdBSXszalziH5onfbE/AV9j6TdVOcbk1pxQEd
         lFsw==
X-Gm-Message-State: AJcUukdarmni3ZsdnnuSCuj2soUx+jhEJ7Gme1R/X7Rea9mZRyyI4LT/
        T2KTgC1n0n5rBzhXE38DISCZ19uwIdlqMgz6KHSodxkPqas2X24/
X-Google-Smtp-Source: ALg8bN6WHLqQALs88Bb0LSeKSwFieuS9rHF5Xc0PHn+PUkMvThEIrDtxu1oK/h0/ZlUUnPMvtVYzK+SFMuGgi5FGPf0=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr7034159iti.166.1547464343114;
 Mon, 14 Jan 2019 03:12:23 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007f604f057f2b8509@google.com> <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
 <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com> <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com>
 <234c868b-4521-0707-a135-d8c24bc179bd@schaufler-ca.com> <99cd1f6b-682e-7d1f-35ad-b9092d46323f@schaufler-ca.com>
In-Reply-To: <99cd1f6b-682e-7d1f-35ad-b9092d46323f@schaufler-ca.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Jan 2019 12:12:11 +0100
Message-ID: <CACT4Y+aSUaLMFDuodsEvPprcNsmTGG=A+P6hV_AxkTKR+7c66g@mail.gmail.com>
Subject: Re: WARNING in apparmor_cred_free
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 2:47 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/11/2019 3:20 PM, Casey Schaufler wrote:
> > On 1/11/2019 2:43 PM, Casey Schaufler wrote:
> >> On 1/11/2019 2:30 PM, John Johansen wrote:
> >>> On 1/11/19 2:11 PM, Casey Schaufler wrote:
> >>>> On 1/11/2019 1:43 AM, syzbot wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzbot found the following crash on:
> >>>>>
> >>>>> HEAD commit:    b808822a75a3 Add linux-next specific files for 20190111
> >>>>> git tree:       linux-next
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=179c22f7400000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c052ead0aed5001b
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=69ca07954461f189e808
> >>>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d947f400000
> >>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139f6c37400000
> >>>>>
> >>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>>>> Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

Please include the tag for tracking purposes.


> >>>>> ------------[ cut here ]------------
> >>>>> AppArmor WARN cred_label: ((!blob)):
> >>>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 cred_label security/apparmor/include/cred.h:30 [inline]
> >>>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
> >>>>> Kernel panic - not syncing: panic_on_warn set ...
> >>>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc1-next-20190111 #10
> >>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >>>>> Call Trace:
> >>>>>  <IRQ>
> >>>>>  __dump_stack lib/dump_stack.c:77 [inline]
> >>>>>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> >>>>>  panic+0x2cb/0x65c kernel/panic.c:214
> >>>>>  __warn.cold+0x20/0x48 kernel/panic.c:571
> >>>>>  report_bug+0x263/0x2b0 lib/bug.c:186
> >>>>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
> >>>>>  fixup_bug arch/x86/kernel/traps.c:173 [inline]
> >>>>>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
> >>>>>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
> >>>>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> >>>>> RIP: 0010:cred_label security/apparmor/include/cred.h:30 [inline]
> >>>>> RIP: 0010:apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
> >>>>> Code: 7c 88 48 c7 c7 00 d0 7c 88 e8 fd 70 f2 fd 0f 0b eb a9 e8 54 3f 29 fe 48 c7 c6 c0 df 7c 88 48 c7 c7 00 d0 7c 88 e8 e1 70 f2 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 80 38 00 75 4a 4c 8b 2c 25 00
> >>>>> RSP: 0018:ffff8880ae6079f8 EFLAGS: 00010286
> >>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >>>>> RDX: 0000000000000100 RSI: ffffffff81687fa6 RDI: 0000000000000006
> >>>>> RBP: ffff8880ae607a18 R08: ffffffff8987dec0 R09: 0000000000000000
> >>>>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a86b3100
> >>>>> R13: ffff8880a86b3100 R14: ffff8880a86b3188 R15: dffffc0000000000
> >>>>>  security_cred_free+0x4b/0xf0 security/security.c:1490
> >>>> The obvious thing to do is put a check in security_cred_free
> >>>> for a NULL cred->security, in which case the LSM hooks
> >>>> wouldn't get called.
> >>> Right, but the question is should we? To my thinking we shouldn't
> >>> ever have a cred without cred->security, unless the cred was
> >>> allocated but a later step in its construction, say allocating
> >>> ->security failed.
> >> If allocating ->security fails in security_cred_alloc_blank()
> >> or security_prepare_creds() you don't have to do anything but
> >> fail because the LSM hooks are not called before the allocation.
> >>
> >>> In which case I'd rather see the cred directly freed and not
> >>> call into security_cred_free() as I like being able to detect
> >>> corrupt creds.
> >> I think we need to look for some bit of code that's setting
> >> cred->security to NULL inappropriately.
> > If security_cred_alloc_blank() fails for lack of memory
> > in cred_alloc_blank() abort_creds() will be called. This
> > in turn calls put_cred() and put_cred_rcu(), which will
> > call security_cred_free() with ->security set to NULL.
> >
> > put_cred_rcu() is the only caller of security_cred_free().
> > The ->security == NULL check can be in either put_cred_rcu()
> > or in security_cred_free(). I suggest the latter as the
> > cleanest option.
>
> From 47134986133c822e1d88860fa2b108f92c97a7ff Mon Sep 17 00:00:00 2001
> From: Casey Schaufler <casey@schaufler-ca.com>
> Date: Fri, 11 Jan 2019 17:31:50 -0800
> Subject: [PATCH 1/2] LSM: Check for NULL cred-security on free
>
> Check that the cred security blob has been set before trying
> to clean it up. There is a case during credential initialization
> that could result in this.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/security/security.c b/security/security.c
> index a618e22df5c6..7bffc86d4e87 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1477,6 +1477,13 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>
>  void security_cred_free(struct cred *cred)
>  {
> +       /*
> +        * There is a failure case in prepare_creds() that
> +        * may result in a call here with ->security being NULL.
> +        */
> +       if (unlikely(cred->security == NULL))
> +               return;
> +
>         call_void_hook(cred_free, cred);
>
>         kfree(cred->security);
> --
> 2.20.1
>
>
