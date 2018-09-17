Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5482098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oCZpdNqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5482098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeIQTrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:47:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeIQTrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RBQSTgTJb6Y+7fOwy+trJVuZqVYaA4iy1jzXbjsC6b0=; b=oCZpdNqQsO/GsvhnC8CfZxxip
        3vxV0RZH++1a6o2aR3Bi4VFVAKT1sc73mESfyt7iQSt5FZ2jZbQj66C+XS+2XghA6wYUD7GHuelmm
        keeXqeoBJl8GEBvSMp2krba4yCJPPkRKOUZSmbjYQcT9WicpH18Wk9eyj4XKkz+1XMf4rLihKT1nb
        0TSnBjVcF1ddGLnrJA4KbpNroWjs+H9kgQPuvUGan0XSpbv/pVCqE1tnBq7m4+dIeYgajtgwinLoB
        kr0akO10ffkhD5TPTjNzlnGdWY+4D2Lz7y/nxyt/cS4b4V06Onn7nQRUR7+evSvM0wgj+nclgZOLr
        0bXmRiY0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1uNt-0005Ac-M8; Mon, 17 Sep 2018 14:20:17 +0000
Date:   Mon, 17 Sep 2018 07:20:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, mark.rutland@arm.com, robh@kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC 1/3] dt-bindings: Correct RISC-V's timebase-frequency
Message-ID: <20180917142017.GA15588@infradead.org>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536962096-233842-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 02:54:54PM -0700, Atish Patra wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
> 
> Someone must have read the device tree specification incorrectly,
> because we were putting timebase-frequency in the wrong place.  This
> corrects the issue, moving it from

Last time this was brought up we actually had realy life DTs with
the timebase-frequency under cpus and not the invidual cpu node.

I think we need to just document both possibilities and live with
them.
