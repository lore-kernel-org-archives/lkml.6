Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB888C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644872075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644872075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbeKVKL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:11:57 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57873 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbeKVKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:11:57 -0500
Received: from 79.184.254.110.ipv4.supernova.orange.pl (79.184.254.110) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id ed15b96da810fb01; Thu, 22 Nov 2018 00:35:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Oleg Nesterov <oleg@redhat.com>, Chanho Min <chanho.min@lge.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Donghwan Jung <donghwan.jung@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Date:   Thu, 22 Nov 2018 00:35:25 +0100
Message-ID: <2198026.vTmrAJsSTa@aspire.rjw.lan>
In-Reply-To: <20181112081517.GA23178@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com> <20181112081517.GA23178@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 12, 2018 9:15:18 AM CET Oleg Nesterov wrote:
> On 11/12, Chanho Min wrote:
> >
> > @@ -1083,7 +1084,7 @@ static int de_thread(struct task_struct *tsk)
> >  	while (sig->notify_count) {
> >  		__set_current_state(TASK_KILLABLE);
> >  		spin_unlock_irq(lock);
> > -		schedule();
> > +		freezable_schedule();
> >  		if (unlikely(__fatal_signal_pending(tsk)))
> >  			goto killed;
> >  		spin_lock_irq(lock);
> > @@ -1111,7 +1112,7 @@ static int de_thread(struct task_struct *tsk)
> >  			__set_current_state(TASK_KILLABLE);
> >  			write_unlock_irq(&tasklist_lock);
> >  			cgroup_threadgroup_change_end(tsk);
> > -			schedule();
> > +			freezable_schedule();
> >  			if (unlikely(__fatal_signal_pending(tsk)))
> >  				goto killed;
> >  		}
> 
> Thanks, looks good to me.
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Patch applied, thanks!

