Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4350AC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35C4208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJGKPkmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35C4208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFKRkN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932409AbeFKRkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:40:12 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8EC208AF;
        Mon, 11 Jun 2018 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528738811;
        bh=BjTLVx0gJR1Gqb/0vbV4Kayt14EoOw4+dGTEZaLYQgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJGKPkmcNqRaHEJbQOZT0CYgBzj9+/0jlWtESN1Q1jE5+RKfKn3z/mw2ncNetOs+l
         SJwbtwzi2K1NVTpsXVm+4jke07BrnQzu0GE1aw+/H9EMojqnFfWEdnh0RD+/hr3dTx
         C+ssQDs8/eQIHMs05eLF68zuPHPeoGnsVtAevkVo=
Date:   Mon, 11 Jun 2018 10:40:10 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Message-ID: <20180611174010.GC6783@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
> > for the mapping for node and meta page caches.
> >
> > [1] https://lkml.org/lkml/2018/4/8/661
> 
> Hmm. The patch there looks correct, and anybody who relies on slab
> constructors is crazy.
> 
> That email from April says it should go into stable, but it never even
> went upstream..

Heh, I forgot to link the latest results. The MM fix was merged by:

abc1be13fd11 ("mm/filemap.c: fix NULL pointer in page_cache_tree_insert()")

Thanks,

> 
> Adding Willy to the cc, for comments, since he's been active there and
> is probably the maintainer even if the MAINTAINERS file doesn't say
> so..
> 
> Willy?
> 
>              Linus
