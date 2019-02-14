Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55771C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244FE21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="LK3eHapj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438127AbfBNWIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:08:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45101 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395232AbfBNWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:08:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so779373pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mFDawymT8Zh+E+HOem14TYUCVAe8NsegNwIXcLtnH/8=;
        b=LK3eHapjO2duzbmPZyml2AAntHc+oCsXsAmOo3RruPUCgn4e1oQ/RTGL1IjLhTk3Bg
         nsUp4MloY69HY4JkvL/o6uZAwq4aEfit60aCwnjMcKT34tL5QSmuao5f11O7fVKsPoEl
         eBQ7udFASBf2anMqyQJJYRTOi7lKdktcnUwL2jrRxpmPMeq+iC8zXsWm18DW0z3287ZZ
         4e3Qvaw+WpYOYZ5V4As/0Clxq5EYE0ADKB8fcxTzUUenhmefNlMWkPMfBtlVeovTGLuk
         EWQcn87uG9Dm0/5kLzJc3zKogxuVgRNQ8mCciALhhT0nqhePF60DlU6Ayzh0Rt9pwrDh
         NTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mFDawymT8Zh+E+HOem14TYUCVAe8NsegNwIXcLtnH/8=;
        b=nIFfDNhkyudV0FZEwpUR8a/WBcPW7uTf3A9nNvlJ6g1KlHSKaLVDjp/BUXWR+g1CAC
         b4+IQn776b4S8qNMWPCX8by2tVIY114dsSJJnezI5LNjz+6EMYHQtjoj3BjwCwFCdnKe
         g6wqxPcpGDUyxBYPSqRuNMIJveAp9tSnXmdxOjHNtv154Pl7crha7wR/WFluXflBQ4bR
         YMScOb67EkixGZeUtj+OuU7iYYMEoB10Nwnh8PxreFkndBfass4h5pGSp4xquBn0PsxA
         3IWiYGmUY6KLXC6k+GzJTXF2aMJ+08TV3CxXFbnecZ9VQnHgEnpmlaDHiFyd4WV0lBlM
         D3cQ==
X-Gm-Message-State: AHQUAuYxWqBVMINANT35BR/FWl7hr9M53XXgaq0gzkQh2KtLFV9hka/L
        fBGfBmd9wGpUWlx2VozJH5u7Wg==
X-Google-Smtp-Source: AHgI3IbI/gzTIQORPKner8uMFyoO6LP7LhzVUUoaOAA5F4X4Rq3yTQfVTS2AgXHcjITlz8fbIPKOcw==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr2034048pgs.166.1550182094094;
        Thu, 14 Feb 2019 14:08:14 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id z62sm8443131pfi.4.2019.02.14.14.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:08:13 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4FF443008A8; Fri, 15 Feb 2019 01:08:10 +0300 (+03)
Date:   Fri, 15 Feb 2019 01:08:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214220810.cs2ecomtrqc6m2ap@kshutemo-mobl1>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214211757.GE12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214211757.GE12668@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:17:57PM -0800, Matthew Wilcox wrote:
> On Thu, Feb 14, 2019 at 04:30:04PM +0300, Kirill A. Shutemov wrote:
> >  - migrate_page_move_mapping() has to be converted too.
> 
> I think that's as simple as:
> 
> +++ b/mm/migrate.c
> @@ -465,7 +465,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
>  
>                 for (i = 1; i < HPAGE_PMD_NR; i++) {
>                         xas_next(&xas);
> -                       xas_store(&xas, newpage + i);
> +                       xas_store(&xas, newpage);
>                 }
>         }
>  
> 
> or do you see something else I missed?

Looks right to me.

BTW, maybe some add syntax sugar from XArray side?

Replace the loop and xas_store() before it with:

		xas_fill(&xas, newpage, 1UL << compound_order(newpage));

or something similar?

-- 
 Kirill A. Shutemov
