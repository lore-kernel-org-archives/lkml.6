Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0F82075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l3q8bmYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0F82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbeKVIrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:47:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbeKVIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1VEYE8AYKWMorcMRVdBvCicCcdIwPJJhQJfF/v55zvA=; b=l3q8bmYSAP0C4J0SX/eBkeyYI
        6q1G4j4F1WHUK+XfeCBDaRPFepLiwNySLDXsJou+eJDF5MApqp4LQw3WW3Jf1GTrD8MHjlVgsWEiM
        jauN1tEcNyiSYEYVb0iyNLnLRZ8CXfA/IY91VqorrMWDjAuSLE3qUklZAWXMuSd8QDZ5BmqJ4vLDu
        C+HdgSLxnZLRyr5Fr2fKni6pJZAxGNY+OUitgtK90lvJQbFzMLLHKy7po6WyimBReFOxMUEYxB/vZ
        io9QGqK58sX/FlFINnc1lLsagJWfpK2aYqOy7DFOR82lRVxRFuUNRkovxREAQR8sffjqIA1hnfeJu
        vJjksTSDw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPai4-0005HQ-Ge; Wed, 21 Nov 2018 22:11:00 +0000
Date:   Wed, 21 Nov 2018 14:11:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: use swp_offset as key in shmem_replace_page()
Message-ID: <20181121221100.GM3065@bombadil.infradead.org>
References: <20181119010924.177177-1-yuzhao@google.com>
 <20181121215442.138545-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121215442.138545-1-yuzhao@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:54:42PM -0700, Yu Zhao wrote:
> We changed key of swap cache tree from swp_entry_t.val to
> swp_offset. Need to do so in shmem_replace_page() as well.
> 
> Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
> Cc: stable@vger.kernel.org # v4.9+
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
