Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933561AbeBMHZb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeBMHZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:25:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061C721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x226zb8tOU8vPYOyE+zjMiw/BeaxtdIzN64oZPUx+EajnC/ZqcRfAnqFfsPk0DeshOV4mAI33hzhsU37yFU75ezY=
MIME-Version: 1.0
In-Reply-To: <20180212161538.22669-3-s.nawrocki@samsung.com>
References: <CGME20180212161641epcas1p2418c2323e5eb99a37a89b42c246f23dd@epcas1p2.samsung.com>
 <20180212161538.22669-1-s.nawrocki@samsung.com> <20180212161538.22669-3-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Feb 2018 08:25:27 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe5dFQYUQ+Fdn1NOynBT7Bp_256McYd=cYB2PFosqPbag@mail.gmail.com>
Message-ID: <CAJKOXPe5dFQYUQ+Fdn1NOynBT7Bp_256McYd=cYB2PFosqPbag@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ASoC: samsung: i2s: Ensure names of supplied
 clocks are unique
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
> In order to support multiple instances of the I2S IP block the platform
> device name is prepended to each clock registered by the driver.
> The clock-output-names property is now not used, this should not cause
> any issues as, for example, CDCLK clock is referenced through DT 'clocks'
> property, not by name.
>
> This change allows to have both I2S0 and I2S1 enabled simultaneously
> on exynos5433 and working properly when #clock-cells property is specified
> in respective DT nodes.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - added devm_kasprintf() error handling.
> ---
>  sound/soc/samsung/i2s.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
