Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C72CC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC02086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="SsHJKjAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbeLOPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:10:28 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47742 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:10:28 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 899A325AD76;
        Sun, 16 Dec 2018 02:10:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544886624; bh=29RLGCxGCFhYuv+baaInVTGEOHIyPnagRONXiomE4C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsHJKjAED5PK/r1xR7bZ3wbOWG7Fh7pTS3llWFNgYyfmuLJqyNrlBtzRVXSYq7H4Z
         ciEoS/4x3NlKIPi3Gop3nA2VQlq6Vp5BzUCIDs4LgaIbuqP//swkHGYvo3/SxREwoR
         XvjqPJ5kBXBCpIjRyTyhVyoGoBvc+Re1JycxmB2Y=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 3FCF2E20E06; Sat, 15 Dec 2018 07:10:22 -0800 (PST)
Date:   Sat, 15 Dec 2018 16:10:22 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 0/9] RZ/G2E basic device tree
Message-ID: <20181215151017.2wqpiwvd7texfk7e@verge.net.au>
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:10:04AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this series adds a basic dtsi for the RZ/G2E (a.k.a. r8a774c0).

Thanks Fabrizio,

This series looks fine to me but I will wait to see if there are other
reviews before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> Fabrizio Castro (9):
>   arm64: dts: renesas: Initial device tree for r8a774c0
>   arm64: dts: renesas: r8a774c0: Add SYS-DMAC controller nodes
>   arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes
>   arm64: dts: renesas: r8a774c0: Add INTC-EX device node
>   arm64: dts: renesas: r8a774c0: Add PFC support
>   arm64: dts: renesas: r8a774c0: Add GPIO device nodes
>   arm64: dts: renesas: r8a774c0: Add Ethernet AVB node
>   arm64: dts: renesas: r8a774c0: Add watchdog support
>   arm64: dts: renesas: r8a774c0: Add secondary CA53 CPU core

My usual question regarding SMP enablement: to what extent has this
been verified with respect to CPU hotplug and Suspend-2-RAM ?

>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 649 ++++++++++++++++++++++++++++++
>  1 file changed, 649 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> 
> -- 
> 2.7.4
> 
