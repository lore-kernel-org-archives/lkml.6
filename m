Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B92C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244EC21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XoAVdGcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQ9cIm+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfBKNk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:40:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34335 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727664AbfBKNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:40:28 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B956E22108;
        Mon, 11 Feb 2019 08:40:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Feb 2019 08:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=p6Q+Jtym291XvE1/SU6tLSFns2P
        WwuGXi3SFBgo+DaI=; b=XoAVdGcRLaOS6RmOrewv195rVMref/2T5i5HzKdQl9t
        drEVmYeGDR1cEeuRVDK9pH1IUTmjGndNcG4sX33sySloQ3W7Uo7r7aymqTduSA8G
        z7kxc1mXkj/MiqNKQynpJEWPWgVCxceYg1oXk/qv1w29QNi4XlswEQAqUb6IZlru
        i7KJHg9lX8jUEDYPmZBtKzIDqMOAihzK0pmXf/smyitiLU6tL4YKiKUa6Apoe/BD
        SKMV+kgpS8/E6UY886IsyWa7WpB2ezewiDzS9/akCgVOdxLItm9a65V3SzGzSEaz
        Q/YXeqZxsmSsIfPZxhjUb/hJ8U/HqqmzUkgEmfzC6lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=p6Q+Jt
        ym291XvE1/SU6tLSFns2PWwuGXi3SFBgo+DaI=; b=mQ9cIm+M68DCxPJrCuV4b3
        MZVXgWoUQACx4twsRVot99ZWStgdgPtBDmPrhhFTr4QFU2HW6ZSejaMY95MYotWp
        yjiBu9wSGpchzl4uyyDmSjnw2BOx0J8NcC4jXMqVj991ECdN/TMGihhILD+nEJuq
        JQqdWR5hbqTViFU8aqYNmVrPzz79WqyVTz83F8nMWESbjE5Md4tODOWJk0ZQZD3S
        NoHg09hncK9rSSC4QXj8w8LniEj8nBzUrQIxSn72TUhwzjH9Q7VGiGOF61CeEYkG
        Oe7IYLMYybyWdIg5pyg+msyImN+fzl/fBTS4V9+48FrW0tmMtd+cPFqHusNC6E7Q
        ==
X-ME-Sender: <xms:SnthXC8xtMcgyEn4iPgnkZsgG4K4FCBRRx9V-m2qll4jhQ4cm8kuPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleelgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgg
    gtuggjfgesthdtredttdervdenucfhrhhomhepfdhgrhgvgheskhhrohgrhhdrtghomhdf
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutdejne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:SnthXD-sFqESJn2hP7bZRDx7CvrG4vwPIJbIboRaz4Sx0TZjqsdq5A>
    <xmx:SnthXNWrG6_KgRBlqUoyoM8RaFMWx6S_QlDNtZpN4v1FJLO64vSTbw>
    <xmx:SnthXIYZvljL0rl_r8ff49sQmopYuJFj4K2pO7wwdcgqTn3pMT1tfA>
    <xmx:SnthXDaoy_-sKkFQH1hxzUR9U0YWqlo_KrdIzBZPhtSA61hoQX0x-g>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2CAFE1030F;
        Mon, 11 Feb 2019 08:40:26 -0500 (EST)
Date:   Mon, 11 Feb 2019 14:40:24 +0100
From:   "greg@kroah.com" <greg@kroah.com>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 4.14 "uio: Prevent device destruction while fds are open"
Message-ID: <20190211134024.GD17709@kroah.com>
References: <007d90a957944409abd32af82a3680444a1e4399.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007d90a957944409abd32af82a3680444a1e4399.camel@nokia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:27:27AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Hi,
> 
> I hit use-after-free issues in UIO in 4.14.x, and discovered that it's
> already fixed in later kernel versions:
> 
> commit a93e7b331568227500186a465fee3c2cb5dffd1f
> Author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> Date:   Mon May 14 13:32:23 2018 +1200
> 
>     uio: Prevent device destruction while fds are open
> 
> Can we have this in 4.14.y?
> (good idea to older LTS kernels too)
> I picked and tested the following commits in 4.14.x:
> 
> 
> # Temporarily revert "uio: Fix an Oops on load",
> # to avoid merge conflict later with "uio: use
> # request_threaded_irq instead"
> git revert f6a6ae4e0f345aa481535bfe2046cd33f4dc37b8
> 
> # "uio: Reduce return paths from uio_write()"
> git cherry-pick 81daa406c2cc97d85eef9409400404efc2a3f756
> 
> # "uio: Prevent device destruction while fds are open"
> # Also amend this, change __poll_t to plain unsigned int,
> # the former not found in 4.14.
> git cherry-pick a93e7b331568227500186a465fee3c2cb5dffd1f
> sed -i "s/__poll_t/unsigned int/" drivers/uio/uio.c
> git commit --amend drivers/uio/uio.c
> 
> # "uio: use request_threaded_irq instead"
> git cherry-pick 9421e45f5ff3d558cf8b75a8cc0824530caf3453
> 
> # "uio: change to use the mutex lock instead of the spin lock"
> # Resolve conflict due to __poll_t in patch context.
> git cherry-pick 543af5861f41af0a5d2432f6fb5976af50f9cee5
> sed -i -e '/<<<<<<</,/=======/d' -e '/>>>>>>>/d' \
> -e 's/__poll_t/unsigned int/' drivers/uio/uio.c
> git add drivers/uio/uio.c
> git cherry-pick --continue
> 
> # uio: fix crash after the device is unregistered
> git cherry-pick 57c5f4df0a5a0ee83df799991251e2ee93a5e4e9
> 
> # uio: fix wrong return value from uio_mmap()
> git cherry-pick e7de2590f18a272e63732b9d519250d1b522b2c4
> 
> # uio: fix possible circular locking dependency
> git cherry-pick b34e9a15b37b8ddbf06a4da142b0c39c74211eb4
> 
> # Revert "uio: use request_threaded_irq instead"
> git cherry-pick 3d27c4de8d4fb2d4099ff324671792aa2578c6f9
> 
> # re-apply: uio: Fix an Oops on load
> git cherry-pick 432798195bbce1f8cd33d1c0284d0538835e25fb

That's a lot of work for me here, can you just send the patches properly
backported as a series so that I can apply them that way to ensure that
I got this all correct?

thanks,

greg k-h
