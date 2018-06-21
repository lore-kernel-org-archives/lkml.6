Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B53C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F0D20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gaqLHI2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F0D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeFUHQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:16:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeFUHQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WhOhfdGp5UJlV52jIYD4O8Jdl0ha5WbVyQyg+qduI+k=; b=gaqLHI2HAXWPEJst5BAa6xzFk
        8/EWMzUeblAkVBHbR2YGvdEZGSgcltcFgdF16xRaPXnOyjFMIJ/JbZV3WgLH7OiOSb6g7J30LvJei
        nUwKfagNL55aGSWm7hr4By7nIKZQPx2YNpZSBY6etH5TlvOjvMlWXtFkahThlgYt0J9tG5UCljv05
        z4Mo7/1OrNQyBa9TqgpOiXZoCSFHUcZMRzvyN4i/Lb4l0+XRq6CcXD9UzBO8Yqvpzc/UNpK7i/h4K
        R59f3JDaiwi51OO8pfpT72SyhacXvCT9PEiya/pZ0bQQmq5B389A/F1PN2hQnEDDFQK/nwuSUb/Zm
        OjFLHxQNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVtpE-0001jL-Vz; Thu, 21 Jun 2018 07:16:13 +0000
Date:   Thu, 21 Jun 2018 00:16:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     akpm@linux-foundation.org, jthumshirn@suse.de, cl@linux.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, dvyukov@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempool: Remove unused argument in
 kasan_unpoison_element() and remove_element()
Message-ID: <20180621071612.GA584@bombadil.infradead.org>
References: <20180621070332.16633-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621070332.16633-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:03:32PM +0800, Jia-Ju Bai wrote:
> The argument "gfp_t flags" is not used in kasan_unpoison_element() 
> and remove_element(), so remove it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
