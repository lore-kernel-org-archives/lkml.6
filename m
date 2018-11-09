Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1220818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="lIRyjgsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKJG1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:27:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeKJG1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:27:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id u13-v6so1442940pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqeW8MnbDg2PokJJQw17Go2b59puuLzNW0F5TYLSyF8=;
        b=lIRyjgsALz9gD/229FsCi+xZO42yKODRhEtA94EbIdH9kMpjesJTiu/MZ55+iRXj3W
         q0kRgJH2ycJ+wK0EW0k6EUSQFkq85E7Sr0c1+NMS3LEFqjA+tape7E9pKTk8PpJxcKRT
         qtJWWDvus0vyU214sA2SnllSlsRSgIa5QzdTdVDIzW2vzyHPsIgjGcCwXw0y6aPUIfHw
         +sp8hqHQggVqDopKopfjs3Q2dMegTTcJ3rQE20UAlktTdZEsq38HLpUeH0XXx9943+2l
         AJLPEviyaHiGJ1wzx5iDl1b/el+y6qg9OSeOrsT7NuuLU8MtrxXjHmjLGeK0l5Q1d5ov
         8Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqeW8MnbDg2PokJJQw17Go2b59puuLzNW0F5TYLSyF8=;
        b=E39GzPMPITFaAxwgSi94bu49CZhu56qXxNzZLBeExuvGwpLknrVLD7t+OavMn55QlD
         0ozoZuCzNnvZffMjnBLipmniq5rxZx3/NzB74/eJRBllE/by01AFE4HJ6Zt2laqnWI41
         OKBqxRDAsPZtMTRROfdr0eRUNqFJEy//dkJFaYYIBzB+p9BL5klkNmZYU22kvQO6RZDG
         77OtD9RWCqRE2nHdIGhr/+pLGml6N8q7+UJ/bIo3uaWUBX9MSlVwKBNaaTje5fTVqFaq
         qTalF7REUye4hSzBCXdlw9YLv01Q5tUWXCAGVQN7JcvrH/FNYItuNf7dYkk1wVETcrsG
         WuyA==
X-Gm-Message-State: AGRZ1gKqZPUgKeGcyYIV3hNGIxSgaPadjTn9V0IyUbuHU/TOyCiq/5jV
        gPaYFFyHW0iHJGs3HT+txBeojw==
X-Google-Smtp-Source: AJdET5eWwoHtGLMfTDdHqHY7anf02icBEwNZ5H7snwAT1XAxQpdlCA9zVqIC7QP2OeInZDm4VofZcA==
X-Received: by 2002:a62:d8c3:: with SMTP id e186-v6mr10738230pfg.52.1541796298802;
        Fri, 09 Nov 2018 12:44:58 -0800 (PST)
Received: from cisco ([128.107.241.186])
        by smtp.gmail.com with ESMTPSA id c7-v6sm9397934pfh.25.2018.11.09.12.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 12:44:57 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:44:54 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCHv6 2/7] tty: Hold tty_ldisc_lock() during tty_reopen()
Message-ID: <20181109204454.GF3645@cisco>
References: <20181101002452.5483-1-dima@arista.com>
 <20181101002452.5483-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101002452.5483-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 01, 2018 at 12:24:47AM +0000, Dmitry Safonov wrote:
> tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
> nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
> But it races with anyone who expects line discipline to be the same
> after hoding read semaphore in tty_ldisc_ref().
> 
> We've seen the following crash on v4.9.108 stable:
> 
> BUG: unable to handle kernel paging request at 0000000000002260
> IP: [..] n_tty_receive_buf_common+0x5f/0x86d
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  [..] n_tty_receive_buf2
>  [..] tty_ldisc_receive_buf
>  [..] flush_to_ldisc
>  [..] process_one_work
>  [..] worker_thread
>  [..] kthread
>  [..] ret_from_fork
> 
> tty_ldisc_reinit() should be called with ldisc_sem hold for writing,
> which will protect any reader against line discipline changes.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: stable@vger.kernel.org # b027e2298bd5 ("tty: fix data race between tty_init_dev and flush of buf")
> Reviewed-by: Jiri Slaby <jslaby@suse.cz>
> Reported-by: syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Feel free to add

Tested-by: Tycho Andersen <tycho@tycho.ws>

to this as well. We've recently seen this bug (well, the one that
syzbot reported), and this patch fixes it.

Tycho
