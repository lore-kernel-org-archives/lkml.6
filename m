Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3912DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB8D2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550785446;
	bh=9zxz3UN/CEWlIByBWZuZX/fn6rZgTADee+6kemEtPg0=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=Htb76qtPOS0LbwVsJDNWVccD5WTvJOWpSiuTdMdY800pXbDbXR89LSdIQiPm5RftX
	 2ugENYzcS9HCJKjC8UsCRta3gCmN85BkAFKbre3rJ3vkrHfCiIetX2W7oZ6NSx0bRO
	 WUd+1GvuIX0EXOsw8VuxfvtiE1mXwbEcPjl6Za1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfBUVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBUVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:44:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1792080F;
        Thu, 21 Feb 2019 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550785443;
        bh=9zxz3UN/CEWlIByBWZuZX/fn6rZgTADee+6kemEtPg0=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=bYP2nwGAkhPJape5j1b4UOEQuR7Y5m8jIe5SWEkMM+vNBbLNtlcfgCizrQ/DgX2Pc
         P3Mz4ByNhkl+dPfn4oOfrX2IdaoaPnGP/Qh4Xdei0O7X+ra/leNDAWwNeRFBOG+Jsc
         Kk32fSAhle4Vu+35i+C3uJvzMCJDmEbLYmg9qiHM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <155078544270.77512.5446420781034016673@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211181531.GA3238@embeddedor>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190211181531.GA3238@embeddedor>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 13:44:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2019-02-11 10:15:31)
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>=20
> This patch fixes the following warnings:
>=20
> drivers/clk/samsung/clk-s3c2443.c: In function =E2=80=98s3c2443_common_cl=
k_init=E2=80=99:
> drivers/clk/samsung/clk-s3c2443.c:390:3: warning: this statement may fall=
 through [-Wimplicit-fallthrough=3D]
>    samsung_clk_register_alias(ctx, s3c2450_aliases,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      ARRAY_SIZE(s3c2450_aliases));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/samsung/clk-s3c2443.c:393:2: note: here
>   case S3C2416:
>   ^~~~
>=20
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>=20
> Notice that, in this particular case,  the code comment is modified
> in accordance with what GCC is expecting to find.
>=20
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to clk-next

