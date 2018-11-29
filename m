Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F766C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35674206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SNY4t83n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGtDSbwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35674206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeK2Xok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:44:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36021 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbeK2Xoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:44:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5984D22158;
        Thu, 29 Nov 2018 07:39:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Nov 2018 07:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hzFmC9qjgT1n0Uz5z79Xtc0JEPJ
        xVU2dBLbq/7oSWF8=; b=SNY4t83niVZ0rrxU1sOnIZ6XjbUGwbEWd/1N3281lUG
        9h5c2PsPZP+E6qEw8SlqcwJOnWJSKWwWee/U3Q6qQ6ceswXmZsRANzBNTFj8K5Rq
        W9SJtnGsnTLN11GOn4DNQXFLqVsZqMP+J1WWOxGCemAnnEsB8ud2gUKkruETJnjZ
        /SwXTtza6LKS0xO+JjNGcq2qK3XEnS2/b7slakfxTWmWTeAK4pbf4SuaK6v1vuEV
        KsrTAWtflbHDiHGcnb7PznsZs8A8gTViyL/JVcKSOwSO1PJ8WpC1C/S1I24KefN/
        oGVGaxgvAqeJRWMykUrtrFtycmd1iC3I6niURSFGo8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hzFmC9
        qjgT1n0Uz5z79Xtc0JEPJxVU2dBLbq/7oSWF8=; b=oGtDSbwQ75YU4Jkto+RcVi
        oOkb5hWCx9gXE3H0elit1NvzkFtWKfWjdL0IeDZUOuYKoqGCfjVh91Vjgt7rrEAu
        2c3DmgsK01NpRRdJVEl+OjZvEmr7KGhJJ3bhmE4Hekan8qU8J9P0IcnGIvHbloS7
        WE7fagZXtUogOiCRAvUy6IajXx86LBdJXltZuzRM9hVoRN24rzGkkj/nboAs0lJc
        Pu63KEsi09YgwfLqMMOTraji7jnSi3LYNpxoQZqZq8fyJHRtRx+5qKSlTEUeUrDA
        HOZ31LsuVhci3jcsu+PY5npn757iWTv1Mkp2Wqoz1MSfFBrDej6a4nSyUe7n5ZKw
        ==
X-ME-Sender: <xms:-93_W7DNzIZF6HWQRr20dMwcFUcHIk5jbsndxW78AtPR1x4H58HgQg>
X-ME-Proxy: <xmx:-93_WzP26YKz7_27rECnfCjNTr-8kkpxdevU4fhobbcy-ZJzXKXkhw>
    <xmx:-93_W-g8ZN1Jv2ET_8FnMy3NpmdMGjkgPX5M-5dtxOSyipsSJWXQfQ>
    <xmx:-93_WzdtI_yrOzYRFzV1mWlq9O9uBiKQHOzWpjSoM0BogMX9C6eB9g>
    <xmx:-93_Wxb_IWxUCNUGkYpYpnwM4Kl1uIJrKJHYj0MV_mGgQ46xtVYYvA>
    <xmx:-93_W0kMlLTjtOBIT9UhPRmLxa8Ybc0QRQZN65Ywt-K6UHupsN6wqA>
    <xmx:_d3_W1o3jMhm_hOW5n1GiS9GhCRL7SuV5eD1mwiZCrQFNkIcwRNU7w>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CEE4104EF;
        Thu, 29 Nov 2018 07:39:23 -0500 (EST)
Date:   Thu, 29 Nov 2018 13:39:22 +0100
From:   Greg KH <greg@kroah.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     stable@vger.kernel.org, mhillenb@amazon.de, dwmw2@infradead.org,
        peterz@infradead.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RCU -stable] Make need_resched() respond to urgent RCU-QS
 needs
Message-ID: <20181129123922.GJ3149@kroah.com>
References: <20181105023434.GA26868@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105023434.GA26868@linux.ibm.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 06:34:34PM -0800, Paul E. McKenney wrote:
> commit 92aa39e9dc77 upstream.
> 
> The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
> need for an RCU quiescent state from the force-quiescent-state processing
> within the grace-period kthread to context switches and to cond_resched().
> Unfortunately, such urgent needs are not communicated to need_resched(),
> which is sometimes used to decide when to invoke cond_resched(), for
> but one example, within the KVM vcpu_run() function.  As of v4.15, this
> can result in synchronize_sched() being delayed by up to ten seconds,
> which can be problematic, to say nothing of annoying.
> 
> This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
> rcu_check_callbacks(), which is invoked from the scheduling-clock
> interrupt handler.  If the current task is not an idle task and is
> not executing in usermode, a context switch is forced, and either way,
> the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
> task is an idle task, then RCU's dyntick-idle code will detect the
> quiescent state, so no further action is required.  Similarly, if the
> task is executing in usermode, other code in rcu_check_callbacks() and
> its called functions will report the corresponding quiescent state.
> 
> Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [ paulmck: Backported to make patch apply cleanly on older versions. ]
> Tested-by: Marius Hillenbrand <mhillenb@amazon.de>
> Cc: <stable@vger.kernel.org> # 4.12.x - 4.19.x
> 

Now queued up, thanks.

greg k-h
