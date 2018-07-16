Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34247ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6E208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B6E208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeGPSYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:24:08 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43312 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:24:08 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so15760609ybl.10;
        Mon, 16 Jul 2018 10:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+n2y7bqnH05oma4+qLV+X6GQKqHQu56p2vXD3bDgNA=;
        b=rJVdGcIVyeByHtGwIFWGG0UIeRzFnGIApkPOaGdXbvtrTMFo+dr7QRG0QzexdsexUl
         YZhtq8pRQcYamaHHk+u5lptPUu6tA/GIg5QIo4Qo4FO9r6wPzCe0PghZgTMJ00KeNsZW
         M1Lq5QwUeCuhuYk4ORqR298aTJbeRXpFjANqgMxUy94jiMgusD6lb1qHhORuB5wyVJGP
         BjRho7ke3IU+XDt80vzIAAHcf1jSaBXtmzVJZ58bXGJDWZ1teupvAS+8cLyAilR7gOxk
         tERJYBt8kgMTrHjURhLPTKY+fo116e0B+ZNQTnzS2mLyAqTBiqTei9iQ7VWD27XQlfZx
         ZwGQ==
X-Gm-Message-State: AOUpUlHmzHRmr1w4jjxEP299V9gYrSPyarNRBfxVwK0xdfX5Z9dfUgsy
        CG+wQRPwj5CRGRZeg2wtMg==
X-Google-Smtp-Source: AAOMgpcwGcHDE6EgLzsszJHwjafidfWz/mfZZjpry/HIf10ZAHoG/D1BgYsLs+pPt0U4g0H66WC7wQ==
X-Received: by 2002:a25:848d:: with SMTP id v13-v6mr9352865ybk.389.1531763737645;
        Mon, 16 Jul 2018 10:55:37 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c74-v6sm19075287ywh.17.2018.07.16.10.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:55:36 -0700 (PDT)
Date:   Mon, 16 Jul 2018 11:55:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pfuze100: add optional disable
 switch-regulators binding
Message-ID: <20180716175535.GA10835@rob-hp-laptop>
References: <20180713125002.24331-1-m.felsch@pengutronix.de>
 <20180713125002.24331-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713125002.24331-2-m.felsch@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 02:50:01PM +0200, Marco Felsch wrote:
> This binding is used to keep the backward compatibility with the current
> dtb's [1]. The binding informs the driver that the unused switch regulators
> can be disabled.
> If it is not specified, the driver doesn't disable the switch regulators.
> 
> [1] https://patchwork.kernel.org/patch/10490381/
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> ---
> Changes in V2:
>   - add more information about the binding
>   - rename binding and add vendor prefix
> 
>  .../devicetree/bindings/regulator/pfuze100.txt        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
> index 672c939045ff..2c46b8d368db 100644
> --- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
> +++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
> @@ -4,6 +4,17 @@ Required properties:
>  - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
>  - reg: I2C slave address
>  
> +Optional properties:
> +- fsl,pfuze-support-disable: Boolean, if present disable all unused switch
> +  regulators to save power consumption. Attention, till 4.18 these regulators

You shouldn't have kernel version info in bindings.

> +  were always on without specifying "regulator-always-on". So be sure to mark
> +  import regulators as "regulator-always-on" (e.g. DDR ref, DDR supply). If

s/import/important/

> +  not present, the switched regualtors are always on and can't be disabled.
> +  This binding is a workaround to keep backward compatibility with old dtb's
> +  which rely on the fact that the switched regulators are always on and don't
> +  mark them explicit as "regulator-always-on". On new dtbs this property should
> +  always be present.
> +
>  Required child node:
>  - regulators: This is the list of child nodes that specify the regulator
>    initialization data for defined regulators. Please refer to below doc
> -- 
> 2.18.0
> 
