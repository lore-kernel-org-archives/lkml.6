Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754683AbeBGQnb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:43:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36404 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:43:27 -0500
X-Google-Smtp-Source: AH8x225/wRgI8tKBET0UH4e/U3sF9N4UEPLJRpHqlMiOaPgupTaDW0ZDIUaOhqCDfCRPnkLbjepf/g==
Date: Wed, 7 Feb 2018 08:43:24 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings/interrupt-controller: pdc: descibe
 PDC device binding
Message-ID: <20180207164324.GP9465@builder>
References: <20180207154958.13421-1-ilina@codeaurora.org>
 <20180207154958.13421-3-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207154958.13421-3-ilina@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Feb 07:49 PST 2018, Lina Iyer wrote:
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
[..]
> +Example:
[..]
> +	wake-device {
> +		[...]
> +		interrupt-controller = <&pdc>;

Sorry for not seeing this earlier, but this should be:

		interrupt-parent = <&pdc>;

Or as it's not unlikely that clients might use a mix of pdc and non-pdc
interrupts the example could use the form:

		interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;

> +		interrupt = <2 IRQ_TYPE_LEVEL_HIGH>;
> +	};

Regards,
Bjorn
