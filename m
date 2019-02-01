Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB7FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDABC218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="T91rIXME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVgfHy48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfBAOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:18:28 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53263 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfBAOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:18:27 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 51509230D;
        Fri,  1 Feb 2019 09:18:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 01 Feb 2019 09:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=cYN1+pJOnNF9P1ndZGXJsYrxGkP
        jPzsd+M1Sam0mjns=; b=T91rIXMEeQ5ox6jA3B0EcW4fCI9S3SLSxAIK5tQRq95
        gliA0BkkOoYZWKMut6NCm3yQZOH/BqZhvNS3HenVGS/px/J4hQBEK1DIdwVHnMWL
        wkbubvBK/2hos3GUDOvtyP5y+tLHis1zkTRXr88mIOXWu2+KMH8aOasskuFwu1bB
        n4jR8YR8P94lHp2C8p49DfvREtXhCcJo3B+2NnsmccqPoB8ro9WwTmra0qVelGlo
        jiyVV2etc0+pu00HuUfJs+v0nx1jtwPH2DfJrohYrpVGr8HnRRMb30WobBgRBUP4
        zIU/FvFjBOvnfCYIV5U0vgSxD6rkfTd10VX11Euq3Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cYN1+p
        JOnNF9P1ndZGXJsYrxGkPjPzsd+M1Sam0mjns=; b=dVgfHy48uiM+ndsulVLWx7
        NIZPUnbdVZEib9puwIOLn73+DPCyZuAdIFJgtUTTIRpIphWi2brgkz+/ehO/GC4C
        n6BPNlX66N5dKlwweFfRxIjNAf8vaqrRAovPn16XuuvYHsh7WJe4Abc6Rp00FpRs
        2BLywgPawOulfmzltOewKq8aHN9RA9YeXzcWH8x700eqc7MCdQ3xiBh6ZbiiQmSY
        CFu9d7c6mSsmq4lgjmxdGkvVTKvujGuLJSrZPAaReUCpRkby92TeqwuLfZSZ0lwZ
        9AbQ6P/21PNBK6PhXHsHs7j0TuIK4EPox531WSzYsT4uwGV+FrXSigKfodbF2xmA
        ==
X-ME-Sender: <xms:MFVUXBTNMkAg4LuwtLMP-N40_aYVdBBj6HRJWLwr41yqNFo1mezxOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeekgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgg
    gtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhr
    ohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:MFVUXHE2_CGnYUbr2S9mIeyzWNYQEAFd66UK6YZQUr2zAc6DhZxQTg>
    <xmx:MFVUXJm9d05pDCIXBXvmPCzAjpJVx-CAvPNFQsl1q7H3mWGHR7oiFw>
    <xmx:MFVUXK3P8ky6Ic4V5bpaFt2UetzS_godVJ1-pIUQrXpnAxoIddPv7Q>
    <xmx:MVVUXLhxy0fZeuyYsL-L2mkXfFDi_0NNlVkqLDzLPa8cXuxfRFf4Xw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B59CE4078;
        Fri,  1 Feb 2019 09:18:24 -0500 (EST)
Date:   Fri, 1 Feb 2019 15:18:22 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <20190201141822.GA30151@kroah.com>
References: <20190201134146.0bfd5ba0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201134146.0bfd5ba0@canb.auug.org.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:41:46PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the driver-core tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: "__arm_smccc_hvc" [drivers/firmware/stratix10-svc.ko] undefined!
> ERROR: "__arm_smccc_smc" [drivers/firmware/stratix10-svc.ko] undefined!
> 
> Exposed by commit
> 
>   095ff29d2b88 ("firmware: intel_stratix10_service: add hardware dependency")
> 
> I have added the following partial revert for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 1 Feb 2019 13:37:59 +1100
> Subject: [PATCH] firmware: intel_stratix10_service: remove COMPILE_TEST
> 
> This does not build yet ...
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/firmware/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 7e5491aed5c8..cac16c4b0df3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
>  
>  config INTEL_STRATIX10_SERVICE
>  	tristate "Intel Stratix10 Service Layer"
> -	depends on (ARCH_STRATIX10 && HAVE_ARM_SMCCC) || COMPILE_TEST
> +	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
>  	default n
>  	help
>  	  Intel Stratix10 service layer runs at privileged exception level,
> -- 
> 2.20.1
> 
> -- 
> Cheers,
> Stephen Rothwell


Thanks, I've added this to my tree now.

greg k-h
