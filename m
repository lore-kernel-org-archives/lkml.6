Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D53C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2B62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1NOY6CIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2B62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK3XqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:46:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46185 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeK3XqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:46:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so2741249ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bn6/IATCmOhq9fc4Rfya2kL0WShY44A8AzXjW5u1lzw=;
        b=1NOY6CISY+DfXXbFDwGsSFN1Dhli6DfOJTQT7vUWkH+p+tu0rLKlTH50cdzalwX5zg
         Y7kdCcqvB+gb2l4w6AvbUCgHQSD+2610PDhQvROzZlY1bfNBu7+cZOEtx3LupPCs6Jtd
         Dj1zde+ot0ZKHM6SoQS+fi33wFASatlazT0Aup1wONRHeNFqkP4WK/D1RTqvLKc47l4x
         TACFBzR7slDfMLz4Oi5KtAjatYDHamociQDjbrwPPrJdmklWj/R63BZiILh6rl1WAT0O
         ZjEXNBDTK+a97ysKLn211nLiAlEJnQQm6BJXCf59N2V21PG4EYjqLBW7e6i3QmRg58+0
         Gn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bn6/IATCmOhq9fc4Rfya2kL0WShY44A8AzXjW5u1lzw=;
        b=s+PKBCj8ZUPc3MiNWhUeuBeXquxI4i0wftCN8sa8l3nqll5XNNxzE0wUR3nf/Nc17L
         N2xMHjS4b1WZWZoUIjwyqhQc2uV6yw+aBlaAowYM/FMLhEsqTQUfNmDDXavNCSWk0Xou
         88AhfGKmEBuuKA8OS9a/Z9WLAnaeVQ3A9sl6wRkjpHhw3kW3w8K7hag28X5XwIuNxY+B
         tn3dSUNp2qs8/E7yV7PB9JWzM1eTDpFH7Gnb1P7kMF/G9WIQ5JhYgtqTEyaKjegm2zj0
         7fIN6VsMiGBinCDY+gsXvBwEnXnOwxhY/FhsApu7qesQB3nOxVoQAGkbIH/xHZ6kkVqy
         ACzA==
X-Gm-Message-State: AA+aEWaOVS/l6VHZRY0HWtr2deqMeasKWjP84Vft/tipEInQChZk/p47
        IbkAKlRi1z68PFy1eXSl66gr8Q==
X-Google-Smtp-Source: AFSGD/XVoM4YnjMdM9orOGWjSrAryX7sgpoRgtsaOoORMJQCcMAha8CzE9u4/nTjXhulC2r0e6P6Rg==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr5558852plb.321.1543581416398;
        Fri, 30 Nov 2018 04:36:56 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id a10sm6680026pfi.138.2018.11.30.04.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 04:36:55 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 6DDEF30042C; Fri, 30 Nov 2018 15:36:51 +0300 (+03)
Date:   Fri, 30 Nov 2018 15:36:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-mm@kvack.org,
        lersek@redhat.com, alex.williamson@redhat.com, aarcange@redhat.com,
        rientjes@google.com, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge
 or THP
Message-ID: <20181130123651.5qrdrw3i5ergbuzl@kshutemo-mobl1>
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
 <20181130121851.GI6923@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130121851.GI6923@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 01:18:51PM +0100, Michal Hocko wrote:
> On Fri 30-11-18 13:06:57, Jan Stancek wrote:
> > LTP proc01 testcase has been observed to rarely trigger crashes
> > on arm64:
> >     page_mapped+0x78/0xb4
> >     stable_page_flags+0x27c/0x338
> >     kpageflags_read+0xfc/0x164
> >     proc_reg_read+0x7c/0xb8
> >     __vfs_read+0x58/0x178
> >     vfs_read+0x90/0x14c
> >     SyS_read+0x60/0xc0
> > 
> > Issue is that page_mapped() assumes that if compound page is not
> > huge, then it must be THP. But if this is 'normal' compound page
> > (COMPOUND_PAGE_DTOR), then following loop can keep running
> > (for HPAGE_PMD_NR iterations) until it tries to read from memory
> > that isn't mapped and triggers a panic:
> >         for (i = 0; i < hpage_nr_pages(page); i++) {
> >                 if (atomic_read(&page[i]._mapcount) >= 0)
> >                         return true;
> > 	}
> > 
> > I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
> > with a custom kernel module [1] which:
> > - allocates compound page (PAGEC) of order 1
> > - allocates 2 normal pages (COPY), which are initialized to 0xff
> >   (to satisfy _mapcount >= 0)
> > - 2 PAGEC page structs are copied to address of first COPY page
> > - second page of COPY is marked as not present
> > - call to page_mapped(COPY) now triggers fault on access to 2nd
> >   COPY page at offset 0x30 (_mapcount)
> > 
> > [1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c
> > 
> > Fix the loop to iterate for "1 << compound_order" pages.
> 
> This is much less magic than the previous version. It is still not clear
> to me how is mapping higher order pages to page tables other than THP
> though. So a more detailed information about the source would bre really
> welcome. Once we know that we can add a Fixes tag and also mark the
> patch for stable because that sounds like a stable material.

IIRC, sound subsystem can producuce custom mapped compound pages.

The bug dates back to e1534ae95004.

> > Debugged-by: Laszlo Ersek <lersek@redhat.com>
> > Suggested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> The patch looks sensible to me
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
