Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524586446; cv=none;
        d=google.com; s=arc-20160816;
        b=HXL/c1FlrXIwdLMUp0cz4hTuut6hIvb2tCMWN4HMIwkxE0Fgpnb97/ByX2j2mmjRoG
         z66Vq8gmlIGdf1VeHZ3sNF0Ookfs0yMvjlBOALgM/4eXtEBVbBwf9CMR2b46Wi5kPRkJ
         xV5V7y71NASDZlaI2lx+W0toVMJt9VGg0VViVsqvBQfQvAaEOH/PuIGiiR3TqzMzNdSF
         TuzctrJbhzwsZxibo+AONHX1DUBpYLGvGtYJO0TXToYQsSaLaRmUW6mC62qQgbrSbJzY
         JB/YI/TqdsOYcwk42eJywhiN4fDv952KKUL18ELDqVItzbHRaEGUc5a1k9gklZyv9A52
         GciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nB9yfOKKEfY5A/RPIeo+YZRTWGbjxNEZ8RxOdTV/u2M=;
        b=NwWF7xbt9M6hYAQ8kLQx6ZKvX86vNg4THHVOpG9etgV3O3w6s5tH2lgoEQqaGwDTxq
         t4Py30W9dD/DPNBdJQoTH5f6IzJMSzQfqgV/B/Nwm9MUmNjalKoQ+oV62qGCixTI/7SU
         aWhFHFAP9QQLc13TdW3Rqxmx29+vSoHf/McYHd+lG36hxz2H0OWRa0g5+H5X3qI+Dtbd
         /j9ORS0E1PsVUp+ktY8ogqvme0PoVcax42KlhsVHag9d9hlbnWWhTT8IS4S3z4NMyI9h
         rLUORK61od66EtaYkUGYHuLea3cEKa3y3Q+SxtgDufGtNgTtNTmVb4S9hKx6nVs5NmiP
         ksQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+Iv51P1blTEBMGraIXERag/qxJynVBu6+PZfQC1rSLHwD+JAnkM4hN9OpuIC/34tEgxqjudQ==
Date: Tue, 24 Apr 2018 11:14:04 -0500
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org, david.brown@linaro.org,
	mark.rutland@arm.com, lgirdwood@gmail.com, plai@codeaurora.org,
	bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v5 04/23] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Message-ID: <20180424161404.v3ecysrg7z4v3ejp@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-5-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098779871079963?=
X-GMAIL-MSGID: =?utf-8?q?1598644757151671114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 04:31:38PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt       | 88 ++++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6afe.h             | 31 ++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> new file mode 100644
> index 000000000000..3925726a3319
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
> @@ -0,0 +1,88 @@
> +Qualcomm Audio Front End (Q6AFE) binding
> +
> +AFE is one of the APR audio service on Q6DSP
> +Please refer to qcom,apr.txt for details of the common apr service bindings
> +used by all apr services.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
> +		  Or "qcom,afe" where the version number can be queried
> +		  from DSP.
> +		  example "qcom,afe-v2.0"

Doesn't match the APR example.

> +
> += AFE DAIs (Digial Audio Interface)
> +"dais" subnode of the AFE node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <prop-encoded-array>

array?

> +	Definition: Must be 1
> +
> +- reg
> +	Usage: required
> +	Value type: <prop-encoded-array>

array or single value?

> +	Definition: Must be dai id
> +
> +- qcom,sd-lines
> +	Usage: required for mi2s interface
> +	Value type: <prop-encoded-array>
> +	Definition: Must be list of serial data lines used by this dai.
> +	should be one or more of the 1-4 sd lines.
> +
> += EXAMPLE
> +
> +q6afe {
> +	compatible = "qcom,q6afe";
> +	reg = <APR_SVC_AFE>;
> +
> +	dais {
> +		#sound-dai-cells = <1>;
> +		hdmi@1 {
> +			reg = <1>;
> +		};
> +
> +		prim-mi2s-rx@16 {
> +			reg = <16>;
> +			qcom,sd-lines = <1 3>;
> +		};
> +
> +		prim-mi2s-tx@17 {
> +			reg = <17>;
> +			qcom,sd-lines = <2>;
> +		};
> +
> +		sec-mi2s-rx@18 {
> +			reg = <18>;
> +			qcom,sd-lines = <1 4>;
> +		};
> +
> +		sec-mi2s-tx@19 {
> +			reg = <19>;
> +			qcom,sd-lines = <2>;
> +		};
> +
> +		tert-mi2s-rx@20 {
> +			reg = <20>;
> +			qcom,sd-lines = <2 4>;
> +		};
> +
> +		tert-mi2s-tx@21 {
> +			reg = <21>;
> +			qcom,sd-lines = <1>;
> +		};
> +
> +		quat-mi2s-rx@22 {
> +			reg = <22>;
> +			qcom,sd-lines = <1>;
> +		};
> +
> +		quat-mi2s-tx@23 {
> +			reg = <23>;
> +			qcom,sd-lines = <2>;
> +		};
> +	};
> +};
> diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
> new file mode 100644
> index 000000000000..3c7868394889
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6afe.h
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef __DT_BINDINGS_Q6_AFE_H__
> +#define __DT_BINDINGS_Q6_AFE_H__
> +
> +/* Audio Front End (AFE) virtual ports IDs */
> +#define HDMI_RX		1
> +#define SLIMBUS_0_RX    2
> +#define SLIMBUS_0_TX    3
> +#define SLIMBUS_1_RX    4
> +#define SLIMBUS_1_TX    5
> +#define SLIMBUS_2_RX    6
> +#define SLIMBUS_2_TX    7
> +#define SLIMBUS_3_RX    8
> +#define SLIMBUS_3_TX    9
> +#define SLIMBUS_4_RX    10
> +#define SLIMBUS_4_TX    11
> +#define SLIMBUS_5_RX    12
> +#define SLIMBUS_5_TX    13
> +#define SLIMBUS_6_RX    14
> +#define SLIMBUS_6_TX    15
> +#define PRIMARY_MI2S_RX		16
> +#define PRIMARY_MI2S_TX		17
> +#define SECONDARY_MI2S_RX	18
> +#define SECONDARY_MI2S_TX	19
> +#define TERTIARY_MI2S_RX	20
> +#define TERTIARY_MI2S_TX	21
> +#define QUATERNARY_MI2S_RX	22
> +#define QUATERNARY_MI2S_TX	23
> +
> +#endif /* __DT_BINDINGS_Q6_AFE_H__ */
> +
> -- 
> 2.16.2
> 
