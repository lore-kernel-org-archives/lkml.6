Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F87ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6798720850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6798720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbeGTRvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:51:53 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34385 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:51:53 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so10473178ioj.1;
        Fri, 20 Jul 2018 10:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCHXlgkxSIXTogbUPnU17Hf+k6CFBrD7TxglqXiwzTs=;
        b=ebFD48fM3SRGnwsbkKYPgNMHPm1XrBRGi5kGVhohSjSJMIjLmJS2Dz4z47NhWjOCZ1
         YkdF8Yazo/x/+Fdd8G8NpIbrnv0JXX7GpjQ/61X+8jURPpwXdkGkpm2uUaQ+dNJ6JzRi
         SOUwVLKmQCBBlu9mEvH8FoDi1jYBp6GdvlrBM/35MfO3h+0e5XzyeXR70fsNBrd9wtPd
         ddc/6TZ9kKNsOpMK6zX+cB79BTTAaJDT9g/3fvw00YosSzykYvqlZXXIGRCFkfxqWVAO
         6MUg3B7INPQgPz7AbUgjRvWbL8Nw4vXKawT7fZeQWndS/cUrYmoPQMqGO2NzwMORtVxg
         eEEg==
X-Gm-Message-State: AOUpUlGzeO20JbDwCcfRm1Y8seQJOz9j6/usB2G9Of32zsKGQevJtNZh
        SqUnn2hN/a7/SLWWNQyCzw==
X-Google-Smtp-Source: AAOMgpeeK7xCNX4mdw3OiJ1mssDyIqfCAtDYaJGBt0SQ6pESJSwN1jRJ6zv1gozN0r1tvUc84I94GA==
X-Received: by 2002:a6b:6315:: with SMTP id p21-v6mr2243874iog.72.1532106163486;
        Fri, 20 Jul 2018 10:02:43 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id p130-v6sm1156377itc.38.2018.07.20.10.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:02:42 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:02:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 1/7] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180720170242.GA18120@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717084158.23532-2-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:41:52AM -0400, Brian Masney wrote:
> This patch adds support for the regulator framework to the mpu6050
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> Changes since v1:
> - Use devm_regulator_get() instead of devm_regulator_get_optional()
> - Use devm_add_action() for cleaning up the regulator.
> - Correct ordering of resume code.
> - Add regulator_enabled flag to ensure regulator is not disabled twice,
>   specifically the case where the device is suspended and then the
>   driver is removed.
> 
> Original extra changelog from v1:
> 
> This is a variation of Jonathan Marek's patch from postmarketOS
> https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
> with the following changes:
> 
> - Stripped out 6515 variant code.
> - Add the regulator to the mpu core instead of only the i2c variant.
> - Add error handling.
> - Release the regulator on suspend, device remove, etc.
> - Device tree documentation.
> 
>  .../bindings/iio/imu/inv_mpu6050.txt          |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 73 +++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  3 +
>  3 files changed, 77 insertions(+)
