Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE79C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D3C214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D3C214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIZVWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:22:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeIZVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:22:13 -0400
Received: from [217.9.97.180] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5BQi-0001RB-23; Wed, 26 Sep 2018 17:08:44 +0200
Date:   Wed, 26 Sep 2018 17:08:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for
 x86
In-Reply-To: <20180926150059.ua5576guhns5osgj@breakpoint.cc>
Message-ID: <alpine.DEB.2.21.1809261707090.4072@nanos.tec.linutronix.de>
References: <20180926110117.405325143@infradead.org> <20180926150059.ua5576guhns5osgj@breakpoint.cc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-518413826-1537974523=:4072"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-518413826-1537974523=:4072
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Sep 2018, Sebastian Andrzej Siewior wrote:

> On 2018-09-26 13:01:17 [+0200], Peter Zijlstra wrote:
> > In particular this ordering ensures a concurrent unlock cannot trigger
> > the uncontended handoff. Also it ensures that if the xchg() happens
> > after a (successful) trylock, we must observe that LOCKED bit.
> 
> so I backported a bunch of atomic files and qspinlock back to v4.9-RT in
> order to get these patches applied. The backported kernel booted and
> showed the same symptomps within seconds (those I reported last FR).
> With those three patches ontop I have the Core2Duo 10 minutes in
> testing without any issues…

Remember that 4.14 took almost 8 hours to fail, so I'd recommend not to
cheer too much. Let's see what it tells us in 48 hours.

Thanks,

	tglx
--8323329-518413826-1537974523=:4072--
