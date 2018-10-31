Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4220685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ZYLvtmBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D4220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJaSAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:00:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeJaSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:00:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id u13-v6so1675340pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UwWI8TupGd+sGyzp7jG/5TYvyiQ9DAMVDOEWShq0zpQ=;
        b=ZYLvtmBFpbL4kozvj01DbJuwdXfpgPlf5H/6SYP4tAmeQ8UDnfNelTJFA4oN9/Ng80
         8krAC/ebxaWBLhoUqr3RdgGtq+VE2dph3S1ZNDdhdfCLjw8RDD2CdaUlP8B3QigxOtFI
         /3DraJBDonqZqIgaEFflePB5D/1f4t8c6mnSaiYUmtfudKBQYWJY6Upv9p7U24JfFXnw
         pgk2ZJ05ogkMQ+ySzgC7zpBfyYoUb2WRW5MXF0XGaXNNE67nYz40My/5xwADCTVCKAzz
         /PGe3h5fSb/MtsbXMMyM2z7BH84d1jWlS/f7At4sxCA2mN5iuVkNKgnx8169VNYW/X8X
         WRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwWI8TupGd+sGyzp7jG/5TYvyiQ9DAMVDOEWShq0zpQ=;
        b=DlgwBknsIruW1TGUlHyCl16XNTnjVEMxicSpXGNyC3Lv6khZA4ewpXZAnpqeXyjCFF
         M/YEjDjbWcgkI0yJP+RLoi6SY6U7I1Z2nPQIP+xiDbBSG58+lTBw87pLc7PrDySKcPDA
         a4qtqbQQA5ykjBOKJ3SuKvJohi12kG/ZypGjwoKcxnw3Po1bI37YKIkSn/C8zEWk7Y0E
         kzYwJs8AG9raS6dfDsKLn7bj7WFQFminZ6lRy+0WUyjJOQ43QCsVgYI+1Sq5p1X6bO22
         gecXI4xt7PDOyZ67LBLFp30wchHYFbRaom/yjUHlMScYauA8eyT4vY8JQuduYWtsCphm
         ugIQ==
X-Gm-Message-State: AGRZ1gLxpj0mTD/YltR11XCf9GnvrpVqHQwRw+3WsFBQx3sk+WTa+SpM
        YIDkvUiRbng4weJzJ7KHZhQJ4g==
X-Google-Smtp-Source: AJdET5fPasKYijSaOXqazHFMMITRbrWspCvoKg571P4WUj5LmHy/SzDksXblVon6/KfuB0pVZPdg7w==
X-Received: by 2002:a63:e40e:: with SMTP id a14-v6mr2343330pgi.28.1540976581739;
        Wed, 31 Oct 2018 02:03:01 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id x23-v6sm27763825pfh.56.2018.10.31.02.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 02:03:00 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id EC89A301604; Wed, 31 Oct 2018 12:02:55 +0300 (+03)
Date:   Wed, 31 Oct 2018 12:02:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm: introduce mm_[p4d|pud|pmd]_folded
Message-ID: <20181031090255.bvmp3jnsdaunhzn7@kshutemo-mobl1>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-2-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539621759-5967-2-git-send-email-schwidefsky@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:42:37PM +0200, Martin Schwidefsky wrote:
> Add three architecture overrideable function to test if the
> p4d, pud, or pmd layer of a page table is folded or not.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  include/linux/mm.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0416a7204be3..d1029972541c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

Shouldn't it be somewhere in asm-generic/pgtable*?

> @@ -105,6 +105,46 @@ extern int mmap_rnd_compat_bits __read_mostly;
>  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
>  #endif
>  
> +/*
> + * On some architectures it depends on the mm if the p4d/pud or pmd
> + * layer of the page table hierarchy is folded or not.
> + */
> +#ifndef mm_p4d_folded
> +#define mm_p4d_folded(mm) mm_p4d_folded(mm)

Do we need to define it in generic header?

> +static inline bool mm_p4d_folded(struct mm_struct *mm)
> +{
> +#ifdef __PAGETABLE_P4D_FOLDED
> +	return 1;
> +#else
> +	return 0;
> +#endif

Maybe
	return __is_defined(__PAGETABLE_P4D_FOLDED);

?

-- 
 Kirill A. Shutemov
