Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300A5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52342086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52342086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeFRNzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:55:19 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:33358 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754601AbeFRNzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:55:18 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w5IDsNpk007745;
        Mon, 18 Jun 2018 14:54:23 +0100
Date:   Mon, 18 Jun 2018 14:54:22 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: what trees/branches to test on syzbot
Message-ID: <20180618145422.11b61298@alans-desktop>
In-Reply-To: <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
        <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
        <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
        <873735n3dy.fsf@xmission.com>
        <20180116173440.GA15893@kroah.com>
        <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
        <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
        <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
        <20180610015107.GC5020@thunk.org>
        <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
        <20180611012250.GD5020@thunk.org>
        <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But forward bisection (when bug is fixed) unfortunately won't work
> because these commits are not connected to HEAD. And forward bisection
> is very important, otherwise who will bring order to all these
> hundreds of open bugs?
> https://syzkaller.appspot.com/

Bisection isn't so important when you are trying to close bugs that
got fixed, with a note that it's no longer reproducable. It might mean the
reproducer broke but it also stops you drowning and it tells a user that
they might as well try the new one and see if still breaks thus
collecting the information needed.

True it's nice to know what commit may have magically fixed it but it's
not essential. Further more once you see a bug is fixed even in -next you
can later run the reproducer against an actual release to make sure it's
still fixed there, and bisect between previous release and that release to
find a mainline commit id if it's a single fix point.

Alan
