Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524586522; cv=none;
        d=google.com; s=arc-20160816;
        b=i2Qt2g8LRWb1LroMqBLXomYOer2gDoDiV71qRi/UWz+wrWkj0vI92CtsuEv+wTNP5c
         Eo/Llci2UGft+tQkG+6Al1Ip80WwVF4UE2oSz5JBchh2N1STHoAtfcjyss7JnhNhiPLI
         O0BpQ/P8uSNuG85PFYKJSJ4wpG9a2+VnuaEGOdHCAXDgBT9wRWtRdo9jDVfK3hEaSF4G
         +KHO+kny7EH+jv/AODSmVipLxYp52Cg9WlDp+T5t9imBwDA9ppUpYPSB1tYgLuR2XS6A
         ip7HeJOiID1K3jJxhJQ4UOhvYFS24DnRdD7stbpKQcfbNs0wz62syDYtLqkJ9mP237sK
         G+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=x9VAfOy4DqNCNL9Cwgsnb+6TjMpJnEQFPAJh6ZouDKg=;
        b=zhuVrRtahtt/ys/2fSpZQkkWtasSpBy/isS+4pzptYLUf+55GsNJ9Jl3wcbBrWC0cQ
         tuI99AtnaQm8PVQ8KBdrATduoJXBROHykEIq/RZ+mAfUsx+xclSqbef9GhCrRTcaRjSo
         S1NWnFexM7rhVGdCXmGdarlcKpLWL7uDsSxWu1kg1sjInAzWIkH0TPuUJ4Tx2YVcVO9a
         xljhjBYtZniZoi2DUl07HFJLPtbTvIcGFtqOa0A1krFV0kefxihzMwYJGxqYD734O+v+
         92vBvSWSag7j3ZiBi1ELAuFfRQs9BVUUF+7dtE2x+RcDPcYSUJqyPvoBomukBvDqRBrA
         dL6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZq2fwoBZ2aUcqbLpqkwr/8Cl64ztwMdtO2x23dyTIlLRtqDUz+Ovkg6midRXw/+hdvfSrJtJg==
Date: Tue, 24 Apr 2018 11:15:21 -0500
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
Subject: Re: [PATCH v5 05/23] ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
Message-ID: <20180424161521.tyhnpiwbz2tqqetj@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-6-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098781495174847?=
X-GMAIL-MSGID: =?utf-8?q?1598644837603558845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 04:31:39PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add DT bindings for ADM (Audio Device Manager) DSP module.
> This module implements mixer controls to setup the connections between
> AFE ports and ASM streams.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6adm.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt

Similar comments in this one.

> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.txt b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> new file mode 100644
> index 000000000000..f1e2df8d2ea8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.txt
> @@ -0,0 +1,33 @@
> +Qualcomm Audio Device Manager (Q6ADM) binding
> +
> +Q6ADM is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
> +used by the apr service device.
> +
> +- but must contain the following property:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,adm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> +		   Or "qcom,adm" where the version number can be queried
> +		   from DSP.
> +		   example "qcom,adm-v2.0"
> +
> +
> += ADM routing
> +"routing" subnode of the ADM node represents adm routing specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Must be 0
> +
> += EXAMPLE
> +q6adm {

a6adm@?

Needs to be the number, not a define.

> +	compatible = "qcom,q6adm";
> +	reg = <APR_SVC_ADM>;
> +	q6routing: routing {
> +		#sound-dai-cells = <0>;
> +	};
> +};
> -- 
> 2.16.2
> 
