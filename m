Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeBMH0E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeBMH0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:26:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C68217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x227frHNzomZZefCdBhnWwKm3PGaZ5kXqH/88R1p4KXot7fLKd3uQb4Wi1dHnkRCPeQ0GKQjbZRZtsucKGU74jds=
MIME-Version: 1.0
In-Reply-To: <20180212161538.22669-4-s.nawrocki@samsung.com>
References: <CGME20180212161646epcas1p2dabca4c8d98d3e66b7a78133d926bccb@epcas1p2.samsung.com>
 <20180212161538.22669-1-s.nawrocki@samsung.com> <20180212161538.22669-4-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Feb 2018 08:25:59 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfktrQGJsHECCwJxw37eD_dpXYHXEXsA1W_sOFCwB5MPg@mail.gmail.com>
Message-ID: <CAJKOXPfktrQGJsHECCwJxw37eD_dpXYHXEXsA1W_sOFCwB5MPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: samsung: i2s: Prevent external abort on
 exynos5433 I2S1 access
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 5:15 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> It seems both PCLK_I2S1 and SCLK_I2S1 clocks need to be enabled before
> I2S1 control registers can be accessed on exynos5433. If SCLK clock
> is disabled an exception is triggered. To fix this parent clock of
> the RCLK_SRC clock is assigned to pri_dai->op_clk so required gate
> clock is handled by the runtime PM ops.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - removed stray whitespace change.
> ---
>  sound/soc/samsung/i2s.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
