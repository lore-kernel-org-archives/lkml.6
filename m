Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC091C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC1A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ft1AanhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfANLX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:23:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfANLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ndFVpxKaBEKLCz7RGcc/EQQsj4szmWrUJQOCc/s5F8s=; b=ft1AanhXRaYFDw+LLS57XWrZK
        Q1NGIfd04DXcgdLAsIcLf4n2aLmZclNFwsmrB0HVSkdn11T4oOrUDisBnpYmuR59SxWlWJ9FWmEoN
        3Efu0VbBTVEI9N8IY/Tw2wQnWdMbLI52DLIlRS1gZ4ev9Hh2r44vzYYq8YGbf+4zMkQqutE4SvpZY
        f1OJxtlO2ur5+3suOvGr7Rlm8RtBBHaM9SID1PdONjv6Zq31s856DDzm/pU+4NxFVE1UkL3oTxw5g
        zH+6RoHBxe5xBGabeOq8ltp3Wj4AZNwafYd3768+bD4ixer1x8SdXNgykWpLQ3gJEKB+lFkZzQLww
        ekUjl3MNA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0LT-0006oO-TC; Mon, 14 Jan 2019 11:23:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: DMA-related cleanups for parisc
Date:   Mon, 14 Jan 2019 12:23:45 +0100
Message-Id: <20190114112353.30616-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Helge,

this series has a couple DMA-related cleanups for parisc.  The main aim
is to move anything not required by drivers out of <asm/dma-mapping.h>,
but I noticed a few related bits and cleaned them up as well.
