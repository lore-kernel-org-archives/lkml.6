Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527093626; cv=none;
        d=google.com; s=arc-20160816;
        b=UdIjlSXIsa268TfyQS++of8UafjXD630/NTNIbgxKP5/6RubAiCXaZ979v4z3EHDS0
         A0nDS/QuB3+h3LXFmuY3xtCMOUBt20/j9DioryRFC1vrTMgOhFviS3ZsY1081GKPBUVX
         dJc/aGuPHWGNKiQH/llJALQyssI1iHHvRRtfMCHAjjAKdWlD2Q3293C5NbLR1wnByN7a
         Dfn4f5e/bCgIJ16zVoEnTbcdeDXAdv/yJiR91cZSNmjL96Dsdu6lyICBc6nEqJU60nrx
         DVFyszrPYtMZAIebkP/3nj4Y/+cUQWirgze+fLCFhYxFQN/1Yw8qIFZI59EEb0TBqr1c
         p4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JY5ALSlnR2OXtPlQVZBnp9YCg/CF6sqbgXS16p5a8HY=;
        b=fx7Qa30/nXvVmBklWzK8PEDyUepPA4CQbgeReLgye42pbAl1aoYxCIvUiud5gI+RcS
         a0QfgIOb1axRNhR0NYenTz1MZjdynTSGOY/u0KryNMKjIARYvAYjW+C2mshmkRSHZ2Fa
         kNfUvLhW+k6BReIxQ2fVGAc+i+vtzVfu3yko9iqQNRQeH3s9rY3EnskH6EWlmQLZd+Xz
         H9OhgeeaK7I5iD2xHIxKPeLnp+FTUmWB4AuLxmw1TefEYy+Q7hNEHcypt0eGCCGXnM+Z
         p+IwsP/W0OmYUHyigwp0BV12DuAP+9ea5u590u25U9PMOJ13HBcjKyfHOxSA9YWDLZra
         NdPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrGCRi9jPv6xVd/ZOZET3ZFC9RaqSm44BXAF6Ax3tVklUm/ZZz2O2EGEjgi3pBAD2DWfMZfuA==
Date: Wed, 23 May 2018 11:40:23 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, kramasub@codeaurora.org,
	sdharia@quicinc.com, girishm@quicinc.com,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	bgoswami@codeaurora.org, devicetree@vger.kernel.org,
	broonie@kernel.org, linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
Message-ID: <20180523164023.GA24671@rob-hp-laptop>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1601273726747740287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 05:51:17PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm SLIMBus NGD controller found in
> all new SoCs starting from B family.
> SLIMBus NGD controller is a light-weight driver responsible for
> communicating with SLIMBus slaves directly over the bus using messaging
> interface and communicating with master component residing on ADSP for
> bandwidth and data-channel management
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
> new file mode 100644
> index 000000000000..c948fb098819
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
> @@ -0,0 +1,70 @@
> +Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
> +
> +SLIMBus NGD controller is a light-weight driver responsible for communicating
> +with SLIMBus slaves directly over the bus using messaging interface and
> +communicating with master component residing on ADSP for bandwidth and
> +data-channel management
> +
> +Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,slim-ngd"

SoC specific compatible needed.

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the controller
> +		    register blocks.

blocks? Is there more than one? If so, how many?

> +
> +- reg-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "ctrl"

reg-names is pointless when there is only 1.

> +
> +- qcom,ngd-id
> +	Usage: required
> +	Value type: <u32>
> +	Definition: ngd instance id in the controller

Why do you need this?

> +- dmas
> +	Usage: required
> +	Value type: <array of phandles>
> +	Definition: List of rx and tx dma channels
> +
> +- dma-names
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "rx" and "tx".
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must list controller IRQ.
> +
> +#address-cells
> +	Usage: required
> +	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
> +
> +#size-cells
> +	Usage: required
> +	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
> +
> += EXAMPLE
> +
> +slim@91c0000 {
> +	compatible = "qcom,slim-ngd";
> +	reg = <0x91c0000 0x2C000>;
> +	reg-names = "ctrl";
> +	interrupts = <0 163 0>;
> +	qcom,ngd-id = <1>;
> +	dmas =	<&slimbam 3>, <&slimbam 4>;
> +	dma-names = "rx", "tx";
> +
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	codec@1 {
> +		compatible = "slim217,1a0";
> +		reg  = <1 0>;
> +	};
> +};
> -- 
> 2.16.2
> 
