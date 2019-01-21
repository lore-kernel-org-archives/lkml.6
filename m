Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28418C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02B020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ktknl7KW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XoI1rNwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfAUWSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:18:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAUWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:18:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 64B876087D; Mon, 21 Jan 2019 22:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548109094;
        bh=SP6j9DpD7xw8Fr58NzICelUN9+Tmr0A0d0znJFHcBFo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ktknl7KWVdvqjJ/yZB7EdaCaOQ99xdaQGvxtfZMm37EVUHR3Ipi0sunk6pDrurFWt
         WO+i02XX0j4aFT7lTWTGj4ZmU6bVw4k2Sk4m9FPBZPNLZ6Y2+jc4WYaosJvvT29HWS
         +WMMlJ7h1Clrod27fHWH/YJ7ql5o6nUuYIu9DvxI=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94E896079C;
        Mon, 21 Jan 2019 22:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548109093;
        bh=SP6j9DpD7xw8Fr58NzICelUN9+Tmr0A0d0znJFHcBFo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XoI1rNwHGF27BfGzlmGCVV7VIJrlCh86zd6u4eK3PU1P28sT05nLsiRj2YQiTudnl
         /ofvklhZBhEfHuhMrpgoOFUD+Cr6KRqKz5PwvcQLz0Z3EfxueMrdrSkmhDwfjyLMbJ
         HcGVmUdT01ZOKxZiz9UWNJVhWETafSiHaqjbR4gQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94E896079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 21 Jan 2019 14:18:12 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
In-Reply-To: <4925c9db-fc73-1ccb-1766-ef68d014d55a@ti.com>
Message-ID: <alpine.DEB.2.10.1901211415140.11004@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-4-git-send-email-lmark@codeaurora.org> <20190119102527.GA17723@infradead.org> <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com> <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com> <0ed7875f-15e9-184f-5b99-9a53df7c8d14@ti.com> <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com> <4925c9db-fc73-1ccb-1766-ef68d014d55a@ti.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Andrew F. Davis wrote:

> On 1/21/19 2:20 PM, Liam Mark wrote:
> > On Mon, 21 Jan 2019, Andrew F. Davis wrote:
> > 
> >> On 1/21/19 1:44 PM, Liam Mark wrote:
> >>> On Mon, 21 Jan 2019, Christoph Hellwig wrote:
> >>>
> >>>> On Sat, Jan 19, 2019 at 08:50:41AM -0800, Laura Abbott wrote:
> >>>>>> And who is going to decide which ones to pass?  And who documents
> >>>>>> which ones are safe?
> >>>>>>
> >>>>>> I'd much rather have explicit, well documented dma-buf flags that
> >>>>>> might get translated to the DMA API flags, which are not error checked,
> >>>>>> not very well documented and way to easy to get wrong.
> >>>>>>
> >>>>>
> >>>>> I'm not sure having flags in dma-buf really solves anything
> >>>>> given drivers can use the attributes directly with dma_map
> >>>>> anyway, which is what we're looking to do. The intention
> >>>>> is for the driver creating the dma_buf attachment to have
> >>>>> the knowledge of which flags to use.
> >>>>
> >>>> Well, there are very few flags that you can simply use for all calls of
> >>>> dma_map*.  And given how badly these flags are defined I just don't want
> >>>> people to add more places where they indirectly use these flags, as
> >>>> it will be more than enough work to clean up the current mess.
> >>>>
> >>>> What flag(s) do you want to pass this way, btw?  Maybe that is where
> >>>> the problem is.
> >>>>
> >>>
> >>> The main use case is for allowing clients to pass in 
> >>> DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
> >>> which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
> >>> ION the buffers aren't usually accessed from the CPU so this allows 
> >>> clients to often avoid doing unnecessary cache maintenance.
> >>>
> >>
> >> How can a client know that no CPU access has occurred that needs to be
> >> flushed out?
> >>
> > 
> > I have left this to clients, but if they own the buffer they can have the 
> > knowledge as to whether CPU access is needed in that use case (example for 
> > post-processing).
> > 
> > For example with the previous version of ION we left all decisions of 
> > whether cache maintenance was required up to the client, they would use 
> > the ION cache maintenance IOCTL to force cache maintenance only when it 
> > was required.
> > In these cases almost all of the access was being done by the device and 
> > in the rare cases CPU access was required clients would initiate the 
> > required cache maintenance before and after the CPU access.
> > 
> 
> I think we have different definitions of "client", I'm talking about the
> DMA-BUF client (the importer), that is who can set this flag. It seems
> you mean the userspace application, which has no control over this flag.
> 

I am also talking about dma-buf clients, I am referring to both the 
userspace and kernel component of the client. For example our Camera ION 
client has both a usersapce and kernel component and they have ION 
buffers, which they control the access to, which may or may not be 
accessed by the CPU in certain uses cases.

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
