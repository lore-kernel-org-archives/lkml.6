Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B0C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE992077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDgmsbEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE992077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIETMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:12:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36887 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:12:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20-v6so6288374edd.4;
        Wed, 05 Sep 2018 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJLWh5J1xF5RGAEKnnqjrDnkn+ci55h1xB0YZ6pxCoo=;
        b=qDgmsbElaQQRsRZZnNC+HPs5/ecZZAq0LSDOopYMAjexsEWFQfsvTmXvYyzgXlj7J2
         nNercsrxFttYSXYXHLRWQiOS5glyO1yQXFu+h8FZwbmzQ8r/g91VMcxJypOr/lhnb4MN
         IZYCAGhUvNMgMoWTxxe7wTTb8RHXuhVf+yKzB3suNxZiU0V34M1T1y5h7P4tukGEjdch
         g2ePGueXQXVXJmW6/cn1WuMqX3I59mbFHd2SF9HxAS4gZQaxR1DmTt1CxI5eTEVXZo7/
         LkBLyN+cADKT6ev52CJVRmZRZTfDVZPHr4KaCYdDaDi5TTWNoe12kdqxh3uuD2Jpj4dk
         Vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJLWh5J1xF5RGAEKnnqjrDnkn+ci55h1xB0YZ6pxCoo=;
        b=RZXAWA9N46qqwRYTv2uEVzQ1xQh28HXHKn6B/6K8pg+BdznCI/Hj6ELxdLCn+lTqv5
         0HBq3cVqWegCJcm6ZyNyQj/8G9+ePSFyBs92HKYunX705gO7U16stOB/9jXwudpr3WH9
         lKdkMIwmNNZ+ADcwg7Mfpm6FM31pmODf2oRZK6DFcUhnFBkRpmUfIKuhnyULp3WE6KBK
         5Uwe7VQUDC40lrcBHV4IStSKeGit5tASO6i8v2UWmTVThwxBBiPaUteOkLxkPQrqnK50
         kbsYZcPirj6MA+qfYchFxeWQM41nuNneHEYMORWQb+WTDNW7nGYI6EMc1wrZw5bmfSBe
         mItg==
X-Gm-Message-State: APzg51DyP36s+jO13z/DUugBzNebN76a78OgkzsXTUwkXQIhcY13uItO
        2cn+cRJH3Ew3S2igSN5G5AM=
X-Google-Smtp-Source: ANB0Vdbnoa6SeoDPYS7kvvkTKwX/LMIwiwMT6bzZ8qtg/g1Py3HSW/6cdl+qdj4yEoMeM5cF5s+Dog==
X-Received: by 2002:aa7:d78c:: with SMTP id s12-v6mr42334415edq.69.1536158502101;
        Wed, 05 Sep 2018 07:41:42 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h40-v6sm1183843edh.88.2018.09.05.07.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:41:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxZ0D-0004eT-58; Wed, 05 Sep 2018 16:41:53 +0200
Date:   Wed, 5 Sep 2018 16:41:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw, hpeter+linux_kernel@gmail.com
Subject: Re: [PATCH V2 3/4] USB: serial: f81232: implement break control
Message-ID: <20180905144153.GD1089@localhost>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1535593634-22004-5-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535593634-22004-5-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:47:13AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Implement Fintek F81232 break on/off with LCR register.
> It's the same with 16550A LCR register layout.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> v2:
>         1: Fix f81232_break_ctl() for mis-operated set_mask_register().
>         2: Add set break control bit in f81232_set_termios().
> 
>  drivers/usb/serial/f81232.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 56adae8a9ee0..863430d7535f 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -65,6 +65,7 @@ struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
>  	u8 modem_status;
> +	bool is_break;
>  	speed_t baud_base;
>  	struct work_struct lsr_work;
>  	struct work_struct interrupt_work;
> @@ -377,13 +378,24 @@ static void f81232_process_read_urb(struct urb *urb)
>  
>  static void f81232_break_ctl(struct tty_struct *tty, int break_state)
>  {
> -	/* FIXME - Stubbed out for now */
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
> +	int status;
> +	u8 tmp = 0;
>  
> -	/*
> -	 * break_state = -1 to turn on break, and 0 to turn off break
> -	 * see drivers/char/tty_io.c to see it used.
> -	 * last_set_data_urb_value NEVER has the break bit set in it.
> -	 */
> +	mutex_lock(&priv->lock);
> +
> +	if (break_state) {
> +		priv->is_break = !!break_state;
> +		tmp = UART_LCR_SBC;
> +	}
> +
> +	status = f81232_set_mask_register(port, LINE_CONTROL_REGISTER,
> +						UART_LCR_SBC, tmp);
> +	if (status)
> +		dev_err(&port->dev, "set break failed: %d\n", status);

Why not maintain a shadow lsr value so that you don't have to retrieve
it every time you want to change the break state? It looks like you do
it this way in f81534.

Johan
