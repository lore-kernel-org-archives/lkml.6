Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF1AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BBD21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Aj9/vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BBD21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJQFhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeJQFhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:37:54 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BAE621471;
        Tue, 16 Oct 2018 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539726333;
        bh=eK7QjIEVlvLhc5//yJpnhu3HtlieMif72hnuLD9YrwY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=t6Aj9/vRcQZLL+psFz6hOs1/wArrP15MVE0RK5zqr/C2Cr7nsXMRcDQoDwcfxUroH
         uP4MtwSQtKXz6cW0RlwSHOAujzQk+euVj3XCyCsXxv0mi7RWt2oV6egLShcU6GkDDe
         7jp4rDXqpaW90MV7quyW+1Zp825IVvAmBp60+qsw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sangbeom Kim <sbkim73@samsung.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180829192010.14182-1-krzk@kernel.org>
Cc:     stable@vger.kernel.org
References: <20180829192010.14182-1-krzk@kernel.org>
Message-ID: <153972633244.5275.13938528417819448345@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: s2mps11: Fix matching when built as module and DT node
 contains compatible
Date:   Tue, 16 Oct 2018 14:45:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2018-08-29 12:20:10)
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

> The issue will not happen if this is a built-in (no need for module
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
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> =

> ---

Applied to clk-next

