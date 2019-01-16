Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4957CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159A7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="R41kpar6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sU3lXaPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404865AbfAPQCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:02:25 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36947 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbfAPQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:02:24 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1BFF116126;
        Wed, 16 Jan 2019 11:02:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 16 Jan 2019 11:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9CcDB8bPVn2L2be4Z1VTuiPsI/s
        uiy08g3piKsDsbyU=; b=R41kpar6SWCrGB0gXYCRo0KxjVCmDHwgu3F7JK7//fp
        BiruRqhW+s9f/z3iMnAbDOOmAL9p+LfY8mP1tPulpuSBiuSy49Wlq6TCvZPBtAd2
        mpja6d/miC3GPOmrPsilW1TO5v9qv7dMjALspMdbUr5xypoA0+zYzKa+6jXi/rMf
        eBMKzMdGEss6u+1S5mj9V/udrpePlG4mBPEeFVGmhoGisaHaJFzhmKp3sZ8sCarS
        rlczd52fTbIFrrEDR8rvpjTYYDL21D/HehCMixekGrIp80zYcQ0KJWnwLyX/a3NZ
        NWZ5e03VX+OklHMFGH35xZc4DtNp/xfyhZdAQCwKz1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9CcDB8
        bPVn2L2be4Z1VTuiPsI/suiy08g3piKsDsbyU=; b=sU3lXaPHuPXZLwBVO/yVU8
        2WjybTkDQzM80M+sFH83BoCImsUW3kWswO/M2fTWCf2ZnwrKQW7kFH2nkpaiKY2b
        uwBG4Wq+N2p7Xbe5g+lPCZ8OYCBtOJHWlGqRyoDC5CoBqSpBTItwIv5uu8myYqz8
        KsSG3FRVyBUsGtOy4syGl5Z7mM7C6USbJN6jmXKkIrAdU7fmfxSyrao9Vij9GKk+
        HqFpew+cgUianEQWgHlJk3Mkb1zvtSwkxoytS8wPcdiaS9DdRHc3KkGMjZjulmGy
        Iar0RXRe26242q7nI2mhu0CsavwQdsNbtYTywfTJCHFRqGVUyHL/JoUFecfRBdKg
        ==
X-ME-Sender: <xms:i1U_XFcbRNqHrXESyD9IPDNzXHhtQgTEtIQxsO-As5oZqJKoz_etRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgeehgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttd
    dmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekle
    druddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:i1U_XK_BSXUINTk772EEtQGWOUVBEbf3-b_PEfKnxePwc3FpnITjvA>
    <xmx:i1U_XNHXMGePEV21fC9_VniiZ-rebHzJsUYUgwYbGfSiaMCtC-NtWA>
    <xmx:i1U_XJSr8P0UVFgKea1Sf4SFodqakFCR4ATXkgPOcsyd4csj6-5MGQ>
    <xmx:jFU_XDAg7YuRurRxrin6FMBRuJUDM5dLZ3usFaQuxRlgYEm9FjJVhg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE2861027C;
        Wed, 16 Jan 2019 11:02:18 -0500 (EST)
Date:   Wed, 16 Jan 2019 17:02:16 +0100
From:   Greg KH <greg@kroah.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH STABLE v4.19.15] gpiolib: fix line event timestamps for
 nested irqs
Message-ID: <20190116160216.GA4594@kroah.com>
References: <20190116153557.13720-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116153557.13720-1-brgl@bgdev.pl>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:35:57PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Nested interrupts run inside the calling thread's context and the top
> half handler is never called which means that we never read the
> timestamp.
> 
> This issue came up when trying to read line events from a gpiochip
> using regmap_irq_chip for interrupts.
> 
> Fix it by reading the timestamp from the irq thread function if it's
> still 0 by the time the second handler is called.
> 
> Fixes: d58f2bf261fd ("gpio: Timestamp events in hardirq handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> Hi Sasha,
> 
> this is a backport for v4.19.y series. The original patch didn't apply
> due to a conflict.

What is the git commit id for this patch in Linus's tree?

thanks,

greg k-h
