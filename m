Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE93C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE61F2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfBLRJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:09:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfBLRJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:09:39 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 15F6314C36B4D;
        Tue, 12 Feb 2019 09:09:39 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:09:38 -0800 (PST)
Message-Id: <20190212.090938.1241676476384735940.davem@davemloft.net>
To:     hch@lst.de
Cc:     netdev@vger.kernel.org, nicolas.ferre@microchip.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: net: don't pass a NULL struct device to DMA API functions v2
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211132004.29143-1-hch@lst.de>
References: <20190211132004.29143-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 09:09:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 14:19:56 +0100

> We still have a few drivers which pass a NULL struct device pointer
> to DMA API functions, which generally is a bad idea as the API
> implementations rely on the device not only for ops selection, but
> also the dma mask and various other attributes.
> 
> This series contains all easy conversions to pass a struct device,
> besides that there also is some arch code that needs separate handling,
> a driver that should not use the DMA API at all, and one that is
> a complete basket case to be deal with separately.
> 
> Changes since v1:
>  - fix an inverted ifdef in CAIF
>  - update the smc911x changelog
>  - split the series, this only contains the networking patches

Series applied, thanks.
