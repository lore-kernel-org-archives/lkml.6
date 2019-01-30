Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70DCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71EA2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548842867;
	bh=9d6rHs/SDFt8xKj8KZeuROPhEAeOAgVLz3LnRSYQQ2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V/fH5BPkgGiFmT4Rh9ZoF+rHf1QuPBajPYTmRsKa5ozF7hnnc0oGJohDcOSkjNtTt
	 pqKrvrGogscU7+V2g6XkdPmSM+r2Vog9FAuPyS1JUcmQ02WgFZ6Gt/qdZYlJURn0kX
	 2Jhh7O0zbkFEryOcogb60cjauZ+6FGLRiHxTHeVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfA3KHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:07:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41203 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3KHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:07:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so20164053ljc.8;
        Wed, 30 Jan 2019 02:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kN/2wSUiHLI2WtXBOwgOk4c/eaZ2luQazEMp69syOrg=;
        b=M7SmFJscLqKuyXAU7FbaI1uEiA5WWYQthvE/tijrbzjX6SID9ynPvSt6lvklYjotpR
         kLeFEt1lulru0Di7Sz7kl/e4t/Kc0/qS9XWygOfTZKkVmJW6vm0BxL22XO4w0xWKx/cn
         fB8/DY7JOWzw1S91pskcet02C8AhvEJaTVwkNHbeXL2OiIWUTQ5bYQTTXwfV/Vanr0Dr
         l4iQnXUzaMZn5/RtBxtgZXLCFze3Gigb7GA6iN0DWduWNwhZtJS4dvk8Igxja1m0+DlZ
         zeJjlzEck0CvREyG6u0s6jHbLAyzmQmjNaIH+MP6WO0BQ2MP5Z3Q8XFX9fLSbhw2KCHq
         8NRQ==
X-Gm-Message-State: AJcUukdP9BkCID7ZEhwLOlMlObAMMi4a/fQSNPPOQFBi47NBzDu+/8cz
        74ApZdlUjYki9KzKJR4xwXw=
X-Google-Smtp-Source: ALg8bN5wrFpThY3Q3Vv5g8H9yZ3uXDIuTZakbGOAiFji+khVX19qPlZOaBt3PhHCkYNFxY06MMKcYA==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr21308598ljj.49.1548842862949;
        Wed, 30 Jan 2019 02:07:42 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a18-v6sm195865ljk.86.2019.01.30.02.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 02:07:42 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gommQ-0001EZ-8l; Wed, 30 Jan 2019 11:07:38 +0100
Date:   Wed, 30 Jan 2019 11:07:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Switch pty driver to slave side in
 tty_set_termios()
Message-ID: <20190130100738.GQ3691@localhost>
References: <20190128065259.GA2976@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128065259.GA2976@myunghoj-Precision-5530>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 10:53:02PM -0800, Myungho Jung wrote:
> tty_set_termios() should be called with slave side of pty driver. So, If
> tty driver is pty master, it needs to be switched to ->link.

I'm not sure that's the right solution. PTYs are virtual devices used
for IPC and neither end (master or slave) have support for modem
control or baud rates.

> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..90c5ea8c399b 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -299,10 +299,18 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  	return 0;
>  }
>  
> +/* If driver is pty master, return slave side */
> +static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
> +{
> +	return  (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> +		 tty->driver->subtype == PTY_TYPE_MASTER) ? tty->link : tty;
> +}
> +
>  /* Flow control or un-flow control the device */
>  void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>  {
>  	struct tty_struct *tty = hu->tty;
> +	struct tty_struct *real_tty;
>  	struct ktermios ktermios;
>  	int status;
>  	unsigned int set = 0;
> @@ -314,11 +322,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>  		return;
>  	}
>  
> +	real_tty = hci_uart_get_real_tty(tty);
>  	if (enable) {
>  		/* Disable hardware flow control */
> -		ktermios = tty->termios;
> +		ktermios = real_tty->termios;
>  		ktermios.c_cflag &= ~CRTSCTS;
> -		status = tty_set_termios(tty, &ktermios);
> +		status = tty_set_termios(real_tty, &ktermios);
>  		BT_DBG("Disabling hardware flow control: %s",
>  		       status ? "failed" : "success");

So instead of these pointless calls to set the slave termios and
modem-control state, you might as well bail out early above (and
similarly in set_baudrate()).

Using n_hci for a master pty really makes no sense at all, so we could
even bail out at ldisc open, but perhaps that can be discussed and
addressed later.

Johan
