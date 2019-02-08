Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091EAC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59652147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfBHFxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:53:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45557 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBHFxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:53:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so2661766qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 21:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdWg7t5clHHyjIuZwgAgH0hXxK3yfesua4rUUk5hG74=;
        b=BVxoXfJIubwm+PjhONwg+3V1e/Au3B6Tcdi7YpoQCdaadSsE1Z5N4ow/Ziunnt2PQx
         bmKG0aQsozZBUom5o0btu6ZWlLI5WaMWtZjTzH5sJamJojfRJzNqf26xKnC199pU7eaU
         XQm5rh8/85L6YY8wWIMSGeEMnrOPSQXbxzAeXHcAVKzjLJPg2fsnxnq+m2r8wZp832Mb
         YqN8MlPHCgnvtTC2e8JeL3awdQvW1jHK69IKVhxhLlG5seMw/O3GyUjFlkve7qzAUAOL
         k1WLqLgr+apNdCUHjStCpd5zORT6JyiN1AlRacUoqf0t31nCJZVSx63NmwzorbxGcOzT
         yTRQ==
X-Gm-Message-State: AHQUAuaNoxiKxcgR1g51VVkz65vceuLpnHZ5ts2AXET65CJVCuFrPsJ9
        FSkP3gXkYNMBpJVru03+cYRrlg==
X-Google-Smtp-Source: AHgI3IahxvXlLwD30LNYnLLsJZTMzXcLcC4ZzfWlXsqAs+Vev+Ouo3OcuJfBjOvIELXmXQHzoy0fzQ==
X-Received: by 2002:ac8:300a:: with SMTP id f10mr4736014qte.236.1549605183121;
        Thu, 07 Feb 2019 21:53:03 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id p63sm882677qkd.52.2019.02.07.21.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 21:53:02 -0800 (PST)
Date:   Fri, 8 Feb 2019 00:53:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/page_poison: update comment after code moved
Message-ID: <20190208005242-mutt-send-email-mst@kernel.org>
References: <20190207191113.14039-1-mst@redhat.com>
 <20190207210141.f0c0b08841f53ba4ee668440@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207210141.f0c0b08841f53ba4ee668440@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:01:41PM -0800, Andrew Morton wrote:
> On Thu, 7 Feb 2019 14:11:16 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > mm/debug-pagealloc.c is no more, so of course header now needs to be
> > updated. This seems like something checkpatch should be
> > able to catch - worth looking into?
> > 
> > Cc: trivial@kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: akpm@linux-foundation.org
> > Fixes: 8823b1dbc05f ("mm/page_poison.c: enable PAGE_POISONING as a separate option")
> 
> Please send along a signed-off-by: for this.

Oh sorry.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Good enough or should I repost?
