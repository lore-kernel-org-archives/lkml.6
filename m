Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC4C21834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bbOjt4g8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC4C21834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeHMJcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:32:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OAQaZws4Hyw8/bjV4aL5pSWojk/ycRjJr6xLMz05Qps=; b=bbOjt4g80KOLj5bHUTCJE55KH
        cXgZOJSa/I9MqDm3iYtLIkyL98bk03V+ihOPL5X1K7RhbdHXaKcIOCtUpa5noY/S2btXkAWQfmyN6
        QgQVCWyy09DRvyVW+ouJChTSL5ottvDynbQ5PQ/CFkCZMDegi11a6hG2mkJILruyenaJgbLo/9Fky
        lrhRCSQoaWHbNrSLpObUbiB7dJdjCfL6D3DZYn7WFsF0aciisK4slTYDTPY3AEknIPpn+ZHNihZ/R
        fUdTQih6FoIpZA1XfuejlLH/PAZYW/q0LEryNObgjfUgn75g/rqEflSZJhU/VXh+DyLrHYfJ6BoNE
        73NOslF9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fp6hj-0004c4-BC; Mon, 13 Aug 2018 06:51:51 +0000
Date:   Sun, 12 Aug 2018 23:51:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 00/16] staging: gasket: return of the son of cleanups
Message-ID: <20180813065151.GB6039@infradead.org>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, can someone explain what 'gasket' even is?  A quick look through
the directory didn't provide any answers.  And please don't just send
that anser to me, put it in the source tree (Kconfig, and if needed
another documentation file).
