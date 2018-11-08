Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D52ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0DE2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0DE2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKIB2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:28:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeKIB2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:28:39 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKmba-00030a-1z; Thu, 08 Nov 2018 16:52:26 +0100
Date:   Thu, 8 Nov 2018 16:52:26 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     lcapitulino@redhat.com, julia@ni.com,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rcu: enable rcu_normal_after_boot by default for RT
Message-ID: <20181108155225.d2m6sx5z7tvzurft@linutronix.de>
References: <20181101230235.GA8757@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101230235.GA8757@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 16:02:35 [-0700], Paul E. McKenney wrote:
> > The forcing of an expedited grace period is an expensive and very
> > RT-application unfriendly operation, as it forcibly preempts all running
> > tasks on CPUs which are preventing the gp from expiring.
> > 
> > By default, as a policy decision, disable the expediting of grace
> > periods (after boot) on configurations which enable PREEMPT_RT_FULL.
> > 
> > Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
> > Signed-off-by: Julia Cartwright <julia@ni.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> In case it matters:
> 
> Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> Alternatively, any reason that I should not pull this into -rcu?
because we don't have CONFIG_PREEMPT_RT_FULL yet.
> 							Thanx, Paul

Sebastian
