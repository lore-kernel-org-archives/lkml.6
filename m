Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5602BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D134921A66
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmQgEejr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D134921A66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeF2HMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:12:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeF2HMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E2y8MgkWYIrvlucom96B5jepIho/wY0LFgxB87sKUmE=; b=RmQgEejrQLjYn58EPqD8BaAR5
        UVgxL1SYKWRZS+7QOOz2RR2AFycDQqtrhH9rM4kVVWN37xmVx9cAbZ+jlI+ozyLisYqs+IH+D54BP
        0jMBJ4AxUsufaPi3n6cdZ441QfFaBdKb/SA4sVYb9VwP93pKkdGe4pVslsNav24iifC1MTbw9XPA/
        44tlGtD1wGe/4zISRKfW2AdeCb4poJOJHkxUf/6UWD/CGBvcz7OFyuBZ45UBpWskcepkKk5QI/mZE
        eZOJRCN4QTdKzIEB9oTKiUI7foXjxZOSnY8Yau2RbNn7nWcwE2HzqdDs5TRrcyKNlATPmwOB2yyn7
        8XHQ8oyUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnZY-0005FP-Rb; Fri, 29 Jun 2018 07:12:00 +0000
Date:   Fri, 29 Jun 2018 00:12:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, hch@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, greentime@andestech.com
Subject: Re: [PATCH v2 3/4] RISC-V: Add definiion of extract symbol's index
 and type for 32-bit
Message-ID: <20180629071200.GC12956@infradead.org>
References: <cover.1529915117.git.zong@andestech.com>
 <4c4def99db5e0392238947dc878c5018cc7aca3e.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4def99db5e0392238947dc878c5018cc7aca3e.1529915117.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 04:49:39PM +0800, Zong Li wrote:
> Use generic marco to get the index and type of symbol.

Why do we even need this in a uapi header?  Shouldn't ELF_RISCV_R_SYM
and ELF_RISCV_R_TYPE move to module.c?  In that case we could just
use CONFIG_64BIT.
