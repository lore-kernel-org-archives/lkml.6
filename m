Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B133C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1942B20896
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlbsEOVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfACH4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:56:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfACH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E5nHf0axNTTsOkj4FsWz4Uz61lUYTnWBgoxBNd6+0t8=; b=nlbsEOVT5VGzAtC8Ma2rGQtmU
        elzT9d4qqpgLD5Y4WqgpnOwrQHTzFuIZY8XX8mmLjd+OaYNx7/r5sWb8pkyGDjBkSpnAX4b9y3mcW
        aAMsvbCT4sA1nMPstXKDbZeHqfdDa8nxfWlWXJ6XffjkXlxzq1S19sLqVjBnX7voZh274B7NsTVVF
        eAqTpEWB4qITWFbvZozM7ppK/53AKyMolXYDTRzitjKprlGYGAtbgwew8QO7U8G9PHnAsaTVOopH8
        YpV6IiFC6MQxU27t+HTWctcKG/8CRpH7wTsZBUJRKyqlB9cQpo/dPZaLTomH7ixUCvlyXASVr13yz
        GV3JVGqpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gexr4-0004EA-L3; Thu, 03 Jan 2019 07:55:50 +0000
Date:   Wed, 2 Jan 2019 23:55:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        alexey.skidanov@intel.com, linux-kernel@vger.kernel.org,
        shijie8@gmail.com
Subject: Re: [PATCH 2/2] lib/genalloc.c: export symbol addr_in_gen_pool
Message-ID: <20190103075550.GA11147@infradead.org>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
 <20181224070622.22197-2-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224070622.22197-2-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:06:22PM +0800, Huang Shijie wrote:
> We may use the addr_in_gen_pool() in the driver module.
> So export the addr_in_gen_pool for the compiling.

Please send this along with the driver that plans to use it.
