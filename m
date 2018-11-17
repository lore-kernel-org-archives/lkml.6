Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8083120815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8083120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeKRBqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:46:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32835 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeKRBqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:46:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so16499642oib.0;
        Sat, 17 Nov 2018 07:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N76KxkCGoujNQC2m1a0Xv670F3l8oqXF9XyF9SVbpdw=;
        b=HD4YmX+bFzy5j413PPczAaa60oktacjGuii+8TytLrp2ZhIaHV+j7IqzCT7juWvjMG
         IaRXEMy5OedLXCAVWGIS1mtWW/XAokN0P6ZIbRe3oePAQR9teA0BHiJmeZaP1dSFolzd
         2fiypOYE8sNzSKY6egNf5TJ1s3jpHVC55bnvCB3Y4/Wrd6MrnjGktzDC+tiQrCAoV031
         vf3B+2l7RGWRURmtMHKqZ8XUZpMh1AOgRtL7MpjVqLl9553RJ4bfDxLkyIAS48SYRkwr
         C9ufLKHJ9r7gaUT/IWJVWnO8bn639ZlPybQYdHAn0MtAi62Y0EQNQyHOREEjT+lVK1pq
         sDRg==
X-Gm-Message-State: AGRZ1gIXnmNNPVSCSbfw66PSkTykUDPd5cQyWcb6l4zbbws2vO5mA1m9
        0HiwhE3c6XKUZJoc3H5qdw==
X-Google-Smtp-Source: AJdET5eBcPOv8bdH72uFU/Y/a9TsZAEAQ+2nLuVs0KTjfXK5fAyxeLs0dWkimkaAoblO2k4uCd2Xpw==
X-Received: by 2002:aca:4805:: with SMTP id v5mr3145412oia.292.1542468591851;
        Sat, 17 Nov 2018 07:29:51 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id f34sm7954593otb.25.2018.11.17.07.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:29:51 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:29:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
Message-ID: <20181117152949.GA31247@bogus>
References: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
 <20181108225607.7521-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108225607.7521-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 11:56:06AM +1300, Chris Packham wrote:
> With the addition of the invert-pwm property the adt7475 needs its own
> binding documentation rather being captured under trivial-devices.txt.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - use pwm-polarity attiribute to indicate normal or inverted polarity.
> 
>  .../devicetree/bindings/hwmon/adt7475.txt     | 24 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.txt   |  4 ----
>  2 files changed, 24 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Documentation/devicetree/bindings/hwmon/adt7475.txt
> new file mode 100644
> index 000000000000..d9212b5e9036
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt
> @@ -0,0 +1,24 @@
> +*ADT7475 hwmon sensor.
> +
> +Required properties:
> +- compatible: One of
> +	"adi,adt7473"
> +	"adi,adt7475"
> +	"adi,adt7476"
> +	"adi,adt7490"
> +
> +- reg: I2C address
> +
> +optional properties:
> +
> +- pwm-polarity: This configures the polarity of the PWM. 0
> +		(PWM_POLARITY_NORMAL) uses logic high for 100% duty cycle. 1
> +                (PWM_POLARITY_INVERSED) uses logic low for 100% duty cycle.

So we're using part of the PWM binding, but none of the rest of it? What 
is the PWM connection here?

It sounds like this is common for sensors, so this should be documented 
somewhere common.

Rob
