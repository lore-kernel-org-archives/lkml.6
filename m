Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47697C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199C12085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wIBf3yip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfBSRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:21:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42699 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:21:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id i5so35448530oto.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryAQx0eVnsFaBRoyj/Aqm9Xj5ZU4/2+jLsvZlamla6w=;
        b=wIBf3yipRO+l0XcyAv6d3K1DP9jpRwd+IldHS4k7GZRYS8Pa1ClJMyIJWisvmH3EmX
         ryQVJuatBrDmoMgULUP9zWW+hGrvqa4zcN3x4s3oDrgLYZTRkbz2ayi1CkodNnRaUg0+
         XxFvHwB2T9skWsHhdqOiC5gwQAJlAZYvtXxJ1WR3iqDvakQiVe8MQprDxDhxA3bQS1vD
         QqgJHb3FG9O1jXi8UB9PoUsxer32oEFHJrbT0uw8c3kNspfMPCJurQPmFuw9UGbR6J7n
         qd2tpX83P0kd/ihHcXMP/F2SD95DDFjyK1nJ4OLyoAQGrR3i7g+hv+pSiitn+lB6WJ75
         DOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryAQx0eVnsFaBRoyj/Aqm9Xj5ZU4/2+jLsvZlamla6w=;
        b=hRvXuzs+PQ/zxuRZ3sWMHK7TC31iaSJzVtdS0+ROO3WDKLr4y/88/DZz6F1UCJaaAm
         NZt3M4cNh6IeubvYZmMmZL5dh31cZVdloghssotJ/m144C6siFizj5YTHY9Feg57W56v
         YqRe+aXZa5VnqMRTt26p0EgxvAxLafkN6SUMU4D3G2msPtUQVxNfFTFCJ75HVVQ3EnKf
         nK7WvZ8g3uvsGBo9oR4QJPELYuu7jshXbCktWr756GaB7WjzfBBfjd3ukdsc7G7CLNdz
         lDaiAfXDoTvzBB5g/dj0q7LN0l2w7Dp1klFl7TLvYSyhfoARo/WTLSmHy4wkMoef2KL5
         GprQ==
X-Gm-Message-State: AHQUAuaV1kWjZO4OLj3JqiQrYUJBvuFhXlEjal4SlYvkaRGbK8sIO/YH
        lG8UVZBWIpgkVlTN6lxCYwUPLaWPoKnyPkszGL/2x+1G
X-Google-Smtp-Source: AHgI3IabMTTtMCANoEAm9u/yt6MTkzJywrPCaORBEHuWmy67T3mEXwDsosPfa9WaWm+ZdSUoQw88DALgXj+tnqoHQBQ=
X-Received: by 2002:a9d:37b7:: with SMTP id x52mr19722344otb.214.1550596876126;
 Tue, 19 Feb 2019 09:21:16 -0800 (PST)
MIME-Version: 1.0
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154899812264.3165233.5219320056406926223.stgit@dwillia2-desk3.amr.corp.intel.com>
 <4672701b-6775-6efd-0797-b6242591419e@suse.cz>
In-Reply-To: <4672701b-6775-6efd-0797-b6242591419e@suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Feb 2019 09:21:04 -0800
Message-ID: <CAPcyv4g5YwQFVjz+TLSwZZ7LE9h+JU==+KDrL37025dXMyXWoA@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] mm: Move buddy list manipulations into helpers
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 7:24 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/1/19 6:15 AM, Dan Williams wrote:
> > In preparation for runtime randomization of the zone lists, take all
> > (well, most of) the list_*() functions in the buddy allocator and put
> > them in helper functions. Provide a common control point for injecting
> > additional behavior when freeing pages.
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Here's another fixlet to fold into mm-move-buddy-list-manipulations-into-helpers.patch
> This time not critical.
>
> ----8<----
> From 05aaff61f62f86e646c4a2581fe2ff63ff66a199 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 19 Feb 2019 16:20:33 +0100
> Subject: [PATCH] mm: Move buddy list manipulations into helpers-fix2
>
> del_page_from_free_area() migratetype parameter is unused, remove it.

Looks good,

Acked-by: Dan Williams <dan.j.williams@intel.com>
