Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ED121B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zMmXsWNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393750AbfBNW3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:29:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40629 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbfBNW3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:29:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so3882938plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvjkFmreiSParKFafQcGiRdK5zDzo6y3sTnyvcFNMzU=;
        b=zMmXsWNaqFgtURCjoEYmlG9ZootJV5ETk7RClqRFNaN8UtvsHttKiTduUB2vRFLESU
         Irv8uNMRW39/Dt4ph9ebsvwqiek11zObnThfoX3rv9ZPb9vmkPWCpfV53nTW18dGR9On
         Vi0iJd7SX6A7bQ5zmpinCi7IZXHRVufYoUWYHI7cpK3R4scCSdUtlFJH98y5l/CDRtfg
         sn7DnsR8Gb2ZciO30zpSgCP6vnc4KosNxCn+DbhIK0angJilTkL5hmoRLTXPXjC1/KPX
         Uy8melJuZm8a6jnjud5Fv/KJfyUlcg9KVPdEXDUPKkxb3klzdSxmDy5Er2KOBNYHafdV
         uA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvjkFmreiSParKFafQcGiRdK5zDzo6y3sTnyvcFNMzU=;
        b=jGTqoiHbtrmmU3jw/wCyK25CuUfsGoX+YZpsK1b0kcsu0Gm+bW8j3QvDehEJIIOO1u
         AR685vJERX+uNATNkJKKyR09Hzjqgxpb5h4umcbwGGr74sWtC1KFysZEXWm2tRIakjSL
         lA0PN2JqTegTTh3O1j4d+3a6AVUQ12CFID3JXV0AjhIWPJddYeY5avfX6T6WgA6NzKgP
         q/Kd+K4HLRyj5LiXo7qkzIzDMzCv+b9P4sCc2udlAvLJhLCKD81SelSfWfAzNlDN3x5M
         fBS/H5JT9miyCJJhgMzVCgmPYdvpfO0RaimybUmpkd+6lTWvqtoIx4/gSGYMN1acOaUu
         RqfA==
X-Gm-Message-State: AHQUAuZxYbGLJJY9oxCQeHXV1rS2DpA0SImp1lsVxjLFagVZimo0U+Sq
        5Q5z5cKKRxO6U5mtcn9UzEkxZcM6EFMegg==
X-Google-Smtp-Source: AHgI3IbRwfPTP/Y0Xv5KT7Y/ZfnHrmYGt49yZlShyrIq2MoJyVHHOX2q/yx+7hvTOo/tOTXaLI+zsA==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr6737872pla.131.1550183388999;
        Thu, 14 Feb 2019 14:29:48 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id i186sm6122051pfc.28.2019.02.14.14.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:29:48 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E68993008A8; Fri, 15 Feb 2019 01:29:44 +0300 (+03)
Date:   Fri, 15 Feb 2019 01:29:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214222944.74ipvbnvo2lvfgnr@kshutemo-mobl1>
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

Other missing pieces are memfd_wait_for_pins() and memfd_tag_pins()
We need to call page_mapcount() for tail pages there.

-- 
 Kirill A. Shutemov
