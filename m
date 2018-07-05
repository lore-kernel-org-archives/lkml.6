Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA5CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858B820C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HNh80qev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hNz7X9KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858B820C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754428AbeGEQ2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:28:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38529 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753829AbeGEQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B993721ABB;
        Thu,  5 Jul 2018 12:25:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Jul 2018 12:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=wfIs56SDKy7QlwZory55V3yk1FMTQh5Bd+uDH/5hhCo=; b=HNh80qev
        mxlAe0o+jS8R3cs3pADnWMKhrQTtrUIARtHX4B6gf64QGbEUY3PyUhqpuVZuPSfx
        rFCp1Y51yUtpQBvOxQRGw4q1TNfFwgsK1mlEYYujn2FOZyZ2on/GdMiyt7RVysWw
        0/+Z0+6Tp4jwIrUi6vklr/yxMlQJaFbT1kcrg4ksfzTxkMe3ONaLKhhI6nxT5Hy+
        rYdNJBzTANWELlDS+IZor3ceT28DlFc19jslxFPf2bFD8CDoTN4WyprxcX6la+QI
        1oo8kSoPWwxE4bvumAyDAa5IjsUk+7C6HYJtOQgvgMvSC9c8iVudga9c0JaBXAJb
        LHJxBHA0GxEVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=wfIs56SDKy7QlwZory55V3yk1FMTQ
        h5Bd+uDH/5hhCo=; b=hNz7X9KM/Z/h8TGT6Es1SEhHzypXHqrLf1NbhhTZSyIsR
        LzFbOFpOaDPkdIZt/MrVZ9n//nO08FzahMLnwAZ/az6Oi8F0yrsFssC/XmK2XjRQ
        suUgyCA8nYXR1cEl1R/DWuGwv1rGEHj60J6tBadvKxlqieXfqgQZ8KtbW+30EjGw
        EN83sv7BFuIu/MLB7KdKdinU3F0+DjaLXAWh+cMeyWHquCSJH9nGurCsikkL6uxj
        JsYnlXVwwX4PxRqU07iXjHWZpegInFYNWQChrB24rbvCcE8iiQePMK1w4Bham8Eu
        ZXvUL2N0Tr1e0JmROqCOtf8T390aSV0I1zoikzQMg==
X-ME-Proxy: <xmx:bUY-W3P-qFo5CB9cMelM-lkQH70nB-WWaUp9Oy9AJaZpaUBk7rEnEQ>
    <xmx:bUY-W5Lubn1uNNd0vqrcCEFHto812jQ3dsMt1Z_kHDPtib8WL47RuQ>
    <xmx:bUY-W6q2iUWfBGtCzoUSfHKscSDCKf_rpEp8nti53TaaixIV279h3Q>
    <xmx:bUY-W0bs-UChwkXcq8go7emq3TBvWMzUxPwtvYuY-OXAu7rrL4fsTw>
    <xmx:bUY-W3z9Zrly19KJbMXRvXcU4xF1u2Yjz5q3ZJfcG41-BjIgh6gYLw>
    <xmx:bUY-W6N1DwpSQ_7DA3P0OAMnyeXLIY44IhqTemPeupy9WRzVOaYm2Q>
X-ME-Sender: <xms:bUY-W0p-gzZulw0_r-k9ovLeiVxi9Q6f_RAXPCG4ZM7hBC-pmwU5Jw>
Received: from localhost (d57d388d.static.ziggozakelijk.nl [213.125.56.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D7FDE405A;
        Thu,  5 Jul 2018 12:25:16 -0400 (EDT)
Date:   Thu, 5 Jul 2018 18:25:15 +0200
From:   Greg KH <greg@kroah.com>
To:     Stefan Bader <stefan.bader@canonical.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
        stable@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable-review@kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [Stable-review] [116/165] ext4: dont return to
 userspace after freezing the fs with a mutex held
Message-ID: <20180705162515.GB18499@kroah.com>
References: <20100730171510.105264205@clark.site>
 <4C56B45E.9010601@canonical.com>
 <4C56FA35.7060607@redhat.com>
 <20100802184806.GA16878@kroah.com>
 <20100807040732.GB16342@khazad-dum.debian.net>
 <4C5D61E7.9090008@redhat.com>
 <4C5FC3BB.4030602@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C5FC3BB.4030602@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2010 at 11:00:43AM +0200, Stefan Bader wrote:
> On 08/07/2010 03:38 PM, Eric Sandeen wrote:
> > Henrique de Moraes Holschuh wrote:
> >> On Mon, 02 Aug 2010, Greg KH wrote:
> >>> On Mon, Aug 02, 2010 at 12:02:45PM -0500, Eric Sandeen wrote:
> >>>> On 08/02/2010 07:04 AM, Stefan Bader wrote:
> >>>>> We have reports about this patch breaking lvm snapshhots. Eric, there is a patch
> >>>>> mentioned which is supposed to fix things but its not upstream, yet.
> >>>>> Do you know what happened to that?
> >>>> right, patch below is needed to fix things.
> >>>>
> >>>> Ted just acked it on the list recently; Greg, I'd either drop 116/165
> >>>> for now, or include the patch below which should be upstream soon...
> >>> I can't take anything that isn't upstream yet.
> >>>
> >>> And I just released with this patch in the kernel, should I do a revert
> >>> and do a new release?
> >>
> >> Any answers on this?
> >>
> > 
> > Yes, I'd revert it for now, I'm afraid, if the other patch isn't upstream
> > yet.
> > 
> > Sorry about that,
> > 
> > -Eric
> 
> Upstream as of now (same SHA1 as in linux-next):
> 
> >From 437f88cc031ffe7f37f3e705367f4fe1f4be8b0f Mon Sep 17 00:00:00 2001
> From: Eric Sandeen <sandeen@sandeen.net>
> Date: Sun, 1 Aug 2010 17:33:29 -0400
> Subject: [PATCH] (pre-stable) ext4: fix freeze deadlock under IO

That is a patch from 2010, are you sure this is what you are looking
for?

confused,

greg k-h
