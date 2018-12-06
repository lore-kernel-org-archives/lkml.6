Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35804C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66BA20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Gmlb/Peq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFZ1Gbtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66BA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeLFFmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:42:32 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37483 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728648AbeLFFmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:42:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B017722195;
        Thu,  6 Dec 2018 00:42:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 06 Dec 2018 00:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Fv+xuuNHqHCC3DhGzwxSXAV9Njt
        fKYV/fpkZdld60mk=; b=Gmlb/Peq+QhlwyMjSmLBzjNeLZmjoJ4bo6s6PLdsJux
        g+DJKma7oXs8L7YoOfFa7JrILiU8iRxoVHP3wiRfAUt/ePJ5ru+0aXX+0ASidLO+
        EvmtieHrUcaS5ndXOZURfZfbECnS2eVhsFkuBoxbl6u/ATusv0AlJ7FkmhkHTROF
        RamCldYQoVbhUeHH35US4UWFQcunISjyymCsbHY8bbS06EOZLXUa2e5M8KOU9y48
        Oc1bnDmwUrpp2e1XaIwqs2bjaSlOgdnEzILkB6Pv90p5EjyoeGNVCW5W5ZQHk0yB
        UHQCeNybhRJGaKbH4kMifWr9Vydvxw5OSJo1nWOw9Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Fv+xuu
        NHqHCC3DhGzwxSXAV9NjtfKYV/fpkZdld60mk=; b=kFZ1Gbtr1U9hTg/ZcuDlKV
        VuIx55G8mr03gR5gueZA4ooqWs2r9tO/RcM9oSqPp7hqKch1SRuxMmmdJxfCJ8HE
        8uFe4TMWbPbPX2kxa0Au9TRSi3W4E8jhoN6POI/dTHCRO2jf7UJaylH87ia4lkzV
        d0uKdW/dGea8cWJhgYPXP6ozgdzoC04056XMlNSeLADVojQKmrXFa2WFabnaX0i1
        KGq88mKUcvML3fiN3e/BDEJgy8MFROYYLDddJOqLZlZF6eFsU2i1SfDuLr+EMTvj
        MZeuMQbJvNqe/Yib5p3dEwaoh0h2wQDdZmB8YQyU+0Nn1an/ctayA3FmO8PugmMg
        ==
X-ME-Sender: <xms:xLYIXIkcR0uOPBAP1gvHorW_VOWatIoFfAtUeEgFxiZozrLvHrA7kA>
X-ME-Proxy: <xmx:xLYIXBo6cF-G6CBYug0zyUVF2Pd4VLapW7AHQkxMKIVQ2atR1dsQ9A>
    <xmx:xLYIXBcnFGzY2r9DJTGGFTsuQSW23vgLaj_WFT_Ou-iBB0co-LeTsg>
    <xmx:xLYIXIqEKMgKT6PowCm7qHKyN2ahn-tjLfx_syu3WaMKKJQBUD9WrA>
    <xmx:xLYIXKG4IspOCrw9F57Dimdk8nwJ6N7m6k8-fr2Meav7nmlEhmwHyQ>
    <xmx:xLYIXAtWAJ0JKta0VkGFJO7lWfuN0_ZN2f_-C-9E_ybrtKNooFFCrw>
    <xmx:xrYIXFD-0xCTWFp2c6wZZUpv5o464o6vuSeg7qXt-GdjDT9FiyzfrA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D0217102DD;
        Thu,  6 Dec 2018 00:42:27 -0500 (EST)
Date:   Thu, 6 Dec 2018 06:42:24 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: linux-next: manual merge of the char-misc tree with the mmc tree
Message-ID: <20181206054224.GA12239@kroah.com>
References: <20181206154800.760ff17a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206154800.760ff17a@canb.auug.org.au>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:48:00PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   drivers/misc/Makefile
> 
> between commit:
> 
>   4eb78924bf0e ("misc: cardreader: add new Alcor Micro Cardreader PCI driver")
> 
> from the mmc tree and commit:
> 
>   fcb418cd567f ("pvpanic: move pvpanic to misc as common driver")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/misc/Makefile
> index fe3134cf3008,b76d611c87de..000000000000
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@@ -57,4 -57,5 +57,5 @@@ obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed
>   obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>   obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>   obj-$(CONFIG_OCXL)		+= ocxl/
>  -obj-$(CONFIG_MISC_RTSX)		+= cardreader/
>  +obj-y		+= cardreader/
> + obj-$(CONFIG_PVPANIC)   	+= pvpanic.o

Looks good to me, thanks!

greg k-h
