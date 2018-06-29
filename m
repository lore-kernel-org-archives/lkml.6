Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2327B9A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3nE2tn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF2327B9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeF2H0n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:26:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeF2H0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n1a4F8W6G1/MNeqRryFlLXpWiJqWV6lNGZZU1CPtY8Q=; b=d3nE2tn0We90U7K0J4HYf3UPv
        5ho/eyq9XTau0VtJur1robWHXUNqtg3d8HejRNSiFLA9OJ4GxP+sYuO+KT1SXn+PEI37c4dyAVf/E
        ATupT2Pa/pbPjM4fxDuAjdMWKths8QDohjW25vq7qXMPG+MV3YHRsLKDwRNVYPhLpsduscgfPL1LU
        Ud4DzBdktcPXO0F1CubqMh+X2fHar3hXTPWqtuzJSqas2717LtUxq8jn+NjSllNyY81LaRUJWTdSP
        OUOaDkcCN8ViYmqIKzwCd6ZwSCBr/rAdvbMEqXzITYf7ChCpIW6tchktnOGXJ7aeIFm0seiibD12H
        do27FP4XA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnng-0003Hp-VK; Fri, 29 Jun 2018 07:26:36 +0000
Date:   Fri, 29 Jun 2018 00:26:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     Zong Li <zong@andestech.com>, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greentime <greentime@andestech.com>,
        Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] riscv: Add support to no-FPU systems
Message-ID: <20180629072636.GA4416@infradead.org>
References: <1530073346-5341-1-git-send-email-alankao@andestech.com>
 <20180629072229.GE12956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629072229.GE12956@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, I wonder if we just just move __restore_d_state/__save_d_state
to assembly.  They just call assembly routines to start with, so
they might be a natural fit for the new fpu.S file.
