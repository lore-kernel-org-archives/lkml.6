Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAEDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1BB26970
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6o5IwUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1BB26970
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965385AbeFZOiz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:38:55 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964772AbeFZOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:38:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id w8-v6so7714658pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=SxQroKpBaBKrzbnif2s7oWfECxJ1tmTwJ1hv8zSqWco=;
        b=o6o5IwUSdTShTdXP0oyId2RQtfYnfEcjwYXhYslYWR7DTAo+nYBX9k/TrQIGsFKCE/
         y+xhIcQtReaiIZ/73Okp+QYAR6Dgzl2QC0WmA+8GG58GsF7k3hmDEPhbGV3ctr3Obrlm
         aYOFy28/gsk0IlTvUrNNZmAitfUZmNpX3uGdQbfQZ9J6pbRDc4pICy+xeeWkYwdwySCU
         2c38QHjYHV+lWq7XEPt9mcewlIuNCAKUGfAOuxaJ/VqzvTI4JfdRJA4TH+dYuYYNu/am
         JMKfVBmjgcysvHIKz42S0+apXPhANfSdoikqKZBskoMw05oeKD7C2zfDirI0cO0Qs2xB
         a22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=SxQroKpBaBKrzbnif2s7oWfECxJ1tmTwJ1hv8zSqWco=;
        b=IgOQPKsa5oGeUqdFTy2coKAHtUD0E6cZ9+dO5BDNtioE5JPPB8ww0y5LNLFBn2W0Be
         sYmKFOLJBs5ln1ayMsBj9OJVN8RLn7oxZdT/MBURjMlxAg5ioMCPEjOplf8LrqcKR2am
         UIpPyaR3e3tcYMfR5L7xxlY4ZQwVS/SogX+hN1vttSSx+9Oxn7U3NRcs+7NxhFpuT2z9
         6SfJ2CbQuJaiYHcJUy6DC8NtvKVNpiXivY9XlER+yO8WzcYVOgP33XhIi7GhoakxX9uh
         XXVVG5Uh44NSPpcV7A6VeaxnaJrydvJy2OwShH29VvRLOSDXKBoHDfX8McZeGzmsAJEW
         HpGw==
X-Gm-Message-State: APt69E19ZJtxgz15nshtcTyuTq+gav8kZoYDExBFPRfxTNH1ZlM42Ifz
        Q1qSgf1k4Z8M0YwYd13w/qlcYgpgZ9UdjV7e0O/ofg==
X-Google-Smtp-Source: ADUXVKJoD2fxO9gLnk1SifZmYXLTkRqMd3R1Z0mdhBPoDF8OpuKC4VaFTFLg9NaaZyew/5kcd/w0caZmGEk9n41vpT8=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr1644784pgu.96.1530023930355;
 Tue, 26 Jun 2018 07:38:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 26 Jun 2018 07:38:29
 -0700 (PDT)
In-Reply-To: <20180626141602.GA17788@thunk.org>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
 <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp> <20180626141602.GA17788@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Jun 2018 16:38:29 +0200
Message-ID: <CACT4Y+YH3Z1q9aVTUgTbTPfDp2ao-z=YAjzBGU5HsjGJ-utgeg@mail.gmail.com>
Subject: Re: what trees/branches to test on syzbot
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:16 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, Jun 26, 2018 at 07:54:53PM +0900, Tetsuo Handa wrote:
>> I hope we can accept NOW either "reviving linux-next.git" or "allowing debug printk()
>> patches for linux.git". For example, "INFO: task hung in __sb_start_write" got 900
>> crashes in 81 days but still unable to find a reproducer. Dmitry tried to reproduce
>> locally with debug printk() patches but not yet successful. I think that testing with
>> http://lkml.kernel.org/r/f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp
>> on linux.git or linux-next.git is the only realistic way for debugging this bug.
>> More we postpone revival of the linux-next, more syzbot reports we will get...
>
> Here's a proposal for adding linux-next back:
>
> *) Subsystems or maintainers need to have a way to opt out of getting
>    spammed with Syzkaller reports that have no reproducer.  More often
>    than not, they are not actionable, and just annoy the maintainers,
>    with the net result that they tune out all Syzkaller reports as
>    noise.

False. You can count yourself. 2/3 are actionable and fixed.

This also makes the following point ungrounded.

> *) Email reports for failures on linux-next that correspond to known
>    failures on mainline should be suppressed.  Another way of doing
>    this would be to only report a problem found by a specific
>    reproducer to the mailing list unless the recipient has agreed to
>    be spammed by Syskaller noise.
>
> And please please please, Syzkaller needs to figure out how to do
> bisection runs once you have a reproducer.
>
>                                                 - Ted
