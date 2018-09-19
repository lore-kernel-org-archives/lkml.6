Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15894C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD33A21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD33A21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbeISWfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:35:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbeISWfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:35:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D409E88303;
        Wed, 19 Sep 2018 16:56:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A447A84E3;
        Wed, 19 Sep 2018 16:56:42 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w8JGugi5009763;
        Wed, 19 Sep 2018 12:56:42 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w8JGub0k009759;
        Wed, 19 Sep 2018 12:56:37 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 19 Sep 2018 12:56:37 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Nathan March <nathan@gt.net>,
        =?ISO-8859-15?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: Re: [PATCHv5 0/7] tty: Hold write ldisc sem in tty_reopen()
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
Message-ID: <alpine.LRH.2.02.1809191256060.9689@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180917235258.5719-1-dima@arista.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-871284115-1537376202=:9689"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Sep 2018 16:56:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-871284115-1537376202=:9689
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 18 Sep 2018, Dmitry Safonov wrote:

> Hi all,
> 
> Three fixes that worth to have in the @stable, as they were hit by
> different people, including Arista on v4.9 stable.
> 
> And for linux-next - adding lockdep asserts for line discipline changing
> code, verifying that write ldisc sem will be held forthwith.
> 
> The last patch is an optional and probably, timeout can be dropped for
> read_lock(). I'll do it if everyone agrees.
> (Or as per discussion with Peter in v3, just convert ldisc to
> a regular rwsem).
> 
> Thanks,
> Dima

I confirm that this patch series fixes the crash for me.

Tested-by: Mikulas Patocka <mpatocka@redhat.com>


> Changes since v4:
> - back to lock ldisc with (5*HZ) timeout in tty_reopen()
>   (LKP report link: lkml.kernel.org/r/<1536940609.3185.29.camel@arista.com>)
> - reordered 3/7 with 2/7 for LKP robot
> 
> Changes since v3:
> - Added tested-by Mark Rutland (thanks!)
> - Dropped patch with smp_wmb() - wrong idea
> - lockdep_assert_held() should be actually lockdep_assert_held_exclusive()
> - Described why tty_ldisc_open() can be called without ldisc_sem held
>   for pty slave end (o_tty).
> - Added Peter's patch for dropping self-made lockdep annotations
> - Fix for a reader(s) of ldisc semaphore waiting for an active reader(s)
> 
> Changes since v2:
> - Added reviewed-by tags
> - Hopefully, fixed reported by 0-day issue.
> - Added optional fix for wait_readers decrement
> 
> Changes since v1:
> - Added tested-by/reported-by tags
> - Dropped 3/4 (locking tty pair for lockdep sake),
>   Because of that - not adding lockdep_assert_held() in tty_ldisc_open()
> - Added 4/4 cleanup to inc tty->count only on success of
>   tty_ldisc_reinit()
> - lock ldisc without (5*HZ) timeout in tty_reopen()
> 
> v1 link: lkml.kernel.org/r/<20180829022353.23568-1-dima@arista.com>
> v2 link: lkml.kernel.org/r/<20180903165257.29227-1-dima@arista.com>
> v3 link: lkml.kernel.org/r/<20180911014821.26286-1-dima@arista.com>
> v4 link: lkml.kernel.org/r/<20180912001702.18522-1-dima@arista.com>
> 
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Nathan March <nathan@gt.net>
> Cc: Pasi Kärkkäinen <pasik@iki.fi>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rong, Chen" <rong.a.chen@intel.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> (please, ignore if I Cc'ed you mistakenly)
> 
> Dmitry Safonov (6):
>   tty: Drop tty->count on tty_reopen() failure
>   tty/ldsem: Wake up readers after timed out down_write()
>   tty: Hold tty_ldisc_lock() during tty_reopen()
>   tty: Simplify tty->count math in tty_reopen()
>   tty/ldsem: Add lockdep asserts for ldisc_sem
>   tty/ldsem: Decrement wait_readers on timeouted down_read()
> 
> Peter Zijlstra (1):
>   tty/ldsem: Convert to regular lockdep annotations
> 
>  drivers/tty/tty_io.c    | 13 ++++++++---
>  drivers/tty/tty_ldisc.c |  9 +++++++
>  drivers/tty/tty_ldsem.c | 62 ++++++++++++++++++++-----------------------------
>  3 files changed, 44 insertions(+), 40 deletions(-)
> 
> -- 
> 2.13.6
> 
--185206533-871284115-1537376202=:9689--
