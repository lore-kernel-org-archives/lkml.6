Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D5CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BD1206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnvOxTNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfAMQtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:49:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfAMQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wrZm73XoQCJ9+KwY5y7yjv8JJNYe/WdlAJUCzKjmak4=; b=bnvOxTNcPIsfTh7rVGKvYNIhY
        2VyR6sCq5y8Z7HRM2cNWQvmi9QsuwB9D3QTcwBkKt2IU0WvPJqdCczlYuoUmT1GgEhiFaSNvLxZia
        1e+OKkHFz0Z+CYhn/++w7S0zOcyTCy+S4X8eI/gNAknsU6wuy5WIA2tBGgTQ9/+iNexNPjOOCDJnv
        qIzsOf5M1ybNwURSPjtdwOqyiSL2ASxKWafBqWS/V6gq2GpY7M2fEptT+cLsMOeHAWBm/RVybXHUD
        4RiEQA8HGPSMORyQZc9mbcLAtihbNwgxIcgxldkd0U510htG4QWtV16E5vmNo6UFR7hW7UvyUVTcU
        kxFxfscGg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giix6-00041e-Bt; Sun, 13 Jan 2019 16:49:36 +0000
Date:   Sun, 13 Jan 2019 08:49:36 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Joe Perches <joe@perches.com>, Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] coding-style: Clarify the expectations around bool
Message-ID: <20190113164936.GW6310@bombadil.infradead.org>
References: <20190110234805.GN6890@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110234805.GN6890@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:48:13PM +0000, Jason Gunthorpe wrote:
> +The Linux kernel bool type is an alias for the C99 _Bool type. bool values can
> +only evaluate to 0 or 1, and implicit or explicit conversion to bool
> +automatically converts the value to true or false. When using bool types the
> +!! construction is not needed, which eliminates a class of bugs.
> +
> +When working with bool values the true and false definitions should be used
> +instead of 0 and 1.
> +
> +bool function return types and stack variables are always fine to use whenever
> +appropriate. Use of bool is encouraged to improve readability and is often a
> +better option than 'int' for storing boolean values.

It's awkward to start a sentence with a lower case letter.  How about
rephrasing this paragraph and the following one as:

  Using bool as the return type of a function or as a variable is always
  fine when appropriate.  It often improves readability and is a better option
  than int for storing boolean values.  Using bool in data structures is
  more debatable; its size and alignment can vary between architectures.

> +Do not use bool if cache line layout or size of the value matters, its size
> +and alignment varies based on the compiled architecture. Structures that are
> +optimized for alignment and size should not use bool.
> +
> +If a structure has many true/false values, consider consolidating them into a
> +bitfield with 1 bit members, or using an appropriate fixed width type, such as
> +u8.
