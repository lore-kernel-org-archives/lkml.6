Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B51C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2124D21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="xEPmjA7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503429AbfBNWlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:41:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40105 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408127AbfBNWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:41:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so265479pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PIbuAu83tU6MnBvhuGJcfbmbWhFchHhVCd+8U8eEQ4g=;
        b=xEPmjA7Ur5QzxnY9HhmKWp7m+N5ET2X6uJICYKN7XEucCSvCzbZxF/x41NDa6DPxOp
         z2RmqocGPk9l96tUFltKq9ZyYc7eII3va/hoMjNGfG8OcugOfFT/QlFc3YhFx3SOmPFS
         ueNpacTm8PbBaOuJOfuk1srGZpuxqL3QUpMWeh0w5FVGSz5sTC1wuJD+hsV5GGfL0xEa
         5xvWTga/HwNx13PHrF6hGMeo5OoDVC7ZC7QPFUexcjT9BT12or4ZylghiiNPt+fpBhWP
         gUBEu6BJZ3u0AL1Qx2UkKhJA1u7MLdoABEHSmVRf4mog0D+tXiwqTREobiHRhWeUZzTD
         s7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PIbuAu83tU6MnBvhuGJcfbmbWhFchHhVCd+8U8eEQ4g=;
        b=DUTDPFrOQ7zkrPSkfl9TJXVsB60bs9qUcCA88acEcvEP14MAxza30+XifiuUA57yPD
         y7pzt4g7zm6hZXwaZNFkuXpiUYqzfIkQHiu/DxTvHS/oeKRzmYQwMknbB4MFnz7iwniR
         D1XhNQEWn8tSQo4gOy9n+qyusiOX7Ydski17bKG9NVqnFqGkLAMwJuYZ1MWY2jBbRoiS
         Dziy8AeQtMuUQEv0g7hLbjfmfGB0fFoYYtLDiEruAUh+rm7z3OgDL6mBRiFraMpnhUPq
         GgZXAxRpY491MhAZPaLVjNzVaFV0/M4yiBNtqA4+uPaZW2XkAoxiTmwq1r24vozrxa7o
         XRKQ==
X-Gm-Message-State: AHQUAuYGA4NN5iZkqN0KzD4zd2YKFIXAJO4e0AFolV7pxY8K+0KcRZan
        LX5hLJh7WjioyJ6FIVmyA1tzow==
X-Google-Smtp-Source: AHgI3IbBtBc8ecYjxuLAkMM7INBEAgmMEWl4Mr9FMhVLpVQuuO5irj0i9E/fjpQNvqRUQZIPf7zhlg==
X-Received: by 2002:a63:516:: with SMTP id 22mr2159642pgf.353.1550184079904;
        Thu, 14 Feb 2019 14:41:19 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id m68sm10097613pfj.89.2019.02.14.14.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:41:19 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 899A03008A8; Fri, 15 Feb 2019 01:41:15 +0300 (+03)
Date:   Fri, 15 Feb 2019 01:41:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214224115.4edwl7x72abztajb@kshutemo-mobl1>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 04:30:04PM +0300, Kirill A. Shutemov wrote:
> On Tue, Feb 12, 2019 at 10:34:54AM -0800, Matthew Wilcox wrote:
> > Transparent Huge Pages are currently stored in i_pages as pointers to
> > consecutive subpages.  This patch changes that to storing consecutive
> > pointers to the head page in preparation for storing huge pages more
> > efficiently in i_pages.
> > 
> > Large parts of this are "inspired" by Kirill's patch
> > https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> > 
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> 
> I believe I found few missing pieces:
> 
>  - page_cache_delete_batch() will blow up on
> 
> 			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
> 					!= pvec->pages[i]->index, page);
> 
>  - migrate_page_move_mapping() has to be converted too.

  - __delete_from_swap_cache() will blow up on

	VM_BUG_ON_PAGE(entry != page + i, entry);

-- 
 Kirill A. Shutemov
