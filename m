Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF782086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hpRIPvTG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgFmAHml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF782086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLLI3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:29:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59159 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbeLLI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:29:54 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B83752318F;
        Wed, 12 Dec 2018 03:29:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Dec 2018 03:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9O84dMbu4oo1mtg/9dEPCMOREy3
        zp7D2cmD82xIrezY=; b=hpRIPvTGAxgM+tr/8SWCk+ilXEhra03PsAm6fCQxqVf
        dYqRaFkgo4wuhxgLh1yB2vzo28UQTzaQz6NxlzkIMZD4NUqnf8KVQMN2LNgyWC1A
        VwjVFGSne9oAp3YqscHLV47wEiRxM56RGcIMP86tYjxzcEQcEL2ZA701K5Mw0vmK
        y/0fpTKmYvXwKhI3uyaMGKYQvO9yy72ezsPd1PHAP1lRuCxo+FbmLcX7mSM9hpFB
        JopQ0M2X6bUgkifTY9DBUoqCBM3M1CbzzYdZ1fDQ9oiAa7DH0n1CR15+xBT1mYqT
        xnaKAcRNQFHDhE/3phmO+tR4lY8Amlp11TyFTkg097Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9O84dM
        bu4oo1mtg/9dEPCMOREy3zp7D2cmD82xIrezY=; b=LgFmAHmlJuazULaY2UnUf2
        /aMB5j+k7/eegOal2nFuZsRaWcn+18QGFoA5mV+YuuPF1zf6hoEWstv2DdyIlXYX
        69dat7dFZ+/e6gknFau2iDRibGj6x7ZMFjCNaE0inThehJ3Ma46tK79RhTj+z7Fe
        d8Fv67oOd9X3jfEs6aWnsgbk6Aj9W3V0u0/crOADImXxzUCIycxnAWOmRuy7dBwG
        6cJc8I7cMRvTuoWgHdmd8Wz20YUFuIYiw5cs+szur+IX/mJ19H6ig1ary2L3PMMF
        Ctj9MbrLTmFW3csurJ0mEFXvWWDi7asL3osfQ3l6JWWxxrCRUPXtMooGeMRTzJCw
        ==
X-ME-Sender: <xms:_8YQXMWrdfH01Jod2h0j1Fbf_ZnXP5qEAqcl0xz92Jp_ha2irMluMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudegkedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukf
    hfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghes
    khhrohgrhhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepke
    efrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhr
    ohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:_8YQXCim5SuXMSHarrJGC0mZmwb3U7qC9As-IyGlIR79K5uNtrJ3lA>
    <xmx:_8YQXMoyO10RKxB18ob_V20GX-HWC1dLCpu35XG-qpH3h8oY4gFHcA>
    <xmx:_8YQXNiDcwy0j4fGfb9e_0Bx_BtBqBHas8QbtElJezB9nliHdg9VjQ>
    <xmx:_8YQXCITy16IJj-Fej5LnKw8EwPSO4AM1yCiXUUiqBMflvBArI52eg>
    <xmx:_8YQXK4P1un2_9nhmsoRXUjzWVgJVPcMx70pdpUouKB9ct12v3CV5w>
    <xmx:AMcQXJApc1OvhliTzF_wOly4iBOzywliLxfuOYAkr-DljOM57OA9kw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0E74102A0;
        Wed, 12 Dec 2018 03:29:50 -0500 (EST)
Date:   Wed, 12 Dec 2018 09:29:49 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the
 char-misc.current tree
Message-ID: <20181212082949.GC13212@kroah.com>
References: <20181212120252.5260cb22@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212120252.5260cb22@canb.auug.org.au>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:02:52PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   cb4f131e1f2c ("MAINTAINERS: Patch monkey for the Hyper-V code")
> 
> from the char-misc.current tree and commit:
> 
>   b255e500c8dc ("net: documentation: build a directory structure for drivers")
> 
> from the net-next tree.
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
> diff --cc MAINTAINERS
> index 4a2a30380bed,a676b40ac1d6..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -6930,11 -6902,9 +6931,11 @@@ Hyper-V CORE AND DRIVER
>   M:	"K. Y. Srinivasan" <kys@microsoft.com>
>   M:	Haiyang Zhang <haiyangz@microsoft.com>
>   M:	Stephen Hemminger <sthemmin@microsoft.com>
>  +M:	Sasha Levin <sashal@kernel.org>
>  +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>   L:	devel@linuxdriverproject.org
>  -S:	Maintained
>  +S:	Supported
> - F:	Documentation/networking/netvsc.txt
> + F:	Documentation/networking/device_drivers/microsoft/netvsc.txt
>   F:	arch/x86/include/asm/mshyperv.h
>   F:	arch/x86/include/asm/trace/hyperv.h
>   F:	arch/x86/include/asm/hyperv-tlfs.h

Looks good to me, thanks!

greg k-h
