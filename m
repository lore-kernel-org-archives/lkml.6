Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6B4214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6B4214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeIZVO2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:14:28 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:37680 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbeIZVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:14:27 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g5BJE-0002Iy-IN; Wed, 26 Sep 2018 17:01:00 +0200
Date:   Wed, 26 Sep 2018 17:01:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for x86
Message-ID: <20180926150059.ua5576guhns5osgj@breakpoint.cc>
References: <20180926110117.405325143@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180926110117.405325143@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 13:01:17 [+0200], Peter Zijlstra wrote:
> In particular this ordering ensures a concurrent unlock cannot trigger
> the uncontended handoff. Also it ensures that if the xchg() happens
> after a (successful) trylock, we must observe that LOCKED bit.

so I backported a bunch of atomic files and qspinlock back to v4.9-RT in
order to get these patches applied. The backported kernel booted and
showed the same symptomps within seconds (those I reported last FR).
With those three patches ontop I have the Core2Duo 10 minutes in
testing without any issues…

Sebastian
