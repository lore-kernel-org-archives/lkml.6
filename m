Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F15FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712A42089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712A42089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJBNNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:13:41 -0400
Received: from mail.monom.org ([188.138.9.77]:58792 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbeJBNNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:13:41 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8E84B50093C;
        Tue,  2 Oct 2018 08:32:02 +0200 (CEST)
Received: from helium.monom.org (ppp-212-114-235-157.dynamic.mnet-online.de [212.114.235.157])
        by mail.monom.org (Postfix) with ESMTPSA id 7A866500317;
        Tue,  2 Oct 2018 08:32:01 +0200 (CEST)
Date:   Tue, 2 Oct 2018 08:31:59 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20181002063159.r4hxljpzyxpsdg5s@helium.monom.org>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> This matches Daniel Wagner's observations which he described in [0] on
> v4.4-RT.

Peter Z recommended to drop to ticket spinlocks instead trying to port
back all the qspinlock changes to v4.4-rt.

With ticket spinlocks, 'stress-ng --ptrace 4' run for 50 hours without
a problem (before it was seconds) and my normal workload for -rt testing
for 60 hours without a problem (before it broke within 24h).

The cyclictest max values went slightly down from 32us to 30us but
that might just be coincidence.

Thanks,
Daniel
