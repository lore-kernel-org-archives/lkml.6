Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99F3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0D20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548662311;
	bh=+9Q7ezDpx6kMr43h4c4CTUe+4tLiKv4QfZ4uxKhM4wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qjJFRnnguD0t/07szE/TW+BhM9z2wYDZxuZRkocCti4TutD/vXnGSV6r6HIFfj+j7
	 XwNlqH1xKtSOUeeZzHrjuimgEc9gRpr3sWXRz980gRb3dTddqXDu1Ulbz81h4R5XJg
	 QaNy+ppIeCJSuzTQjG/zOnZOJss1XpYdsqUd0vlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfA1H6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:58:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34051 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1H62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:58:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id u89-v6so13401595lje.1;
        Sun, 27 Jan 2019 23:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uX4EWl+872Z83SHKtTPVAAO1e9XNAnakGSaGM3zqyVY=;
        b=TowfRVOa4u4eikpTYZYpMO50+dCm5ur0fKYBeEw24xqYv0nM53NE6yG20Pd3hxoK7R
         CJ2irbZ+PaxQRFkn9BeuYMsBs9YVUN/TWlA2+fHvxyZlRrkEdbKHc6jPlTSEUL3Sq50L
         W3czxVUcVw+IMnMu/YREGcnXufqVNtsuKbCXtefmh544BeE+12dNSu3remmmXqIC42Xc
         bzBiWD/GHjYHBUPJcAxhSjHxZOSDIwxuUQjgssfSiFqgPidni+545luMD4O7LO9sDgK/
         D17MkoAoCCO0WQQ5xhWcr5snB8JUaf7+Y/OUzis4NIK+STSYPuQzcdOa6IGWmeLJJu7d
         t9zw==
X-Gm-Message-State: AJcUukf6AJFH0B75gkeqfYTVvc/o5btgLIst/36ScxEnnJclmPaeLO1y
        5dltTOZC86fg97y828Hxt/s=
X-Google-Smtp-Source: ALg8bN54kxMDhxn7/V+/4QYFNuMpaDXkPqz/pe+5yXkSoxMbvC4Ly5x2lVQHNQgFd4bWUZv+BTdhWA==
X-Received: by 2002:a2e:310a:: with SMTP id x10-v6mr16006353ljx.6.1548662306567;
        Sun, 27 Jan 2019 23:58:26 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y23-v6sm2904753ljk.95.2019.01.27.23.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 23:58:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1go1oB-0000R0-UG; Mon, 28 Jan 2019 08:58:19 +0100
Date:   Mon, 28 Jan 2019 08:58:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, johan@kernel.org, robh@kernel.org,
        jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190128075819.GK3691@localhost>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-4-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127181916.19948-4-tduszyns@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 07:19:16PM +0100, Tomasz Duszynski wrote:
> Add device tree support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .../iio/chemical/plantower,pms7003.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> new file mode 100644
> index 000000000000..e4c7f2fb1e30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> @@ -0,0 +1,19 @@
> +* Plantower PMS7003 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "plantower,pms7003"
> +
> +Optional properties:
> +- vcc-supply: phandle to the regulator that provides power to the sensor

Shouldn't this one be a required property?

> +- set-gpios: phandle to the GPIO connected to the SET line
> +- reset-gpios: phandle to the GPIO connected to the RESET line
> +
> +Refer to serial/slave-device.txt for generic serial attached device bindings.
> +
> +Example:
> +
> +&uart0 {
> +	pms7003 {

The node name should be generic and reflect the functionality rather
than model. Perhaps "pms" will do here.

> +		compatible = "plantower,pms7003";
> +	};
> +};

Johan
