Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5C9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A40C20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A40C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeIFReE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeIFReE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:34:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9434C20844;
        Thu,  6 Sep 2018 12:58:39 +0000 (UTC)
Date:   Thu, 6 Sep 2018 08:58:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 08/22] Revert "x86: UV: raw_spinlock conversion"
Message-ID: <20180906085838.5a4c6708@gandalf.local.home>
In-Reply-To: <1536223096.4669.35.camel@gmx.de>
References: <20180905122754.443196118@goodmis.org>
        <20180905122835.654334475@goodmis.org>
        <20180906073549.zu6gdlwor4fwjngs@linutronix.de>
        <1536223096.4669.35.camel@gmx.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2018 10:38:16 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Thu, 2018-09-06 at 09:35 +0200, Sebastian Andrzej Siewior wrote:
> > On 2018-09-05 08:28:02 [-0400], Steven Rostedt wrote:  
> > > 4.14.63-rt41-rc1 stable review patch.
> > > If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > [ Upstream commit 2a9c45d8f89112458364285cbe2b0729561953f1 ]
> > > 
> > > Drop the Ultraviolet patch. UV looks broken upstream for PREEMPT, too.
> > > Mike is the only person I know that has such a thing and he isn't going
> > > to fix this upstream (from 1526977462.6491.1.camel@gmx.de):  
> > 
> > I don't think that we need to propagate that revert for stable. I
> > reverted it in the devel tree because nobody wanted this upstream and I
> > couldn't test it. For that reason I didn't see the point for having it
> > in the RT tree.
> > However, if you want to revert it for stable, be my guest. It probably
> > will have no impact and if it will people might step forward and fix it
> > properly / upstream.  
> 
> I'm in favor of reverting it as useless cruft.  UV has been broken
> forever wrt PREEMPT, and nobody cares.  The original interest in UV RT
> support evaporated while 2.6.33-rt was still current (and when getting
> it working took a bit more than a spinlock conversion). 
> 

Yeah, I skipped other reverts as I didn't think it was stable relevant,
but this one seemed like a good idea to backport. As Mike is in favor,
and Sebastian said "be my guest", I'll keep this in.

-- Steve
