Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABDF2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABDF2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeFTP6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:58:20 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45457 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754061AbeFTP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:58:18 -0400
Received: by mail-yw0-f193.google.com with SMTP id v190-v6so12571ywa.12;
        Wed, 20 Jun 2018 08:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PD5Gk8cwj2G0Cm/lA+bmtMEd4mZ8z3+BBzHrE06wl2Q=;
        b=qzzD5dDEX2mGrLolb8ApvjHlr0t4EhAFz1VIHf2vdRP/SC+6TPSn8qFQQnsi8/6WFe
         RLJABgKmzTTQk0uAhpa9WidlHVQWVPGDGZcLSTAQRDtfMvYQjk0F8U8vmzKmbSXdbm3c
         Z2Ly3unTE58Vn5y5mh3yzPJadD+VcMEQx1OiywtinrAF/aMcEyeeVNOuYjjdyvGxuuiJ
         6m5512hnv6Fel0vy8at6oYMG0/tJdcdG6cuyfmklTn8r4nzcFwh1G7FuX70sLm1dN9OV
         3Kv/F0ldNPVlsiht9kiQzmsV9466JRdpXnhGHl5AqLkdhmUU9VacGldEIwgAivEksKyD
         80ZA==
X-Gm-Message-State: APt69E2PO1Y0pvqbNvV2LEa/IOgcq7XWl99t7ICSPC6vHucLDXvbr9uP
        /aNoBpRmwq5+IkR3mdWRkg==
X-Google-Smtp-Source: ADUXVKLKpUfcmDtZ7E+/6chthOxKwaH3fkVzIAzFKxmYOLfJQNf2EKzXiRuQtjJQe/D8CJ4DqNXazw==
X-Received: by 2002:a81:c507:: with SMTP id k7-v6mr10781374ywi.395.1529510297696;
        Wed, 20 Jun 2018 08:58:17 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o128-v6sm1107607ywo.54.2018.06.20.08.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:58:16 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:58:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Borys Movchan <borys.movchan@axis.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Borys Movchan <borysmn@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: add ISL29033 device
 bindings
Message-ID: <20180620155815.GA10569@rob-hp-laptop>
References: <20180613140043.5802-1-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613140043.5802-1-borys.movchan@axis.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:00:15PM +0200, Borys Movchan wrote:
> From: Borys Movchan <borysmn@axis.com>

Commit msg missing

> 
> Signed-off-by: Borys Movchan <borys.movchan@axis.com>
> ---
>  .../devicetree/bindings/iio/light/isl29033.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/isl29033.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/isl29033.txt b/Documentation/devicetree/bindings/iio/light/isl29033.txt
> new file mode 100644
> index 000000000000..988e40acc6ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/isl29033.txt

Preferred name if there only one compatible is the full compatible 
string plus '.txt'.

> @@ -0,0 +1,18 @@
> +Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated Digital Ambient Light Sensor
> +
> +Required properties:
> +  - compatible : Must be "isil,isl29033".
> +  - reg: the I2C address of the device
> +
> +Optional properties:
> +  - isil,rext-kohms: External resistor nominal in kOhms used for ADC
> +    reference. If not specified, 499 kOhm value will be used.

-ohms and -micro-ohms are the documented units. Please use '-ohms' 
unless there is a compelling reason not to.

> +
> +Example:
> +
> +        als_sensor@44 {

light-sensor is the documented node name for ALSs.

> +            compatible = "isil,isl29033";
> +            reg = <0x44>;
> +            isil,rext-kohms = <1000>;
> +        };
> +
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
