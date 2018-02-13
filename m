Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933069AbeBMAwE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:52:04 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41464 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeBMAwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:52:01 -0500
X-Google-Smtp-Source: AH8x224AmWUGaid4WwhFsXq/UvtV2WbpPwIk2NwB06Ulnvi5IPavq3Wm6b5za7NeLMfyyQAR6GP2hBFOyzjC2iqhC2U=
MIME-Version: 1.0
In-Reply-To: <20180212062832.2791-3-rnayak@codeaurora.org>
References: <20180212062832.2791-1-rnayak@codeaurora.org> <20180212062832.2791-3-rnayak@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Feb 2018 16:51:58 -0800
X-Google-Sender-Auth: aWJPhT3ul3lviqKReEbIiK2wm4o
Message-ID: <CAD=FV=UQ4YD7M8pqReBwE2etUbhuewye0akp0P9SuTnjwLgL4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: sdm845: Add minimal dts files for
 sdm845 SoC/MTP
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 11, 2018 at 10:28 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  13 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 275 ++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 55ec5ee7f7e8..9319e74b8906 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8916-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sdm845-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> new file mode 100644
> index 000000000000..617c7bb25fb1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0

It would, of course, be up to Qualcomm.  ...but might I suggest instead:

// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

The device tree files really don't have any special secret sauce in
them and IIRC allowing them to have a more permissive MIT license _or_
a GPL allowed people to run other operating systems on these boards.
This kind of thing is better to fix now so we don't have to go and get
everyone's permission later on.

In the past we went through this with Rockchip SoCs in commit
b1772506206f ("ARM: dts: rockchip: relicense rk3288.dtsi under
GPLv2/X11").


> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */

IMHO add an extra line to this comment with a description to avoid the
bike shedding of how we're supposed to do 1-line comments in device
tree files.  AKA:

/*
 * SDM845 MTP board device tree source
 *
 * Copyright (c) 2018, The Linux Foundation. All rights reserved.
 */


> +
> +/dts-v1/;
> +
> +#include "sdm845.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. SDM845 MTP";
> +       compatible = "qcom,sdm845-mtp";

For me checkpatch complains about this.  It looks like the file
"Documentation/devicetree/bindings/arm/qcom.txt" needs to be updated
with "sdm845".  I don't think that will make checkpatch be quiet
(since  that file doesn't have a full list of every board), but it
still should be the correct thing to do.


> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> new file mode 100644
> index 000000000000..55a7e0b454e1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0

As per above, suggest dual licensed?


> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.

As per above, suggest adding an extra line to avoid the bikeshed.

SDM845 SoC device tree source


Besides those things, everything looks good as far as I can see.  I'm
not an expert on every one of the devices used in this file, but
reading through bindings docs and looking at other users of them, it
looks sane enough.  Thus, with the above nits fixed you can feel free
to add my Reviewed-by.


-Doug
