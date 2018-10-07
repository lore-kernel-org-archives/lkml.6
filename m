Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BB2C6783B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5402088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5402088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJHCrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:47:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54011 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbeJHCrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:47:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 31F76207C4; Sun,  7 Oct 2018 21:39:18 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id EDFEC20703;
        Sun,  7 Oct 2018 21:39:17 +0200 (CEST)
Date:   Sun, 7 Oct 2018 21:39:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com>,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: workqueue lockup (4)
Message-ID: <20181007193918.GC32272@piout.net>
References: <0000000000005764090577a27486@google.com>
 <CACT4Y+ZAoLro6LHhaA2EuWF1nAWAA=NAVtpMammhspL4V2aMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZAoLro6LHhaA2EuWF1nAWAA=NAVtpMammhspL4V2aMgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/10/2018 14:18:31+0200, Dmitry Vyukov wrote:
> On Sun, Oct 7, 2018 at 2:15 PM, syzbot
> <syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14c5f491400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=08116743f8ad6f9a6de7
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14514a6e400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025ebb9400000
> 
> The reproducer seems to be all about rtc. So +rtc maintainers.
> 

It seems to be that bug:
http://patchwork.ozlabs.org/patch/898552/

I'm pretty sure the fix is not correct though and didn't have the time
to work on a proper fix.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
