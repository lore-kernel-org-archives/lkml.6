Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F4C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5BC25039
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Q0N0Pa8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sca7W9sD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5BC25039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeGAInw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:43:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57177 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752062AbeGAInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:43:47 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 283BF218B4;
        Sun,  1 Jul 2018 04:43:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 01 Jul 2018 04:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JBg6plJDIozzDp5xops7guJI+B8W2AdPmTKimEtU+kg=; b=Q0N0Pa8H
        zxnaAK/Qor/HlTKxsw5sbG4RNcrdjQjvztk2BNsT5Tnkc9A61uMfzH3CQ/qYf7kW
        cvhK+ui+c/L/OnkxPu8VeztUKH0ixP9pLIml40/imdCXLi9dzAXKhBpaojByXios
        WZDCD+sIfWPmCc6yAixiVziRU20+cJBMTmf+dTISuEiLi+RQTFx8k8Isv5+1t/15
        vpNLCI/DWXimdwAYzJSu2n1xh+SAx9lQuvsb7HLO5Ne/UmkuanoGcgXrWj3S/PZ2
        dzLKiWtQpE9r69XYBUIv/GlGXEZQKD6HRZ9DPGIgZcY20MeIjkD+fKU5rk1l0nJa
        W46Pb4lKQWwXyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=JBg6plJDIozzDp5xops7guJI+B8W2
        AdPmTKimEtU+kg=; b=Sca7W9sDVEfoxbESZhMdL6ZQeb3n1vYjkm+vNm2jfkpOR
        A57VHq261kt+/CFskv0j8GDCe/0eQ6BSSwjSR3s7ULOH+08kD/yDhO69lBYTUqFo
        u27OJGhOdTYYdLJtonY3YVu7Q/GCW71+aOdkxVLx122/mOHZZxXNdkLhtyjurJtY
        w0wCaOJMjVbBqAher34KvS4k3I1t/gwLVeNESaf4TaEjdW6o4v1KXDSUBFyEU1YE
        ak7bTMLrBdlg52OO4kwnL1kAVCDn8Ac3t7E6YFMtcggsfosqqJJj9RtvxjmkyDCM
        x5p75G2ctB+kehk7id+OPbM63FbnykpiC1sEpgZqw==
X-ME-Proxy: <xmx:QJQ4W3HY13lKXNmCPGYTW_mZHYfJ0b4RtVo7ZR5UKy00wU_uj58_qQ>
    <xmx:QJQ4WydYevc8cB1lwMxnQWJa8K0Q4FsaL9c44W7Abb1M21w-td1Qnw>
    <xmx:QJQ4WzvqNRgFsLK5IoNoC__OQp1aFm2PZS-SwwnF44UDaMtACUFmeA>
    <xmx:QJQ4W5nTbWEUTE_aTRVT7kiua6DbHZr87PigcBHR3ISfpdPZcxIJhQ>
    <xmx:QJQ4W-CXmzbTze4Om02C5QtmQoBTo65rfhMFla-tcftHxgi-B18u5A>
    <xmx:QZQ4WwNzs68lZqyrsSG_g2nOPESWR9_R_yCyVHxVA9C0dolMs0UukQ>
X-ME-Sender: <xms:QJQ4WyyI9ipEiRcBmLuY1nivLSRyJ-GXhINrZrhPOFePBocQClYtqA>
Received: from localhost (lfbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95108E425A;
        Sun,  1 Jul 2018 04:43:44 -0400 (EDT)
Date:   Sun, 1 Jul 2018 10:43:43 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Li Jun <jun.li@nxp.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <20180701084343.GA12939@kroah.com>
References: <20180629145719.0d7b8fe7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629145719.0d7b8fe7@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:57:19PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/staging/typec/Kconfig
> 
> between commit:
> 
>   e16711c32bca ("staging/typec: fix tcpci_rt1711h build errors")
> 
> from the usb.current tree and commit:
> 
>   990da41530b3 ("staging: typec: tcpci: move tcpci drivers out of staging")
> 
> from the usb tree.
> 
> I fixed it up (I removed the file and allpied the patch below) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 29 Jun 2018 14:54:04 +1000
> Subject: [PATCH] usb: update for tcpci drivers moving out of staging
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 972fd1911045..ee808903983f 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -65,6 +65,7 @@ config TYPEC_TCPCI
>  
>  config TYPEC_RT1711H
>  	tristate "Richtek RT1711H Type-C chip driver"
> +	depends on I2C

Thanks for this, I'll apply this to my tree when I merge these together
in a few days.

greg k-h
