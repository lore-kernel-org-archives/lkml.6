Return-Path: <narmstrong@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523538903; cv=none;
        d=google.com; s=arc-20160816;
        b=lxoTV12S6wNk1U/K85VkzKMVOtbb6MPa+5/V6DJP0T818ip7Ba/HXcM8YXcQWJY1sb
         33oWO+27zUse+VOS9Z0/ItBfszszf7JO+DxH3G7IjV1GrqDp+iA8OrnP5OxKucS0DaFZ
         ifJ0OTddUJEEguclaytBMbpCll8+CnwvtmnHYND9LlAHCqyQzV8i9FtkMZDi0YHC00To
         osrL4AVJbKVGCr3W8NA2RxgftESwzQzL3Vh/zvwsc8Gqi0Yo2TVNheBmZrL3vqmCi4yX
         SI+CAUdUadPuru3a0jgv8eZnbMhaeWJnPbhhIz4iuSaPS6b/QhHbx2Hse9Ot2fJTcBWd
         vHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=TCLjg+lFZQUSrrz2T1N6ETDEkEy+dF1/aASVLM7Kkfs=;
        b=a/2O0fzC1QPq1iVa3MxtFhqonSpi9I5LDQkzufZdIozABoB4HvY7qoXTALgNyyKsaH
         Ua1L5vaTmkA+/LyRCnglaHwJkRU7KwL0GAt1xJPJwuUxntbFy77owvehMbNx6CvK+RcY
         s1c/kRe87FmRiy4VfrbD3YwExca93xUlevNDc9Ns7B6mRYDBbPYk+a7aH0CSmyRwaoU8
         2IMIBIbwmPyr8hxEtmXboPwtixEZhuNCt4GRwZsYQAeOZeC4di+fHzVSqNftJVT7/epZ
         c6NZP92Jb9BhLDvyVeFKRxFcSLmZAEvCtEU0mhRRHGc5fG/8QOrEZcs3RkYvGHYfwOjZ
         g68A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=0ToL/Sin;
       spf=softfail (google.com: domain of transitioning narmstrong@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=narmstrong@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=0ToL/Sin;
       spf=softfail (google.com: domain of transitioning narmstrong@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=narmstrong@baylibre.com
X-Google-Smtp-Source: AIpwx4/XszI6FVdg2SvNhtpSqG+/M4yCfS8wJ19CPz2ZVrplmz82Jg/EkF35GC3dOtSqIFhD9CqDnw==
Subject: Re: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
To: Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, skannan@codeaurora.org,
 seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 bjorn.andersson@linaro.org, robh+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, davidai@quicinc.com,
 vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7723f351-2460-7378-411a-cfcdf4138d8f@baylibre.com>
Date: Thu, 12 Apr 2018 15:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309210958.16672-3-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495918143221321?=
X-GMAIL-MSGID: =?utf-8?q?1597546329634440575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09/03/2018 22:09, Georgi Djakov wrote:
> This binding is intended to represent the interconnect hardware present
> in some of the modern SoCs. Currently it consists only of a binding for
> the interconnect hardware devices (provider).
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt         | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..70612bb201e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,47 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the usecase. Interconnect providers can also be interconnect
> +consumers, such as in the case where two network-on-chip fabrics interface
> +directly

Hi,

Can't we specify the number of cells for the phandle ? It should be aligned with other consumer/provider bindings.

Neil

> +
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware
> +
> +Examples:
> +
> +		snoc: snoc@580000 {
> +			compatible = "qcom,msm8916-snoc";
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +		};
> +		bimc: bimc@400000 {
> +			compatible = "qcom,msm8916-bimc";
> +			reg = <0x400000 0x62000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +			status = "okay";
> +		};
> +		pnoc: pnoc@500000 {
> +			compatible = "qcom,msm8916-pnoc";
> +			reg = <0x500000 0x11000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +			status = "okay";
> +		};
> +
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
