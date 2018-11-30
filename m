Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85182C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E6E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="XYU41ssU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E6E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeK3V2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:28:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34175 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3V2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:28:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so2596674plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 02:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+YWiKKUgLodwOXkLIOrsJw0vbFaB8rOlRN4as8zZsNo=;
        b=XYU41ssUMqcMo4z5OxV7SXLEWoZtNaViopfCbGICP72b6GxkWYQrxISt5+wfJlOuM3
         eZxQuP4ft7fXRfoFkaeT6s9dfymCVufWXDMVfksO57rKnZB/eHm5x9Eu89FYJqwC6Npf
         vvdcc2oArr4gC9Ra40x14t4ZMftxzZiLwV8i4G2zdbKxcYYdDL94f0NB87x3/MoUq7RH
         j4txyG8NrxqI4AfgIvQ2jaZVGmc5Y/cNBMgOnyqeoEeLNb8qIIVkc4P3vQWmfBqJjh+g
         JUlBSh6fx+0qCPZHI71HlzbEq+RoD6chmnuBdkoAImscZsggxtg6Y4oEu70N5/CW+4u2
         8tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+YWiKKUgLodwOXkLIOrsJw0vbFaB8rOlRN4as8zZsNo=;
        b=j1VQ4jrPzKQVtZnGWGHK8om9y1kZiM5Jppng5b9+HpXKGiTk4HgBOlmZQfPllozYNx
         b009WuZIc+/4quE6Qh4WzY8JQGegV7jX95DRnCUdGwp1UUDHNZlABt5Qq3AZathtH5vs
         mhB38RmF/Mi7T/iuzOCJ41MUf2y/4Gbw7TMF1HP9aB6f2tPIcpdNlIuZ5AYDxzmOImNH
         Hr/e/qBGCnJ4FgI/cWzDPRd3rJMmoldDRSuRQLpD2dKdPJNms4tq7wzsOv6dFaruPU8r
         ut3UyjeUpOPqSjbVTnY1uRjQK73WUd7BCjLGvEotr/+g0SRhwvZEA1FH/606oPtmiQYC
         22qg==
X-Gm-Message-State: AA+aEWaTJbeNlaKBi2/U30hOGd7ivfukgkYUO4qKUvI4Fiv+S5gdY4He
        T6aKkKudr7D6F6BZ75dQU0K7aQ==
X-Google-Smtp-Source: AFSGD/U4Ybf7UP3rv+snaICV1180DlgzIsnam5/CcIQ0PuWHTOmSuVnMDiIKX6D0MKe4MRXTPizVNg==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr5193544plb.103.1543573198720;
        Fri, 30 Nov 2018 02:19:58 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id k14sm11277530pgs.52.2018.11.30.02.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 02:19:57 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8A83D30042C; Fri, 30 Nov 2018 13:19:53 +0300 (+03)
Date:   Fri, 30 Nov 2018 13:19:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, lersek@redhat.com, alex.williamson@redhat.com,
        aarcange@redhat.com, rientjes@google.com,
        mgorman@techsingularity.net, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_mapped: don't assume compound page is huge or
 THP
Message-ID: <20181130101953.u4owfaqmaq2osuod@kshutemo-mobl1>
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:53:48PM +0100, Jan Stancek wrote:
> LTP proc01 testcase has been observed to rarely trigger crashes
> on arm64:
>     page_mapped+0x78/0xb4
>     stable_page_flags+0x27c/0x338
>     kpageflags_read+0xfc/0x164
>     proc_reg_read+0x7c/0xb8
>     __vfs_read+0x58/0x178
>     vfs_read+0x90/0x14c
>     SyS_read+0x60/0xc0
> 
> Issue is that page_mapped() assumes that if compound page is not
> huge, then it must be THP. But if this is 'normal' compound page
> (COMPOUND_PAGE_DTOR), then following loop can keep running until
> it tries to read from memory that isn't mapped and triggers a panic:
>         for (i = 0; i < hpage_nr_pages(page); i++) {
>                 if (atomic_read(&page[i]._mapcount) >= 0)
>                         return true;
> 	}
> 
> I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
> with a custom kernel module [1] which:
> - allocates compound page (PAGEC) of order 1
> - allocates 2 normal pages (COPY), which are initialized to 0xff
>   (to satisfy _mapcount >= 0)
> - 2 PAGEC page structs are copied to address of first COPY page
> - second page of COPY is marked as not present
> - call to page_mapped(COPY) now triggers fault on access to 2nd COPY
>   page at offset 0x30 (_mapcount)
> 
> [1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c
> 
> This patch modifies page_mapped() to check for 'normal'
> compound pages (COMPOUND_PAGE_DTOR).
> 
> Debugged-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/linux/mm.h | 9 +++++++++
>  mm/util.c          | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5411de93a363..18b0bb953f92 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -700,6 +700,15 @@ static inline compound_page_dtor *get_compound_page_dtor(struct page *page)
>  	return compound_page_dtors[page[1].compound_dtor];
>  }
>  
> +static inline int PageNormalCompound(struct page *page)
> +{
> +	if (!PageCompound(page))
> +		return 0;
> +
> +	page = compound_head(page);
> +	return page[1].compound_dtor == COMPOUND_PAGE_DTOR;
> +}
> +
>  static inline unsigned int compound_order(struct page *page)
>  {
>  	if (!PageHead(page))
> diff --git a/mm/util.c b/mm/util.c
> index 8bf08b5b5760..06c1640cb7b3 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -478,6 +478,8 @@ bool page_mapped(struct page *page)
>  		return true;
>  	if (PageHuge(page))
>  		return false;
> +	if (PageNormalCompound(page))
> +		return false;
>  	for (i = 0; i < hpage_nr_pages(page); i++) {
>  		if (atomic_read(&page[i]._mapcount) >= 0)
>  			return true;

Thanks for catching this.

But I think the right fix would be to change the loop condition:

	for (i = 0; i < (1 << compund_order(page)); i++) {

Non-THP compound page also can be mapped and we need to check mapcount of
subpages.

Any objections?

If not, please update the patch.

-- 
 Kirill A. Shutemov
