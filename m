Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7316ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715C620883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L5ldOwfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715C620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeIQU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeIQU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ptbbydbv/V3HTegT/08X+zwkSZ+4szvy3Tr6Sezsrn0=; b=L5ldOwfd1lTl47pKrPr1uAe0j
        i/8oYcqGr2UCunRredlS/xubqZDbgefnVSmSqzSL730fZuiWia75jQQ1DszvIqNAALzCm7GkSrkMW
        kgxEgxhDl5nIj4qaTq8rorH/qEzLAuHr9NOfwcjjDK3eMwexv6VEf8lhZWIe3oLAEeU+MkxbXsXGc
        rYqbPlgFsv8ES43E8IvLWKTH2UYPTMMQz4y5/FSYrcQXTPCfJXaYrVslUqkMHO+aG7W5Z8Q5i9llo
        2PblBZiusEnm12MxkjsG6Tt/RcuiXrmO5n240hYybgRU2ojstVlfagstdsZS0Uc20eyg3IaoTIuND
        hplYsAVpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1v25-0008Iz-EZ; Mon, 17 Sep 2018 15:01:49 +0000
Date:   Mon, 17 Sep 2018 08:01:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh@kernel.org, Damien.LeMoal@wdc.com, marc.zyngier@arm.com,
        anup@brainfault.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] RISC-V: Remove per cpu clocksource
Message-ID: <20180917150149.GA25348@infradead.org>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-4-git-send-email-atish.patra@wdc.com>
 <20180917143550.GC15588@infradead.org>
 <alpine.DEB.2.21.1809171638560.16580@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809171638560.16580@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:52:44PM +0200, Thomas Gleixner wrote:
> If this really does not need configuration and all actual implementations
> are not "allowed" to screw the timer up, then this surely can do without
> DT.

That would be the plan.

> 
> Just for the record, this would be the first (architected) timer ever which
> just works. I'm having a hard time to believe this, but I'd certainly
> welcome it.

And that would be the contact with reality.  Note that the current
scheme which just matches for the riscv hart (aka cpu core) nodes
would not exactly help either.

> 
> > -TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
> > +core_initcall(riscv_timer_init);
> 
> Are you sure that core_initcall is not too late?

No, I'm not at all.  This is just intended as a quick throw-away draft.
