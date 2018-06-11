Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF0C2C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DD3208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DD3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933322AbeFKSPU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:15:20 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43512 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933452AbeFKSPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:15:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so1593050pfm.10;
        Mon, 11 Jun 2018 11:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=od0tPLMB85tETDmIVCjywjCvXuUto8NThnQAcsf+i38=;
        b=Hn9PXuCAI8lBIaIj0YkcdFq6YrxAvSzPM/LHEpgnegKKFVhihI3X76pWwLucV4uotI
         J70bvJDgwA6tpAGIgDVkw6ojpppk0AliX4vEtbDLTqky0PnvSrSNX8BAu/xrud1CgxZI
         QCfSO21loO6pN4Ki9OSgIGbOcZ1IyvwngCx50RPfNIt2nEt209Kvms+eQ1+yk0Av0mR7
         CoZr4+X/QAZQOX9OvXW40FCb5o3KwPbxNIhHS6gf5/0zP1Dttz+ApgcoNdRLebVPRrFM
         sSDmJUvLENpWopG4CegbquwdydQY2r93Jm3e7wNbYPLD+po1MIDzIUr+JgVrVsS9wjKp
         9afg==
X-Gm-Message-State: APt69E3ExyMXSmc6KL1n3h+3dh1BMhmrlSlzAAP7vNi2vwJ1yZjw0mlQ
        CDJMFv3yEwqMMN6/CAaGww==
X-Google-Smtp-Source: ADUXVKIa4AS/HDII7EwGTZ9PX0pNnl1WmV7kldd1jqwIay6m97u1RXdX/POXbcNBt1mwp8jaBUis5Q==
X-Received: by 2002:a62:d146:: with SMTP id t6-v6mr237643pfl.127.1528740917856;
        Mon, 11 Jun 2018 11:15:17 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id u84-v6sm77694527pfg.156.2018.06.11.11.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:15:16 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:15:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180611181515.GA32546@rob-hp-laptop>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <20180607181306.9766-3-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607181306.9766-3-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:12:51PM +0100, Craig Tatlor wrote:
> Add bindings for the Qualcomm Battery Monitoring system.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
> * Changes from v4:
>   Uses proper units and expands some definitions,
>   along with changing vadc@ to adc@.
> 
>  .../bindings/power/supply/qcom_bms.txt        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> new file mode 100644
> index 000000000000..a1a32d6ab460
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> @@ -0,0 +1,91 @@
> +Qualcomm Battery Monitoring System
> +
> +The Qualcomm Battery Monitoring System is found inside of Qualcomm PM8941
> +PMICs. It provides open circuit voltage (OCV) and coulomb counter registers
> +that allow the OS to infer a capacity level.
> +
> +Required properties:
> +- compatible:                   Should contain "qcom,pm8941-bms".
> +- reg:                          Specifies the SPMI address and length of the
> +				controller's registers.
> +- interrupts:                   OCV threshold interrupt.
> +- io-channels:                  Should contain IIO channel specifier for the
> +				ADC channel that reports battery temperature.
> +- io-channel-names:             Should contain "temp".
> +- qcom,fcc-temp-legend-celcius: An array containing the temperature, in degC,
> +				for each column of the full charge capacity
> +				lookup table.
> +- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values in uah,
> +				one entry for each temperature defined in in
> +				qcom,fcc-temp-legend-celcius.
> +- qcom,ocv-temp-legend-celcius: An array containing the temperature, in degC,
> +				for each column of the OCV lookup table.
> +- qcom,ocv-capacity-legend:     An array containing the capacity for each
> +				row of the OCV lookup table.
> +- qcom,ocv-lut-microvolt:       An array of OCV values in uV, one entry for each
> +				capacity defined in qcom,ocv-capacity-legend.

Need to say which of these are 8-bit values.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
