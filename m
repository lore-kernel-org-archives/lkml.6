Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55A1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D36A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwbTLfGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D36A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeGaSzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbeGaSzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:55:45 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3173420844;
        Tue, 31 Jul 2018 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533057269;
        bh=ZWb/IiEpXh/MWpzUYdci0auOqrxcdz/LhqjD9OJrRBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fwbTLfGohFkPkEU3ib1JY8AthGM7K9a51tJ9hi7ps+u69kAFXVqhTUBroteDX/g4E
         1fv3AkYRyxj0IruVBJJsSGAXEcdOB/ys76t/sFHcUxLD0fG/9nilMGyvOH6CvBduJi
         xYaUwcnXNE6+VSmxPm0ezZ7xSOgZHaK5dEKXJumY=
Date:   Tue, 31 Jul 2018 19:14:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, bristot@redhat.com, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org
Subject: Re: [PATCH] nohz: Fix local_timer_softirq_pending()
Message-ID: <20180731171426.GD28353@lerouge>
References: <20180731161358.29472-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731161358.29472-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:13:58PM +0200, Anna-Maria Gleixner wrote:
> local_timer_softirq_pending() checks whether the timer softirq is
> pending with: local_softirq_pending() & TIMER_SOFTIRQ.
> 
> This is wrong because TIMER_SOFTIRQ is the softirq number and not a
> bitmask. So the test checks for the wrong bit.
> 
> Use BIT(TIMER_SOFTIRQ) instead.
> 
> Fixes: 5d62c183f9e9 ("nohz: Prevent a timer interrupt storm in tick_nohz_stop_sched_tick()")
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
