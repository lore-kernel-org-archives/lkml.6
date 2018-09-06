Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DD1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0982075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0982075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIGAHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:07:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34610 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeIGAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:07:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fxzz3-0005mY-4S; Thu, 06 Sep 2018 21:30:29 +0200
Date:   Thu, 6 Sep 2018 21:30:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 00/22] Linux 4.14.63-rt41-rc1
Message-ID: <20180906193028.jvyp2dj3rto4ax7s@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
 <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
 <20180906124349.56b89024@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180906124349.56b89024@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-06 12:43:49 [-0400], Steven Rostedt wrote:
> > Your tree (v4.14.63) has
> >   80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")
> >   0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an
> >                  inline softirq")
> > 
> > which means that the patch "nohz: Prevent erroneous tick stop
> > invocations" can be reverted / dropped. It might have clashed during the
> > emerge of the stable tree.
> >
> 
> My tree also has this:
> 
> commit 5536f5491a2e098 
> 
>     softirq: keep the 'softirq pending' check RT-only
>     
>     The patch "nohz: Prevent erroneous tick stop invocations" was merged
>     differently upstream. The original issue where a slow box could lock up
>     with a pending timer remained. I currently assume that this is a RT only
>     issue and keep the patch as RT only.
>     
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> 
> What needs to be done?

This commit can be removed / reverted. The two commits (80d20d35af1ed
and 0a0e0829f9901) fix the issue and this duct-tape commit
(5536f5491a2e098) is no longer required.

> -- Steve

Sebastian
