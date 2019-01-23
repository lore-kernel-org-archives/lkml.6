Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BDE217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yd/WkN0S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eSmWqtut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfAWGxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:53:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfAWGxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:53:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B6B960795; Wed, 23 Jan 2019 06:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226411;
        bh=SS7rYxPdMVWkbtJ1ROXKiUWK5xHmQiMDL3yy5M8+eC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yd/WkN0StZT2EIX3AKuUf5ra7ZPQ+y07KK0iZhk0Fe23ZF3Y/kyQJ0mSdf8pic3Kz
         lAOGIriYYqnROWD9nz3PBmZgv7SDOLneIEWRQvHZhAbudQ5B4KEoU0ms9hnvyGmvD5
         NyDnUgGoFjqc09ict08U4kXn9VXdanpjErqpr0b8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 741BF60225;
        Wed, 23 Jan 2019 06:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226410;
        bh=SS7rYxPdMVWkbtJ1ROXKiUWK5xHmQiMDL3yy5M8+eC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eSmWqtutgGZH17+DdJsTXG9MD4aEjj7R1CupNgGXXPlUPRIGumFR0Yp3WjZ93T3RO
         PxINgkmjCj0RyKGvHdzePoNJkuDJhLaTYg2M7+0R6fEpDhKIfDX80oqRG4S58idG0g
         bTv1A0dY/DL2ELkFJwdC2QbpzSR3qj6CV3t57Kjs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:23:30 +0530
From:   alokc@codeaurora.org
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 5/6] tty: serial: qcom_geni_serial: Add interconnect
 support
In-Reply-To: <1548138816-1149-6-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-6-git-send-email-alokc@codeaurora.org>
Message-ID: <ac8c76ee1940d61278c0dd390982228b@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark Brown

On 2019-01-22 12:03, Alok Chauhan wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote accordingly based on maximum supported Uart frequency.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c
> b/drivers/tty/serial/qcom_geni_serial.c
> index a72d6d9..e2ea499 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include <linux/interconnect.h>
> 
>  /* UART specific GENI registers */
>  #define SE_UART_LOOPBACK_CFG		0x22c
> @@ -1348,6 +1349,22 @@ static int qcom_geni_serial_probe(struct
> platform_device *pdev)
>  		return ret;
>  	}
> 
> +	/* Set the bus quota to a reasonable value */
> +	port->se.avg_bw = console ? Bps_to_icc(1000) : Bps_to_icc(2500);
> +	port->se.peak_bw = Bps_to_icc(76800000);
> +	ret = geni_interconnect_init(&port->se);
> +	if (ret) {
> +		dev_err(&pdev->dev, "interconnect_init failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Vote for interconnect path early. This has to move as part of
> +	 * Runtime PM APIs when implemented for better control betwen
> +	 * console and non-console usecases
> +	 */
> +	geni_icc_update_bw(&port->se, true);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
>  		return -EINVAL;
> @@ -1385,8 +1402,15 @@ static int __maybe_unused
> qcom_geni_serial_sys_suspend(struct device *dev)
>  {
>  	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>  	struct uart_port *uport = &port->uport;
> +	int ret;
> +
> +	ret = uart_suspend_port(uport->private_data, uport);
> +	if (ret)
> +		return ret;
> +
> +	geni_icc_update_bw(&port->se, false);
> 
> -	return uart_suspend_port(uport->private_data, uport);
> +	return 0;
>  }
> 
>  static int __maybe_unused qcom_geni_serial_sys_resume(struct device 
> *dev)
> @@ -1394,6 +1418,7 @@ static int __maybe_unused
> qcom_geni_serial_sys_resume(struct device *dev)
>  	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>  	struct uart_port *uport = &port->uport;
> 
> +	geni_icc_update_bw(&port->se, true);
>  	return uart_resume_port(uport->private_data, uport);
>  }

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
