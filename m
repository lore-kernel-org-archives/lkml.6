Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EFCC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D28927B7E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gov9Cfjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D28927B7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeF2HXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:23:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeF2HXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EUpPJqkt+NXLn5llLVe4+4eecThzMJurA13pxUVWaQs=; b=Gov9CfjzfxDf8lMk8fu6DTqTh
        0JzhOrUJc8TJ82/P4QAHSJtcJgxNMBYgHTsZAiokBCK2lKXOJDyivwx+7EeFv4LXTjwvE0+UfE7RV
        eD5RnaAP8w2kw1PUo6oCHK3ockHz2Co/3YlW4Ura3uZ+MSeDXZV1b4SYOYSekKQDqw4UyP/MjhGLR
        Mey4VyZ9kTRQQLgCdOeZVDYB6EKpdOXNlyrEh7DT7XXes8kck5i7TJZ2wux1I1ZRJegPQEAnza26B
        r3RSGSSv2IVLTHGSkdZ7rQM0ASPOtBSlYql1Zxp38hst/WCNncdXA5fqlhZPiyWO25oNmosoC3D2l
        baP2exdqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYnkJ-00011p-TY; Fri, 29 Jun 2018 07:23:07 +0000
Date:   Fri, 29 Jun 2018 00:23:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zong@andestech.com>
Cc:     palmer@sifive.com, hch@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, greentime@andestech.com
Subject: Re: [PATCH v2 0/4] Building for 32-bit RISC-V kernel
Message-ID: <20180629072307.GF12956@infradead.org>
References: <cover.1529915117.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529915117.git.zong@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, what kind of userspace do you use for riscv32?  Do you have an
easy to use root file system available somewhere (or a way to build
one)?
