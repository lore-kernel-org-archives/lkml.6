Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42118C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2720865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVhhvnIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E2720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIJQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:35:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38028 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:35:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id t84-v6so8501078pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zNkUrEtrvi41oCBdIZnhvdu/DIOWRlppDQhasO50Pnw=;
        b=kVhhvnIOXVLu2vyjVeyHVo/Zt2rW1JmjtoGYwphiV1ecWXZD2Yiw4YTOtk68XZalov
         t541XFNtknF6Xp/mHROj1V6jMns2SjHOdTJ9aip3A/rC+LOGLrUTKDSrzJNuROwcLGJD
         a3X0Hg7tgFmp2oeW7UUGRpQtoPINU5R4rWEOp/8Cw7iGYka/ji6agG78oyp5UQQ1TFbo
         A6lfbo7uNOysZKe6ckeSCSeuPOSdnpoZpau1+KKB3f7kfekMjTNenOmPBri4m1QlS2p5
         R+KyKjzAQnN23jxpVkEhkRt6lI5UBQiW3OJL16tbnFmbUNcQpIiWqPYbwxz92t1l5g6s
         UxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zNkUrEtrvi41oCBdIZnhvdu/DIOWRlppDQhasO50Pnw=;
        b=r4jzaiT/pIjBz3UdorVbgOuHAyV8vW5l2Ba87ZGcFk3r+VNIEGO2p2OCeNBXwBPhZ7
         CXa8rh3GsTfJfbWG6qWOMmbDTVQOV4BeQZWYJuDTdi8ApBlsDBWzEooBSTD77vCG2zjF
         k4IVepAC0t5JvyYP4ZkvwiVwVhhtVMDSqeS7ckiAwXhaHnN4XhBY22BF5XmeQ99UBwxk
         +A/uEnBa7C3jvQaJXZsd5QerWCOb9BSMch/0y9yBDhCwJsaG3d4LmYrJNWdfew0JWbvM
         R++bJTDu/BfrBZlpK/4JC+nzs98KAqGiGG3eJM/Ib4rCV2yN6sCLHGuc1TQX6oHwX6Za
         uPSQ==
X-Gm-Message-State: APzg51A4rxIQfHQ1aKMVa+ExaBWNFt9F6OVKlDZVtkYCY1FiBfozgRBT
        CasycCZdBx3LfhwmQ0j6pY0=
X-Google-Smtp-Source: ANB0Vda//Nmdo/DSGm3ICPeKd9Xg+NxvHkcjrnJlLA3TgEDQU7ow5TGUOtyQiRvcBRmdgttXD76hDA==
X-Received: by 2002:a62:464f:: with SMTP id t76-v6mr23238580pfa.118.1536579718608;
        Mon, 10 Sep 2018 04:41:58 -0700 (PDT)
Received: from toy ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id g20-v6sm21294952pfo.94.2018.09.10.04.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 04:41:57 -0700 (PDT)
Date:   Mon, 10 Sep 2018 19:41:53 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
Message-ID: <20180910114153.GA10734@toy>
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
> This is a bit subtle: are you using the pgd fixmap entry because the path from
> map_mem() uses the other three?
> 
> Using the pgd fix slot for a pud looks a bit strange to me, but its arguably a
> side-effect of the folding.

Yes, it's a side-effect of the folding.

When the CONFIG_PGTABLE_LEVELS == 3, the pud is folded into the pgd. It
means that the pgd is never none and it is also a pud. That's why I use
the pgd fixmap entry.

Maybe write this more clearly:

static inline void set_pud(pud_t *pudp, pud_t pud)
{
#ifdef __PAGETABLE_PUD_FOLDED
	pgd_t *pgdp = (pgd_t *)pudp;

	if (...) {
		pgd_t *fixmap_pgdp;
		pud_t *fixmap_pudp;

		spin_lock(...);
		fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
		fixmap_pudp = pud_set_fixmap_offset(fixmap_pgdp, 0UL);
		...
	}

Do you have any way to make it look more reasonable?

> I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
> be during paging_init(). What do you think to keeping paging_init()s use of the
> pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
> during paging_init()?

I think the set_pud() should not be called on a 64K/42bit-VA. As only
the level 2 and level 3 page tables are in use. It means that the pmd is
folded into the pud and the pud is never none. So the set_pud() should
not be called.

I think a variable can be introduced to indicate whether paging_init()
has been completed. And decide whether or not to skip the
in_swapper_pgdir() base on the value of it.

I don't know if this is reasonable. What do you think?

Thanks,

Jun
