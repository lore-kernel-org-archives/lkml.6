Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524585148; cv=none;
        d=google.com; s=arc-20160816;
        b=OBxlK5pbumO0Mbp0TLcK+3rTPobyGu4Nmb/JMfMtez+QecgX8WhoehVIoZdgGcGTI5
         4VfupklKuJqlRj0gpt2Y09sq73kuhkPDbgdwn0jUt4wEirOvMnfYYIDnWj0S/JpTbZaE
         oZuzm0OYBRH1UwC/TCcJEvjxkdKzRLKo7L9xDW5AQtvERiK1T9VVOqhdIKDYfdcP/PPM
         TVT+lrCZob4bDefh54b/23hpIRmrjFYt/xp5casOsELlMtiOFMjgBlfHeEkXk0IuJzwp
         33Crd11/MfWYeXySqYbwQZUvjmPHRH9elSY5v3oOycBs8IzMO4ttNt0EjMz+G7aoiMiP
         plgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2AmiRXgz0NgRR/BVrfHz0n34TOSf+L4m7b59qpVtYCY=;
        b=FHPs21B6/2JndHBUdYwVfmJmNVWRLByZ6VrBFREHtLOgJZMzvVKPgQHgVIG9VNeLHA
         l8S5na+WQkILvTpr4sEbIOjSRlc7IZMUfC+w6PTiZj4TvryFqp8TcritUj97VSKv9hqZ
         vT4sMClt71R7dPw9gN5lFcXAOQU8IZDTzJ88q8J151BGmPCT8Ba71vk0hGQP/z2jSVlU
         vEyXcvgdJenN8WM/OspZKuEzd8pm9jg375cjuMVYK8hD22duAX+rgrMKMQ/6i0s9YB0w
         rmZ7X+aO8Opai7g+aOh1CkaAfioGzhTlrgjIb3lbMCqZ+ub2I4itPZdtHPjfCmsidTk0
         ryVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx49ul01p7lZ+c7sP/dmbh6jGyVa7hM33sSMOJ20ZZyhWzwuHlf8anhh6A2oR82EcSAJwrvaXxQ==
Date: Tue, 24 Apr 2018 10:52:26 -0500
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
Subject: Re: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
Message-ID: <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098775422985978?=
X-GMAIL-MSGID: =?utf-8?q?1598643396428576389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> bus driver. This bus is used for communicating with DSP which provides
> audio and various other services to cpu.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 85 ++++++++++++++++++++++

This should probably go under bindings/sound/ as it is at least mostly 
sound related.

>  include/dt-bindings/soc/qcom,apr.h                 | 27 +++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>  create mode 100644 include/dt-bindings/soc/qcom,apr.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> new file mode 100644
> index 000000000000..85cc0433fb00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
> @@ -0,0 +1,85 @@
> +Qualcomm APR (Asynchronous Packet Router) binding
> +
> +This binding describes the Qualcomm APR. APR is a IPC protocol for
> +communication between Application processor and QDSP. APR is mainly
> +used for audio/voice services on the QDSP.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apr-v<VERSION-NUMBER>", example "qcom,apr-v2"
> +
> +- qcom,dest-domain-id
> +	Usage: required
> +	Value type: <prop-encoded-array>

If this is an array, what do the indexes of the array correspond to?

> +	Definition: Destination processor ID.
> +	Possible values are :
> +			1 - APR simulator
> +			2 - PC
> +			3 - MODEM
> +			4 - ADSP
> +			5 - APPS
> +			6 - MODEM2
> +			7 - APPS2
> +
> += APR SERVICES
> +Each subnode of the APR node represents service tied to this apr. The name
> +of the nodes are not important. The properties of these nodes are defined
> +by the individual bindings for the specific service
> +- All APR services MUST contain the following property:
> +
> +- reg
> +	Usage: required
> +	Value type: <prop-encoded-array>

Not really an array, right?

> +	Definition: APR Service ID
> +	Possible values are :
> +			3 - DSP Core Service
> +			4 - Audio Front End Service.
> +			5 - Voice Stream Manager Service.
> +			6 - Voice processing manager.
> +			7 - Audio Stream Manager Service.
> +			8 - Audio Device Manager Service.
> +			9 - Multimode voice manager.
> +			10 - Core voice stream.
> +			11 - Core voice processor.
> +			12 - Ultrasound stream manager.
> +			13 - Listen stream manager.
> +
> += EXAMPLE
> +The following example represents a QDSP based sound card on a MSM8996 device
> +which uses apr as communication between Apps and QDSP.
> +
> +	apr {
> +		compatible = "qcom,apr-v2";
> +		qcom,smd-channels = "apr_audio_svc";

Drop this?

> +		qcom,dest-domain-id = <APR_DOMAIN_ADSP>;
> +
> +		q6core {
> +			compatible = "qcom,q6core";
> +			reg = <APR_SVC_ADSP_CORE>;
> +		};
> +
> +		q6afe {
> +			compatible = "qcom,q6afe";
> +			reg = <APR_SVC_AFE>;
> +
> +			dais {
> +				#sound-dai-cells = <1>;
> +				hdmi@1 {
> +					reg = <1>;
> +				};
> +			};
> +		};
> +
> +		q6asm {
> +			compatible = "qcom,q6asm";
> +			reg = <APR_SVC_ASM>;
> +			...
> +		};
> +
> +		q6adm {
> +			compatible = "qcom,q6adm";
> +			reg = <APR_SVC_ADM>;
> +			...
> +		};
> +	};
> diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
> new file mode 100644
> index 000000000000..905503f81885
> --- /dev/null
> +++ b/include/dt-bindings/soc/qcom,apr.h
> @@ -0,0 +1,27 @@
> +#ifndef __DT_BINDINGS_QCOM_APR_H
> +#define __DT_BINDINGS_QCOM_APR_H
> +
> +/* Domain IDs */
> +#define APR_DOMAIN_SIM		0x1
> +#define APR_DOMAIN_PC		0x2
> +#define APR_DOMAIN_MODEM	0x3
> +#define APR_DOMAIN_ADSP		0x4
> +#define APR_DOMAIN_APPS		0x5
> +#define APR_DOMAIN_MAX		0x6
> +
> +/* ADSP service IDs */
> +#define APR_SVC_ADSP_CORE	0x3
> +#define APR_SVC_AFE		0x4
> +#define APR_SVC_VSM		0x5
> +#define APR_SVC_VPM		0x6
> +#define APR_SVC_ASM		0x7
> +#define APR_SVC_ADM		0x8
> +#define APR_SVC_ADSP_MVM	0x09
> +#define APR_SVC_ADSP_CVS	0x0A
> +#define APR_SVC_ADSP_CVP	0x0B
> +#define APR_SVC_USM		0x0C
> +#define APR_SVC_LSM		0x0D
> +#define APR_SVC_VIDC		0x16
> +#define APR_SVC_MAX		0x17
> +
> +#endif /* __DT_BINDINGS_QCOM_APR_H */
> -- 
> 2.16.2
> 
