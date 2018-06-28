Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC37C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC927347
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Q41G5//V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CC927347
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeF1MST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:18:19 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53739 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeF1MSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:18:18 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 434C025B7A3;
        Thu, 28 Jun 2018 22:18:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1530188296; bh=eMiYzt/6JFKk5zMvKzVGGeEP3eSf04zaCHrvDO0Oox4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q41G5//VLCE2z2V6ZdrqODapuUlCeblET/BOhf3zw3Bft/F+cQ0wsinDbvGn3+l63
         lh7TFt0NXyD0K/m/BqeOf1wfMRLGte+pRQWds3MmRpc/HKAY/zNyJs+ghaNMEtbv6b
         rZh5ig1SwyJV6VslKdW85UoZ/9FSF7dYreO2RPOw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 3219A940760; Thu, 28 Jun 2018 14:18:14 +0200 (CEST)
Date:   Thu, 28 Jun 2018 14:18:14 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Carlo Caione <carlo@endlessm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] ARM: dts: Renesas R9A06G032 SMP enable method
Message-ID: <20180628121813.ffrppdo7p3s42t5i@verge.net.au>
References: <1530173842-56851-1-git-send-email-michel.pollet@bp.renesas.com>
 <1530173842-56851-4-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530173842-56851-4-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:17:14AM +0100, Michel Pollet wrote:
> Add a special enable method for the second CA7 of the R9A06G032
> as well as the default value for the "cpu-release-addr" property.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.

I had to manually resolve a conflict due to updates to the patch
that added this dtsi file (as noted elsewhere). Please check that this is
correct.


From: Michel Pollet <michel.pollet@bp.renesas.com>
Subject: [PATCH] ARM: dts: Renesas R9A06G032 SMP enable method

Add a special enable method for the second CA7 of the R9A06G032
as well as the default value for the "cpu-release-addr" property.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 339d0958011e..afe29c95a006 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -29,6 +29,8 @@
 			compatible = "arm,cortex-a7";
 			reg = <1>;
 			clocks = <&sysctrl 84>;
+			enable-method = "renesas,r9a06g032-smp";
+			cpu-release-addr = <0 0x4000c204>;
 		};
 	};
 
-- 
2.11.0

