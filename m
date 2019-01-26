Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB84C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5173C218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBvDDAuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfAZBcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:32:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:32:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so5313117plm.12;
        Fri, 25 Jan 2019 17:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bpm/2QheN5kJtKHzjmtkw5lGHpt0EwWzXZdKKDqegfg=;
        b=QBvDDAuV4Q6zIcqd0jgXkLt51nhIe7IN10Fwod7T62XmvUhMswlTdKZl5HvU6lGh7r
         vuoeVmYLPC7vJpduOQt82IDbIbvuTQeSLw8v3KXwbUJlckdCquiRSOmgZtRhdtyKC1HA
         6OJYMqM/PC4HvJTcAT1miNJBkfQjbmSXs3l1LToTEH2YluGeAjdnGPB6xlrbpiMdXGBi
         sbKWcPR1zzlLFA4Bw11YL8ObjMtSpmXkdu/Lx9K8P5/tQDTybdoU5hUggnCNYveme4lL
         C37inEvhSoB6CM99IbmdWqPxXwbrx3ecuxqRpyZChw3UgT//gESyiUPWZGuPsmRpHzsF
         K5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bpm/2QheN5kJtKHzjmtkw5lGHpt0EwWzXZdKKDqegfg=;
        b=MlzNtUgpgvTWbipipkqIbm8ikZ1W1o3f5tFDilZJJB2Scegu7Ds7J8FiRQrV5+Du+c
         8gQfNnjN3jejT2GgWkDWm7kgfWjNKwGRLLAnYVY3SJNaUryLe391LtUZLyOVpcoDnj1I
         umcswM9txtEuNrzTzInBfgqiGE67yHi+TPYuXlmqxB6EYemgC6wSpiM1jTrHGY5P6lEm
         5VYRz8QTr9SUANntILL1JkqZUYbBi8hI/80PZUvV9r3/r+uQFKB3SNLD/dwdEObYl+jN
         xbguykdJaPfgx1Dxb/tE/q4jPDjHYrTrExz99Iztzx6ZydNZHflqK2pz+cIsxrbvWRzZ
         ngLQ==
X-Gm-Message-State: AJcUukekSupQJA8kPxbAWS5zsft5n6uvGLqOn3Ul+hBNmIu0ZJQdpY9x
        eFev+5SJD1zRr1soIL/WkIg=
X-Google-Smtp-Source: ALg8bN4wxbIfPJDzJsLEpadkg8ejpyqMxcj+8jBTKjsJprP4G8Ly6A1LbmRkDl4mp/Cb/KbHP0jXeg==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr13512032plm.154.1548466359841;
        Fri, 25 Jan 2019 17:32:39 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m20sm30077027pgb.56.2019.01.25.17.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:32:39 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:32:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: input: Add documentation for gp2a sensor
Message-ID: <20190126013237.GF212026@dtor-ws>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125175045.22576-5-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125175045.22576-5-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:50:45PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> This commit adds documentation for Sharp GP2AP002A00F.
> It's Proximity/Opto Sensor connected over i2c.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/input/sharp,gp2ap002a00f.txt     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
> new file mode 100644
> index 000000000000..c524eb7d3d60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
> @@ -0,0 +1,29 @@
> +* Sharp GP2AP002A00F I2C Proximity/Opto Sensor
> +
> +Required properties:
> +- compatible : Should be "sharp,gp2ap002a00f"
> +- reg : The I2C address of the sensor
> +- vout-gpio : The gpio connected to the vout pin

Do you know what it is for?

> +- interrupt-parent : should be the phandle for the interrupt controller
> +- interrupts : Interrupt mapping for GPIO IRQ, it should by configured with
> +		flags IRQ_TYPE_EDGE_BOTH
> +
> +Optional properties:
> +- wakeup : If the device is capable of waking up the system
> +- io-channels : Phandle to an ADC channel connected to the light sensor
> +- io-channel-names = "light";
> +- poll-interval : Poll interval time in milliseconds, default 500ms
> +- light-adc-max : Maximum light value reported, default 4096
> +- light-adc-fuzz : Fuzz value for reported light value, default 80
> +
> +Example:
> +
> +gp2a@44 {
> +	compatible = "sharp,gp2ap002a00f";
> +	reg = <0x44>;
> +	vout-gpio = <&gph0 2 GPIO_ACTIVE_HIGH>;
> +	interrupt-parent = <&gph0>;
> +	interrupts = <2 IRQ_TYPE_EDGE_BOTH>;
> +	io-channels = <&adc 9>;
> +	io-channel-names = "light";
> +};
> -- 
> 2.17.1
> 

-- 
Dmitry
