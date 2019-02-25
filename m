Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB69213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfBYRlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:41:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:56885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYRlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:41:15 -0500
Received: from homer.simpson.net ([185.221.150.179]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML72n-1gybMC1bMX-000PQE; Mon, 25
 Feb 2019 18:40:37 +0100
Message-ID: <1551116436.5281.5.camel@gmx.de>
Subject: Re: [PATCH RT 4/2] hrtimer: Don't lose state in cpu_chill()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 25 Feb 2019 18:40:36 +0100
In-Reply-To: <20190225163440.ptw2ohijokhumn7i@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
         <20190218163137.cmor4ek3odus5m6j@linutronix.de>
         <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
         <20190219160842.qxpwicoa5tzq4njo@linutronix.de>
         <1551105815.6234.14.camel@gmx.de>
         <20190225163440.ptw2ohijokhumn7i@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:82esocUz6gOqNxMOqU10sQzm04DmWmYIzqTaGaLNzrzhpMUe0Vv
 D5+Valuv+xa2Qtg3yL3o7Y5CD16iZ2dUdTwmpAth2L8tm2N7ddJPPq9w9je1rO5kpt3GvmS
 uXSMTnW0zugg8ib97emuDPW4o3F20MhgMW/d0auEeYT1k1EeyQGvdSyltHICdiWa0demT3s
 XWsokB400M83xuoVil7nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n3rKK/JSzVs=:tWdncV7Yd5P65zVPpdXbvf
 mrGrCBiNeiSLBP5pk97ILzqZ4iLjymaDtLiOH8yAGEG3nurQo6n9c6+qntdbcvVJlIS+cygxz
 MtcjLxGh0ZPgjUdcYHdU3QnhzUkZ5By3kqBzxff0K5yqt7YKiaOYeNt5ZhSqVk6y+TJKGzc2c
 FZPkiZY6S3DbHlLK4beug0zxLuVdE9KqoFdgN+mCN5fcyxytqfsAUz5a1crOIDaFEKkpw2Ue4
 7ABLD+XbEWMOT04XI9YnaQ68/Fhwm7zWVn0e+XU5SiwUStvvFXTPazrNfom1HIdD7buuuXSwT
 CDxZ/yiNQxBKBK+V4c/xGXaONXjAIs930CnB9g9A1oRcHrnyUno9C9oPbmuU3x0WMnx9+I/0b
 2LGwfe7OsXT+X+Vlb6DF39r5i8X8zIx37eaDib/AqMA4mTVDg/9kFx1mKIZ1UtqAvQumxCjN/
 b3OnsBrclh/1Z39E+SySy89NFouzpNVitowh2Kq1uyw1ADgOv3MqumAoQ7qo3lNWvZF4fzMeE
 VOVClX/Da7parPXJgP3jGE6QpXbSwKCAQsLtDLY1YMKd4rOdM5KII5HIx0KYymhs2RBr2UF1e
 Yaq2vblqjhdXQY/juOgHTSvFGBVaQ2mh1qzmuIoJJ8Cj0tVtV/UuFImy56JNXntu8fQOx41+t
 VUPOaKOEruH4fBaGdNyQE3F6sxvX7DfHToSaVill+4+vTraRBC1JECHz50IOnyzsQc7sDuh1E
 0IeSqIl3GulhR0yJugsf45gKvThemJfd/zucRvJEoeUuEraWBfBIt6g7jMiUAqePMW90tcBGg
 V97tg5ipHtZ1z6GaxX/iMk80jp/yEuJUVsYuE2pXWkMYPNqBVPNsP1yE4XvuEYVL4M+t5uIPQ
 OcXSNoFWAaywhU1tR9LqJ2eGAw+KA1qvZlsgGqr23ln4fPIIfDE7gDGllHQfWv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 17:34 +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-25 15:43:35 [+0100], Mike Galbraith wrote:
> > Hi Sebastian,
> Hi Mike,
> 
> > My box claims that this patch is busted.  It argues its case by IO
> > deadlocking any kernel this patch is applied to when spinning rust is
> > flogged, including virgin 4.19-rt14, said kernel becoming stable again
> > when I whack the accused.
> 
> does the following hunk make any difference?

Ah.  Yup, box says you're right.

> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 6ecdb9469ca9..e154632b90b4 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1884,20 +1884,29 @@ COMPAT_SYSCALL_DEFINE2(nanosleep, struct old_timespec32 __user *, rqtp,
>   */
>  void cpu_chill(void)
>  {
> +	struct task_struct *self = current;
>  	ktime_t chill_time;
>  	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
> -	long saved_state;
>  
> -	saved_state = current->state;
> -	chill_time = ktime_set(0, NSEC_PER_MSEC);
> +	raw_spin_lock_irq(&self->pi_lock);
> +	WARN_ON(self->saved_state != TASK_RUNNING);
> +	self->saved_state = self->state;
>  	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
> +	raw_spin_unlock_irq(&self->pi_lock);
> +
> +	chill_time = ktime_set(0, NSEC_PER_MSEC);
> +
>  	current->flags |= PF_NOFREEZE;
>  	sleeping_lock_inc();
>  	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
>  	sleeping_lock_dec();
>  	if (!freeze_flag)
>  		current->flags &= ~PF_NOFREEZE;
> -	__set_current_state_no_track(saved_state);
> +
> +	raw_spin_lock_irq(&self->pi_lock);
> +	__set_current_state_no_track(self->saved_state);
> +	self->saved_state = TASK_RUNNING;
> +	raw_spin_unlock_irq(&self->pi_lock);
>  }
>  EXPORT_SYMBOL(cpu_chill);
>  #endif
> 
> Sebastian
