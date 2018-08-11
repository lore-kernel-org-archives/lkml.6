Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4FFC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C17223AB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 10:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C17223AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHKMrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:47:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55752 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbeHKMrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:47:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F25D42072F; Sat, 11 Aug 2018 12:13:25 +0200 (CEST)
Received: from bbrezillon (LStLambert-656-1-150-232.w80-14.abo.wanadoo.fr [80.14.32.232])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5E793206A6;
        Sat, 11 Aug 2018 12:13:25 +0200 (CEST)
Date:   Sat, 11 Aug 2018 12:12:51 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-mtd@lists.infradead.org
Subject: Re: mmotm 2018-08-09-20-10 uploaded (mtd/nand/raw/atmel/)
Message-ID: <20180811121251.1baa8696@bbrezillon>
In-Reply-To: <a7523628-9728-6586-1bab-e256d3ba56a7@infradead.org>
References: <20180810031103.Ym0HzDAqN%akpm@linux-foundation.org>
        <a7523628-9728-6586-1bab-e256d3ba56a7@infradead.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, 10 Aug 2018 08:37:01 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 08/09/2018 08:11 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2018-08-09-20-10 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.  
> 
> on i386:
> 
> ERROR: "of_gen_pool_get" [drivers/mtd/nand/raw/atmel/atmel-nand-controller.ko] undefined!
> ERROR: "gen_pool_dma_alloc" [drivers/mtd/nand/raw/atmel/atmel-nand-controller.ko] undefined!
> ERROR: "gen_pool_free" [drivers/mtd/nand/raw/atmel/atmel-nand-controller.ko] undefined!

Hm, missing 'depends on GENERIC_ALLOCATOR'. I'll send a patch to fix
that.

Thanks for reporting the problem.

Boris
