Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAABC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DD220856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YrvP+7Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfA2T1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36855 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfA2T1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so18954476otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 11:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nET3Y86B4FJO24Nl8dIyjfW3/vMpVLUZO3awvOx1bRU=;
        b=YrvP+7Wjt5mXzM5Ec+lXaUbBrMsan8PhJMu8/n3REzC244dMWImh79DE8soYLdE4fQ
         f43O9bbsZJjT/n6sD9CX+wRNOEe1bKTsrdEtEXZ1FroaS8b4DRL2618aCty2+21vQHtW
         TxaOLH9ZYrzqkFyAN83jHBCUFUgl5nwrL59QXbmgJp53RUXvls16PUCyrIKeg167f+0z
         /bR9pDiz5Hld4i/UkLrl921V/lb8WiuxunO910uZcA8UTjJa9PgDhCHTc4CLwUqItk/5
         3wkp0Y3DghWKwWuTTwave2IMtXKqkNrAAr7spDEjOgFJKXuURlD4oI+7FWUf5AWNLvsD
         0zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nET3Y86B4FJO24Nl8dIyjfW3/vMpVLUZO3awvOx1bRU=;
        b=eFjiGtMqeA16PhEQe5CFGcezSnFRp56qD1mzSDi1G8Ska6aCgrNxX0UCoq9VNDmyW5
         ABm78NXw3fNafbTNuW1PtzrtQCEnQI9dW/Yjb3P0ctw1Ij/HK+e3OSY8LAzbsjeZQR1m
         Re9M5unE9DYmxm9h+vuQPR3VPR6sCAbfvS6XfNqOACXfJlxF6vCSAhv+LKfKilxC3sDF
         QuVHqgcLts0INHBfqvjmDhLAxHo74mpRWmVAqHCnmwN2OYiYfANGDSMzongjJWIBtoY1
         7QFmJxwENPAiqwA/s2G5kGMKZByF+2IoTqwxXet8JkccbzEd1WFUk7aks+pCjFPWumwt
         RRMA==
X-Gm-Message-State: AJcUukdgvJZIb8nohd58kXaOsFJi9Ukb4o01ka7Yme6ICdzFKK5VNHAE
        a6/JT1GPalfGz1y6fJwCg+Cd7yUsT4/81cOxZnhjlg==
X-Google-Smtp-Source: ALg8bN7SG3XMSqfla3KDK9bjtwYeb4iaklfQE03/7c+8/bunhAoLBZeuY7hkSaWpNWitfcRWCoa5pQe0fgpYoedjFNo=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr20680714oti.367.1548790037656;
 Tue, 29 Jan 2019 11:27:17 -0800 (PST)
MIME-Version: 1.0
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327612.676627.7469591833063917773.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190125143044.GO3560@dhcp22.suse.cz>
In-Reply-To: <20190125143044.GO3560@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 11:27:05 -0800
Message-ID: <CAPcyv4ga-SgWA1xVmYM2ZjT6ASfFYynP7YnJv5H9offEPYw+VA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] mm: Move buddy list manipulations into helpers
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 6:31 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 07-01-19 15:21:16, Dan Williams wrote:
> > In preparation for runtime randomization of the zone lists, take all
> > (well, most of) the list_*() functions in the buddy allocator and put
> > them in helper functions. Provide a common control point for injecting
> > additional behavior when freeing pages.
>
> Looks good in general and it actually makes the code more readable.
> One nit below
>
> [...]
> > +static inline void rmv_page_order(struct page *page)
> > +{
> > +     __ClearPageBuddy(page);
> > +     set_page_private(page, 0);
> > +}
> > +
>
> I guess we do not really need this helper and simply squash it to its
> only user.

Ok.

>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> --
> Michal Hocko
> SUSE Labs
