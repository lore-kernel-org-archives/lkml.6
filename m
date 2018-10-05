Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A45C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488E3213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488E3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJEXJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:09:23 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75D8A208E7;
        Fri,  5 Oct 2018 16:10:01 +0000 (UTC)
Date:   Fri, 5 Oct 2018 12:09:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <peng.hao2@zte.com.cn>
Cc:     <andrea.parri@amarulasolutions.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181005120959.6b8649e2@gandalf.local.home>
In-Reply-To: <201810060003580936940@zte.com.cn>
References: <20181005154632.GA18077@andrea>
        <201810060003580936940@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2018 00:03:58 +0800 (CST)
<peng.hao2@zte.com.cn> wrote:

> >Hi Peng,  
> 
> >On Sat, Oct 06, 2018 at 06:22:11AM +0800, Peng Hao wrote:  
> >> find_lock_lowest_rq may or not releease rq lock when return
> >> lowest_rq=NULL, but it is fuzzy.
> >> If not releasing rq lock, it is unnecessary to re-call
> >> pick_next_pushable_task.  
> 
> >IIRC, deadline.c uses a similar pattern (c.f., find_lock_later_rq() and
> >pick_next_pushable_dl_task()): should it be considered for this change?  
> peterz asked the same question.
> at first I thought dl's retry action is simple. But now  the change is simpler, I will
> add it. 
>

I would still do that as a separate patch though.

-- Steve
