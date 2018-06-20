Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0FEC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99C720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99C720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFTTwS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:52:18 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:42807 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932588AbeFTTwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:52:17 -0400
Received: by mail-yw0-f194.google.com with SMTP id t184-v6so278995ywg.9;
        Wed, 20 Jun 2018 12:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lySzHsXn0KVA8IEQMkXWe+zHmnR4iQ/2dPyaqm3CDO0=;
        b=ZueSo4TD4Wt2l9hv+Iqqh80iZu8L4/df3PI7Aiz5F3FUGq8TZFSb1rS2IB7l/18Y33
         PUdKRAWHBRNUmQa5/PDnyZOQpIL5ZCmGkf1XIw9QW1YsGLZ7qpqyNn7vmKtYNXuD3Vff
         LzZ3dp6QY0MrrA74A2sjgIWSAtNux52+DEVCEd4Y4lQbqEiZDgNK0o+igNCizGrkrMXc
         4HcRkDIz75us0PMD+2Suh46k5uy/fOMzN7pVMY9pJpHLrLTgbxHAWvhKsIMMeLZi4SDD
         yusGrOzt8HTgrb7f2yvTB+IabBJTyoYs9qMFPQezEeP5FxGSQJXH1OIX0laEXHaBdVgY
         RtNQ==
X-Gm-Message-State: APt69E335p1fW6ydkg1APe3GSOulRMboVTrC2MubhehrZPVYjm+l6iZ+
        Q0MzUPyy5kpNxs9ZS8nAxQ==
X-Google-Smtp-Source: ADUXVKISoAYK5+UWGcN5WVU7IvnUi8T9bBVrDL0d11x78yHYwTkxXa7bLLOoOW7EbXMZYFwQ7Oi1RQ==
X-Received: by 2002:a81:1d06:: with SMTP id d6-v6mr10824620ywd.322.1529524336594;
        Wed, 20 Jun 2018 12:52:16 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i5-v6sm1173807ywg.110.2018.06.20.12.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:52:15 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:52:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20180620195214.GA10436@rob-hp-laptop>
References: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
 <1529310679-13482-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529310679-13482-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:01:17PM +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add binding document for supported thermal implementation
> in Stingray.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> new file mode 100644
> index 0000000..33f9e11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> @@ -0,0 +1,45 @@
> +* Broadcom Stingray Thermal
> +
> +This binding describes thermal sensors that is part of Stingray SoCs.
> +
> +Required properties:
> +- compatible : Must be "brcm,sr-thermal"
> +- reg : memory where tmon data will be available.
> +
> +Example:
> +	tmons {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		tmon_ihost0: thermal@8f100000 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f100000 0x4>;
> +		};

You still haven't given me a compelling reason why you need a node per 
register.

You have a single range of registers. Make this 1 node.

Rob
