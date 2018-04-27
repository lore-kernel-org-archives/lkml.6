Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524838404; cv=none;
        d=google.com; s=arc-20160816;
        b=TWc9j8Pw912FeFJmj6BA7ucKp/Irp/kWfBB9Sh4ml1IQbjsU8EerIeWWoGS1plsKNl
         eKH6LGjNSnmtIHV9ThBghfZv/oc7xH9f4pLq07c0aOuJy7Si3kZ9+2bqDIjfqNUjWjjd
         h2w2spZ8Wy6mHb6g/ivMcYFMinnr4uqpNjso2WlzWLQM7KHWApYWMreRgQFTFjwhm0j6
         BUxWkrmfG1ZGbL7modUYWV/CLhZaR4TM7lpoFDseB0Prqg90ItJ5/O9UH/I/yy/UZCg8
         6ou8GDPkcl1iDXqDUEwmEykK0LBeU9QttbRVXFjTgUYFd3IJoOYl3x9eZb0MEV+BzajW
         a8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=19RmBtSU2AO6P1hA8lhvLI9D3+Y5jOv1bxl993gmx4Y=;
        b=MBaW/hQMovWAjh5RzfJhIxN/pFT+zooq6Gf35WjPXyWU7W127+CvTHy8c3y61Ijb8t
         Kh4mCOUE+ZzdZZCmXZ8alu1z0fW2WZaoSjuWLvfG1h6PRtAwcctPx6RVaBziO+BRR+WC
         oo+ad6OXgUZ1rsHDrn8HQ7sLDIoVGzlXdLpO9ewMWdJPgYJntTTU4jpiZAqoIbjFvc5o
         fKmOTd9xPjq8JOKRwesPjikL3VMNe2xDLZM5LX8OewrFTvr9rK7RAeqvI23Ny9m25UdN
         J3BLjVOLy63/A8zk5TVoUTMUNvWDX8Zw60yRP003BHhHwIPLWnxkRkdUpWg5iQE+8EjD
         gwIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZr+/GEVT+MsuoRmsZ0yd04PjgcIwxAVHs2pUbIlo80yDN3sjrMddPEfOIjBJRU0DDSLQB1SvQ==
Date: Fri, 27 Apr 2018 09:13:23 -0500
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
Subject: Re: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Message-ID: <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801759184316258?=
X-GMAIL-MSGID: =?utf-8?q?1598908955471844373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:46AM +0100, srinivas.kandagatla@linaro.org wrote:
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
> index 000000000000..05208a63dd3c
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
> +	Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
> +		  Or "qcom,q6afe" where the version number can be queried
> +		  from DSP.
> +		  example "qcom,q6afe"

reg too.

> +
> += AFE DAIs (Digial Audio Interface)
> +"dais" subnode of the AFE node represents dai specific configuration
> +
> +- #sound-dai-cells
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 1
> +
> +- reg

It's not clear here these are in a grandchild node.

> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be dai id
> +
> +- qcom,sd-lines
> +	Usage: required for mi2s interface
> +	Value type: <prop-encoded-array>
> +	Definition: Must be list of serial data lines used by this dai.
> +	should be one or more of the 1-4 sd lines.
