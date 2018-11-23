Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E65C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EE820866
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nuvpEFvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EE820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410201AbeKXEWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:22:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34749 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410185AbeKXEWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:22:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3643805pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t41GPIkn4+S1hWPAEEdEHpy0LppqEuAurUKrzMOJk8c=;
        b=nuvpEFvMRVlmTRa/zjoqy69p8LW09GA/l90bsDoOA/L+BzRqv2DvTpiObaT8udTKBX
         GJnf9LTijZQkVAtmRIupMW/a9hKdezRxgHfzxhxiaZvEKC8eUMXiA1H11pqDVgyLKMRd
         fTcHw7RwT21rp64UnhxGtcw0RuMcTu5YCwMaG9KmhPxrj8M9viSPNhLQ3d+fHO+/vTK4
         d17Wg6I+gGt57kDGt7B/XPDF1om+e5z0kh/4E8vQUL9G+saHt1Q6tjzXaQX5igm+CHf2
         omvuB5YPfsbnl6T33R99bOnRQOWdNINhbZ6milyiyj3oQbtQh30htMX6E2CKhPukjqaT
         BQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t41GPIkn4+S1hWPAEEdEHpy0LppqEuAurUKrzMOJk8c=;
        b=S1QdzL/QZ89yB1g6CFLMoO0x5VjJSUTxifJbcA4VIJmu4zQstc4ZTjs/Wl+XSZOZAB
         eVMkUY53W8qmXe9VrKO6nGS1DGNiZr22MMn2qxDgKNpc2mw2dZvmwfbOmIuXREJP08Mk
         jw6S4NLNxYDXvorUMLHYiXbBBduXCWgKu/6epinGgTkit84PvCWQhcNTkv7dMs3cUCK4
         NLY1vgMHKBL+CzOp0MAkQNIPatwAop3YrGNW/Lil/pFhG4JaZeKOk4WTinfNICRKm+fK
         Hq1p1qInO0/a7imW2JpP1rlMVj59NkJuHHYBPnPmvWN4DsLwPqa4tskM1TmfgeE/BxhT
         QOBw==
X-Gm-Message-State: AGRZ1gLHlD8PufbF8zEa2+R+idqhQZNbobYa4jmBpzHqnyKPgR6B5my4
        s2LybEF+4bzRrsRPrhxviQcU5w==
X-Google-Smtp-Source: AJdET5c+XYRdWaUZ0A/N0UFhKB8RIp6w8+ohFYu38nrz7ArT9hcuARReiD9ycYgV/8VEFmer8hyFUQ==
X-Received: by 2002:a62:5bc7:: with SMTP id p190-v6mr16904147pfb.175.1542994615699;
        Fri, 23 Nov 2018 09:36:55 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id f22-v6sm57519439pfn.177.2018.11.23.09.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 09:36:54 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 4574D30033D; Fri, 23 Nov 2018 20:36:51 +0300 (+03)
Date:   Fri, 23 Nov 2018 20:36:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 2/2] page cache: Store only head pages in i_pages
Message-ID: <20181123173650.eteuc44bppvxwbcd@kshutemo-mobl1>
References: <20181122213224.12793-1-willy@infradead.org>
 <20181122213224.12793-3-willy@infradead.org>
 <20181123105643.fxqk7l57rdurdubx@kshutemo-mobl1>
 <20181123171900.GU3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123171900.GU3065@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:19:00AM -0800, Matthew Wilcox wrote:
> On Fri, Nov 23, 2018 at 01:56:44PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Nov 22, 2018 at 01:32:24PM -0800, Matthew Wilcox wrote:
> > > Transparent Huge Pages are currently stored in i_pages as pointers to
> > > consecutive subpages.  This patch changes that to storing consecutive
> > > pointers to the head page in preparation for storing huge pages more
> > > efficiently in i_pages.
> > 
> > I probably miss something, I don't see how it wouldn't break
> > split_huge_page().
> > 
> > I don't see what would replace head pages in i_pages with
> > formerly-tail-pages?
> 
> You're quite right.  Where's your test-suite?  ;-)

Yeah-yeah...

> I think this should do the job:
> 
> +++ b/mm/huge_memory.c
> @@ -2464,6 +2464,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>                         if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
>                                 shmem_uncharge(head->mapping->host, 1);
>                         put_page(head + i);
> +               } else if (!PageAnon(page)) {
> +                       __xa_store(&head->mapping->i_pages, head[i].index,
> +                                       head + i, 0);
>                 }
>         }

Looks good to me. But I still need to look into the rest of the patch.

> Having looked at this area, I think there was actually a bug in the patch
> you wrote that I'm cribbing from.  You inserted the tail pages before
> calling __split_huge_page_tail(), so a racing lookup would have found
> a tail page before it got transformed into a non-tail page.

I don't think so.

The page still has refcount==0 and any lookup of the page suppose to fail
due to !page_cache_get_speculative() or block on tree lock.

-- 
 Kirill A. Shutemov
