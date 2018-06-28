Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B401C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F52730F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="CNF3vIFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8F52730F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbeF1MAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:00:38 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53477 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeF1MAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:00:36 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6735225B7A3;
        Thu, 28 Jun 2018 22:00:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1530187234; bh=G8fVmF538MDPEKSonpsvcK7XC0tq8PePZuEjuXmL3XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNF3vIFz4X44qxzdgcq5KD/6dypWIFKfJqAl0XSQphF7xZ2JYiK66zuzaZzsjeC1V
         LQTAionEldiwWae4mEl7LBjZUA9efOONSHU0iVTChq2rV5MVi+fMjOTU50KLs/80fg
         eIB0dNDb3UYwqobF8eTNWnb2tIgwdf0+dPJN1Coc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 4F8A1940760; Thu, 28 Jun 2018 14:00:32 +0200 (CEST)
Date:   Thu, 28 Jun 2018 14:00:32 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] ARM: dts: Renesas R9A06G032 base device tree file
Message-ID: <20180628120031.eq2yuysz4re2olwn@verge.net.au>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:56:32AM +0100, Michel Pollet wrote:
> This adds the Renesas R9A06G032 bare bone support.
> 
> This currently only handles the SYSCTRL block note,
> generic parts (gic, architected timer) and a UART.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied with the following appended:

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..4c85ac04872d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1969,6 +1969,7 @@ S:	Supported
 F:	arch/arm/boot/dts/emev2*
 F:	arch/arm/boot/dts/r7s*
 F:	arch/arm/boot/dts/r8a*
+F:	arch/arm/boot/dts/r9a*
 F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
