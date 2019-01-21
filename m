Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E81C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5C320844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UytXDuTU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J1w8jovS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAUToO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:44:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfAUToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:44:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8021360866; Mon, 21 Jan 2019 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548099852;
        bh=rF77RCWbWZur6KREszBmKEh8qdl8SemN/uWDuL0OL8g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UytXDuTUdIWUb2NC9eY2xUl70tZdhpLERCvqYoyusyqTJWnuvpddpDCY8cnSnUOD0
         7BVViJz6OoPp9Whs3dXS/dut9XUTAjzwRgfhAWTg8ys3/zwE8GhGg8F2suEFZmbDDR
         BD5bNyw3lw7LowC6RO+hT1Ml/mkiy6rkOhUkVpQE=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C6D860112;
        Mon, 21 Jan 2019 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548099851;
        bh=rF77RCWbWZur6KREszBmKEh8qdl8SemN/uWDuL0OL8g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=J1w8jovSt47kiS/w56M+ZilqkOBzhGLxXbFMY/iIaA4BnIg7tfJb2J3ib1I708UYV
         o41mHdC/4+1Zxggsxz87EsIbxkn/5Zhca+GC8SWKUwuNQIYkkqa8gL0zKa/fs52880
         dZRg65ba+kJJP3bppUfzDG7XNjo7AFDnZq17LRVI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C6D860112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 21 Jan 2019 11:44:10 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
In-Reply-To: <20190121083046.GD12420@infradead.org>
Message-ID: <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-4-git-send-email-lmark@codeaurora.org> <20190119102527.GA17723@infradead.org> <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com> <20190121083046.GD12420@infradead.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Christoph Hellwig wrote:

> On Sat, Jan 19, 2019 at 08:50:41AM -0800, Laura Abbott wrote:
> > > And who is going to decide which ones to pass?  And who documents
> > > which ones are safe?
> > > 
> > > I'd much rather have explicit, well documented dma-buf flags that
> > > might get translated to the DMA API flags, which are not error checked,
> > > not very well documented and way to easy to get wrong.
> > > 
> > 
> > I'm not sure having flags in dma-buf really solves anything
> > given drivers can use the attributes directly with dma_map
> > anyway, which is what we're looking to do. The intention
> > is for the driver creating the dma_buf attachment to have
> > the knowledge of which flags to use.
> 
> Well, there are very few flags that you can simply use for all calls of
> dma_map*.  And given how badly these flags are defined I just don't want
> people to add more places where they indirectly use these flags, as
> it will be more than enough work to clean up the current mess.
> 
> What flag(s) do you want to pass this way, btw?  Maybe that is where
> the problem is.
> 

The main use case is for allowing clients to pass in 
DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
ION the buffers aren't usually accessed from the CPU so this allows 
clients to often avoid doing unnecessary cache maintenance.


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
