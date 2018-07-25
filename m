Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE78AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6977B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiRdDy2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6977B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbeGZBCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbeGZBCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:02:35 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDCD020843;
        Wed, 25 Jul 2018 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532562513;
        bh=FoRKg/Sq0t8+1gjJDbUD5HJ2ADhc8HGalp5IiYD8xjE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kiRdDy2UG7Xz9g/AwsTzf4w7qF1HUC+3ltlJwsG91cB0450Sn8hloy2kV3vzinpya
         bDmhHN9pcaKEX/g67Inla558pV0diabK8YWZmgjAZcK/mSChuY5l6CSXr0kYYccGgB
         wP19Lkve6x2hLE6PUB09AcXYMTK4GhVCI5T6VOIE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180725155517.4872-2-krzk@kernel.org>
Cc:     stable@vger.kernel.org
References: <20180725155517.4872-1-krzk@kernel.org>
 <20180725155517.4872-2-krzk@kernel.org>
Message-ID: <153256251231.48062.2127272830110571402@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] clk: s2mps11: Fix matching when built as module and DT node
 contains compatible
Date:   Wed, 25 Jul 2018 16:48:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2018-07-25 08:55:15)
> When driver is built as module and DT node contains clocks compatible
> (e.g. "samsung,s2mps11-clk"), the module will not be autoloaded because
> module aliases won't match.
> =

> The modalias from uevent: of:NclocksT<NULL>Csamsung,s2mps11-clk
> The modalias from driver: platform:s2mps11-clk
> =

> The devices are instantiated by parent's MFD.  However both Device Tree
> bindings and parent define the compatible for clocks devices.  In case
> of module matching this DT compatible will be used.
> =

> The issue will not happen if this is built-in (no need for module
> matching) or when clocks DT node does not contain compatible (not
> correct from bindings perspective but working for driver).
> =

> Note when backporting to stable kernels: adjust the list of device ID
> entries.
> =

> Cc: <stable@vger.kernel.org>
> Fixes: 53c31b3437a6 ("mfd: sec-core: Add of_compatible strings for clock =
MFD cells")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

