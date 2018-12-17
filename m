Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02654C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5F320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbeLQLcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:32:11 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36932 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:32:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3C115608A391;
        Mon, 17 Dec 2018 12:32:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SC8bvh5rqd-f; Mon, 17 Dec 2018 12:32:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A9EE3608A3B6;
        Mon, 17 Dec 2018 12:32:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WAgIwvCfE2pz; Mon, 17 Dec 2018 12:32:07 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 2B9D3608A391;
        Mon, 17 Dec 2018 12:32:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hsiangkao@mail.ru,
        kirill.shutemov@linux.intel.com, stable@vger.kernel.org,
        zhangjun <openzhangj@gmail.com>
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
Date:   Mon, 17 Dec 2018 12:32:04 +0100
Message-ID: <1605618.KFvAoLHJ4l@blindfold>
In-Reply-To: <20181217105944.a7eylrxi5pni4mqq@kshutemo-mobl1>
References: <20181215150130.19381-1-richard@nod.at> <20181217105944.a7eylrxi5pni4mqq@kshutemo-mobl1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. Dezember 2018, 11:59:44 CET schrieb Kirill A. Shutemov:
> On Sat, Dec 15, 2018 at 04:01:30PM +0100, Richard Weinberger wrote:
> > The page migration code assumes that a page with PG_private
> > set has its page count elevated by 1.
> > UBIFS never did this and therefore the migration code was unable
> > to migrate some pages owned by UBIFS.
> > The lead to situations where the CMA memory allocator failed to
> > allocate memory.
> > 
> > Fix this by using get/put_page when changing PG_private.
> 
> Looks good to me.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> > Cc: <stable@vger.kernel.org>
> > Cc: zhangjun <openzhangj@gmail.com>
> > Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
> 
> It is fair to reference the commit here. But I believe the bug itself
> predates the commit and relevant not only for migration.

My intention was not blaming you. :)
IMHO backporting the fix makes only sense up to that commit.
 
> We might make it clear in the commit message.

Fair point, I'll rephrase.

Thanks,
//richard




