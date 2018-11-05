Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F965C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268B22085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268B22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbeKFHgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:36:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47012 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:36:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id q5so9551224otl.13;
        Mon, 05 Nov 2018 14:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D1oN3rM0SNziWmaeF24y0zW7FebKaZkVpZsX+skvOTI=;
        b=Xc1c9qm+JcSgg+3Dpzv58YeV+4g+HyGScS7tysC8qPBqBwE8sjTmMAgaL7qe4IIyVU
         dkapjrq7Qv4ccgMP5lXHb9GpqzkNNDy/h4EWw9WJ3x/Dt1wV0kpzvnEE9FM/MZ1CZv4v
         6zFsqp3yCWewcbPqttSCmHEaDlIUsu4ZhBIqHhlgY4/4Qmju88ocvImtBApfuRsrnMPJ
         Lwmjzy3y8cXOi7ykb/ajWYt//IVoTf+Y9Dl4+BBv/KOrE6GXM6xrKg/d+l0o7pSOx5fP
         RXRZLycENcAFXT6YGuaq/l7EQB4lKoGpPpFtIc55CekJmsSosdlrY7JO93hYzACae4DM
         w0YQ==
X-Gm-Message-State: AGRZ1gIaTRMXgSWsZMqyByc17Mn725qx1sO4kmU6ijDdyV2O4XYwJu+d
        smC14BFl8SCgmNmZWFb2IA==
X-Google-Smtp-Source: AJdET5ee4a+PH+byDr9Qs4Dkzqp3eWsCDHJPfwwjPaqVfLvMZjZTEFCqeN52P8+3wK+oF2pV2dtoxw==
X-Received: by 2002:a9d:2cd3:: with SMTP id e19mr13398718otd.363.1541456087622;
        Mon, 05 Nov 2018 14:14:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c30sm1800070otj.62.2018.11.05.14.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:14:47 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:14:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 bus+gpio 4/4] dt-bindings: gpio: Document GPIOs via
 Moxtet bus
Message-ID: <20181105221446.GA825@bogus>
References: <20181102103539.6077-1-marek.behun@nic.cz>
 <20181102103539.6077-4-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181102103539.6077-4-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:35:39AM +0100, Marek Behún wrote:
> This patch adds documentation of the device tree bindings for GPIOs
> on the devices connected via Moxtet bus.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/gpio/gpio-moxtet.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
> new file mode 100644
> index 000000000000..7e9b5770585d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
> @@ -0,0 +1,18 @@
> +Turris Mox Moxtet GPIO expander via Moxtet bus
> +
> +Required properties:
> + - compatible		: Should be "cznic,moxtet-gpio".
> + - gpio-controller	: Marks the device node as a GPIO controller.
> + - #gpio-cells		: Should be two. For consumer use see gpio.txt.
> +
> +Other properties are required for a Moxtet bus device, please refer to
> +Documentation/devicetree/bindings/bus/moxtet.txt.
> +
> +Example:
> +
> +	moxtet_sfp: moxtet-sfp@0 {

gpio@0

> +		compatible = "cznic,moxtet-gpio";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		reg = <0>;
> +	}
> -- 
> 2.18.1
> 
