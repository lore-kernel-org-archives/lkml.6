Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524586651; cv=none;
        d=google.com; s=arc-20160816;
        b=o0cnaOBJ8hlyuEjuJGjYOTF/PqltdoZgod3FBO/uPjjfMSQp3MzFfZvtpO0bWLc8C1
         sgevsCZQ2SN3OEy0B0rAmHFUs8D2zLcvodiM00nw5tjY08eS3e7TM3dq+8vdUOCBd2LZ
         MWoy/qX7+RbAS9Yf6I/FZAos++sqoFB0gCA1Av7xjvU7IPexUaqlFjiCw7R5HQnZaxoE
         LfKDoVuYQckVh0iTza+IPNL2wcdPqy1U5rQuVknHfSjIK3EiJaDg95Pixs1yxY8UU/w4
         bJeQdbjvUeUQSJeJYb4HEMMZVrVxUj+cqu++bTYbg9VeaKB6Qazm60JepZGogP2v0YOP
         h72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=aNSsMRVWt6EeERVuOPS3UIdvoffnqmLyYfgf5Ekdy18=;
        b=JxReVxxqfao3YB4okyA2CvAzgezAzBhNl4CL05mXyPBYpI9SSJZqE8r36FN+wASaiI
         mohV/mONelW+Xj8It6OoQ9C3L90oxOuj15vcyDWjXgs/yQ7lklni/vDWIk9o56fJq/By
         asqGLe+cNvWyh/kkE3TmIhxMaIBeh+njIorErrxtXAelbyNea6wjd/3u/WOfGQzNDYjD
         KeNJpazVi+hr/9GCoIDSDZdhFiDfndNWXByDEWdgHfZ/wUNN6bexFtEtfhpaYN03wkMs
         sD625vW8QX/+mBEde2LbHvdnL+J9gWe50v98f1wJWVYoytzIj3lYudv+yMZwQGeiGF5+
         mm6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx48ypA9ye9DO385eHYdHnu8IXa5p8g3cRmmWaZl7VT6wlazfaUQ8sfMXMM6T8TwBMrw4vSMUIw==
Date: Tue, 24 Apr 2018 11:17:30 -0500
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
Subject: Re: [PATCH v5 06/23] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
Message-ID: <20180424161730.4r3vixqa4sdjv7a2@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098782482052461?=
X-GMAIL-MSGID: =?utf-8?q?1598644973022010295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 04:31:40PM +0100, srinivas.kandagatla@linaro.org wrote:
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
> index 000000000000..d034a50a202a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Stream Manager (Q6ASM) binding
> +
> +Q6ASM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
> +used by the apr service device.

Need to be clear this is a child of APR.

> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		    Or "qcom,asm" where the version number can be queried
> +		    from DSP.
> +		    example "qcom,asm-v2.0"
> +
> += ASM DAIs (Digial Audio Interface)
> +"dais" subnode of the ASM node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Must be 1
> +
> += EXAMPLE
> +
> +q6asm {

Unit address needed.

> +	compatible = "qcom,q6asm";

Doesn't match the doc.

> +	reg = <APR_SVC_ASM>;
> +	q6asmdai: dais {
> +		#sound-dai-cells = <1>;
> +	};
> +};
> diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
> new file mode 100644
> index 000000000000..2e11b15d930d
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6asm.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
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
> +
> +#endif /* __DT_BINDINGS_Q6_ASM_H__ */
> -- 
> 2.16.2
> 
