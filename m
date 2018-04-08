Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeDHMrV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 08:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeDHMrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 08:47:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5CC21772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sun, 8 Apr 2018 08:47:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180408084717.62ee4f9e@gandalf.local.home>
In-Reply-To: <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180407234812.2bf2b24b@gandalf.local.home>
        <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Apr 2018 13:54:59 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> On Sun, Apr 8, 2018 at 11:48 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Sun,  8 Apr 2018 10:16:23 +0800
> > Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >  
> >> Don't choose the process with adj == OOM_SCORE_ADJ_MIN which
> >> over-allocating pages for ring buffers.  
> >
> > Why?
> >
> > -- Steve  
> because in oom_evaluate_task, the process with adj == OOM_SCORE_ADJ_MIN will
> be suppressed by oom_badness, but with applying your latest patch,
> such process will
> be selected by oom_task_origin
> 
>         if (oom_task_origin(task)) {
>                 points = ULONG_MAX;
>                 goto select;
>         }
> 
>         points = oom_badness(task, NULL, oc->nodemask, oc->totalpages);
>         if (!points || points < oc->chosen_points)
>                 goto next;

And what's wrong with that?

-- Steve
