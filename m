Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3CFF0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66C72086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CbltW3w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934600AbeFLWBx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:01:53 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:65416 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFLWBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:01:50 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5CM1QxU003279;
        Tue, 12 Jun 2018 17:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528840886;
        bh=h1yClt9nfF8rsruUUxn+qIC1kgaq7QdvKsgHdVo03Fc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CbltW3w9eQAyFKS2hcgGj4jyFQpZnaVzC4wedp3pxxbupk5PAYpDaZUyS5jDnGUCc
         elLg04NLLvAfOvzmJX2CCXpBvzlYzWP5YdXvHBXlae76YpFvrO0m5ACFLikOVX4uYK
         gotADl05FyczY3Bgm3hbDxnrIjtSincDuM/nO4Rw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM1QnF010344;
        Tue, 12 Jun 2018 17:01:26 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 17:01:25 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 17:01:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CM1P04010342;
        Tue, 12 Jun 2018 17:01:25 -0500
Date:   Tue, 12 Jun 2018 17:01:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 1/6] Documentation: arm: ti: Add bindings for AM654
 SoC
Message-ID: <20180612220125.3scgr6by62wifirp@kahuna>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-2-nm@ti.com>
 <20180612210519.GA17653@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612210519.GA17653@rob-hp-laptop>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:05-20180612, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:01:20AM -0500, Nishanth Menon wrote:
[...]
> > +Boards based on K3 Multicore SoC architecture shall have the following property:
> > +- compatible: Every hardware block introduced in K3 Multicore SoC
> > +  architecture shall be of the form:
> > +  "ti,XXX-YYY", where:
> > +     'XXX' represents the specific SoC part for which the support is added.
> > +     'YYY' represents the corresponding peripheral in SoC being supported.
> 
> No need to explain standard DT convention here. (But I don't think we 
> have this convention documented anywhere, so patches welcome. :))
> 

Thanks. Will drop off from my series (will skip the generic dts
convention for now ;) ).
-- 
Regards,
Nishanth Menon
