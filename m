Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7DFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E0B20837
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CKNvSoIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E0B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754202AbeGFOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:11:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeGFOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qjN3w/UTqAszMLLKCwpNBHqi7FPwRfkF8COqr6IF6vg=; b=CKNvSoICfTl67dxSPHikkwLEp
        cLzsJoubXCZ5FNF2ZBquFaNbBrBXZZW6qwZr79dQivuwcq0Fd8eICyVptBv8hH61PuTSY7TEJsk9g
        iFjHAIb5dYhC2PgzKNm2eeOC6e+K7Me5Z2WkvVOtgdzJxZh+QTsnhSRJIl6Yxa8GVh5pG4Z0BvI3P
        SE8b+tzLvc6QNqrqYGectF0FYCt+Lc3K9wGUoPyvM6u7djqnR1NKwf/IJJZZlCGNbACa2sZFj5vsm
        bOrvU3HdGm93QbhLA4zqtZLF3oxxbQ8NI7RJTH0Ip43B40pte4r5j9Ufg9+KPqMcp62x/ynfFT+Jk
        Q6mJE5I6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbRSY-0005X8-1i; Fri, 06 Jul 2018 14:11:42 +0000
Date:   Fri, 6 Jul 2018 07:11:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Fix lock/unlock imbalance in xa_alloc
Message-ID: <20180706141141.GA20816@bombadil.infradead.org>
References: <20180706131044.GA25469@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706131044.GA25469@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:10:44AM -0500, Gustavo A. R. Silva wrote:
> Release *xa_lock* before return.

Thank you!  I need to improve the test suite to catch that one.
