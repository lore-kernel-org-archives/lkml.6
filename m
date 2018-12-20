Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14E821909
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljt+A0id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeLTTp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:45:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35330 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389483AbeLTTpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so1734703qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKmYRYZ8i9OtQjopx4/zRiXjDlfBrbzkMJTi5+z4kig=;
        b=Ljt+A0idXUEnF5LAnsQXnAhP2HjkaChKUTxbo/ITBVf0Jccx9GjxWhOyo3Oax+61Mr
         gDkiiHqNDoWVakbxfq1VL6G8+xFb/bGUk/5rmfrK8hebHu9k25Sa7BJ4nASHnAnVsGv9
         jvIo/5a+WqNhYcdSIozXUg8h3w+Gx4M4iV5tb66MnVNGerWOE63a3NCELEElZqvsJpyz
         JdjLLiXgjxVsV3r2PwKro5VErhPpvsEZcceRkjH4/JiOrRMK4Yqn3EAl4ZtjAUa1J1Fd
         4LMgDchFZrhvWxro7Dx0XWvrrhrOr3u+1pYTIHuELQHdIelUUVD/Zq5exBEN5leeaxFE
         NFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKmYRYZ8i9OtQjopx4/zRiXjDlfBrbzkMJTi5+z4kig=;
        b=YC0/qo7tabNZDZ3io0ttFBGamn4WR7yDnpVYkVEvGGhuRgobkZ70B10AX9QiK/Wrh0
         ltFH8HbrSstklVe3y7oV2lwrK6jpElasyeUK1PDjrsYm+P+4ANz6/gFqHHNvHunVVEmW
         P+XDkWf/slCn5x77RSLb1i1/0hfHKcdPFRTa6AXEbrphTb+oxzPwTLWq1y11z6kPBXNj
         /YmKINHRxtik7KSypVAjXgNVxn1VMYW7kavEpa4laX1NLIAgJn3MSawfe30EGub5Tqbe
         gZw6pqs6ZQVUbGQfZiyVOGLKiKTh6ZTyt5KsKalTxhrB1MqKqW/ZeHNQXNO4AzXEVXau
         sSCg==
X-Gm-Message-State: AA+aEWaSpm0CGUvdBNQcYH1v1VsJzeqSVVSXQzfvyn74771fWbGmsSni
        rjPijQEX+rptgeo7BJ0yJM47W8GPkiKCUNjaDoE=
X-Google-Smtp-Source: AFSGD/VBds3C89sGV9++238eDor5qCfEClTVWWva7YtSZqasPDTwvaUnyPK8WL4gMlDVdArK7KM2kSzVi99e2b0vDcU=
X-Received: by 2002:a37:97c1:: with SMTP id z184mr25956590qkd.39.1545335109937;
 Thu, 20 Dec 2018 11:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20181214230310.572-1-mgorman@techsingularity.net> <20181214230310.572-7-mgorman@techsingularity.net>
In-Reply-To: <20181214230310.572-7-mgorman@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Dec 2018 11:44:57 -0800
Message-ID: <CAHbLzko6jXSikw-4LQXi6KfNR9=U4XJnB_OaaZ4XcNHUj4NLUQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] mm, migrate: Immediately fail migration of a page
 with no migration handler
To:     mgorman@techsingularity.net
Cc:     Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        torvalds@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 3:03 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Pages with no migration handler use a fallback hander which sometimes
> works and sometimes persistently fails such as blockdev pages. Migration

A minor correction. The above statement sounds not accurate anymore
since Jan Kara had patch series (blkdev: avoid migration stalls for
blkdev pages) have blockdev use its own migration handler.

Thanks,
Yang

> will retry a number of times on these persistent pages which is wasteful
> during compaction. This patch will fail migration immediately unless the
> caller is in MIGRATE_SYNC mode which indicates the caller is willing to
> wait while being persistent.
>
> This is not expected to help THP allocation success rates but it does
> reduce latencies slightly.
>
> 1-socket thpfioscale
>                                     4.20.0-rc6             4.20.0-rc6
>                                noreserved-v1r4          failfast-v1r4
> Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> Amean     fault-both-3      2276.15 (   0.00%)     3867.54 * -69.92%*
> Amean     fault-both-5      4992.20 (   0.00%)     5313.20 (  -6.43%)
> Amean     fault-both-7      7373.30 (   0.00%)     7039.11 (   4.53%)
> Amean     fault-both-12    11911.52 (   0.00%)    11328.29 (   4.90%)
> Amean     fault-both-18    17209.42 (   0.00%)    16455.34 (   4.38%)
> Amean     fault-both-24    20943.71 (   0.00%)    20448.94 (   2.36%)
> Amean     fault-both-30    22703.00 (   0.00%)    21655.07 (   4.62%)
> Amean     fault-both-32    22461.41 (   0.00%)    21415.35 (   4.66%)
>
> The 2-socket results are not materially different. Scan rates are
> similar as expected.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df17a710e2c7..0e27a10429e2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -885,7 +885,7 @@ static int fallback_migrate_page(struct address_space *mapping,
>          */
>         if (page_has_private(page) &&
>             !try_to_release_page(page, GFP_KERNEL))
> -               return -EAGAIN;
> +               return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
>
>         return migrate_page(mapping, newpage, page, mode);
>  }
> --
> 2.16.4
>
