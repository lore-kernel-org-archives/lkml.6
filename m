Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BFDECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2B20850
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="psCFDXls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C2B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeGSDY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbeGSDY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:24:56 -0400
Received: from kernel.org (c-71-202-33-127.hsd1.ca.comcast.net [71.202.33.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF319206B7;
        Thu, 19 Jul 2018 02:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531968248;
        bh=WPozIJ/B8pL1zkrvGyqdZM9rpcNh07jC/G2XCWTcjik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psCFDXlsqiNDR1kQNqMQ2H2AsxMVzCe1SlulOL3hJdBvpa8Lu1QY51jrvrggk5dTP
         0xsikLS/SvkWsXfo833FJ1tDpWfepDu7O4pZYTGHw/cqE5VIjEPyQ7VIZ/jNF2fiqf
         vHbAHbHzW7NsFlCFFLe5XHuF+VUYBg4rszB84VDk=
Date:   Wed, 18 Jul 2018 19:44:05 -0700
From:   Shaohua Li <shli@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers/md/raid5: Use irqsave variant of
 atomic_dec_and_lock()
Message-ID: <20180719024405.GA99813@kernel.org>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-2-bigeasy@linutronix.de>
 <20180716122740.q7oim7te5bybcniz@linutronix.de>
 <20180717003727.GA128433@kernel.org>
 <20180718105721.rcd6l7s6l4yfbahg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718105721.rcd6l7s6l4yfbahg@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:57:21PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-16 17:37:27 [-0700], Shaohua Li wrote:
> > On Mon, Jul 16, 2018 at 02:27:40PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2018-07-03 22:01:36 [+0200], To linux-kernel@vger.kernel.org wrote:
> > > > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > > > 
> > > > The irqsave variant of atomic_dec_and_lock handles irqsave/restore when
> > > > taking/releasing the spin lock. With this variant the call of
> > > > local_irq_save is no longer required.
> > > 
> > > Shaohua, are you with this?
> > 
> > Acked-by: Shaohua Li <shli@kernel.org> 
> 
> Thank you. 
> Is there a reason why you did not apply it or are you too busy now and
> do it later (and just signal the ack that you are fine with it)?

Since you sent a series, I suppose you want someone else to take it. But I can
take it for sure, will do soon.

Thanks,
Shaohua
