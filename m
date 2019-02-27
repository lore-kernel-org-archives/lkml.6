Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F77C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4896217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551308897;
	bh=/hJisD4YyuJEzZgHbr0GRaRor0vukyg3nWtgXpPdfnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EDAWE6Nr1XS1CEfh8h/xZNbX36riAlvJmgncdFPdAAb17VkrQcJhREXHq2dabWJQ+
	 WKwABmcD8vpGjRHZAj/SwK50AUxetWjUyH3rDwuXNiUWItFfDSecpnZVzK99ILYxrf
	 k5v4QRzpm/V/fsfJDQfdqkzMyXhLuooRopAFo+o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfB0XIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:08:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB0XIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:08:15 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6712087C;
        Wed, 27 Feb 2019 23:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551308895;
        bh=/hJisD4YyuJEzZgHbr0GRaRor0vukyg3nWtgXpPdfnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0G8MGLcuzJYSEYP+eD1Fo7xSa6oWzvDFR3vJrhY3Bnx7HB4pOg9bo9Cwq92LGK4h
         S3fDF4mXMF89dwnnGTI9gPc5ynhTzrrzWaRykpOhiCPd+HyP4WxmohX7SFDRir9D8M
         Co8M6gsXSVdxGBkySDSspWYVM/kzUSrfJEP0l3Yc=
Date:   Thu, 28 Feb 2019 00:08:12 +0100
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
Subject: Re: [PATCH 11/32] softirq: Macrofy softirq vectors
Message-ID: <20190227230811.GD15294@lerouge>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-12-frederic@kernel.org>
 <20190227095410.oq5wf7cjn7xblxea@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227095410.oq5wf7cjn7xblxea@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:54:10AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-12 18:14:02 [+0100], Frederic Weisbecker wrote:
> > --- /dev/null
> > +++ b/include/linux/softirq_vector.h
> > @@ -0,0 +1,10 @@
> could you please add a spdx header/identifier here?

Ah right, will do.

Thanks.
