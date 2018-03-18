Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeCRMy2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:54:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38501 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeCRMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:50 -0400
X-Google-Smtp-Source: AG47ELvW2x9G1U7VuiQtCMLTsREHWNTT5hfEBs9zykY01d2sp9wz3SNTnzAZn6hT5TZNBIwv+samkg==
Date: Sun, 18 Mar 2018 07:52:47 -0500
From: Rob Herring <robh@kernel.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] soc: qcom: rpmpd: Add a powerdomain driver to model
 corners
Message-ID: <20180318125247.qrttjjuvr7xniwmu@rob-hp-laptop>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-3-rnayak@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:38:19AM +0530, Rajendra Nayak wrote:
> The powerdomains for corners just pass the performance state set by the
> consumers to the RPM (Remote Power manager) which then takes care
> of setting the appropriate voltage on the corresponding rails to
> meet the performance needs.
> 
> We add all powerdomain data needed on msm8996 here. This driver can easily
> be extended by adding data for other qualcomm SoCs as well.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt       |  14 +
>  drivers/soc/qcom/Kconfig                           |   9 +
>  drivers/soc/qcom/Makefile                          |   1 +
>  drivers/soc/qcom/rpmpd.c                           | 299 +++++++++++++++++++++
>  4 files changed, 323 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 drivers/soc/qcom/rpmpd.c
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> new file mode 100644
> index 000000000000..4d7a4a1f054f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -0,0 +1,14 @@
> +Qualcomm RPM Powerdomains
> +
> +* For RPM powerdomains, we communicate a performance state to RPM
> +which then translates it into a corresponding voltage on a rail
> +
> +Required Properties:
> + - compatible: Should be one of the following
> +	* qcom,rpmpd-msm8996: RPM Powerdomain for the msm8996 family of SoC

qcom,msm8996-rpmpd

> + - power-domain-cells: number of cells in power domain specifier
> +	must be 1.
> + - domain-performance-state: One or more nodes describing the performance-states
> +	supported by the powerdomain.
> +	For domain-performance-state bindings refer to
> +	Documentation/devicetree/bindings/power/power_domain.txt
