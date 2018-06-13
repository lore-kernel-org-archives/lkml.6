Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F39ACC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D0C208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SL5Xz/3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D0C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeFMI1K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:27:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934124AbeFMI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bLkhRzPct31wf7bKHFXNpTjmxuHtp1rXA3GeUf47UCU=; b=SL5Xz/3p4uERGI0ZCf+sgbl3P
        omhoyH/mHv0b6MS0dkI0D4Pg12P7znA7RV3FKGyixSCuJXCXawOkDS9qe7mS/MxCOMeTqDciUhFWv
        7HrBV0TituMvrxMCIBezWiQYyO8ClJDRQ3AUq7E6Dg0nmGTG02MtW84OMH8CIFTcZryLigJ+lNb7V
        7wSNTTBuficYvRdaZdvFKiC1Y4idBF+EJL0DuKtwLFHBEAKPKD1W/puaVmcM39wetkoSNVOEJ2N/e
        vTmZXK8v1Q6KXReqp21/QDQiQPUO/KJKy4cN7hapL3c59zOnMiVOe4Qa4vo1znDjnFV3ubVi13y5t
        6HbRhQ6mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT17O-0003cj-GT; Wed, 13 Jun 2018 08:27:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40A62201EA7C8; Wed, 13 Jun 2018 10:27:00 +0200 (CEST)
Date:   Wed, 13 Jun 2018 10:27:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <xiaolong.ye@intel.com>
Cc:     mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org,
        tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        dzickus@redhat.com, lkp@01.org
Subject: Re: [lkp-robot] [watchdog/softlockup]  4808e7a5dc:
 BUG:KASAN:null-ptr-deref_in_h
Message-ID: <20180613082700.GV12198@hirez.programming.kicks-ass.net>
References: <20180612161832.428662402@infradead.org>
 <20180613050838.GK12146@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613050838.GK12146@yexl-desktop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 01:08:38PM +0800, kernel test robot wrote:
> [    0.037000] BUG: KASAN: null-ptr-deref in hrtimer_active+0x70/0xa0
> [    0.037000] Read of size 4 at addr 0000000000000010 by task swapper/1
> [    0.037000] 
> [    0.037000] CPU: 0 PID: 1 Comm: swapper Tainted: G                T 4.17.0-11348-g4808e7a #1
> [    0.037000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.037000] Call Trace:
> [    0.037000]  ? kasan_report+0xe3/0x360
> [    0.037000]  ? hrtimer_active+0x70/0xa0
> [    0.037000]  ? hrtimer_try_to_cancel+0x17/0x210
> [    0.037000]  ? hrtimer_cancel+0x15/0x20
> [    0.037000]  ? softlockup_stop_fn+0x11/0x20
> [    0.037000]  ? lockup_detector_reconfigure+0x25/0xa0
> [    0.037000]  ? lockup_detector_init+0x51/0x5d
> [    0.037000]  ? kernel_init_freeable+0xa9/0x243
> [    0.037000]  ? rest_init+0xd0/0xd0
> [    0.037000]  ? kernel_init+0xf/0x120
> [    0.037000]  ? rest_init+0xd0/0xd0
> [    0.037000]  ? ret_from_fork+0x24/0x30

ARGH, I thought I fixed that one..

I think that'll cure things, but let me do a KASAN build myself.

--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -587,8 +587,8 @@ static __init void lockup_detector_setup
 		return;
 
 	mutex_lock(&watchdog_mutex);
-	softlockup_initialized = true;
 	lockup_detector_reconfigure();
+	softlockup_initialized = true;
 	mutex_unlock(&watchdog_mutex);
 }
 
