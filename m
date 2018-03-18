Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521413398; cv=none;
        d=google.com; s=arc-20160816;
        b=S5xIkAsUL1PlLy9vzXCbllGzxsAwe79AW5WJo1C1s1pnF7HOA3REz+gs4sW7H6k+yh
         6I2mOBiPIbBVCvpO13Y62XsOX/9W9XYCc0Z64i/rmuanOXKGDgYsSOmobFABUTbbVaf0
         vtOyxjeAqBqEIM9eKeE4l8bYLLXDvRE5KbrRBmGZytBHhwAislJglSFG13uCWEcmykbo
         g6zVwbYWo0zOfeWcS1RzKjUYPoGHwgN5ThJk+f9R+cq3dVYWWHCnkLfmUUd+fHTPtj7Q
         a6ZYQ2PX/ylfCpig7q4M5U++M+fQ1wEfM+g2StPy0rx9CRCcZJYWyE3LbSQerfGRlIlD
         dNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=JSB+aQl9YtatODbtQOJL8q5uG12qf6amy8G1m51kxSk=;
        b=J79FoTfG/vKkl1a3QXpRQKkM18c48k1Rkyyz+HFw4XDm4ZOS3NnJKI6uC4Ss2QqBYw
         tX0uGZwQTFneJNiw4OFZmlAPMT1f/iKDziFrZ33IZ8uce5WZuwHIWFxtZ7Ko5pHyDVxV
         3PJ/o7Oef4LIBRlYmqtaoZzTevrPHZPgPPfEaX3n4YXMnXAVVUuHRk3a/HQP5/UZ1TnI
         23SeeCUk8d14kAKdAOUddG9AYTxxyjWogiLNO7HCnDmf+9f+L2T6wFzGnjxQa2dnoHen
         Y20NGOY4LSqNfKOf8ZJFZHe2n+GVyplOaMEFRsGgIziEX1/vEeMLBqcm2JMGyUA052bG
         RdnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g0aROU/t;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=g0aROU/t;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtw9Uuvtr/QPBdD1O8EsxXgvLG4hlDeZwok6rLJh3YsydF+vOvSSgaHU1053gXqy98EvK/47A==
Date: Sun, 18 Mar 2018 15:49:57 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
	robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com,
	vincent.guittot@linaro.org, skannan@codeaurora.org,
	amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
	davidai@quicinc.com, mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 6/7] dt-bindings: Introduce interconnect consumers
 bindings
Message-ID: <20180318224957.GP5626@tuxbook-pro>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-7-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309210958.16672-7-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495929599493024?=
X-GMAIL-MSGID: =?utf-8?q?1595317576053771340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:

> Add documentation for the interconnect consumer bindings, that will allow
> to link a device node (consumer) to its interconnect controller hardware.
> 
> Tha aim is to enable drivers to request a framework API to configure an
> interconnect path by providing their struct device pointer and a name.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt         | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 70612bb201e4..7935abf10c4b 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -45,3 +45,26 @@ Examples:
>  			status = "okay";
>  		};
>  
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which consume the interconnect
> +path(s) provided by the interconnect provider. There can be multiple
> +interconnect providers on a SoC and the consumer may consume multiple paths
> +from different providers depending on usecase and the components it has to
> +interact with.
> +
> +Required-properties:
> +interconnects: Pairs of phandles and interconnect provider specifier to denote
> +		the source and the destination port of the interconnect path.
> +interconnect-names: List of interconnect path name strings sorted in the same
> +		order as the interconnects property. Consumers drivers will use
> +		interconnect-names to match interconnect paths with interconnect
> +		specifiers.

Analog to other subsystems the -names property should be optional, at
least when there's only a single entry in interconnects.

> +
> +Example:
> +
> +	sdhci@7864000 {
> +		...
> +		interconnects = <&pnoc 78 &bimc 512>
> +		interconnect-names = "memory";
> +	};

Regards,
Bjorn
