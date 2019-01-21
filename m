Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE912C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9F820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548060450;
	bh=ujnd5zxDgrfMK9ksr0gHiFYUF1IorcL3aGtLzwrbI9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=doyQ7XjMkEGC2MiEL2Rh4n6EjjCz3oxo8qMYZbxYn9lHjU+NEUhnGK5Tau5C7x637
	 5rUWde/5Z3SEptthnc5dQ99MQq0NJC2/UrDq97N5FoFdgd7nO2z0BOluw+lxXoeO87
	 jhIdDpiXidycIi46XHd01cqS4heuLCqycZqDSKuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfAUIr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:47:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41049 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfAUIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:47:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so16772454ljc.8;
        Mon, 21 Jan 2019 00:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGHnVyIupfMKHeMrNxr37ORjizpqDC9iPIfLKClcFEM=;
        b=Wr8WkIxGo6WnPjki09ejj67aihSonPZ+R4y800w7uZZWpPNe7iNskHWPWy/FKa7TVV
         BIOprO8EXfzaieE30VctTr1aJEPyhr7tbCViMVD1btqv8+4CDcXIof2J/Lx1Lr/BQDIl
         DsCLUcMH0brAy41v0IfBzATouYsRHAYFmtPnGgJj743O+dGn7sQ0h/Fv3NpF1eGYoEAj
         CKeEFS0J7VR0Xb0rRJ3oBcjyPoOMGA1V2EhIA8M8A13x13uhisrWb795fDbAjOrES6Yj
         uWXxBHTY5sHt7QrOWG+SwOUa3Kz3FZ8yge0jJptTYfrVYZWX3qED+hh7LOyWYwQkAZWj
         nE1w==
X-Gm-Message-State: AJcUukf/X/TO5DLKbCUijaoQfMLMeiQxG22n8qHJwjyrfp3fmIYZWBSD
        x0wgs1ezOGrr8Ve/qX9//ao=
X-Google-Smtp-Source: ALg8bN7JyAwlWt8y4rfJRx9RKzezH6IQ0UdNTljYJsuh1H1yBLaW1XE8sO7AGhGEnBCR0eoBbGPGwA==
X-Received: by 2002:a05:651c:14e:: with SMTP id c14mr16726298ljd.20.1548060445922;
        Mon, 21 Jan 2019 00:47:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e97-v6sm2191383lji.51.2019.01.21.00.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 00:47:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1glVEl-0000Mm-QZ; Mon, 21 Jan 2019 09:47:20 +0100
Date:   Mon, 21 Jan 2019 09:47:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow
 control is disabled
Message-ID: <20190121084719.GF3691@localhost>
References: <20190119002305.16639-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119002305.16639-1-mka@chromium.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:23:05PM -0800, Matthias Kaehlcke wrote:
> The geni set/get_mctrl() functions currently do nothing unless
> hardware flow control is enabled. Remove this arbitrary limitation.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Good to hear this was all that was needed. There don't happen to be any
publicly available documentation of these registers?

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index a72d6d9fb9834..38016609c7fa9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -225,7 +225,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
>  	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
>  	u32 geni_ios;
>  
> -	if (uart_console(uport) || !uart_cts_enabled(uport)) {
> +	if (uart_console(uport)) {
>  		mctrl |= TIOCM_CTS;
>  	} else {
>  		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> @@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>  {
>  	u32 uart_manual_rfr = 0;
>  
> -	if (uart_console(uport) || !uart_cts_enabled(uport))
> +	if (uart_console(uport))
>  		return;
>  
>  	if (!(mctrl & TIOCM_RTS))

Ignoring mctrl when the port is a console looks broken too by the way.
The driver parses and handles the flow control parameter, but these
conditionals later overrides it.

Could be fixed in the same patch or in a follow-up patch.

Either way, you can add my 

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
