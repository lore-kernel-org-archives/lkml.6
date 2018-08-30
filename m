Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63406C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9C6205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0YRXG/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9C6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeH3Sdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:33:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeH3Sdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ScPHoR4u9ljK+MZiOpnrg6NgbYoWhqDaWYv/Es/WCng=; b=s0YRXG/dsA5adZi57L8J40Z8g
        lEE1ccBJ6nXLPPctmQIvJPQ5uSO88E7jHJorYF/ol+fI1lf1FsH/vVSWQWuAf7INx9HfXDv0iBxO/
        5h76wTkOkhBLU/j7nl/lgV4pi+aLEL5pNK41KVTLyhvjFWG/lHLvDRyrozmgHdB6MKS3qEN4jDaaa
        kvE7JuGRN+kSUTD+2+A7PLE/4txRi8ebTGPIlwLamuw5azLr0aJE+yE+ePUCMTfPZ3be1ORlT4XX7
        x2utVfv9JVqNhdDhqv12kpTXtmrb5FXlLDxsNklP9aiotjGXA+omVegcK73SFuvMyfUQJdgnBaQSN
        B9XclonYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvNyd-00031s-R0; Thu, 30 Aug 2018 14:31:15 +0000
Date:   Thu, 30 Aug 2018 07:31:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Kao <alankao@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>, vincentc@andestech.com,
        zong@andestech.com, nickhu@andestech.com, greentime@andestech.com
Subject: Re: [PATCH 3/5] Cleanup ISA string setting
Message-ID: <20180830143115.GA11544@infradead.org>
References: <1535332075-5727-1-git-send-email-alankao@andestech.com>
 <1535332075-5727-4-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535332075-5727-4-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:07:53AM +0800, Alan Kao wrote:
> This patch cleanup the MARCH string passing to both compiler and
> assembler.  Note that the CFLAGS should not contain "fd" before we
> have mechnisms like kernel_fpu_begin/end in other architectures.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
