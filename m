Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2368FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B364021B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W7p32tl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B364021B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeHIIyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:54:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHIIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4XvFT4u0GaEOddnatPDK1/ydv5hscNG1j3FxM6bM6R8=; b=W7p32tl1/PsShqMee6G8+2Gg0
        h9FAF44EHPhaw3gbIx0MFblFVu537tFGjDMocuYhLBG+UYLQyesujNR5PjvAzaWUXNFN3u70WuwN9
        rtYjS/cPWRzPpTfLQv/jkBw72wNaSCDi5puQdzlKL9JABao1WQvLxMQrLCbZlYdn4+nkBddEa0X8p
        G1NBbJZuvZhdQL/u3L7nc0ZM+gBT2AQbhZ+L7rLAL5RRAGJvNqBKKlgI1PHGd1WQ4Bo96+tNISySp
        mjBC1veyy0QvdMlS5SjGiH2U9quD4wxnO0p2bqUQOyFmsNvv3xcKIYIkxgEnmcX0FkWYVAeMW6y4d
        qGy7Xad3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fneTk-0008E5-ME; Thu, 09 Aug 2018 06:31:24 +0000
Date:   Wed, 8 Aug 2018 23:31:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        vincentc@andestech.com, zong@andestech.com, nickhu@andestech.com
Subject: Re: [PATCH v5 5/5] Auto-detect whether a FPU exists
Message-ID: <20180809063124.GA26062@infradead.org>
References: <1533796003-680-1-git-send-email-alankao@andestech.com>
 <1533796003-680-6-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533796003-680-6-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  extern unsigned long elf_hwcap;
> +extern bool has_fpu;
>  #endif

Doesn't this conflict with the !CONFIG_CPU stub in switch_to.h?

It seems like we should only have this definition in one place to start
with.

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
