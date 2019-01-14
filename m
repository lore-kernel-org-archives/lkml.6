Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED98B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547473707;
	bh=kfV03/WRC7tGVD6coZg5NFSQRMrDPiRuum+tS6CyZdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nXzroMHOKPKn46CVWJugdXZwIhMOKgV6RL0pDVpgdmgqhu+EOkYoD/FmzIi5UeUYG
	 iKRFbQHlim2ryw6tnIkeOVYrgbXghHYdXKluZswX3BjMxUb62hNRHTQdbosSRV5Eh5
	 IDBnttl+nhYZ2lRNuXK1EFKg2WoHMSYLmGg7WY0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfANNsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:48:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34269 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfANNsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:48:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so19091262lje.1;
        Mon, 14 Jan 2019 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XgL1f+ntB35z83VdEAJq+RYgAW/AsBrWQxuF6AIvDWc=;
        b=MiXzjUKa9mw2r1nE8YmOnL3XpddlF7C692ymjJifoV2Ya4CA/gz0oAlAWKD1FkDewO
         GlItB8pjJOKz2StLqrp5nyZ7eZKmxc415IlVEUZ/Y2Vp6VtKjVqTin6Ev/V9zPKJ1JQg
         UpW58arGk3sSpHZcW47HKHbI7GcN5mL/CChebfzHYDAPu/ezCn99Y3eHA54isOxhTulf
         R88U/TiTNARzy8tzAt0xfVH9nqcd/zermRNl+PvXGu9RIeX5ZPSbTTHXLOhMSUN8938B
         z+DKmCqSwwV93C55nK1OCCZ4fURlLurfDmpCDaD/pMMOf+egjBPM+eG5wGXJxDPV0Yz7
         H1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgL1f+ntB35z83VdEAJq+RYgAW/AsBrWQxuF6AIvDWc=;
        b=bjqJ7u7cWqe8HZSnOKyKqzCUfPO+wqs5tQokUaHPLUvfmvyWg7LbWfTr5nRr/K6bUT
         s/H+6+c2Omj0y1mk3BWXatkZj118gQkB9UniJTJpClQ8ZVksA+LGk2OAeEOQwonNBbd/
         wf/g+kQyo962U0igUN128PnPAg3u+4pT0XbzkoTdxXg9yFB6kgEVpxuwwW4u1xXc7zhs
         UXvwdnce6hSZ8hgPkpaeg6Ks7/J576/cFu36Kdnmb9QKuwvUnns2KTFRGeoxA7IYib2P
         Jyjv3Tbae+69e1Wyi4y5xvv4Na8jqhedK2TMOC+OJB/ETl78q/Tg4b2e57FFUCi2bhoy
         H7Yg==
X-Gm-Message-State: AJcUukdeuUdNEsBFnWWcMRBtPaVzRGWRX/K/NSaAX3xbYZ5DlXH2+OhD
        WzaTCy2E49YYxqfgUUBy3h4=
X-Google-Smtp-Source: ALg8bN45laRHI4Z0jFmYuLBE3wMw14no2sUQwdJQ+ELtxBXpeWwwmUgOJU1/6gA7wwk1Lg46Q3p1TQ==
X-Received: by 2002:a2e:851a:: with SMTP id j26-v6mr14433182lji.163.1547473702118;
        Mon, 14 Jan 2019 05:48:22 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m10-v6sm88223ljj.34.2019.01.14.05.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:48:21 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gj2bF-00050s-1e; Mon, 14 Jan 2019 14:48:21 +0100
Date:   Mon, 14 Jan 2019 14:48:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH] USB: serial: ftdi_sio: Fix GPIO not working in
 autosuspend
Message-ID: <20190114134821.GH3691@localhost>
References: <20190114123003.8228-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114123003.8228-1-pados@pados.hu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 01:30:03PM +0100, Karoly Pados wrote:
> There is a bug in the current GPIO code for ftdi_sio: it failed to take USB
> autosuspend into account. If the device is in autosuspend, calls to
> usb_control_msg() fail with -EHOSTUNREACH. Because the standard value for
> autosuspend timeout is usually 2-5 seconds, this made it almost impossible
> to use the GPIOs on machines that have USB autosuspend enabled. This patch
> fixes the issue by acquiring a PM lock on the device for the duration of
> the USB transfers. Tested on an FT231X device.
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> Please consider backporting to 4.20.x, otherwise the GPIO driver is not
> really usable for anybody with USB autosuspend enabled (eg. many laptops),
> at least not without manual configuration.
> 
>  drivers/usb/serial/ftdi_sio.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 1ab2a6191013..01813dce37f2 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1783,6 +1783,13 @@ static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
>  	int result;
>  	u16 val;
>  
> +	result = usb_autopm_get_interface(port->serial->interface);

Both of the functions where you add autopm calls already have a local
variable for port->serial.

> +	if (result) {
> +		dev_err(&port->serial->interface->dev,
> +			"Failed to wake device from autosuspend.\n");

And we tend not to log errors for these calls.

> +		return result;
> +	}

I replaced and port->serial with serial and dropped the dev_err:s before
applying for -rc3 with a Fixes and CC-stable tag.

Thanks,
Johan
