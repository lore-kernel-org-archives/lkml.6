Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F2BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F6520817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F6520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeKRCUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:20:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39478 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:20:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id 192-v6so22077737oii.6;
        Sat, 17 Nov 2018 08:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hKmu3+vGORQZRVjL9RzdE4lTrhiw7EL+85h7W87Iay0=;
        b=kO0ho30mNjulZRY6wwtZe00pHNZJLDZ5rCklIS49d6Uquk0pNJlad5c7IHgF4CoEVC
         r5+Twodn08IHTtLOkq+nwLgstjLU9t6jWMIra+22aa5ZI+wJoGyXkDGMsiPZD1ATGjdT
         3DIFIwMDa3GWOo+9AxM8AhaxuWuhUpliSaMe6WkVE+jNEZat+/eENi/Pv76hxX1NazuT
         +aZ9A+aOwb7x4SpU3M6iAnG/Pkf/w3oOimPlxGqj4XRtYiwpIfkt8xPTGfWaTAyRcXSi
         rzKFh3siC2c/Xua1o7Eqi+BgzYWvZZpwX4VLQmUfyFWJo5i68DUEZyC0mcIScY19C029
         uu4g==
X-Gm-Message-State: AGRZ1gKa9O/dDIk01wdEBB6ybIFbmSae7eNzdIu1YuRKjdn3enNT8zGE
        CeR2U4oflZqbvaNl2eA/bA==
X-Google-Smtp-Source: AJdET5eUEArGVt8AbU82a/siyfGvVBJLRBIHM44IesAMNs4nFPVsDWzg75+X/S3TRwg3qFsLoTYJiw==
X-Received: by 2002:aca:3807:: with SMTP id f7-v6mr3594316oia.46.1542470587602;
        Sat, 17 Nov 2018 08:03:07 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id q199sm6197826oic.39.2018.11.17.08.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 08:03:07 -0800 (PST)
Date:   Sat, 17 Nov 2018 10:03:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 02/17] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Message-ID: <20181117160305.GA31494@bogus>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 17:23:48 +0100, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/cmd-gpio/cmd-gpios/
> - s/ready-gpio/ready-gpios/ in the documentation paragraph
> - Remove status = "okay" from the example
> 
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
