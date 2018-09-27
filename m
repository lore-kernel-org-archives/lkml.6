Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AED216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AED216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeI0WYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:24:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52522 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0WYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:24:47 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5YnS-0007Ei-SW; Thu, 27 Sep 2018 18:05:47 +0200
Date:   Thu, 27 Sep 2018 18:05:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()")
 may have revealed another problem
In-Reply-To: <20180828022545.GA25943@lerouge>
Message-ID: <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com> <20180824041245.GA2730@lerouge> <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com> <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de> <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com> <20180828022545.GA25943@lerouge>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
> On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
> > I tested it and Frederic is right, it doesn't help. Can it be somehow related to
> > the cpu being brought down during suspend? Because I get the warning only during
> > suspend when the cpu is inactive already (but still online).
> 
> It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
> 
> Does this script eventually trigger it after some time?

Any update to this?

Thanks,

	tglx
