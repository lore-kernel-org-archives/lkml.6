Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF82C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA492081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="R9wNjINL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA492081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeLDOom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:44:42 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:43051 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeLDOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:44:41 -0500
Received: from penelope.horms.nl (96-64-203-130-static.hfc.comcastbusiness.net [96.64.203.130])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D314525B71D;
        Wed,  5 Dec 2018 01:44:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1543934679; bh=1mSr7w+NpDI1/SkgE/+vtKedcg/AjBheIWDHTAMWjio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9wNjINLQ1TQ+37fBRhGHsn4De5SQanxmpEXube8X+RY70yYwCrgraSrLmy3UWx5E
         2ccCxrrzMy1IW3XQqvpwmcuezDbPBfxLzbkwX8iH6b3vJIEy6vivadhG8MakQayAlT
         xw3NdUxh6LmkNXrb80xwzcS60JbsCM3QpuDQ6Dew=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 07FB2E217E3; Tue,  4 Dec 2018 06:44:35 -0800 (PST)
Date:   Tue, 4 Dec 2018 06:44:35 -0800
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 25/34] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
Message-ID: <20181204144434.cin5sbg6gd27enf3@verge.net.au>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-26-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-26-robh@kernel.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:32:14PM -0600, Rob Herring wrote:
> In preparation to convert board-level bindings to json-schema, move
> various misc SoC bindings out to their own file.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/renesas,prr.txt   | 20 +++++++++++++++++++
>  .../devicetree/bindings/arm/shmobile.txt      | 18 -----------------
>  2 files changed, 20 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

Applied for v4.21, but should we add renesas,prr.txt to MAINTAINERS
as a follow-up?
