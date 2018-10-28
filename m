Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C3EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000720665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AP/Al/wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0000720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJ1TID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 15:08:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJ1TID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 15:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3jDaZ1xYLEny0Ob3RYybM83HZoEZZBuR/omY7KjG2iI=; b=AP/Al/wooMawAhsNY6k2kzDxu
        3PgK6Ffl3ocdFCnozUpBGiBqmwBiPwm94jGWp8zFXJ52VtSh6YbXGtIlsQpRqbs/Ot99H+37tBKK6
        N//APtggPdmePKWb36qfzHc/J6Po9zgb04Mmrjl1dak+215lyr8dheFxzbXwzO9NxJh9gWFatGbFt
        P+YIUO7P1KHYiXowgN2s946SsEx/ihPC921OvQaqa/qR6VCkrkNXfKycksW1yIB4z65s3jJhks1UB
        rVq1gB1IYqbzxREHXfuvpfnv8o3Cwlwgsh3OnGBumMiW4E0iloBlavxCl6H7P/yVe6bVvWZA8BsJN
        BzHoAES9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGiEU-0006ka-Jh; Sun, 28 Oct 2018 10:23:46 +0000
Date:   Sun, 28 Oct 2018 03:23:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] mm: simplify get_next_ra_size
Message-ID: <20181028102346.GC25444@bombadil.infradead.org>
References: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 02:13:26PM +0800, Gao Xiang wrote:
> It's a trivial simplification for get_next_ra_size and
> clear enough for humans to understand.
> 
> It also fixes potential overflow if ra->size(< ra_pages) is too large.
> 
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>

I also considered what would happen with underflow (passing a 'max'
less than 16, or less than 2) and it would seem to do the right thing
in that case.
