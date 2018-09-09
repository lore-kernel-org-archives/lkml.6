Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E58CC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B320854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XjvWeCp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0B320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIIX54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 19:57:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeIIX5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 19:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KjrSwzQkP+9g54Mvyhd9RDVsRI9YxrzNh6JQadi5Mdg=; b=XjvWeCp8xyxu5aVrdh98Op4pd
        o/YyEYPLNcTwomDweGta5D3icVkDBNPWyC8Ss/rzm0BhV7ucwHrb2PYuwvJbXzd7rFAxTvS0F9YPI
        HjsGe0N7NCdHOSy8IqB22FX2VN7xBQuoTQa0Ga7bfX9c9owWzVeLN/pvZOsnMP4MwMnazZNQr8Z2Y
        4BKswxE9CRXK5nTNFH29UwuwFDyfqjUtkVXOEDPAeNHoo7FIzEs+L12Ow2osTU9kMGYbsSd/OljnI
        H8DFXqVpr75CFDQFtfmrN0yNcLO66Yqw4WmajRw2fcax6iciveIuJs4NEZ0yBnzCM/qNTg4M4ppHf
        8q7guUh+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fz53C-0004rX-D5; Sun, 09 Sep 2018 19:07:14 +0000
Date:   Sun, 9 Sep 2018 12:07:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Long <wanglong19@meituan.com>
Cc:     akpm@linux-foundation.org, zwisler@kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, heguanjun@meituan.com
Subject: Re: [PATCH] radix-tree: optimization for radix_tree_init_maxnodes
Message-ID: <20180909190714.GA20237@bombadil.infradead.org>
References: <1536499260-126634-1-git-send-email-wanglong19@meituan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536499260-126634-1-git-send-email-wanglong19@meituan.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 09:21:00PM +0800, Wang Long wrote:
> if i == 0, height_to_maxnodes[i] = 0,
> if i >= 1, height_to_maxnodes[i] = height_to_maxnodes[i-1]
> 				+ __maxindex(i-1) + 1.
> 
> so delete height_to_maxindex and optimize the calculation of
> height_to_maxnodes array.

Thanks for your patch.  Unfortunately, this entire function is scheduled
for deletion, so I won't be applying it.

If you're interested in the radix tree, I'd recommend looking at its
replacement, the XArray.  The current version is at
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray
but I'll be pushing another version out in the next few days.
