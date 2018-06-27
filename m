Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C325C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED54425A24
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED54425A24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeF0TkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbeF0TkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:40:21 -0400
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFDF25A05;
        Wed, 27 Jun 2018 19:40:20 +0000 (UTC)
Date:   Wed, 27 Jun 2018 15:40:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Steven J . Hill" <steven.hill@cavium.com>,
        Tejun Heo <htejun@gmail.com>, Christoph Lameter <cl@linux.com>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH REPOST] Revert mm/vmstat.c: fix vmstat_update()
 preemption BUG
Message-ID: <20180627194018.6jwkta4eagxiixix@home.goodmis.org>
References: <20180504104451.20278-1-bigeasy@linutronix.de>
 <513014a0-a149-5141-a5a0-9b0a4ce9a8d8@suse.cz>
 <20180508160257.6e19707ccf1dabe5ec9e8847@linux-foundation.org>
 <20180509223539.43aznhri72ephluc@linutronix.de>
 <524ecef9-e513-fec4-1178-ac1a87452e57@suse.cz>
 <alpine.DEB.2.21.1806132205420.1596@nanos.tec.linutronix.de>
 <20180614142710.8eafb333f6060dc19334ae46@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614142710.8eafb333f6060dc19334ae46@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 02:27:10PM -0700, Andrew Morton wrote:
> On Wed, 13 Jun 2018 23:46:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Can we please revert that master piece of duct tape engineering and wait
> > for someone to actually trigger the warning again?
> 
> OK.

And while we're at it, can we revert it from stable as well. As this is just
an overly aggressive pulling anything that looks like a fix into stable.

-- Steve

