Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9614AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52689214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXV+Ag24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfBLADb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:03:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39459 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfBLADb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:03:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so343412pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 16:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jtqFhIRtTjxHznjVfB/mPBDnRQTS72dZyHbymf3orw=;
        b=XXV+Ag24Y4F6pFQNbTAod+Vjvlq3rRfGlS1bFQ9CuA1J0r5tOMQ5pAdLOIFylgOIEZ
         T9sOcmpOnzOF4rUjHDzFKbp26kHRpEZyMEH9/vJHSxaELbOesWwQU81DC/mykC837VRc
         AsrJ4/YUN2LjWqAN4N3GAUQxKcjrLFiTWW3GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jtqFhIRtTjxHznjVfB/mPBDnRQTS72dZyHbymf3orw=;
        b=CAXqUxSZS1rzq6M9YNj9VKXCoT1Xg1vJPiXkUnoZnPe9N/6FXRQ/M4CxY4XaazC1n6
         T9FxscE9/z6NqgXURUPysdRSwCv1Pv7HW3GLU5SLKt2xgEaqfBHKhVelr5sJyYhAIIgs
         kpOlVdoLOMuiu/ju9NYtkj8fUUxTs/CoF5cE1kYHxtTIaBkJOGLgYBn8kGuNcG/pyK70
         flqAIUwHfzHkMdGUs2z4xQblvnylt698xYyAEjhFtw9azMqo6TLoLUxudu/kLAPVRsea
         g7/UybtGaFfro4cNQ6B8ijorQKsA4VtNJTjBZXM6FEFRj9OQIDkwBSpr/rMn7HT3iSGD
         0jOA==
X-Gm-Message-State: AHQUAuY+I/2YbN6QwsGXyMKLebxDykI84HGL7ifRGMqJTb/IecZSMw5V
        ATE0o1jUwTfsowBO9rAUqyfFog==
X-Google-Smtp-Source: AHgI3IaByifXQ4FWWEH9hx3CsIQqldhRaSCAx/rcsvRpaTSwwzR997KiMMy5Jr2CNQ3ci98AjywI7w==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr991637plb.306.1549929810399;
        Mon, 11 Feb 2019 16:03:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o11sm11374356pfh.107.2019.02.11.16.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 16:03:26 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:03:26 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     msavaliy@codeaurora.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow
 control is disabled
Message-ID: <20190212000326.GS117604@google.com>
References: <20190119002305.16639-1-mka@chromium.org>
 <3d739661db11d669cf8a9cba3f0853fa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d739661db11d669cf8a9cba3f0853fa@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply, your message got buried in my inbox :(

On Mon, Jan 21, 2019 at 08:05:10PM +0530, msavaliy@codeaurora.org wrote:
> On 2019-01-19 05:53, Matthias Kaehlcke wrote:
> > The geni set/get_mctrl() functions currently do nothing unless
> > hardware flow control is enabled. Remove this arbitrary limitation.
> > 
> > Suggested-by: Johan Hovold <johan@kernel.org>
> > Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for
> > flow control")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c
> > b/drivers/tty/serial/qcom_geni_serial.c
> > index a72d6d9fb9834..38016609c7fa9 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -225,7 +225,7 @@ static unsigned int
> > qcom_geni_serial_get_mctrl(struct uart_port *uport)
> >  	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
> >  	u32 geni_ios;
> > 
> > -	if (uart_console(uport) || !uart_cts_enabled(uport)) {
> > +	if (uart_console(uport)) {
> >  		mctrl |= TIOCM_CTS;
> >  	} else {
> >  		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> > @@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct
> > uart_port *uport,
> >  {
> >  	u32 uart_manual_rfr = 0;
> > 
> > -	if (uart_console(uport) || !uart_cts_enabled(uport))
> > +	if (uart_console(uport))
> >  		return;
> > 
> >  	if (!(mctrl & TIOCM_RTS))
> 
> Though late but wanted to check on why flow control is disabled in a BT case
> ?

Flow control is generally enabled, but for the QCA WNC3990 (and
potentially others) it needs to be temporarily disabled during
baudrate switches:

  Bluetooth: hci_qca: Deassert RTS while baudrate change command
 
  This patch will help to stop frame reassembly errors while changing
  the baudrate. This is because host send a change baudrate request
  command to the chip with 115200 bps, Whereas chip will change their
  UART clocks to the enable for new baudrate and sends the response
  for the change request command with newer baudrate, On host side
  we are still operating in 115200 bps which results of reading garbage
  data. Here we are pulling RTS line, so that chip we will wait to send data
  to host until host change its baudrate.
 
  Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

https://lore.kernel.org/patchwork/patch/1038502/

> If i understand, CRTSCTS at serial core is what makes flow as enabled with
> UPSTAT_CTS_ENABLE set and that in turn returned by uart_cts_enabled(uport).
> So is there any settings or configuration missing to enable flow
> control ?

To my knowledge there is no problem with enabling flow control (for
the non-console case). The problem was that RTS was not cleared when
flow control was disabled (done here: https://elixir.bootlin.com/linux/v4.20.7/source/drivers/bluetooth/hci_ldisc.c#L325)

> There could be a case to have 2 wire UART without flow control enablement,
> In that case we may need check for uart_cts_enabled() right ?
> Please add/correct if i missed something.

I'm no serial expert, but IIUC a UART driver doesn't know if the flow
control signals are wired up and is not supposed to do any specific
handling if flow control is enabled on a port without CTS/RTS
wires. Folks with more serial expertise please correct me if I'm
wrong.

Thanks

Matthias
