Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F231C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418A1217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h1nNGVbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418A1217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeHUUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:24:17 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43816 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeHUUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zi6h06Uuh4XJP1dgAZEsDzpIW68fzD8Tm+WXbYBvIxU=; b=h1nNGVbCJP6oMonPfyBrnGjh2
        UH2DG/WpXt4NmkoEgVG8D3RrYkoQiEu355Sur9HSLoH/bc3Y1iwa/POMCMB6LzF1D48YP4DoXnX6C
        5NEvXMmaXgAI7dx1ZSVBEP+KRE2kOXVUOJ6uPkPLVYeHKakggar2ql58SUHb+fDroqGDc=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:38704)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fsA3W-0002JI-K8; Tue, 21 Aug 2018 18:02:58 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fsA3T-0001eI-Qn; Tue, 21 Aug 2018 18:02:55 +0100
Date:   Tue, 21 Aug 2018 18:02:53 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "cdall@linaro.org" <cdall@linaro.org>
Subject: Re: [RFC PATCH] ARM: Debug kernel copy by printing
Message-ID: <20180821170252.GA30658@n2100.armlinux.org.uk>
References: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB177010920A6FC7FC1B61358BC0580@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <nycvar.YSQ.7.76.1807171552380.20892@knanqh.ubzr>
 <TY1PR01MB1770DD78CD0DC472245FA6E9C0310@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770DD78CD0DC472245FA6E9C0310@TY1PR01MB1770.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:56:19PM +0000, Fabrizio Castro wrote:
> Thank you Nicolas.
> 
> Russel, does it look ok to you? Do you think you can apply this patch?
       ^^
Grr, please be more careful in the future, thanks.

Patches need to end up in my patch system, otherwise they're likely to
be lost.  Details in my signature below.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
