Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F772C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461252146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfBTDfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:35:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfBTDfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:35:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 251F43D94D;
        Wed, 20 Feb 2019 03:35:42 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 998386013C;
        Wed, 20 Feb 2019 03:35:40 +0000 (UTC)
Date:   Tue, 19 Feb 2019 22:35:39 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the device-mapper tree
Message-ID: <20190220033539.GA17586@redhat.com>
References: <20190220131555.15317a39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220131555.15317a39@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Feb 2019 03:35:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19 2019 at  9:15pm -0500,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the device-mapper tree, today's linux-next build
> (powerpc_ppc64_defconfig) produced this warning:
> 
> In file included from include/linux/blkdev.h:21,
>                  from include/linux/blk-mq.h:5,
>                  from drivers/md/dm-core.h:14,
>                  from drivers/md/dm.c:8:
> drivers/md/dm.c: In function 'dec_pending':
> include/linux/bio.h:626:15: warning: 'bio' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   bio->bi_next = bl->head;
>   ~~~~~~~~~~~~~^~~~~~~~~~
> drivers/md/dm.c:930:14: note: 'bio' was declared here
>   struct bio *bio;
>               ^~~
> 
> Introduced by commit
> 
>   58c66b86cfe7 ("dm: improve noclone_endio() to support multipath target")

Thanks, I've fixed it up.

Mike
