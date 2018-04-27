Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524838648; cv=none;
        d=google.com; s=arc-20160816;
        b=sIJqULHi++26VV0/+O0JrNfndnLcCJoeLE+aBtc4KusCrECkxE+i8dfGVCsNIVk8km
         6NfJ2gNGuJYwywytdNJ1x1wQC9mOFMeYkJurqpifFxRWu8Wa3pXZPGB2acAkT4/Zy58A
         xc/NTUvNFlgeJx7SxD4KxGZuBHvWOgYg1bt9zSvv3mOsT/F6AAKATYuAcMfCIgZ/Ofr1
         AMSCNKJb3ZQzg9f9hNUeeylFg4XR6pK59Fn9IVKWjBdaoMetlz408dHcRwH7gwwTCy9Q
         SX7roFfWF2/aXKcMqBzi614ualZxD5tf/egAOUqPEaAgAElwkyori6jymckdw4Ma30wo
         3wZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+Bqh4Jg6d4LMpl6JY3zk3itVWi7KPbLQ18q35bTni34=;
        b=pWe5hqrlOZlU0BQSmsHbUoakO2OcGXCdc8D1S976YjgAgbHB8LKLuyHOirriVwHq7R
         HpQDNPLZG4FWkeJD3R8QRwqRXKgGH67sZTFA70gALB+dxYnFmP1fAeIyuNShglZCmfEK
         sd1c5Y5h/Gba9KCH+7DdCrYmtE6rzq7Jpc5JzDD+IxkV2ecMykP+mx2lIxU/uDsqkQ2I
         DHkNeUS1C0CP6XyYZjbhZ1pfg1VNTQMb4ht3ZZAr99QGVZP/dpWN36ydriJTzEWaQswa
         P9gMa0mTh4EZicgbW3sIJL+zBWiKWu/7lIIF9jDAGewvCKsGuRKRljL7jz8qKMrytbSc
         elBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZpf/RTWu16c+xFIacPdxO1LssgCkFEiE/0fdDxlKjUA/Fz3AwpG7mZ2+KZhn84gFFEkvpk0kQ==
Date: Fri, 27 Apr 2018 09:17:26 -0500
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v6 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Message-ID: <20180427141726.f2wrdhm7qwl6de2l@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-7-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801762059177131?=
X-GMAIL-MSGID: =?utf-8?q?1598909210746324673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:48AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ASM (Audio Stream Manager) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> new file mode 100644
> index 000000000000..2178eb91146f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Stream Manager (Q6ASM) binding
> +
> +Q6ASM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the common apr service bindings
> +used by the apr service device.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		    Or "qcom,q6asm" where the version number can be queried
> +		    from DSP.
> +		    example "qcom,q6asm-v2.0"
> +
> += ASM DAIs (Digial Audio Interface)
> +"dais" subnode of the ASM node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> += EXAMPLE
> +
> +q6asm@7 {
> +	compatible = "qcom,q6asm";
> +	reg = <APR_SVC_ASM>;
> +	q6asmdai: dais {
> +		#sound-dai-cells = <1>;
> +	};
> +};
> diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
> new file mode 100644
> index 000000000000..1eb77d87c2e8
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6asm.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DT_BINDINGS_Q6_ASM_H__
> +#define __DT_BINDINGS_Q6_ASM_H__
> +
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15

Do you plan to add more? I find the defines here fairly pointless. 
Nothing says cell values need to be 0 based, so you could just use 1-16 
directly.

In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
