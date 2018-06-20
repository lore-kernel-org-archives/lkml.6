Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13592C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C339B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="H6orUxUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C339B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTL3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:29:22 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:58986 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeFTL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:29:18 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id CFFB825B7FB;
        Wed, 20 Jun 2018 21:29:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1529494157; bh=0i3UnQ0Ke8VeGhpjUM/MDYStCSVZml5/Xdr59KsEEB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6orUxUde58PncRhwSVMXitSADLCPhRyLCRKzf63qKLNx7jfYn594i9PXC6V+xco3
         Tx06YRJsTLg3zcFl8/390ZfSYNpYmwGusAXCy4EO3RjyPZ8lZAQf4tBGhCXGWqyB7Q
         Tw6QByb5QlbE2bsFtc6gFlEqC5uuXCnSE8/LBjjc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B2D529407DF; Wed, 20 Jun 2018 13:29:14 +0200 (CEST)
Date:   Wed, 20 Jun 2018 13:29:14 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     geert@linux-m68k.org, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org,
        linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RESEND 0/6] iommu: ipmmu-vmsa: Add more Gen3 SoCs support
Message-ID: <20180620112909.gzbdpj2kwcehebnx@verge.net.au>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Alex Williamson]

On Thu, Jun 14, 2018 at 12:48:20PM +0200, Jacopo Mondi wrote:
> Hello,
>    this series collects patches sent to mailing lists in late 2017 to add
> support for a number of R-Car Gen3 SoCs to the ipmmu-vmsa driver.
> 
> Part of the series these patches were part of went in through Alex Williamson
> tree and are now included in v4.17.
> 
> These patches have not yet been collected, and need to be rebased on v4.17,
> and this what this series serves for.
> 
> The series:
> - Increses the micro-TLB size to 48bits to accomodate newer SoCs
> - Adds support for M3-N, M3-W, V3-M and E3 to ipmmu-vmsa driver
> - Documents M3-N, V3H and E3 device tree bindings
> 
> All patches have been acked/reviewed by, if nothing big happens they should
> be ready to be collected.

All patches:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Joerg, Alex,

I'd be most grateful if we could find a way for these patches to progress
into mainline.

> 
> Thanks
>    j
> 
> Jacopo Mondi (2):
>   dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
>   iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code
> 
> Magnus Damm (3):
>   iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
>   iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
>   iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings
> 
> Simon Horman (1):
>   iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code
> 
>  .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  3 ++
>  drivers/iommu/ipmmu-vmsa.c                         | 38 ++++++++++++++++++----
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> --
> 2.7.4
> 
