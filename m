Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47474C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E765A2172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+ys/918"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E765A2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeHCJeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:34:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeHCJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uZfqkfPSPY14PZTprRR0TovxgMF1kn+T2Px/reWsHEw=; b=U+ys/918R6OzIPikL/I19OWwh
        2BN5IJy+e/dJjDW1+gGeAq/1Q6cHsgwnHtwaHJmqJusYeAdku0jn88Udq7dQL3t/NCP49GBoMqmOb
        TdA6byqN+xv0Tq2WuntCz87FkmGPhBbhZxmi/OxBDxPIbbUgxQ/6AxWlsWTwLQs7fvp3KWvEeDFYE
        +lND4cwp2fkR4sY/HkHR3XrrDUGE/MPGf5X79v9f8XqWpOLiNFuBxlmVPSa5CpIrMVknbemumSdZC
        /OMEZOvLbNwt6QMu0yeTIIyGmHl8AkbewpgWsDfgk35mdteqKRsCrodKpjNiGttZB0ZpurfPGZkHA
        YlNQvHPuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flUg8-0006xv-Vt; Fri, 03 Aug 2018 07:39:16 +0000
Date:   Fri, 3 Aug 2018 00:39:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     deepa.kernel@gmail.com, zongbox@gmail.com, y2038@lists.linaro.org,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/7] riscv: Delete asm/compat.h
Message-ID: <20180803073916.GA19580@infradead.org>
References: <20180707054247.19802-4-deepa.kernel@gmail.com>
 <mhng-ca3e24c4-d59b-491d-a9c5-c8466168b638@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-ca3e24c4-d59b-491d-a9c5-c8466168b638@palmer-si-x1c4>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 06:26:58PM -0700, Palmer Dabbelt wrote:
> I thought we were using this to make uname print "riscv64" (or "riscv32")
> instead of just "riscv"?  Is there another mechanism to do that?

That is set in the UTS_MACHINE variable in arch/riscv/Makefile
and doesn't involve compat.h at all except when actually implementing
32-bit compat on 64 bit, which RISC-V doesn't (at least yet).
