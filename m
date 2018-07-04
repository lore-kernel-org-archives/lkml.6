Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D7C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD17247A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1m2QqzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD17247A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbeGDCL7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:11:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37838 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932739AbeGDCL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:11:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so1890291plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ceqP5mxuI7bg8UcgLhrWNYxZyAjv7uvgRju9/kvOU/E=;
        b=Q1m2QqzICakk9bqEHriDbvLB5FSjNDvuKHmrRa13AYvVgYYSFbtH3tXjid4kPhzrRo
         c3r5gU2+XAHsPR7YfAYGu0PquEmuNaxegAf+QdlXMQjnFDp03Kb33H0dK5FhcIrnilK4
         T+lVqgwN78g3f9kn7y559a9VVIctTTNgma3rqdLNa6zuYMRbsT5Upe1oH9yeQ887DGlc
         iSwrjDsJe8dDcGqHlXyxjHtXiB7v6nysnDTfqIBqXLp8NeiRNVH4acIa9w1iGJ3pnwfp
         DPcinmBpk9RTLdcmoNpguy9VOA5AGdo5x6Q25fo8ouyoxMXAcZklpTKfJFk2/fnuwdas
         sdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ceqP5mxuI7bg8UcgLhrWNYxZyAjv7uvgRju9/kvOU/E=;
        b=N5xPsltNn3t04B1VOXTuc+CUi2ZaoDU8n1k5lUOp93HhpQLT1oHGt0QaRs7EhFBOtR
         pU0+P3K+jyR/y0CnRfL+DAdy2MCu5xC5jZ5QjlH4fAmvbhXn4sDfkYDoM4QO+8AgcVJ8
         h9aLzC97K4NsfLjGMjqKp4UfUy/uPAV6gVcSB488IFcYRlXxYC/0H6oLF2D9ICpsvvfP
         uAT6SBZH1cq5hxpS2yd2diHTIGI+7rQbPsprJC7tS1xREdTNTaj6lyKsYGlNEjB/h1rA
         JSGdqg9BHO+/vjngh6yP0sJef2K+9iHWkaQs7ZvvzWCD7HK0Q7L9dovYhl5hhuZo3GHt
         b/vQ==
X-Gm-Message-State: APt69E3R1qCGfCNUwLmf6xYpI7DTaZmliU2IvSYePob9cIJIxlxFA+m1
        EKLc7pnLqoDB5x7ozTwLkLVDwmBp
X-Google-Smtp-Source: AAOMgpeMw2cs5FVNdgt0LdEqaWaUoyQxMnVJ4ZndVssVksmTgo+seoJdc0AaobFyOynalnxsnPvaUA==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6-v6mr132354plk.75.1530670317661;
        Tue, 03 Jul 2018 19:11:57 -0700 (PDT)
Received: from localhost ([175.223.14.150])
        by smtp.gmail.com with ESMTPSA id l11-v6sm3625988pff.50.2018.07.03.19.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 19:11:56 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:11:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 00/21] mm, THP, swap: Swapout/swapin THP in one
 piece
Message-ID: <20180704021153.GA3346@jagdpanzerIV>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627215144.73e98b01099191da59bff28c@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/27/18 21:51), Andrew Morton wrote:
> On Fri, 22 Jun 2018 11:51:30 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> 
> > This is the final step of THP (Transparent Huge Page) swap
> > optimization.  After the first and second step, the splitting huge
> > page is delayed from almost the first step of swapout to after swapout
> > has been finished.  In this step, we avoid splitting THP for swapout
> > and swapout/swapin the THP in one piece.
> 
> It's a tremendously good performance improvement.  It's also a
> tremendously large patchset :(

Will zswap gain a THP swap out/in support at some point?


mm/zswap.c: static int zswap_frontswap_store(...)
...
	/* THP isn't supported */
	if (PageTransHuge(page)) {
		ret = -EINVAL;
		goto reject;
	}

	-ss
