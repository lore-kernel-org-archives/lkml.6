Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFAAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B6218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551309004;
	bh=fTfUSY+DC5ZTvuhVVmzB6ulPFGb0hxbxsILNHPCtQAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M86gMs1CSkyDblHcAdjeIrkqj/ogOQYeLGih0vO+/rSz5qiQZ7W4QBXaOtv3thijR
	 9VuudEljB/jBmqcCPLWDr8oFABkagMjpWxDqAVqWqc+vN8N/T0MKbRkxLM3YcMECME
	 it15qkshuXpQzWT54DW3+j+0QcA3vVjenmai0VD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfB0XKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB0XKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:10:01 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D79217F5;
        Wed, 27 Feb 2019 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551309001;
        bh=fTfUSY+DC5ZTvuhVVmzB6ulPFGb0hxbxsILNHPCtQAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXLqvNyuPc1/xTnvUwu8UEfBF152DMwyEkotmlstnehpritG8v2SHe0uBX+ojg4Ed
         zXFTD70D/BpeIPq2AKahKMOwB+yvUQ7xYKaR+TUimASIcXwzZMLq+1+OuR/qeclZpo
         ezDXcIyVwQl4eHONIJ80SRC4XnUrLcFXrl3dIPME=
Date:   Thu, 28 Feb 2019 00:09:58 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 23/32] softirq: Remove stale comment
Message-ID: <20190227230957.GE15294@lerouge>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-24-frederic@kernel.org>
 <20190227110403.sy4djsxtukd6wasp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227110403.sy4djsxtukd6wasp@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:04:04PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-12 18:14:14 [+0100], Frederic Weisbecker wrote:
> > __local_bh_disable_ip() is neither for strict internal use nor does it
> > require the caller to disable hardirqs. Probaby a celebration for ancient
> 
> Probaby
> 
> > behaviour.
> 
> I think the point was to override the IP for the tracer. So everyone
> else used local_bh_disable() and was recorded as the caller except for
> softirq.c internal usage where __do_softirq() did also
> "local_bh_disable()" but recorded its caller (instead recording
> __do_softirq()).

Looks so. Anyway now it's also used by locking functions that need to pass
their own callers. So the comment is stale.
