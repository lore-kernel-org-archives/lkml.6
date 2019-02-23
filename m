Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F24DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6067620675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 12:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="u4tvWyMp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="atHSHEhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfBWM7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 07:59:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55433 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbfBWM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 07:59:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E6B59320A;
        Sat, 23 Feb 2019 07:59:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 23 Feb 2019 07:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vey0nNazD+X8kjF1BvoRxBo/gA/
        LX0jWJJjEp4hPVog=; b=u4tvWyMppYaRoN0mbgwtrERRLBd12h82C3AkFURrycY
        u4A7YWWYocAqDcf9ah+yQR8+XpiQVdh7Ah2HkcIA/ep/yvb1V/WAzbPG04gTbuYI
        ZiNJltl9G7YvaUehxVGSaeZpBTLs7i2/I7m2CYUuvTvuEgT16fMnzbTS1cFlZ8br
        0sMjDhfQftkkI+OvtxwJ0Fmf6AGKIqX3bqQzLisPfwIGRZkcI9+c5EHhf6e6VMSD
        JWQX6Dzqqx45nsFJg8FGYxOll3CoLibFk2uIcqrfrbw/URKDWa1ARskGS9sh1S1F
        JOPor9bYTdXsIkn3CncxxgwveYVeNxSGlHyozIR451A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vey0nN
        azD+X8kjF1BvoRxBo/gA/LX0jWJJjEp4hPVog=; b=atHSHEhR3ePAo0KDsBHzIC
        jGYIo+NYznFRcqW2VxrGLrEwLpG7Q296w8nle31lMClwN4FEbzQpQhu5TKimTxmP
        9Jth9OjKZHhK41DBMUMWbJWBgcr8JK7HbaMYcvDSO2n/js9jflPClqmcseCResGc
        4wGQAryxND/a0DIEoSNdS9lPvM4R+GOohEC+XwmK3SoudP8JuWht5zbHdulegIBi
        ireDFbtvqZmSltEw6OCmvV0Qz/cb21j7aDn/2rH7VPzsayVpW6aSGtWWDPi5xHNQ
        S9YSfsKkm8UWP0MUyYQC9qRlF6drjxzj3Y7JgWzpUDEXZIeUMpJPHT/aOBaVWcsw
        ==
X-ME-Sender: <xms:vkNxXAUVBhWWVgmR-zmVONX95DK-TJ8ulzAzsouFdo2HoyV_HK3gsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddruddvgdegleculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vkNxXJiDkxv9T3s8ot8W7KNfZI4dD9tJoZre0dWYt_FJGkCHtqTamA>
    <xmx:vkNxXMiqLQDU6dCmYEMH4PZ_0nZIz5aV7C-jS2lNH1xEhCcsH-dWrw>
    <xmx:vkNxXPzc-kTOmL-1veptlM23jJBUFDFamYOAuYUbHG7ilDBkd23rcA>
    <xmx:v0NxXIC2G3CPfhzcQeXMkf6S0u5Gk7p_AcEby5lkcXJQUlPYvjwhqw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86EBC10331;
        Sat, 23 Feb 2019 07:59:42 -0500 (EST)
Date:   Sat, 23 Feb 2019 13:59:32 +0100
From:   Greg KH <greg@kroah.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     jreuter@yaina.de, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        ralf@linux-mips.org, netdev@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] net: ax25: Fix  multiple blank lines
 warning
Message-ID: <20190223125932.GC16686@kroah.com>
References: <20190223111751.14620-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223111751.14620-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:17:51AM +0000, Jules Irenge wrote:
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  net/ax25/af_ax25.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> index 5048790a75f6..2da349b7854a 100644
> --- a/net/ax25/af_ax25.c
> +++ b/net/ax25/af_ax25.c
> @@ -49,8 +49,6 @@
>  #include <net/ip.h>
>  #include <net/arp.h>
>  
> -
> -
>  HLIST_HEAD(ax25_list);
>  DEFINE_SPINLOCK(ax25_list_lock);

Why are you doing outreachy application patches in net/?  We only accept
them in drivers/staging/  Always start there first.

thanks,

greg k-h
