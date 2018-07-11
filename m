Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE2E2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="275u/73o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TLFmeXYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE2E2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeGKLCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:02:03 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43641 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbeGKLCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:02:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 83F18293;
        Wed, 11 Jul 2018 06:58:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Jul 2018 06:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Sm+Bj0tworHjs83kFkJY19zewtLvt3O5uoQ1e4WM26o=; b=275u/73o
        JnhrMJ+bArDEAI9JKsSTB6x9nGDA46bblS1MhbwuJVmvXckFbgouoUNjCOcBLmOJ
        ABg9LciQ3PnF8rzrVfejUc2FhU2TCHbcc1j91wMDwmc6mQsb+GUwX3hfwdt1oDU7
        rpyFHn89J7x7R4ep0p56bbji83Vtd32kW5cf85pLerN6082N6nOYfBS6dHxjG91b
        1EkVhtLYrefU2IECChU/FIRagTzjkhN0Whry3IsHsfr6oWTm3WYhSEdKBHxOwaLZ
        YSMGkuJ8jP5Cbhop5jSisdlUGXC2GfrE/OJP20P0RCvilMCK8WmFuGjLmY3pkMER
        kyPmFbEKdmC5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Sm+Bj0tworHjs83kFkJY19zewtLvt
        3O5uoQ1e4WM26o=; b=TLFmeXYN7gdV6RyDhuoQxswM0ZuBUCu3as5WeUClpx+8S
        ZHyv9ZNMJu8TDbeeYusiVp+Rtv0CWdmuVzAIflPLjKGJrllKSU7hOHkmFWu/NIya
        artXIoXzZ4BYsGYOIxtd+mlLA+40DaE3VPtRiENiQUhoS9HYMjHtUOHIszGEDHrO
        AKpNGsVFlmBrec/4qEMRDCe8KXFz2JQBzozc3gcF/HLcZJHvyS1M73v6y6e2Ux+T
        7iPVhjkNDpqJ4l4lkk4ZbF2R3B46PzKaR7o88WYiwuZkOs36brtdFXgPgYkaRYIF
        mT42Qg35V4Jk5BMGqL46qGSyr/jC3VR3geIGkQcrQ==
X-ME-Proxy: <xmx:xuJFW5NiH7SJck_JdmxhsA2CxMumnbyVMiC_y0a38WKXpBSAOFSuMQ>
    <xmx:xuJFW8ImxvrwfUUqUhCceWuGIEZoSkRHRPhNwdalpgjTB-N4rm28lw>
    <xmx:xuJFW64x7BcRax20lf5NfuYlxehXikKB6k0VaRvZKghb1FauenfjXQ>
    <xmx:xuJFWxRyG2vgO00b-ciRi5I-Jh5yw_0Ip16Q9CEkdtkPd6BuwdEhrQ>
    <xmx:xuJFW1d_f5putO9gJ2ZPuTZt5ddNP0snQzluORRsgvspXsGR53TqJg>
    <xmx:yOJFWzv_5ql0KE68KF-9534OOwytH7c0HT0Qb-zmv-5_rPVfI6J4oQ>
X-ME-Sender: <xms:xuJFW7784AGqdB44DegkAt7bLZZ3jPm5Ap0rrhiJwxFAiRuwQ0VWhw>
Received: from localhost (lfbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77DADE471F;
        Wed, 11 Jul 2018 06:58:14 -0400 (EDT)
Date:   Wed, 11 Jul 2018 12:58:13 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <damm+renesas@opensource.se>
Subject: Re: linux-next: manual merge of the driver-core tree with the iommu
 tree
Message-ID: <20180711105813.GA18417@kroah.com>
References: <20180711131445.7e1e211b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711131445.7e1e211b@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 01:14:45PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   drivers/iommu/ipmmu-vmsa.c
> 
> between commits:
> 
>   0b8ac1409641 ("iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code")
>   3701c123e1c1 ("iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code")
>   98dbffd39a65 ("iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code")
> 
> from the iommu tree and commit:
> 
>   ac6bbf0cdf42 ("iommu: Remove IOMMU_OF_DECLARE")
> 
> from the driver-core tree.
> 
> I fixed it up (I removed the new IOMMU_OF_DECLARE() lines) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

Resolution seems sane to me, thanks.

greg k-h
