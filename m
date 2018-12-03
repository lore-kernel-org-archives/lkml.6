Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB932087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB932087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLCXJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:09:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34995 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCXJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:09:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id v6so12585588oif.2;
        Mon, 03 Dec 2018 15:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePbUKxVAs2eazwfOSMuAHiYPZYsO5JPSfrUV1iwiCn4=;
        b=OwNZOjiPuHl9y+GKUo+llJ57eH7Ye15/oS3bpxbo/PX1+TnFimLctPxDnFpMvd0gh4
         uFJe/dpVpU6ui2D9LhM4Kbbjj6OX4stQWBbCh0aUvPihC3OvVLRZpKHAmt51wp6PgwZZ
         vygP8fQo8Eoxi5PErCGD3L6fmpHlvp1rgPhf/i4vCUnuDClZ0ndBaKzYWrU9uDn4ySY6
         L9nNHqgkZrDt0xezYfbJtaQ7Bzz8kYN41MeycooiIdd7TSJEku5bUIj1yS157qnMgpWi
         U0afvUZVe8zhxz2CMcnY0QUlF0OA3SXUo/oJzpU0Zh7oEQjG1fs3gC/RLzcsWsNBh4Y8
         cA6Q==
X-Gm-Message-State: AA+aEWYeEvbijtPX2VlXxf3GcpyO+u9LmZQDj7cfr46T7fw4S0yjJK0U
        LeBR6dZmLNH2MDBJIHkjHQ==
X-Google-Smtp-Source: AFSGD/VetK6JeAdrjBzg8PtePSmrCEJPlmVlKzYySemD9FU7hmbKN3tKZQ4rl7tp/a30dXZ25AIxUQ==
X-Received: by 2002:aca:5d57:: with SMTP id r84mr4269338oib.243.1543878548961;
        Mon, 03 Dec 2018 15:09:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m207sm6731899oig.2.2018.12.03.15.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:09:08 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:09:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com
Subject: Re: [PATCH v11 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181203230907.GA17086@bogus>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 09:25:02AM +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..2b82965
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-hw".
> +
> +- clocks
> +	Usage:		required
> +	Value type:	<phandle> From common clock binding.
> +	Definition:	clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +	Usage:		required
> +	Value type:	<string> From common clock binding.
> +	Definition:	must be "xo", "alternate".
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the HW bases in
> +			each frequency domain.
> +- reg-names
> +	Usage:		Optional
> +	Value type:	<string>
> +	Definition:	Frequency domain name i.e.
> +			"freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:

#freq-domain-cells

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
