Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B356D20647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDnmbdSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B356D20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH3Fza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:55:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43589 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeH3Fz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:55:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so3111236pfi.10;
        Wed, 29 Aug 2018 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+cBkw1eH4L5nXn84Hsq69myaOod6+b7O8aUNTieI4RM=;
        b=XDnmbdSVImRHUxU4XLpaCxtTXnkraxxyHvsrkb+0fh7ibDBG2IUuIASD7c5S/ULfMn
         j40uFYTZWgywsl5S5t1QL85dlL99KZpKUviul0b9YMj7fumxIpYkWBc4unFpz/AjrFhM
         BVrZTn7Gr23r4WIJBW/KXAwoUsU+l4vrPnOkM36/CfiSytZr+A48Gsp/ieje0pkmahJm
         cfl/1HVuwr7ZrJ7rNC5X5YVGLrTdp0NVk5LwGwYlnWrnIvEkjpiSI7K09CyaNjDZUt/a
         1LneJ8U0WicJzD9c65c+LudVg+NgfRrGBfEgP8GL38wbDGLQShbKA8tlp+VsK9F5kPk6
         +Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cBkw1eH4L5nXn84Hsq69myaOod6+b7O8aUNTieI4RM=;
        b=WhF9P797mZH4Ir3srWDvFtCJRpBSQWjG4UwcDFOiTqhLo5ApYEASQWaV4Y8zGbgkP5
         L17Vv3MRE0KmMv+H17dAxg9Rczb3YITn44KkeOIt7uB5CJzYjvL/+mbujhJEU1C5jPNS
         l70MXR4p3Z5aQrmCi/LnmSV519Rog8wnHnzE4TMHtRcQ68SsDPLprwBeff0Eh3LXe/55
         cnoRWJEgHThn7Ebr5LSsDDnfE8twx9hgJIOgZH6mpB4Trt1vU7M/MMASB94lB5cjTR5o
         Wjrl4Y4o126+sUYuhCsWYT/yIZn9q+hMzS9QzFGsSZ+rwTN44VhC7JT9d2qK3m81Moyw
         clOQ==
X-Gm-Message-State: APzg51Akf8MydtPUe9/pYH8cuf7md1/NhSz1RjRp9B/GSsjTV3BfyjpE
        RCcLb0ZQw5KszqghzpKkbHs=
X-Google-Smtp-Source: ANB0Vdas5oUIK665bLTYEbSA+j6YxnddUyQrBDV08mQXB/nPgCEfvaXyQPp63QGc3zPcCTC6AKDHmg==
X-Received: by 2002:a63:d806:: with SMTP id b6-v6mr5530173pgh.347.1535594146859;
        Wed, 29 Aug 2018 18:55:46 -0700 (PDT)
Received: from [192.168.1.54] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id e14-v6sm7354180pff.128.2018.08.29.18.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:55:46 -0700 (PDT)
Subject: Re: [PATCH V2 3/4] serial: f81232: implement break control
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1535593634-22004-4-git-send-email-hpeter+linux_kernel@gmail.com>
Message-ID: <3f4bc3ff-1e72-54ee-1047-c69a0ff45771@gmail.com>
Date:   Thu, 30 Aug 2018 09:55:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1535593634-22004-4-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

This article is duplication with
[PATCH V2 3/4] USB: serial: f81232: implement break control
[PATCH V2 3/4] serial: f81232: implement break control
	(Title not start with USB token)

Should I discard this PATCH_V2 series and re-send PATCH_V3 ?
or could you discard the patch - serial: f81232: implement break control
only ?

Thanks

Ji-Ze Hong (Peter Hong) 於 2018/8/30 上午 09:47 寫道:
> Implement Fintek F81232 break on/off with LCR register.
> It's the same with 16550A LCR register layout.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> v2:
> 	1: Fix f81232_break_ctl() for mis-operated set_mask_register().
> 	2: Add set break control bit in f81232_set_termios().
> 
>   drivers/usb/serial/f81232.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 56adae8a9ee0..863430d7535f 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -65,6 +65,7 @@ struct f81232_private {
>   	struct mutex lock;
>   	u8 modem_control;
>   	u8 modem_status;
> +	bool is_break;
>   	speed_t baud_base;
>   	struct work_struct lsr_work;
>   	struct work_struct interrupt_work;
> @@ -377,13 +378,24 @@ static void f81232_process_read_urb(struct urb *urb)
>   
>   static void f81232_break_ctl(struct tty_struct *tty, int break_state)
>   {
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
> +
> +	mutex_unlock(&priv->lock);
>   }
>   
>   static int f81232_find_clk(speed_t baudrate)
> @@ -519,6 +531,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
>   static void f81232_set_termios(struct tty_struct *tty,
>   		struct usb_serial_port *port, struct ktermios *old_termios)
>   {
> +	struct f81232_private *priv = usb_get_serial_port_data(port);
>   	u8 new_lcr = 0;
>   	int status = 0;
>   	speed_t baudrate;
> @@ -572,11 +585,18 @@ static void f81232_set_termios(struct tty_struct *tty,
>   		break;
>   	}
>   
> +	mutex_lock(&priv->lock);
> +
> +	if (priv->is_break)
> +		new_lcr |= UART_LCR_SBC;
> +
>   	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
>   	if (status) {
>   		dev_err(&port->dev, "%s failed to set LCR: %d\n",
>   			__func__, status);
>   	}
> +
> +	mutex_unlock(&priv->lock);
>   }
>   
>   static int f81232_tiocmget(struct tty_struct *tty)
> 

-- 
With Best Regards,
Peter Hong
