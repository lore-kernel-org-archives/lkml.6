Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974D720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974D720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbeGXH2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:28:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43459 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbeGXH2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:28:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fhqjf-0003h0-N3; Tue, 24 Jul 2018 08:23:51 +0200
Date:   Tue, 24 Jul 2018 08:23:51 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     isaacm@codeaurora.org
Cc:     peterz@infradead.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, gregkh@linuxfoundation.org,
        pkondeti@codeaurora.org, stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
Message-ID: <20180724062350.nlem2suuy5wlxpts@linutronix.de>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
 <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-23 18:13:48 [-0700], isaacm@codeaurora.org wrote:
> Hi all,
Hi,

> Are there any comments about this patch?

I haven't look in detail at this but your new preempt_disable() makes
things unbalanced for the err != 0 case.

> Thanks,
> Isaac Manjarres

Sebastian
