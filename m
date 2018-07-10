Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55F6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725220877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7725220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeGJAfu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:35:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeGJAfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:35:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 205A1E24;
        Tue, 10 Jul 2018 00:35:47 +0000 (UTC)
Date:   Mon, 9 Jul 2018 17:35:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Guenter Roeck <groeck@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <fengguang.wu@intel.com>
Subject: Re: what trees/branches to test on syzbot
Message-Id: <20180709173546.dc720ad918e5362b8be2e034@linux-foundation.org>
In-Reply-To: <e05a0804-6759-7579-c1d6-f0e80daf36ae@I-love.SAKURA.ne.jp>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
        <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
        <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
        <873735n3dy.fsf@xmission.com>
        <20180116173440.GA15893@kroah.com>
        <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
        <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
        <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
        <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp>
        <20180626141602.GA17788@thunk.org>
        <CACT4Y+YH3Z1q9aVTUgTbTPfDp2ao-z=YAjzBGU5HsjGJ-utgeg@mail.gmail.com>
        <CABXOdTe1HCy78w+G4LuN8S7Ad5kvUxwHsiP2a=8aW-jEvpjdug@mail.gmail.com>
        <876e38d9-95e5-0a93-9c26-7287151b8b53@i-love.sakura.ne.jp>
        <8c9027d6-ead2-1cca-4410-c8dbbe4bf2ea@I-love.SAKURA.ne.jp>
        <e05a0804-6759-7579-c1d6-f0e80daf36ae@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2018 08:26:32 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Hello Andrew,
> 
> It seems that syzbot (experimentally ?) restarted testing linux-next.
> 
> May I ask you to carry temporarily debug printk() patch at
> https://groups.google.com/d/msg/syzkaller-bugs/E8M8WTqt034/OpadOICfCAAJ
> for "INFO: task hung in __sb_start_write" case?
> 
> The bug should be reproduced within a day if executed under syzbot environment.
> Thus, I'm sure that we don't need to carry this patch for long.

Sure, I can add that.  Let's get the build warning sorted out first,
please.  Any old silly workaround will suffice in a developer-only
debug patch.

