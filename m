Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFFAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2239020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="eA8WIXgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2239020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeLMWAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:00:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41391 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeLMWAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:00:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so39653pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x+f/EfUPLBLGG2sYEYaNMMzAuZ97OhsHrasfcI1i1dE=;
        b=eA8WIXgSivGYPJTr0NmtofJ1i6L/CP111yK6ftVgSy96wCASqEQE2oDzTfksMNS2hW
         zcB5g5rZXoCwGruRvB3THy6MpdDVQ5b4pQpZiSqs6dx1l0IUsdXYSMGwmkYndyyPSo0k
         SNmhUS7qpcrRTJZBoxk/UVow85iGHcnMczKKEVmJo30KoEucUXdfS4BVztFVqSAy+8wS
         af39tNLBmFyirIILRlSX/igBcqwJmxMETArz4sVzz8ewrSJ4H0cxrnYeBZQkOEA6Zv1A
         gu4FxxohgB4giy5I5/6uAAs9ZwGUKzkuIWkVSvHg4SjSfNu9VGldLjpPKSp2hvXeR+cg
         e2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+f/EfUPLBLGG2sYEYaNMMzAuZ97OhsHrasfcI1i1dE=;
        b=tyd5q160083pKMGHI5PchstNLVLy+AZImoFYjlzrJ1BEKc7c1d+hkgVw4QmxdvBeTx
         FsGIFQ0IYAQr4pyclGaLktCT51NEMi3MmwJfRjnNPqpXu4bAiUJfdmVi+GG4QeFZ7Wje
         soQrNV1qRY/qs2QtgpR3lou3rQJqvDUcx8/y1rX0XsHBQEvSCeRVbxYEv7gHAj/Ll31o
         uoM2/oIHVPxMXvqYhGhMwNgWifua5zWzSwvbOs5Du/Mojt2Cb4GJigW2emqTKAbGIUN8
         jCGYgaB4LBBLdL5U5L5ek5eJUBui8xyyrKEfbZiZGmaJgih4w2fHHyGaq3/1blXclslo
         FhNA==
X-Gm-Message-State: AA+aEWaVmM5rGQGHapki5zhSPV4+mwSggcpJnGQ5zScIX9ad92+EFo5x
        ImqUhTIKJH+KzcE5tksvss88/Q==
X-Google-Smtp-Source: AFSGD/UoDUJ78ZW1naZJSgg/wi6mH6Y8aDd8bc49O21snTBR+QJpStXL8gKjaA5qi8Rp0MNVjDsxMg==
X-Received: by 2002:a62:3006:: with SMTP id w6mr452895pfw.258.1544738406057;
        Thu, 13 Dec 2018 14:00:06 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id r66sm3935854pfk.157.2018.12.13.14.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 14:00:05 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id AFE6E30025E; Fri, 14 Dec 2018 01:00:00 +0300 (+03)
Date:   Fri, 14 Dec 2018 01:00:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Richard Weinberger <richard@nod.at>
Cc:     zhangjun <openzhangj@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] ubifs: fix page_count in ->ubifs_migrate_page()
Message-ID: <20181213220000.7b56wysed67y5iv6@kshutemo-mobl1>
References: <1544728817-2870-1-git-send-email-openzhangj@gmail.com>
 <8239265.3QN2sXB6kY@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8239265.3QN2sXB6kY@blindfold>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:36:47PM +0100, Richard Weinberger wrote:
> Am Donnerstag, 13. Dezember 2018, 20:20:17 CET schrieb zhangjun:
> > Because the PagePrivate() in UBIFS is different meanings,
> 
> ...has different meanings...
> 
> I'll fix up that myself after applying your patch. No need to send a v3.
> 
> > alloc_cma() will fail when one dirty page cache located in
> > the type of MIGRATE_CMA
> > 
> > If not adjust the 'extra_count' for dirty page,
> > ubifs_migrate_page() -> migrate_page_move_mapping() will
> > always return -EAGAIN for:
> > 	expected_count += page_has_private(page)
> > This causes the migration to fail until the page cache is cleaned
> > 
> > In general, PagePrivate() indicates that buff_head is already bound
> > to this page, and at the same time page_count() will also increase.
> > But UBIFS set private flag when the cache is dirty, and page_count()
> > not increase.
> > Therefore, the expected_count of UBIFS is different from the general
> > case.
> > 
> > Signed-off-by: zhangjun <openzhangj@gmail.com>
> 
> Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
> 
> > ---
> >  fs/ubifs/file.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> > index 1b78f2e..890dfce 100644
> > --- a/fs/ubifs/file.c
> > +++ b/fs/ubifs/file.c
> > @@ -1480,8 +1480,17 @@ static int ubifs_migrate_page(struct address_space *mapping,
> >  		struct page *newpage, struct page *page, enum migrate_mode mode)
> >  {
> >  	int rc;
> > +	int extra_count = 0;
> >  
> > -	rc = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
> > +	/*
> > +	 * UBIFS uses PG_private as marker and does not raise the page counter.
> > +	 * migrate_page_move_mapping() expects a incremented counter if
> > +	 * PG_private is set. Therefore pass -1 as extra_count for this case.
> > +	 */
> > +	if (page_has_private(page))
> > +		extra_count = -1;
> > +	rc = migrate_page_move_mapping(mapping, newpage, page,
> > +			NULL, mode, extra_count);
> >  	if (rc != MIGRATEPAGE_SUCCESS)
> >  		return rc;
> >  
> 
> Let's wait a few days to give Kirill a chance to review, then I'll apply the patch.

I don't remmeber much context now...

Could you remind me why ubifs doesn't take additional pin when sets
PG_private?

Migration is not the only place where the additional pin is implied.
See all users of page_has_private() helper. Notably reclaim path.

-- 
 Kirill A. Shutemov
