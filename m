Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23109C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77C821B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="n3IgNoNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438377AbfBNWaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:30:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41969 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393758AbfBNWaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:30:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3803834pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57+CqfjmpoWyrfnhc239KRVxSUTm0mnX+kNtxVFNyHU=;
        b=n3IgNoNhVGLIE3Ae/mpYA4gol7LB3wSkbVVitAx2d3rr7+bF978g8xq6VnOX9BsjI4
         42OYeKn8o5QmBa5CcZ6pcwDG6enJI1UzPxnAHOdoQOQpwNy7pUegMSkBJayJnopg0utu
         P2u8emb7/ZW4pXifLX5S82CQHiTTMx3O+7+Di/nWUYMZ1rw24Hhz62VW5UXO2lh89FAB
         iagznw08a9Y1Qy8CZqhng9C5D85SjKsoAXUr9wnjV757vayqLBR65r0g60QRwb405EUM
         V1fUQwLUyPeUfq/lWrDeY/e6xQBnW7efSospsZ8KrivdOmhZVYOZNCUOMM+GIjF46Q/h
         9MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57+CqfjmpoWyrfnhc239KRVxSUTm0mnX+kNtxVFNyHU=;
        b=UVfepdfmG5EsuHeXgLvEOccOExjmndJqpyLamsvkITtmasVlbVetkp0Gyj57XzmLYi
         g7qtJZ+080CxvgKI5b3ytngfLp4M2fPodETrp1UVEt/ZQp0JQO1zAe2/iCGwfsWlDpa6
         TQNRCAYo+G4nhy55oFFgZPYSoSs/WoJ5fDF07OAX6xlGSmk0cml09HvmmybjhCV6Ggly
         gLoRUQqaCFAThcf0EgWjtwxBUB/PvdCOvLrsd7l8Ek0Uom0YO/MUgGzUNVf756CaO4go
         exSjneVYi9vXWOHaHujq7+Ecg6B8d7Acj7go18cI7obiY6AeeacqYl4evceHHJbet3Ih
         6VJw==
X-Gm-Message-State: AHQUAubj7EigG3UGgNOiCeo8pv1MK/qCmmhDVfOGgc770sutcKAKDZqk
        Xo5beXTg96Yu3TLPdy6IeWqRkQ==
X-Google-Smtp-Source: AHgI3IZEeU5VJRySDFSpv/e0+oTrxhNeqc1ub76DDcsblsNUiIpAZ8q5PMfzWUfYshuVR6xz7jOSZw==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr6407766pfm.63.1550183401435;
        Thu, 14 Feb 2019 14:30:01 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id a13sm3815595pgq.65.2019.02.14.14.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 14:30:00 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id BDDB13008A8; Fri, 15 Feb 2019 01:29:57 +0300 (+03)
Date:   Fri, 15 Feb 2019 01:29:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214222957.a5o7zkc6p7zlqy3m@kshutemo-mobl1>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
 <20190214211757.GE12668@bombadil.infradead.org>
 <20190214220810.cs2ecomtrqc6m2ap@kshutemo-mobl1>
 <20190214221158.GF12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214221158.GF12668@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:11:58PM -0800, Matthew Wilcox wrote:
> On Fri, Feb 15, 2019 at 01:08:10AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Feb 14, 2019 at 01:17:57PM -0800, Matthew Wilcox wrote:
> > > On Thu, Feb 14, 2019 at 04:30:04PM +0300, Kirill A. Shutemov wrote:
> > > >  - migrate_page_move_mapping() has to be converted too.
> > > 
> > > I think that's as simple as:
> > > 
> > > +++ b/mm/migrate.c
> > > @@ -465,7 +465,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
> > >  
> > >                 for (i = 1; i < HPAGE_PMD_NR; i++) {
> > >                         xas_next(&xas);
> > > -                       xas_store(&xas, newpage + i);
> > > +                       xas_store(&xas, newpage);
> > >                 }
> > >         }
> > >  
> > > 
> > > or do you see something else I missed?
> > 
> > Looks right to me.
> > 
> > BTW, maybe some add syntax sugar from XArray side?
> > 
> > Replace the loop and xas_store() before it with:
> > 
> > 		xas_fill(&xas, newpage, 1UL << compound_order(newpage));
> > 
> > or something similar?
> 
> If we were keeping this code longterm, then yes, something like that
> would be great.  I'm hoping this code is a mere stepping stone towards
> using multi-slot entries for the page cache.

Fair enough.

-- 
 Kirill A. Shutemov
