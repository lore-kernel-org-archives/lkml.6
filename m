Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2604823CA9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2604823CA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934163AbeGCQ6k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:58:40 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34703 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933063AbeGCQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:58:38 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so943746ywg.1;
        Tue, 03 Jul 2018 09:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEXNpG/vDHGqfqStbO0/PXbKZ26mJWba5U5as7wGSis=;
        b=qORZf+vdOk6WhiZLwPgCIAAN2rK6fojZHRpxiroRwj1TSM4S7+TLt59EpQE0HUdQPJ
         KA9Q2i8bh7QEH2WWjVHCaqGK5VLiK+lchz/mqqu2UvoolZIAa6Q2CLO/Sovky6QCAyki
         r1QjxYcxXE6GSLSZUzQyfO7sUOMe5DLrWy4q0a9Ry2rYm0N2kVYU0lb/EDGwf1s8cesj
         PnEyYKSOrp/eON6US+g59sKutgLVIgtyQ/+Ul7DURajBsLHWHB/dMsEL/6odNEhYVEtx
         iKFfIE35kRy0iwi52gJS53AQDAIfnFfy5fnDnT7z5hgptIFw7kHadK0UqlwXD32sU+wR
         YZDw==
X-Gm-Message-State: APt69E1cxvLIt+KTcqS6jwFeGPOwoDRamN/Lrb+XRg2eZG3PmV78depd
        I3ztUTBn2nPfuKiyll+gonCLq7w=
X-Google-Smtp-Source: AAOMgpdG5wDVXH1i91Kef7yh3QpAbuoqG+p5OQb7/gbOIl6tUw0jciXjZAZbsTON07Hye+1xIiNn8Q==
X-Received: by 2002:a81:3a04:: with SMTP id h4-v6mr15156522ywa.60.1530637117757;
        Tue, 03 Jul 2018 09:58:37 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id j128-v6sm526307ywf.9.2018.07.03.09.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:58:37 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:58:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH linux-next v6 07/13] dt-bindings: mfd: Add a document for
 PECI client MFD
Message-ID: <20180703165835.GA18160@rob-hp-laptop>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621194054.20897-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621194054.20897-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:40:54PM -0700, Jae Hyun Yoo wrote:
> This commit adds a dt-bindings document for PECI client MFD.

This and the next patch still have the same issues I've outlined in at 
least 2 prior versions.
 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> ---
>  .../bindings/mfd/intel-peci-client.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/intel-peci-client.txt b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> new file mode 100644
> index 000000000000..cb341e363add
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> @@ -0,0 +1,34 @@
> +* Intel PECI client bindings
> +
> +PECI (Platform Environment Control Interface) is a one-wire bus interface that
> +provides a communication channel from PECI clients in Intel processors and
> +chipset components to external monitoring or control devices. PECI is designed
> +to support the following sideband functions:
> +
> +- Processor and DRAM thermal management
> +- Platform Manageability
> +- Processor Interface Tuning and Diagnostics
> +- Failure Analysis
> +
> +Required properties:
> +- compatible : Should be "intel,peci-client".
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients starts from 0x30 based on PECI specification.
> +
> +Example:
> +	peci-bus@0 {
> +		compatible = "vendor,soc-peci";
> +		reg = <0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		peci-client@30 {
> +			compatible = "intel,peci-client";
> +			reg = <0x30>;
> +		};
> +
> +		peci-client@31 {
> +			compatible = "intel,peci-client";
> +			reg = <0x31>;
> +		};
> +	};
> -- 
> 2.17.1
> 
