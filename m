Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B72B2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Rp2gs74C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B72B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeKIBcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:32:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55193 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeKIBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:32:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so1778716wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aP8M3v2sKFe092cO729hyjHlswdFhJrc9am8yLdOFk0=;
        b=Rp2gs74C5I9YrNis8byjsSGu4AYKsx3Mkud0Iz01CYHEn2KPWjk3Ii7KzH5sqNp6c7
         t6IShP3eYRz7WwnsMa1Cx/KAZLhwf6UZbaAsPonrLmgrn4cpsxc6NeGA1cvW9KJKEOgY
         3nFl2ciyDUGQw4kYu+gXlVwFxp9IObtd6WOhja4jpiEMw7ocnsFv/o/Qqg5SsUgskT+j
         du/CZeyVZZIuJ/uuvMwDz1E7HnUhwgycopKrO9U/39U8osWxizr3Xm1qv0JmlDYl/pxA
         TfTDU/+9ZAi94Y5saFUmyPA/dkmr8tS5+LO4JiCh3S8KDu+AdhNpGaUjqUbvs/goaJaP
         AmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aP8M3v2sKFe092cO729hyjHlswdFhJrc9am8yLdOFk0=;
        b=ILQwoV572dxjjzLh8WfK5z8lGbvWzl1lkyRCw1lHI/v9clWBSYFHK76mWQrURcmkaI
         IkJ3fudM39cJceiDZrjtThJeVyIdtZwNCciaqTu5aJTNjydglA+0mL1hcO7iFvN1X/s3
         nMJm4mrZUjDzYpabSfRBpwsPHGNvKVA/z2AnH+hu6Q6q672UoLnkJhJ48Y+cwrJBf9+q
         lAWFl7XOJrPxshmIimWhF7nrsWCQlIuXrZ5qSrGo2kN1AKgEgtu/byuq2lDLJNcPGGzG
         sStX6xh2qx1duvPySfye1AdA8un3lRIydZ/ZUOnHPK8UIc8evbldraHM6yNXVXsiyOZT
         50ZQ==
X-Gm-Message-State: AGRZ1gJ4A23t9ilcV+hjFzMBdLP+kflUSDx7e4yx9kMT8ArxrkmzklB+
        8NwHyFVhn0iRWV6LMLf42tp4lA==
X-Google-Smtp-Source: AJdET5c0Xfm33uyNC+cpv6rYPYX+aFIaQv/2rbVSMMIFU5DsPeExT/Ar4mOeVrcQ1XKnVeiV2qpXAw==
X-Received: by 2002:a1c:da82:: with SMTP id r124-v6mr1779995wmg.54.1541692602234;
        Thu, 08 Nov 2018 07:56:42 -0800 (PST)
Received: from boomer.baylibre.com ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j129-v6sm5857745wmb.47.2018.11.08.07.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 07:56:41 -0800 (PST)
Message-ID: <bafa32609200e57d8efe9843247429a46916bbef.camel@baylibre.com>
Subject: Re: [PATCH 3/3] ARM64: dts: meson-gxl: Add support for the
 Smartlabs SML-5442TW
From:   jbrunet@baylibre.com
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Thu, 08 Nov 2018 16:56:40 +0100
In-Reply-To: <1541691207-24768-3-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
         <1541691207-24768-3-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 19:33 +0400, Christian Hewitt wrote:
> 
> +&audio {
> +	status = "okay";
> +};
> +
> +&aiu_i2s_dma {
> +	status = "okay";
> +};
> +
> +&i2s_dai {
> +	status = "okay";
> +};

The audio stuff has not made it's way upstream (yet) please drop this

> +
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> 
[ ... ]

> +
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +	status = "okay";
> +	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +	pinctrl-names = "default";

Did you forget to put 'uart-has-rtscts;' here ?

> +};
> +
> +/* This UART is brought out to the debug header */
> +&uart_AO {
> +	status = "okay";
> +	pinctrl-0 = <&uart_ao_a_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};

Also, you sent a multipatch series. Such patchset should start with a cover
letter describing the general intent ... even if it is obvious.

