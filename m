Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeBSUbL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:31:11 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39804 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753674AbeBSUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:31:08 -0500
X-Google-Smtp-Source: AH8x227iJR7O0FMu8uD2ZG8LCGqPITcs9y3c61VdF77Ic/KfCzDm2PNoR4S2tRJ8T/9Rch/LjWMXoQ==
Date: Mon, 19 Feb 2018 14:31:06 -0600
From: Rob Herring <robh@kernel.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180219203106.mfzmxy42biwo33qj@rob-hp-laptop>
References: <20180216224614.24037-1-ilina@codeaurora.org>
 <20180216224614.24037-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216224614.24037-3-ilina@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 03:46:14PM -0700, Lina Iyer wrote:
> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> 
> Command DB provides information on shared resources like clocks,
> regulators etc., probed at boot by the remote subsytem and made
> available in shared memory.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/cmd-db.txt         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> new file mode 100644
> index 000000000000..039be54fe9c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> @@ -0,0 +1,30 @@
> +Command DB
> +---------
> +
> +Command DB is a database that provides a mapping between resource key and the
> +resource address for a system resource managed by a remote processor. The data
> +is stored in a shared memory region and is loaded by the remote processor.
> +
> +Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
> +controlling shared resources. Depending on the board configuration the shared
> +resource properties may change. These properties are dynamically probed by the
> +remote processor and made available in the shared memory.
> +
> +The devicetree representation of the command DB driver should be:

Need to state this is a child of /reserved-memory

> +
> +PROPERTIES:

Why the yelling? :)

> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Should be "qcom,cmd-db"

reg?

> +
> +Example:
> +
> +	reserved-memory {
> +		[...]
> +		qcom,cmd-db@c3f000c {
> +			reg = <0x0 0xc3f000c 0x0 0x8>,
> +			      <0x0 0x85fe0000 0x0 0x20000>;
> +			compatible = "qcom,cmd-db";
> +		};
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
