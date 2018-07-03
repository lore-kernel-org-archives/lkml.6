Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A09C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDDA23C19
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDDA23C19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934133AbeGCQrg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:47:36 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47023 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeGCQre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:47:34 -0400
Received: by mail-yb0-f194.google.com with SMTP id s14-v6so978088ybp.13;
        Tue, 03 Jul 2018 09:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAuH4LH1gGeLkLg1XUekchSwnDFdQ8jOV8OkLjv4TjU=;
        b=Fbp6vBJiiPvBd0cymApN+sxwTHskG/DzPdM/LAMYTDnaabQ77XD/2DN8yspoOj7VZX
         eO+/T0TaepCWfi33Afyvm24av0s8AXAIT5xiGBy+PSP4VI5/J30i+N3igoJ+nf9boLQC
         WU3p0Iujx3ajhyOWjHTrFdYFoekY/9CB+CpqJRhlJie6VZj5NYea7QXvlMJXy8v4y0vW
         iiSpkTzaxF7AEkJzp186pzvs4+cirlYOml0eC0UnIXWnc6WNk6SAmrJefhu1bsNZth2M
         ndGmg52h4RNQGA8Zmoet5hVpv8m1Q2pNCRCOhc+h8UQGwlXccr+PflvXyK2mYvPU8otU
         /fOw==
X-Gm-Message-State: APt69E0ccnHB5CbdYc8m1iMZdBMulHPLE122lVtMU9U4RkjdlCuLkhhi
        smjUrSEIWgb0PHmDqZpEBc14Rdw=
X-Google-Smtp-Source: ADUXVKKU0PYMF9GX8+tgI4fGfUlk0bGLGlb+o39Y2LuVyCbUTpSaMd5+APV6cLlHz4RmRMkzzpWeNQ==
X-Received: by 2002:a25:da11:: with SMTP id n17-v6mr16135444ybf.409.1530636453408;
        Tue, 03 Jul 2018 09:47:33 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x129-v6sm501002ywe.61.2018.07.03.09.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:47:32 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:47:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH linux-next v6 01/13] dt-bindings: Add a document of PECI
 subsystem
Message-ID: <20180703164731.GA9150@rob-hp-laptop>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621193947.20645-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621193947.20645-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:39:47PM -0700, Jae Hyun Yoo wrote:
> This commit adds a document of generic PECI bus, adapter and client
> driver.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/peci/peci.txt         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci.txt
> 
> diff --git a/Documentation/devicetree/bindings/peci/peci.txt b/Documentation/devicetree/bindings/peci/peci.txt
> new file mode 100644
> index 000000000000..5583aa80b78a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci.txt
> @@ -0,0 +1,60 @@
> +Generic device tree configuration for PECI buses
> +================================================
> +
> +Required properties:
> +- compatible     : Should be "simple-bus".
> +- #address-cells : Should be present if the device has sub-nodes.
> +- #size-cells    : Should be present if the device has sub-nodes.
> +- ranges         : Should contain PECI controller registers ranges.
> +
> +Example:
> +	peci: peci@10000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x10000000 0x1000>;
> +	};

I don't think you need this section. It's just the parent of the 
controller, right?

> +
> +Generic device tree configuration for PECI adapters
> +===================================================
> +
> +Required properties:
> +- #address-cells : Should be <1>. Read more about client addresses below.
> +- #size-cells    : Should be <0>. Read more about client addresses below.
> +
> +The cells properties above define that an address of CPU clients of a PECI bus
> +are described by a single value.
> +
> +Example:
> +	peci0: peci-bus@0 {
> +		compatible = "vendor,soc-peci";
> +		reg = <0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +Generic device tree configuration for PECI clients
> +==================================================
> +
> +Required properties:
> +- compatible : Should contain name of PECI client.
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
> +			compatible = "vendor,peci-client";
> +			reg = <0x30>;
> +		};
> +
> +		peci-client@31 {
> +			compatible = "vendor,peci-client";
> +			reg = <0x31>;
> +		};
> +	};
> -- 
> 2.17.1
> 
