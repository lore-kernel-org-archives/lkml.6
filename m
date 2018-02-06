Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeBFMPr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:15:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeBFMPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:15:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205B72172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x22415hc1pvUcGi+xJAMCh7xowYsmk9RWb+QM8NhZZjoiyJ3nOoXYAw/FiF7SsVbBCgXDMqtk+JTFRpsI/MaL3/M=
MIME-Version: 1.0
In-Reply-To: <20180205154403.13520-2-s.nawrocki@samsung.com>
References: <CGME20180205154453epcas1p10046e1103497692c86c0899a5ef11781@epcas1p1.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-2-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Feb 2018 13:15:38 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcd_-kGyVvetUXdeKwv8em7sWW5TeRR0jqwHyTV+YQWzg@mail.gmail.com>
Message-ID: <CAJKOXPcd_-kGyVvetUXdeKwv8em7sWW5TeRR0jqwHyTV+YQWzg@mail.gmail.com>
Subject: Re: [PATCH 1/8] ASoC: samsung: i2s: Ensure the RCLK rate is properly determined
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

On Mon, Feb 5, 2018 at 4:43 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> If the RCLK mux clock configuration is specified in DT and no set_sysclk()
> callback is used in the sound card driver the sclk_srcrate field will remain
> set to 0, leading to an incorrect PSR divider setting.
> To fix this the frequency value is retrieved from the CLK_I2S_RCLK_SRC clock,
> so the actual RCLK mux selection is taken into account.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
