Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeCEUI2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbeCEUI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:08:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59FC217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELuZp6m4i3D0tnTgp3VtA0hLzSPAbSv/V3nrL6eIc1jj7Cz5DS9v65JsqLyDUZevtocBWsrtBGjQ4dZxuUmNNU0=
MIME-Version: 1.0
In-Reply-To: <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
References: <cover.1520274879.git.amit.kucheria@linaro.org> <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Mar 2018 14:08:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGXGBQSh3OeG_-bBSgv+uoANxB1CYU8RS0O6FrtaKaJQ@mail.gmail.com>
Message-ID: <CAL_JsqKGXGBQSh3OeG_-bBSgv+uoANxB1CYU8RS0O6FrtaKaJQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: devicetree@vger.kernel.org, Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 12:36 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>
> There is currently no way for the governor to be selected for each thermal
> zone in devicetree. This results in the default governor being used for all
> thermal zones even though no such restriction exists in the core code.
>
> Add support for specifying the thermal governor to be used for a thermal
> zone in the devicetree. The devicetree config should specify the governor
> name as a string that matches any available governors. If not specified, we
> maintain the current behaviour of using the default governor.
>
> Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
>  drivers/thermal/of-thermal.c                          | 6 ++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index 1719d47..fced9d3 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -168,6 +168,14 @@ Optional property:
>                         by means of sensor ID. Additional coefficients are
>                         interpreted as constant offset.
>
> +- thermal-governor:     Thermal governor to be used for this thermal zone.
> +                       Expected values are:
> +                       "step_wise": Use step wise governor.
> +                       "fair_share": Use fair share governor.
> +                       "user_space": Use user space governor.
> +                       "power_allocator": Use power allocator governor.

This looks pretty Linux specific. Not that we can't have Linux
specific properties, but we try to avoid them.

What determines the selection? I'd imagine only certain governors make
sense for certain devices. We should perhaps describe those
characteristics which can then infer the best governor. Not really
sure though...

Rob
