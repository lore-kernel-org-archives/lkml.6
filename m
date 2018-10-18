Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA092148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5TEM1QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA092148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeJSBVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeJSBVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:21:52 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9CB21479;
        Thu, 18 Oct 2018 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539883195;
        bh=dR6l4E4hpCwpSb1qkmCbuUOp9IPqGSsQzHeYzhv+RUg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=K5TEM1QC6/7h7QGPv5GluS3uKR4n2tF+YehheAC7NLbzb+bz/ySUUR99D4iMZoddR
         nxR1o0HA4f+JGnuyghnVu/8T4MH0iQbJjLlwwa7onoP8sPzbUIES2pcKkyBulO0Wrf
         qrT2UHWEwmZx/JQKofvbTuyEX6yyR2oo/d991jxw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181018070729.52943-1-icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
References: <20181018070729.52943-1-icenowy@aosc.io>
Message-ID: <153988319489.5275.13596491306786109572@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: sunxi-ng: enable so-said LDOs for A64 SoC's pll-mipi
 clock
Date:   Thu, 18 Oct 2018 10:19:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Icenowy Zheng (2018-10-18 00:07:29)
> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
> register is called "LDO{1,2}_EN", and according to the BSP source code
> from Allwinner , the LDOs are enabled during the clock's enabling
> process.
> =

> The clock failed to generate output if the two LDOs are not enabled.
> =

> Add the two bits to the clock's gate bits, so that the LDOs are enabled
> when the PLL is enabled.
> =

> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Looks OK to me from not knowing anything about this driver. Shall I pick
directly into clk-next for next release?

