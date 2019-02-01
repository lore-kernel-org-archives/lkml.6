Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9073C2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549012340;
	bh=4WgjWS/3b3jnadjgqPR2B97ZAj8FKEDfamvuzJdHQtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KVT5DVqOXK7yuy5iK27YCntppj4mwUKIh+TmvsBYyWn3D5FhpzLY9+RMwkDFAMQ7n
	 w+tr2Iq9+bvp6IMrxoSYr2CQL3hw3e3q4WOqWYsYsV3kl29O6kn47AgGG0Y7yUwWtY
	 MUBMH9vEnm78gU80Hho8F+9jwZbExscieqvZGz8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfBAJMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfBAJMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:12:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACE720844;
        Fri,  1 Feb 2019 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549012338;
        bh=4WgjWS/3b3jnadjgqPR2B97ZAj8FKEDfamvuzJdHQtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+jDU/6frSnKsZtp/tgoh+NdfsTqfCrcFf9/MuaQqtrd8ONthDZkQd2dq7utu34hL
         w01MBcNjTL7cn2QatecW+NTWP7z+jKBj86xgdwL1utNSBmTWmo11ZyVf9CCmknIUrV
         MVJhEsD40eFTfGh3oDLmOD8If/947MRwg/GoKaDE=
Date:   Fri, 1 Feb 2019 10:12:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] dma: debug: no need to check return value of
 debugfs_create functions
Message-ID: <20190201091215.GB30619@kroah.com>
References: <20190122152151.16139-39-gregkh@linuxfoundation.org>
 <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com>
 <20190122184847.GA32627@kroah.com>
 <20190201090402.GA16244@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201090402.GA16244@lst.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:04:02AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 22, 2019 at 07:48:47PM +0100, Greg Kroah-Hartman wrote:
> > > Does this actually need to be at file scope, or could it be punted to a
> > > local in dma_debug_fs_init() while we're here?
> > 
> > It can be moved to the function scope if you want me to, I was trying to
> > do the least needed here :)
> 
> I've folded the scope move in when applying the patch to the
> dma-mapping for-next tree.

Wonderful, thanks!

greg k-h
