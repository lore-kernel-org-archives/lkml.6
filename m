Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C92C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1FF25D2C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1FF25D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeGBVlz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:41:55 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:54128 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeGBVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:41:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0987C60B5C39;
        Mon,  2 Jul 2018 23:41:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0Ui0t4nOIvg1; Mon,  2 Jul 2018 23:41:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD72960B5C3E;
        Mon,  2 Jul 2018 23:41:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M5XI7QSgL4ka; Mon,  2 Jul 2018 23:41:49 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 9D65860B5C39;
        Mon,  2 Jul 2018 23:41:49 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "UBIFS: Fix potential integer overflow in allocation"
Date:   Mon, 02 Jul 2018 23:41:42 +0200
Message-ID: <5400614.4lJzJ1gdXR@blindfold>
In-Reply-To: <CAGXu5jJabYkC06ZGa1X2HweY8idyDR8a2y805btY5jKMHKbSuA@mail.gmail.com>
References: <20180701212051.29486-1-richard@nod.at> <2073665.T6vW7v0NJO@blindfold> <CAGXu5jJabYkC06ZGa1X2HweY8idyDR8a2y805btY5jKMHKbSuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. Juli 2018, 20:27:00 CEST schrieb Kees Cook:
> > Let's queue another patch for the next merge window which converts
> > kmalloc() -> kmalloc_array().
> 
> I'd prefer to leave it as-is for 4.18 because it would be the only
> unconverted kmalloc()-with-multiplication in the entire tree. We did
> treewide conversions and a revert would be undoing that here. (The
> scripts that check for this case would run "clean" for 4.18.)
> 
> So, this gets back to the question of the int vs u32: if you just
> didn't revert this patch, then the kmalloc_array() would stand too.
> Easy! :)

I can queue the kmalloc_array() conversion on top of the revert.
But TBH, using kmalloc_array() here is just ridiculous, we allocate
dn->size times 2 where dn->size is at most 4k.

Thanks,
//richard

