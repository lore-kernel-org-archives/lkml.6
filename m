Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F7CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzK4AWCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E5D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeGZMiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:38:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbeGZMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rm4XvgNpwJDc3qIYQB6AWbI4TF/Rq/ZztpJ87BxmvwM=; b=kzK4AWCv2cFhn4fjiwOpY9QkC
        dQVA2yk+Ip1sFTCnse/RLEfy7wB8amdbhiLmQyiwe3vt1oKd1BPN8X7sGowpn2pzYBuT0plE6tGKh
        q2PjY7yLfPf2+aiSTbn5s/W1w/HXCqAr/nUp/KAl4UCwt/QigPBhQ4FbNK4XlYxf+xv38JqCjl/ZL
        XNBFPw78aUP85ci5fS5asFFuQ05mYre6cld+pLD6b8BmYGwIk3k2H1qt9du1CujOSliDmuu5V7o8K
        Jde9WqARvQS105+41kJ8PgdrW2YS7O+xjsK8TjVSjDIe1IyecqsEIkrbkyoqPEaWIbzD9oTfGNHIk
        Qe0lZSc3A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fieLj-00071R-WF; Thu, 26 Jul 2018 11:22:28 +0000
Date:   Thu, 26 Jul 2018 04:22:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] aio: add a iocb refcount
Message-ID: <20180726112227.GB3504@bombadil.infradead.org>
References: <20180726082903.30273-1-hch@lst.de>
 <20180726082903.30273-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726082903.30273-3-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 10:29:01AM +0200, Christoph Hellwig wrote:
> +	atomic_t		ki_refcnt;

Should this be a refcount_t instead?  At first glance your usage seems
compatible with refcount_t.

