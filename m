Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3E1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C9720652
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PhbAD0B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C9720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeH0Qlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:41:47 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50363 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeH0Qlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:41:47 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9884525BEEB;
        Mon, 27 Aug 2018 22:55:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1535374512; bh=40eRKJqmLNyBQHEKsYChyCc9DmtULuneFyzxjlOoOWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhbAD0B2g+8RcbXzjCkVRa24/dXi17FFqraNBJVQac0oc4bd0ULgQ6PSIrjXyBM3T
         AIzYVjGzwsh0SopPhbUrSS3jWb/pYvmg5FUFH+l1dN7GVOoYH6D15rMLmTDZ7NEEyo
         3+xl1beilimRX0o5E1ONIJhkTB4Xh66Ms4Ws7QHE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6C54F9404AF; Mon, 27 Aug 2018 14:55:10 +0200 (CEST)
Date:   Mon, 27 Aug 2018 14:55:10 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Message-ID: <20180827125510.ahpk6basgrxbzq6i@verge.net.au>
References: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
 <TYAPR01MB2285834E95AB0D0D3E2C5B72B7300@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20180824082643.7eapxf72iuvkdw3j@verge.net.au>
 <TY1PR01MB177055864EEAD487C2917860C0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB177055864EEAD487C2917860C0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 08:31:42AM +0000, Fabrizio Castro wrote:
> Hello Simon,
> 
> Thank you for the feedback!
> 
> > >
> > > In theory CAN could be broken if renesas,can-clock-select is set to 0x1
> > > (clkp2) in the DT, as this value will be written to the CAN Clock Select
> > > Register. However if the documentation is followed there will be no
> > > problems.
> > >
> > > We should probably update the driver to fix this though, which will be a
> > > change specific to all RZ/G2 devices, so perhaps we should also be adding
> > > a "renesas,rzg-gen2-can" family compatible string as well? (to driver and
> > > documentation)
> >
> > Yes, I think that sounds reasonable.
> >
> > But in that case we should pre-emptively not use renesas,rcar-gen3-can for
> > RZ/G2.
> 
> What do you think about the following:
> https://patchwork.kernel.org/patch/10573795/
> https://patchwork.kernel.org/patch/10573791/
> https://patchwork.kernel.org/patch/10573805/

I think that is the right approach.
