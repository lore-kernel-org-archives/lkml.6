Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521452074; cv=none;
        d=google.com; s=arc-20160816;
        b=aagNrXawru2UcFUOrMZiQYM54yZ5g4sWIZem+ipK+hJL1+X7/hW/0HT6y2diyeQR4l
         s9OOzodhCxiv+ZCAhHKO7z2dewR7MKXKvpXYtbIz6azY7jxDN05W6L6Xzo/cGe+ohLDi
         MSCpVTl2AHSf52WQmkTFpa/IJK7IewMtnhSYeDq03sOA0ykL09IGiE29ssQsoBD3xSYy
         N+CtVTints5S6S4ZEqJaHtPvCwjTtm+kSlIYXLZEdCvV61TozCvywQtnSKJRNHgasSFw
         HpM/ZEh5ve4hqatZnTAeYKCFRk+8opvRv5fiJWH6dJsOT421XUPUNh16467bMWH/3Uus
         PEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :date:message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=tnRKawH4DTybW/gOzVsLkwMnYtX9mDXRMk779y0qUb8=;
        b=OEdmlHyn6hWt1csLahlqKzhGMESp+s+0LpYNPRAqRxXd01ONJ66yfwbE5oqCF1Oo5q
         SK7Fesl3czn5ifLW4ibwf7iH95mMCG8tQdgkJzuraEsZhsxQNe509ljFvnzrHByJIdvq
         jOeTttA6UuLqev3CiAoBgcE6XeIcLc7/o2zn4pb9RHp088+sbAvmXfK3HCoTXM9pqNCl
         19tpBSWbWuQf1+y9iMX92npuWDXF0zDQ9kkoNpUWuDOZ0+TMCfbXcQaXNpQo1TfyWsYF
         7BvGt8RaGd3WW0wMc2F8yXyLPfk4kN+ax7TQ/fVIyhcPbEi9q3JvDiYamAQlLAiPhKp1
         e7xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QiKEN2Bz;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QiKEN2Bz;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELudy8dfrOpSh7/fBRlYBEgOCk2/7EgB0nUxod3RexBf/deJ3K96p+lOnk2N/ER68B7OTIkUTA==
Subject: Re: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
 robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com,
 vincent.guittot@linaro.org, skannan@codeaurora.org,
 amit.kucheria@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com,
 mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
 <20180318225029.GQ5626@tuxbook-pro>
From: Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <45cba7ca-3a83-0ef8-eff7-a8b33bce9185@linaro.org>
Date: Mon, 19 Mar 2018 17:34:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180318225029.GQ5626@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495918143221321?=
X-GMAIL-MSGID: =?utf-8?q?1595358130281189276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn,

On 03/19/2018 06:50 AM, Bjorn Andersson wrote:
> On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> [..]
>> +Required properties:
>> +- compatible : contains the interconnect provider vendor specific compatible
>> +	       string
>> +- reg : register space of the interconnect controller hardware
> 
> These properties doesn't relate to the interconnect provider, so there's
> no need to describe them here.

Agree.

> 
>> +
>> +Examples:
>> +
>> +		snoc: snoc@580000 {
> 
> These nodes should be described in a qcom/msm8916 binding document.

Ok, will move this and the above to the platform specific binding
documentation.

> 
>> +			compatible = "qcom,msm8916-snoc";
>> +			reg = <0x580000 0x14000>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +			status = "okay";
>> +		};

Thanks for the comments!

BR,
Georgi
