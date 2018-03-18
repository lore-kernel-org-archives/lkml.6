Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521413429; cv=none;
        d=google.com; s=arc-20160816;
        b=MyU4YVO+g9RQtttrnrlvk1iu4dS5kJtd7ENYh9DNJgaSp9I/gFIUDAenOOJV0PU9qB
         80HXWz1VUTwVicsmZXl9RTXi/mMB33RzngiIKUrMnzuKrgm0rcWi4/RDnvw14ynRN0mZ
         kmYgsUw3zamFSgtvmrAIV6AvS6nBiyoJxevA56pK59hhdMiurCA23JGOD1RhOQnzH+cC
         Bf2IAoooOIYvUCKNy9z3vc4mDs2DuQdwBtiPU5GYNMlFAvX4dVG2fQi81irIUpmgdZQU
         0tNuZ6qNUpZipHNZ5yGrrlzBBgA0l2A7qDhpR+4O3bqdQXkzm19GlfnBCaJgOaO3keTR
         Qgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=q1POGyhjW/aONV2jQdWCU1ZOF3R6s5s4orhNW5SY5sg=;
        b=ooEs5rTQUVk65tIbvwSrDzCMh2KRusT2lhDNIi8dl0nOA23TJiQK95Jbclax4nA8tk
         XXg2nOd64QUVvSNlBkHKqfwHd9eYyaTidvR7cf6gJy0ylY/By9rgWa+Z5AdZX3/e5Hdm
         RY3a/4qRh7/sh7ZIxHP0mxXUeCsHJPUGkip7DihDTFM7sAtvEW6ZsYnWLbHl/K4N5rs0
         IdqAJzyOosda/VhPgYVszciD8d5BF8Lzw0U10023eN6XAyHUtcgxHTXjXDtvf728CImM
         NCs1OSRInyBfNpv+ScjwF6JN2RMn91fCBrgltkLCyzzL6av4yVo7ECvIcZZNj9LroI4l
         kk9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=b9wQ7FK8;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=b9wQ7FK8;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELv6NLhNpeMm5vsTtFtL0RNzXZ0kcuqEneyOciVme7vHRIp4equIe0GoQBP0FZKh8CpHufYpuw==
Date: Sun, 18 Mar 2018 15:50:29 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
	robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com,
	vincent.guittot@linaro.org, skannan@codeaurora.org,
	amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
	davidai@quicinc.com, mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
Message-ID: <20180318225029.GQ5626@tuxbook-pro>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309210958.16672-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495918143221321?=
X-GMAIL-MSGID: =?utf-8?q?1595317608179311365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 09 Mar 13:09 PST 2018, Georgi Djakov wrote:
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
[..]
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware

These properties doesn't relate to the interconnect provider, so there's
no need to describe them here.

> +
> +Examples:
> +
> +		snoc: snoc@580000 {

These nodes should be described in a qcom/msm8916 binding document.

> +			compatible = "qcom,msm8916-snoc";
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +		};

Regards,
Bjorn
