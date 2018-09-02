Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BD9C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716FC20835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf6Caumx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716FC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeIBLNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:13:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33456 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeIBLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:13:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id b92-v6so2213359plb.0;
        Sat, 01 Sep 2018 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BfDrHFhMMGp4YbOjXL4+FJ5Lbow2qPk9kolnnl3aPx8=;
        b=Zf6Caumxx4BidYsuyoYi5jfwQ9B2yyf3LRfwMeiSTOyf4tVrgmiTBObPcI/O6BlDwP
         0Q+BxGXIE7wTjGJMA8aJ/4FCIHLxTedCleflcPOwx3gLOCVuPHntUNFOTOeh54jDts2q
         PIyfLi8ld+cqgB6LPyBlDd6MNAqsJ07Z12tgs61kw1Tiru3ZHeLuGreSs5fCTwLKvDbX
         EJta4kvaE1tCaVKjNmEg529YIUt71xYd8PUyhep6E3D+OTxPU2GLPIjzrWs4AzaKq2t5
         uaC8lu7Mv8ipRuGzbg4iCaqKUzRMSn1fHeguie9l3IHPSQqxA+3fk94ZihLoWauZI9A0
         t7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BfDrHFhMMGp4YbOjXL4+FJ5Lbow2qPk9kolnnl3aPx8=;
        b=cTis0Ajx7aeFOgtya/s9MjHwvOPZr4djWWKBrs/kp8qnOyF29f5zc8T0Yyo0X1QYhG
         H/8rm3FBg/SSR+idNy7r5MNmuVeueJB1VfGhOZZTSpKdEbGJCvPlfj06DO0UuxsOo6UF
         P2/xJnOdfUYp/7fcdcPojF53idYa3qgTGPlDe1LclN8m7pAj6MotHKySVpd0woOQmO5Y
         MHW5EUIvJtpTvg/ZY7vGUzlahN8yqAWckHdDTePR5Vq5sLucRZjHl7DeV1CiQkBrl4+N
         /TBFgdFsDs7Rvq08KjX/Y/luMZr306uGAAUGPuzE62/YLWVxUXcap+qHNHy9Sni5IoWd
         C5HQ==
X-Gm-Message-State: APzg51Cn7NzOpfZNFDbFVAaCLDGrqBxBn4ZT9+7FrTl941OE6WnqJzSF
        b7CuelJvwcYqz6rxL0QSyjk=
X-Google-Smtp-Source: ANB0VdbwZTyKsJj3QOo8IgqFWlGvoOHv58c8we4xV3yiIEwT/15dExm+445Lh8OGeTa1kDEho/hDzQ==
X-Received: by 2002:a17:902:246a:: with SMTP id m39-v6mr22531386plg.57.1535871543808;
        Sat, 01 Sep 2018 23:59:03 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id d81-v6sm19890941pfj.122.2018.09.01.23.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 23:59:03 -0700 (PDT)
Date:   Sun, 2 Sep 2018 16:58:59 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/rmap: map_pte() was not handling private
 ZONE_DEVICE page properly v2
Message-ID: <20180902065859.GE28695@350D>
References: <20180824192549.30844-3-jglisse@redhat.com>
 <20180830144156.7226-1-jglisse@redhat.com>
 <20180831092724.GD28695@350D>
 <20180831161935.GB4111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831161935.GB4111@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:19:35PM -0400, Jerome Glisse wrote:
> On Fri, Aug 31, 2018 at 07:27:24PM +1000, Balbir Singh wrote:
> > On Thu, Aug 30, 2018 at 10:41:56AM -0400, jglisse@redhat.com wrote:
> > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > Private ZONE_DEVICE pages use a special pte entry and thus are not
> > > present. Properly handle this case in map_pte(), it is already handled
> > > in check_pte(), the map_pte() part was lost in some rebase most probably.
> > > 
> > > Without this patch the slow migration path can not migrate back private
> > > ZONE_DEVICE memory to regular memory. This was found after stress
> > > testing migration back to system memory. This ultimatly can lead the
> > > CPU to an infinite page fault loop on the special swap entry.
> > > 
> > > Changes since v1:
> > >     - properly lock pte directory in map_pte()
> > > 
> > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  mm/page_vma_mapped.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index ae3c2a35d61b..bd67e23dce33 100644
> > > --- a/mm/page_vma_mapped.c
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -21,7 +21,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
> > >  			if (!is_swap_pte(*pvmw->pte))
> > >  				return false;
> > >  		} else {
> > > -			if (!pte_present(*pvmw->pte))
> > > +			if (is_swap_pte(*pvmw->pte)) {
> > > +				swp_entry_t entry;
> > > +
> > > +				/* Handle un-addressable ZONE_DEVICE memory */
> > > +				entry = pte_to_swp_entry(*pvmw->pte);
> > > +				if (!is_device_private_entry(entry))
> > > +					return false;
> > 
> > OK, so we skip this pte from unmap since it's already unmapped? This prevents
> > try_to_unmap from unmapping it and it gets restored with MIGRATE_PFN_MIGRATE
> > flag cleared?
> > 
> > Sounds like the right thing, if I understand it correctly
> 
> Well not exactly we do not skip it, we replace it with a migration

I think I missed the !is_device_private_entry and missed the ! part,
so that seems reasonable

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
