Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0FCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD32146F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CD32146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeHBKSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:18:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:46681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbeHBKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:18:30 -0400
Received: from homer.simpson.net ([185.191.216.67]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgcTf-1fYj3A365X-00O0d9; Thu, 02
 Aug 2018 10:27:59 +0200
Message-ID: <1533198478.11791.10.camel@gmx.de>
Subject: Re: cpu stopper threads and setaffinity leads to deadlock
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     mingo@kernel.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de, isaacm@codeaurora.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Aug 2018 10:27:58 +0200
In-Reply-To: <20180802081252.GG2494@hirez.programming.kicks-ass.net>
References: <24eebe1d874cb8e3b9a18087554544fa@codeaurora.org>
         <20180802081252.GG2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3UosMcJ79z03EPQNxMZV/lsJr5ao+AvOrp2jIh+kMPdNz8GwZic
 RwSjh3dsOpY0lKUzuXAS4lJy0MLOk4ow4+zAxe+cHVnMAeKSx3RWdI0M0Eo0O4uOJBeSV6T
 5lrW4S2NbYyFbb8nE/eCeXY/PmQUMX3Jl6HwEXMFw05Txmh/PvnrBkBIKLcdAuOY3rbbB+u
 1NB8NdTsySJTzh1Ii7RdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8lYunZ92zM8=:8wMiaBFTDcUrYAcbO+oSYf
 +P5XHoijKouulx2SHwDgEfDZd2iT2M7QTPR4YZbspQLQfKxa2Ob+1/UbryJDmddxwb+yu0rsj
 a3qtdTlSJNUP+SPUXyH0wWfX4Jn70MMhhRWQiilmcEq+K+mu647xKDGw1+xijy3HeKR98s5T+
 XQL1wjA0sjSk5r9ucXnZ1vKRjoUQ0Y3NitylVJUdqTBsAaY2+UJ5+rwyD9p3V21KMlk29Jxbl
 GZHSTSkBGxVXGuy8yWNk90WAkhpquztJGi/qxdG5jF59HhSm78XEPS7EXIaQQykWKsjAE21HZ
 Bt5i+HAqWfKZXpHr+7OLFjDKZQnhyuvMG6dr2+cYS9sTvBRWmHtfdm2BxHR3EWN6qvCRtHxa3
 gvOVILI/uXkFIlDreHPgDfLZHPE81CDBqn9QT1ToNKfO01BrSNHa6Bgk4HZMyesZPAfmSNQO1
 5VgsrALcMmD2OtNQOITHFBJTaROq5pkmUOB+0p9OLG62uTpwqEKK7beSmBV5U/aaZsKYQ/7Ow
 fbx1C6ElDnodg7YA59lq+UEC2az2xmqvtrxk1IGLGNBNlcb6ArjulZF9lZ6dn8tLzGyqUx0DG
 7FhnRBS6+9nXVkjOGablsX9d8TgbveY/VF2xwqHubeWZfbdu85SiLqTFmR4YYhQ6RW1oSMf7O
 Ieg2MhyD4VtFEjYSlwq2a5ggiJv9e31wBmosXA1qJQwZaosZlIL+YAZm7Go6kl+mMUdBtzraS
 EXTatkm1qfv3nivV2M9kmU79ol6hvmBRw2gOOX/Q7xLZRxR3eyF3Wf9KRLC5e5TbGz16ZJjKS
 VACnOpX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 10:12 +0200, Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 06:34:40PM -0700, Sodagudi Prasad wrote:
> > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > index e190d1e..f932e1e 100644
> > --- a/kernel/stop_machine.c
> > +++ b/kernel/stop_machine.c
> > @@ -87,9 +87,9 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct
> > cpu_stop_work *work)
> >                 __cpu_stop_queue_work(stopper, work, &wakeq);
> >         else if (work->done)
> >                 cpu_stop_signal_done(work->done);
> > -       raw_spin_unlock_irqrestore(&stopper->lock, flags);
> > 
> >         wake_up_q(&wakeq);
> > +       raw_spin_unlock_irqrestore(&stopper->lock, flags);
> > 
> 
> That puts the wakeup back under stopper lock, which causes another
> deadlock iirc.

Yup, one you fixed.

0b26351b910fb (Peter Zijlstra 2018-04-20 11:50:05 +0200 92)     wake_up_q(&wakeq);
