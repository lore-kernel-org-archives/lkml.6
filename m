Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80908C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB62081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhoWpUlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BB62081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeKFFMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:12:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50648 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeKFFMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:12:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so4664732wmw.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dj5x/qtOD44tLpGIXqKyuHC2pvB7YAv1+t4er9GDfLw=;
        b=qhoWpUluvjROFsbQ2MU0zcIrZ9bsU6tL0nddxNfkziZOJB+aMFd2jpyMkPHVDy1Fj5
         fg56lqx4kHwSXCswmdMYUi6RdiCyHjWKrpU7s8i5ntjLKQKGm9uIDY4ausWyCyt8h3cL
         y2h/GcBUgxQaTT/O4e12fGm8cPPEA65gbuKH4NGD6AXQCEp4WS0MKs/+i2YPcRya2djJ
         pfgChKJouqA1KPX77JaW5logVcScA/enD0+E+XwiiBj+AcISHlxyV46EgJly/IV2VmKD
         SoxYIMd6d0h995kH9XPbrVrnrRgjJArg58KuLN38QnhuElRRbOhOlt/7XLQIKpx8Znaf
         emdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dj5x/qtOD44tLpGIXqKyuHC2pvB7YAv1+t4er9GDfLw=;
        b=K1Yz54EV/LI4doI1pOn5X8+5XxydsgSIJ2Nr8IEIev1xjTmkAxoGSI1e8sAKFzEcsv
         5OVSqeivNFNsn7sc3MfGibAo/Dy1RPay4QFjJVViKuZG46NMrwvz3KxCvUMHyFxzx85O
         shwxttpzO0jJi4Geb/BQ74/uEI6bARJpaA8MZhZWjMNwGBZhw8VUt8up+LTjW2twjGKp
         eznRku0QY52Ysr0+vxieeyLCAySTpnoCGdEp+nvjt1aSWMouc0/cGyBicjxfij9HKVML
         nRKk3WYFXpG4Z7DD6tpt1QV8ynjEh2wMiB8JeLXmDxUTN7zs4MrIHTfpQO8DgSILD4QK
         eMBg==
X-Gm-Message-State: AGRZ1gJ0BB9xagrA5ww0S1s7FIPGPR9wQWWtcfVU0lXRFzhHHzPe4/fI
        wnSqxsIXP+8/wqltA+tJrHM=
X-Google-Smtp-Source: AJdET5f0jbv9g+tiNLNuGBs03NIjsfig3MEmvL1HHGWThFFxwxmCWpbv/226BBpm4BFfxZ5+iQD9dQ==
X-Received: by 2002:a1c:85c5:: with SMTP id h188-v6mr7073103wmd.59.1541447464655;
        Mon, 05 Nov 2018 11:51:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y83-v6sm2178564wmb.20.2018.11.05.11.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:51:03 -0800 (PST)
Date:   Mon, 5 Nov 2018 20:51:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Anvin <hpa@zytor.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        David Riley <davidriley@chromium.org>,
        Colin Cross <ccross@android.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/9] time: Add SPDX identifiers and cleanup boilerplates
Message-ID: <20181105195101.GA86288@gmail.com>
References: <20181031182107.726051323@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031182107.726051323@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Add SPDX identifiers to all files in kernel/time and remove the license
> boiler plates.
> 
> Aside of that use the chance to get rid of (stale) file references and tidy
> up the top of file comments as they are touched anyway by this work.
> 
> This work is based on a script and data from Philippe Ombredanne, Kate
> Stewart and myself. The data has been created with two independent license
> scanners and manual inspection.
> 
> Thanks,
> 
> 	tglx
> 
> ---
>  include/linux/hrtimer.h              |    5 +----
>  kernel/time/alarmtimer.c             |    5 +----
>  kernel/time/clockevents.c            |    6 +-----
>  kernel/time/clocksource.c            |   20 +-------------------
>  kernel/time/hrtimer.c                |   19 +++++--------------
>  kernel/time/itimer.c                 |    2 --
>  kernel/time/jiffies.c                |   28 ++++++----------------------
>  kernel/time/posix-clock.c            |   17 ++---------------
>  kernel/time/posix-stubs.c            |    5 +----
>  kernel/time/posix-timers.c           |   25 ++-----------------------
>  kernel/time/sched_clock.c            |    9 +++------
>  kernel/time/test_udelay.c            |   10 +---------
>  kernel/time/tick-broadcast-hrtimer.c |    4 +---
>  kernel/time/tick-broadcast.c         |    6 +-----
>  kernel/time/tick-common.c            |    6 +-----
>  kernel/time/tick-oneshot.c           |    6 +-----
>  kernel/time/tick-sched.c             |    5 +----
>  kernel/time/time.c                   |   13 +++++--------
>  kernel/time/timeconst.bc             |    2 ++
>  kernel/time/timeconv.c               |    1 +
>  kernel/time/timecounter.c            |   17 ++---------------
>  kernel/time/timekeeping.c            |   11 +++--------
>  kernel/time/timekeeping_debug.c      |   11 +----------
>  kernel/time/timer.c                  |    3 +--
>  kernel/time/timer_list.c             |    7 +------
>  25 files changed, 45 insertions(+), 198 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
