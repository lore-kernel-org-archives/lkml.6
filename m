Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B43C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4F42086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lg+Ye19W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqCHXMu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405177AbfBMSgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:36:05 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45949 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbfBMSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:36:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id F3CD93247;
        Wed, 13 Feb 2019 13:36:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 13 Feb 2019 13:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=aD8TlHQU2jzhMxfpW5RpYxKtLxs
        u49Jx4BXrJPH1sjo=; b=lg+Ye19WCRw7kgGr39A1HSu9F8Y/uOo4LI0RiLpg9Tk
        xZ5vk9v0nmVgWcFHBbc8hu3uTHrONRru6E96kbedT6bz+qEAvs+X6LAbQVdxGRn6
        zgJPQ7CGFdaPhMV7tDGoYWKunAJoq+K35Qdpo6rNvpX2GIDKl8BS8ey3XAUMSxPY
        404LxpjPo1nbho5cUJXQhNeIwcmvzkguMHa6OMIGUoIsmnFHlijtTxLRJhkO+u5J
        D/5ZZo19gTb8YMGRo6ya9o+QyOREQpaA1R4szIAOaFLvHHd2EM4A1Kt2DWnT6mfA
        Y7hqWDXxbiic/BZRdMaGNC474MDL1DLn24Pe3xqixFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aD8TlH
        QU2jzhMxfpW5RpYxKtLxsu49Jx4BXrJPH1sjo=; b=NqCHXMu++UwdfzYUMvH4tL
        Oiq+dGRwC2FKW3Mb46ZekySn9Dz4f74n5R/gmT6rcXNygFtVLhddsvkd67xH+zjB
        +cgm0YlIrVjiGWXsrHgXHRzcuhnjc1cvbPC6KreE7JOUBbqOCSMgYVt2bh30lxug
        kQFsjtLXbREGyN7281p9NQ2uL98gSyU6lrX9/CzCs/eegrDX0CBTeyT1xT9BuayO
        2XKtXBNsWd5ttN1tvGDs/fwPrd3LI4XcJWPNXFtgS6XQ3kcEIcw8rBOhdZwD/TLC
        Ud9tgO26PtXt2t2xVzzKVcRwYvxvnVg00Abex9XcCRhdxYiVg6D7NRlFwtZdWAaA
        ==
X-ME-Sender: <xms:k2NkXD_qFQK93Du4M_sos8YyRnxtca1SS4JMeumoB6j8dj0ehkgGpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukf
    hfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghes
    khhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptd
X-ME-Proxy: <xmx:k2NkXKWGXam-_Cf1KM9sS0ubmflr0cSCEmCmrzGRgJQjkaMGFESnow>
    <xmx:k2NkXHBIiGvpz_GghRzcbGrBbRVw55aj6XFBVGpm_6ZSrGWXVr8HXQ>
    <xmx:k2NkXPFzYupcESOkcChIqgJstQ7JqhiMgCD47PSaDUTktmfE8tLG2w>
    <xmx:k2NkXOrgNn-oG8Lw7UJKCz4rYv2HXfFbbqQMlvVy2uOo3XEMlZD_1g>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0A3410317;
        Wed, 13 Feb 2019 13:36:02 -0500 (EST)
Date:   Wed, 13 Feb 2019 19:36:00 +0100
From:   Greg KH <greg@kroah.com>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.14 0/8] uio backport fixes for 4.14
Message-ID: <20190213183600.GA29373@kroah.com>
References: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:29:12PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Backport uio fixes to 4.14, to fix use-after-free memory errors.
> 
> Changed __poll_t to unsigned int as the former not found in 4.14, and
> resolved some patch context conflicts.

Thanks for this, all now queued up.

greg k-h
