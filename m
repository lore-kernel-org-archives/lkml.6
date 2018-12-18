Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE593C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748C218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeLRWOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:14:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbeLRWOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:14:15 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D83721871;
        Tue, 18 Dec 2018 22:14:14 +0000 (UTC)
Date:   Tue, 18 Dec 2018 17:14:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [ANNOUNCE] 4.14.87-rt49
Message-ID: <20181218171412.548dab13@gandalf.local.home>
In-Reply-To: <20181218220836.y5tfo6qyuf3674vj@linutronix.de>
References: <20181218154034.612d729d@gandalf.local.home>
        <20181218220836.y5tfo6qyuf3674vj@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 23:08:36 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-12-18 15:40:34 [-0500], Steven Rostedt wrote:
> > 
> > Dear RT Folks,
> > 
> > I'm pleased to announce the 4.14.87-rt49 stable release.  
> 
> This contains also commit
>   e8499ab5b93ac ("x86/fpu: Disable bottom halves while loading FPU registers")
> 
> which means you need commit
>   [PATCH] x86/fpu: Disable preemption around local_bh_disable()
>   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/plain/patches/x86-fpu-Disable-preemption-around-local_bh_disable.patch?h=linux-4.19.y-rt-patches
> 

I plan on doing a backport soon. My tests didn't bomb without this
patch :-) so i released this stable. But this just shows I need to do a
backport of your updates ASAP.

-- Steve
