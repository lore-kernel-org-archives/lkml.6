Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE739C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B7A20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVpWcAaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B7A20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIMP7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:59:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46304 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:59:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so2564009pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2YLO81sB6elElavA6ZjRN/hgCZR8EwrO1WMxSY84tlg=;
        b=NVpWcAaflFk3AwIYy/C+SCILM4PgfkChF7V32uZEjNJv+kg4QkNYyFJVMgNdb4UpDL
         QZ9exLS/8cO4LS5T6Iw+Bx8Jt9Gr1zW3qOdFVPN6MHmWWD//wSGd/BV52R8XRTz6Llar
         sl45KlSvNMDsv0pDuU38tEVo3wpLAErNlaLcy8Llyn3+8Oc/QfAiR9IS+fKmxtbKA0dG
         XWmgE8fUXOUnBJ1S2lLbREc4FJKOeiy/pDsdH43ApLwHaPQR8kkuO2LRtOdDwUzqz61s
         wc4QM7ZAepJzYg+Wrb2huqDNkyYRIcR7zdWk0106epNjMR0c7yIVz6+YxSVZ8+y0gfv+
         2iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2YLO81sB6elElavA6ZjRN/hgCZR8EwrO1WMxSY84tlg=;
        b=CA7RebZABw0NrqtrdMp6sLnosI+NL0iVBCwOiG9Nh/6BoY8Ha6WDBE7ZuEvBrZpu0b
         KtaujL7gV4nz/IImwjjzdl7zZnr45YwdjNoDGOnSW+vNtY3V7HReDUwHzrHLg6KOtJxP
         dNiIh1SkvcR2qD+Mo99MZaXDTEYfX4eb9Kqx7RioCoF2nI2W6zCyg8TJ4IQ1wheYoXs7
         Z9J5zwBobOYILCBc1pO5Fz14juOro/wJurGcaAz1RGJVvx+ddga9JnjtAM2fe1LXbY8V
         V0K03/aIpibSBb76miUfl4QeKs5liq47kWpaLTKBQflRfqwGTEFmbQkLbDxe8mlgDjWm
         +0rA==
X-Gm-Message-State: APzg51COqX9F97rfsqTJRtox/xW832b5LXnjs83T9OMMxrlDtmJ6hOSh
        CvkVrLUVqMZYTc/6Is7rP3Q=
X-Google-Smtp-Source: ANB0VdYAvZO3gxH85SkkvqUnTxYue+4lKtRcVSZ9ruYg1f23UbjnipXT/BLicK0mAd18YL4XFGadFQ==
X-Received: by 2002:a63:2043:: with SMTP id r3-v6mr6580391pgm.105.1536835829857;
        Thu, 13 Sep 2018 03:50:29 -0700 (PDT)
Received: from toy ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id b73-v6sm6175441pfj.93.2018.09.13.03.50.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 03:50:29 -0700 (PDT)
Date:   Thu, 13 Sep 2018 18:50:21 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
Message-ID: <20180913105021.GA25870@toy>
Mail-Followup-To: James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-6-yaojun8558363@gmail.com>
 <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Sep 07, 2018 at 10:58:22AM +0100, James Morse wrote:
> On 22/08/18 10:54, Jun Yao wrote:
> >  	WRITE_ONCE(*pmdp, pmd);
> >  	dsb(ishst);
> >  }
> > @@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
> >  
> >  static inline void set_pud(pud_t *pudp, pud_t pud)
> >  {
> > +#ifdef __PAGETABLE_PUD_FOLDED
> > +	if (in_swapper_pgdir(pudp)) {
> > +		pud_t *fixmap_pudp;
> > +
> > +		spin_lock(&swapper_pgdir_lock);
> > +		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));
>
> I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
> be during paging_init(). What do you think to keeping paging_init()s use of the
> pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
> during paging_init()?

I find that the __create_pgd_mapping() is used to set up the page table
during paging_init(). And there are six functions calling it with
different pgdps:

update_mapping_prot()		init_mm.pgd(swapper_pg_dir)
create_mapping_noalloc()	init_mm.pgd(swapper_pg_dir)
__map_memblock()		pgdp(swapper_pg_dir)
map_kernel_segment()		pgdp(swapper_pg_dir)
create_pgd_mapping()		!(init_mm.pgd)
map_entry_trampoline()		tramp_pg_dir

In order to skip the in_swapper_pgdir() test during paging_init(), We
need a way to determine if we are currently in paging_init(). The way I
can think of is to create a function similar to __create_pgd_mapping().
And it is used to create the page table during paging_init(). It differs
from the __create_pgd_mapping() only in that it calls
p?d_populate_without_test(). However, in this way, I'm worried that I am
reinventing the wheel.

Thanks,

Jun
