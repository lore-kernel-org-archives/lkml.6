Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524587118; cv=none;
        d=google.com; s=arc-20160816;
        b=z4BhFGGIJsL/mi2Jl+mIEFinzjolKE9avJFRSsD9sf96wzh21qSW8Vmk6GnGFzK5yy
         RxkiYy4CJAtk3bEK+26+lcbxSS3T36fm94V8CwgjnmkQN9IyHKtp4BsyRndqHBJf/nmL
         ajMClxbqEc8FLQZhmnP7KebmSlJFpnbUpG1mXqNoTgCHte+FED6hsF+EFiA1qJ0m0V5k
         jxVkWNdo5bRL6HUtXkaY8kvG39bG4REGvm2DZBTmd+KQlZQ8z1hcvVR3O2ay5jF+FMBr
         /sD2mpuGPxIynx8bvFg3/2W9mCxj/7vgo+5e0OOLeJrPunGM7g2e3OHKG785J5NSqaRv
         uTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=7YxARgoanoFV/X0XWX+kRedkkO5IB0rdpSC6Zu95/cw=;
        b=rtPY51UNdZg/3jgUNhAUDLiwEmVNMpv1GO8FgDmWIsjOJm7Z94KpgLs/pl/dIe8IwL
         mbtUnm5efdDiRFX2z05dx+vQeVjEMTn4ygw4QvntO/vy2dwXYUJcPxaDYvWjX16lQ4N+
         V6D98JrfAWUvLW36d1nK8hA3vTa/w6c1zQY3pxLU7FO/ASKNlqawYPt6fiYn5GUGWLNo
         OSHPjxF3RQZXpA3UrnOIbljzhdXYUAezggFOKYmUCj2mzCFLAMT2uVamocGqBE3bWAFu
         ohbeJBKg21d0dWawrbN63xRn2fGoQvBxthl57ceUwHZf2NM/MGejR2lmrbdwZLOZWRcY
         KZcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx49yAer/W1jthnc/SVmWL2i6VA8UF1NXZo8hI+4/cv8HFW+UumnCTfrf4inNAQZaCWolV94KKA==
Date: Tue, 24 Apr 2018 11:25:17 -0500
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
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
Message-ID: <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098804369863616?=
X-GMAIL-MSGID: =?utf-8?q?1598645462468729095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 04:31:55PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,apq8096.txt     | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> new file mode 100644
> index 000000000000..37e23d926b95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -0,0 +1,76 @@
> +* Qualcomm Technologies APQ8096 ASoC sound card driver
> +
> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apq8096-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board:

Please list out valid values here.

> +
> += dailinks
> +Each subnode of sndcard represents either a dailink, and subnodes of each
> +dailinks would be cpu/codec/platform dais.
> +
> +- link-name:

Not a standard property, but I guess that sneaked in with the 8016 
binding...

> +	Usage: required
> +	Value type: <string>
> +	Definition: User friendly name for dai link
> +
> += CPU, PLATFORM, CODEC dais subnodes
> +- cpu:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: cpu dai sub-node
> +
> +- codec:
> +	Usage: Optional
> +	Value type: <subnode>
> +	Definition: codec dai sub-node
> +
> +- platform:
> +	Usage: Optional
> +	Value type: <subnode>
> +	Definition: platform dai sub-node
> +
> +- sound-dai:
> +	Usage: required
> +	Value type: <phandle>

phandle with args.

> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
> +
> +Example:
> +
> +audio {
> +	compatible = "qcom,apq8096-sndcard";
> +	qcom,model = "DB820c";
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	hdmi-dai-link {
> +		link-name = "HDMI Playback";
> +		cpu {
> +			sound-dai = <&q6afe HDMI_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6adm>;
> +		};
> +
> +		codec {
> +			sound-dai = <&hdmi 0>;
> +		};
> +	};
> +};
> -- 
> 2.16.2
> 
