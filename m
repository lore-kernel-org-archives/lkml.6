Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10292082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393476AbfAPNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393443AbfAPNrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:47:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 731B6206C2;
        Wed, 16 Jan 2019 13:47:04 +0000 (UTC)
Date:   Wed, 16 Jan 2019 08:47:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Claudio <claudio.fontana@gliwa.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ftrace global trace_pipe_raw
Message-ID: <20190116084702.6d6ce764@gandalf.local.home>
In-Reply-To: <5af4b871-41dd-219b-f78e-3a60ea570160@gliwa.com>
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
        <20180709113257.79152dd0@gandalf.local.home>
        <7dfce43c-afd3-52ee-4c58-ef6a3b1be5fd@gliwa.com>
        <20180724102316.41cdb8a1@gandalf.local.home>
        <732bd9ce-c0dd-79ea-de17-462ba662a10a@gliwa.com>
        <20181219113734.56b57f93@gandalf.local.home>
        <5af4b871-41dd-219b-f78e-3a60ea570160@gliwa.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 09:00:00 +0100
Claudio <claudio.fontana@gliwa.com> wrote:

> Indeed the perf event interface would be awesome, if only it would support tracing all processes.
> 
> Unfortunately for my use case, it can only trace one process on any cpus, or all processes on one (1) cpu.
> 
> I guess for some kind of security concerns..

Not security, but performance.

Serialized writes are best done on serialized instances (per cpu or a
single task). Having all tasks on all CPUs write to a single location
is a huge detriment to performance, and has a significant impact. Which
is why the buffer you are asking for doesn't exist.

-- Steve


> 
> I'll take a look at how much work it would be to extend the interface for the any process/any cpu use case.
> 
> Ciao and thank you,
> 
> Claudio
> 
> 

