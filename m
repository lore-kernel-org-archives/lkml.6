Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C68C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFC320827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="B0O4p6nB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFC320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeKHWUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:20:55 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:45322 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeKHWUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:20:54 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E0F4A25BE2C;
        Thu,  8 Nov 2018 23:45:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1541681133; bh=UoBplw5AQMTQw9qV+OrPiuQqAJdCNgg3bA8rXlPMrs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0O4p6nBR6GszNMkbFzGAw0wKBMQm3Rt3GZXnTuJI+g72T76MnfZ07c3hHWlW992T
         Mskl/cCcmnE2LL9dQNKAsu1sBpYLtf7nr4wtRVi5gqbMVWgDm2vB8VMj+pScYc2kwK
         frvY6Tehx7aj92bvmTiMSKgOdpNv24/rq0NtmVu4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D29F094057D; Thu,  8 Nov 2018 13:45:30 +0100 (CET)
Date:   Thu, 8 Nov 2018 13:45:30 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Message-ID: <20181108124530.dgbucminxi3z63gx@verge.net.au>
References: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB177011B91A9CA579E01760A4C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB177011B91A9CA579E01760A4C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 11:23:58AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> Who is the best person to take this patch?

I believe this one is also for Joerg.

> Thanks,
> Fab
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 17 August 2018 15:31
> > Subject: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
> >
> > Document RZ/G2M (R8A774A1) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > This patch applies on top of next-20180817
> >
> >  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > index ffadb7c..68446dd 100644
> > --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> > @@ -13,6 +13,7 @@ Required Properties:
> >      - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
> >      - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
> >      - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
> > +    - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
> >      - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
> >      - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
> >      - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
> > --
> > 2.7.4
> 
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 
