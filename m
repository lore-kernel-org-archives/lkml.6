Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A6C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 23:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACF824D5C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 23:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mf7hsufE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACF824D5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeFWXGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 19:06:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeFWXGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 19:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rAVJzyWGvdgwZ6Z/wWTpLq0ZQsilaPDI7k/dduCcUmU=; b=Mf7hsufE5upi2iOOL4IY7rARr
        grbMWmzeS2P+ux7Pbrif8cCgpZVBm+A0D7LAM6SBBMe12mWE+ibZ+oxd6ihxi8NZSSHVwJY/6YKf8
        DP/nWAtTgWCDvLc4PNYutr5AZKZwO/CW9EMXCoecKdyOYpEmr/hWwDUWU1YXPpKGH7RH6mq+JO3L2
        Y1rlrCnQGtzOIbNJG3qS/0YfoAnWs8GiqFp8BVgKKpRIu15RFIudFALRjz92Kwf7sdbjhYzeadhBE
        57Aj2fVjtmYzY/o6syrJ3ttIGGXz7SzYh6U07QbjI5QqMyz2rYkDj/kX4j3eYxr9RHWo3NEh2NZk3
        2JmFR6Lbw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWrbh-0002FU-2r; Sat, 23 Jun 2018 23:06:13 +0000
Date:   Sat, 23 Jun 2018 16:06:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vinod <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 16/26] dmaengine: Convert to new IDA API
Message-ID: <20180623230612.GD18630@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-17-willy@infradead.org>
 <20180623123039.GX27187@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623123039.GX27187@vkoul-mobl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 06:00:39PM +0530, Vinod wrote:
> On 21-06-18, 14:28, Matthew Wilcox wrote:
> > Simpler and shorter code.
> 
> I couldn't find ida_alloc/ida_free in 4.18-rc1 so I assume this will go
> thru tree adding this so:
> 
> Acked-by: Vinod Koul <vkoul@kernel.org>

Yup, you were bcc'd on patch 3/26 which added the new API.  I'll be sending a pull request for this mass conversion, and I'll add your ack.  Thanks!
