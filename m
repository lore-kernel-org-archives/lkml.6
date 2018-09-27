Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E48621714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E48621714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeI1Bv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:51:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39216 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI1Bv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:51:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id y81-v6so3215291oia.6;
        Thu, 27 Sep 2018 12:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=etmdW97d/fyYUgmIl6MYAtYFmHRPN6Th3fqlIpCV/ig=;
        b=qsBHVhP+6sAEfGlbRXNBJcSGLqhGZ5eDG8v3CeMldwKYJe0ltqlIk7lwcHuRjLwMii
         rux3OmLtqpGQOCzqvXkeQVtIUOgoYIQqJFBXCUR42nZlIJMG6m0xkOcNeM/diKmnkG5R
         BjcYv1nP/8HglpWUCETv26HceqhVXKxhvvw6TOvgowPVldWemnblkoKVjxG0neZMgupW
         MLDIIq+K6dGO04E6gjiY8B/ixs83F9tfLGeJoAuQBWyUwovNYr7LS90zIEhY3D/HtMtY
         19e8Nm0ur8cE152y0rCGQkZVUYYcnfufBnqrWSfI+MzbRDPcXNLdQrdrcSAEEBukM8US
         GIPg==
X-Gm-Message-State: ABuFfojnPTeXnugo2/Mav90Mzh0E+OfQBKIuEBH+EiAkovkXu5Wcabvt
        nUGaTPnh4IFxawLeHtt++X4vd03kqi1O
X-Google-Smtp-Source: ACcGV61iN8LjGqrId1OumixkyHa9TGBAOgmk7nD3I1Wam9dL1gzYaQ3URgTYl5Kmr1zmlDZqgh6FOQ==
X-Received: by 2002:aca:af06:: with SMTP id y6-v6mr4000687oie.274.1538076698609;
        Thu, 27 Sep 2018 12:31:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x65-v6sm513310oix.3.2018.09.27.12.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:31:37 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:31:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     ryang <decatf@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree
 binding documentation
Message-ID: <20180927193137.GA14849@bogus>
References: <20180922210539.6670-1-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922210539.6670-1-decatf@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 05:05:38PM -0400, ryang wrote:
> Document device tree bindings for ROHM BH1750 ambient light sensor driver.
> 
> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> new file mode 100644
> index 000000000000..468350cc7af6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> @@ -0,0 +1,18 @@
> +ROHM BH1750 - ALS, Ambient light sensor
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +    "rohm,bh1710"
> +    "rohm,bh1715"
> +    "rohm,bh1721"
> +    "rohm,bh1750"
> +    "rohm,bh1751"
> +- reg: the I2C address of the sensor
> +
> +Example:
> +
> +bh1750@23 {

light-sensor@23

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +	compatible = "rohm,bh1750";
> +	reg = <0x23>;
> +};
> -- 
> 2.17.1
> 
