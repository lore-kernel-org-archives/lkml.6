Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754995AbeC0RMl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:12:41 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:46219 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeC0RMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:12:38 -0400
X-Google-Smtp-Source: AIpwx4+2qmy1Yl3zTLrQiaPCwT+zkpt116u/ukEHTEZjeut/VPiHtwr8MVzamoPCy1ztgcsSPjVFaA==
Date: Tue, 27 Mar 2018 10:12:49 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1
 board file
Message-ID: <20180327171249.GI1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
> +

If this is the board and qcom-ipq4019-ap.dk04.1.dtsi is the platform
file then the compatible should be here and not there. Also qcom,ipq4019
is not an awesome compatible for a board file.

> +	soc {
> +		dma@7984000 {
> +			status = "ok";
> +		};
> +
> +		qpic-nand@79b0000 {
> +			pinctrl-0 = <&nand_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};

nand_pins defines the muxing and is defined in the other dtsi. So please
move these pinctrl-* properties to the dtsi.

As long as the node is disabled the pinctrl state won't be applied
anyways.


If there are electrical properties that needs to be specified you can
override the pinctrl state in the board specific file.

Regards,
Bjorn
