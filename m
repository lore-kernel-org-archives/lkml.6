Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7CDC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE022086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKiC6DQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391526AbfAOXqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:46:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732635AbfAOXqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:46:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so2031172plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+HtLVjxVYelMVW/4PzRZAPWPokOcYmvOhrnUOFoHAE=;
        b=lKiC6DQWkLYWmztbIKQu81fq3BVCLsFBBptM2qZJnCrl779Rm2JyaK5XdtU559Iyoo
         B1nvY1td07DxEh7Ff6hWPEi/9MwGSny9Udhazrv5UlKQwehIS3vyouTJ/CbKq/zNSmKJ
         19fFNJhmek51BUFLaE+6hv331vmhbaGXO5A+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+HtLVjxVYelMVW/4PzRZAPWPokOcYmvOhrnUOFoHAE=;
        b=Xix0MK0aka0SasCHQJmahvDmGht7upTEN0DCjxaeYHC91ArKfLH/j3F6ZUD2KD7YeW
         89DEc9AHzbgilDZohoOL+nWjg2kPjzzSq5/W3C+vjGPIXZ6mpHFaEcELgDYIRAWSLb8M
         mvAvCoWtP4arKant50sBsSekohoauLF4r9AAQKhJdlsSZBJilfat0tuxZpxFxaMgyXeG
         Yv9eKF4g+PojJNk3RmaBtzIsmEA+Y7RtJIGO2HSVLPtGb1W/cHM6EBhx/QuIjR98ZobU
         ieGH78iG4xCjsK2D4Om9q2do/DDKH+McE4D14efo03c/kq2ehJ9gyec3loqejyia7wVE
         uf0w==
X-Gm-Message-State: AJcUukchxja1sAs5o1blIMsnWu7jjWocrx+m/MWJ2aUJ1I3LqyLkDS4R
        twxR5Xf0tR3+NNSHwIv8+ktlLBDjSJ5a7w==
X-Google-Smtp-Source: ALg8bN4TXyIZ6y8Ix1lj6TZAPZyyUktdbEVuId2Yo27Ik4LKz2ao02GzjHjuLaxUXyjypt+Z+pMrZw==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr6741148plk.203.1547595990291;
        Tue, 15 Jan 2019 15:46:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p77sm6152395pfi.85.2019.01.15.15.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 15:46:28 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:46:28 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190115234628.GQ261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:22:12PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-01-12 05:26, Matthias Kaehlcke wrote:
> > On Fri, Jan 11, 2019 at 08:37:12PM +0530, Balakrishna Godavarthi wrote:
> > > Hi Matthias,
> > > 
> > > On 2019-01-11 07:07, Matthias Kaehlcke wrote:
> > > > On Thu, Jan 10, 2019 at 08:22:12PM +0530, Balakrishna Godavarthi wrote:
> > > > > Hi Johan,
> > > > >
> > > > > On 2019-01-10 20:09, Johan Hovold wrote:
> > > > > > On Thu, Jan 10, 2019 at 08:04:12PM +0530, Balakrishna Godavarthi wrote:
> > > > > > > Hi Johan,
> > > > > > >
> > > > > > > On 2019-01-09 20:22, Johan Hovold wrote:
> > > > > > > > On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
> > > > > > > >> This patch will help to stop frame reassembly errors while changing
> > > > > > > >> the baudrate. This is because host send a change baudrate request
> > > > > > > >> command to the chip with 115200 bps, Whereas chip will change their
> > > > > > > >> UART clocks to the enable for new baudrate and sends the response
> > > > > > > >> for the change request command with newer baudrate, On host side
> > > > > > > >> we are still operating in 115200 bps which results of reading garbage
> > > > > > > >> data. Here we are pulling RTS line, so that chip we will wait to send
> > > > > > > >> data
> > > > > > > >> to host until host change its baudrate.
> > > > > >
> > > > > > > >> +		/* Deassert RTS while changing the baudrate of chip and host.
> > > > > > > >> +		 * This will prevent chip from transmitting its response with
> > > > > > > >> +		 * the new baudrate while the host port is still operating at
> > > > > > > >> +		 * the old speed.
> > > > > > > >> +		 */
> > > > > > > >> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> > > > > > > >> +		if (qcadev->btsoc_type == QCA_WCN3990)
> > > > > > > >> +			serdev_device_set_rts(hu->serdev, false);
> > > > > > > >> +
> > > > > > > >
> > > > > > > > This may not do what you want unless you also disable hardware flow
> > > > > > > > control.
> > > > > >
> > > > > > > Here my requirement here is to block the chip to send its data before
> > > > > > > HOST changes it is baudrate. So if i disable flow control lines of
> > > > > > > HOST which will be in low state.  so that the chip will send it data
> > > > > > > before HOST change the baudrate of HOST. which results in frame
> > > > > > > reassembly error.
> > > > > >
> > > > > > Not sure I understand what you're trying to say above. My point is that
> > > > > > you cannot reliable control RTS when you have automatic flow control
> > > > > > enabled (i.e. it is managed by hardware and it's state reflects whether
> > > > > > there's room in the UART receive FIFO).
> > > > > >
> > > > > > Johan
> > > > >
> > > > > [Bala]: Yes i got your point, but our driver
> > > >
> > > > I suppose with "our driver" you refer to a Qualcomm UART driver like
> > > > qcom_geni_serial.c. Unless the Bluetooth controller is really tied to
> > > > some specific SoC (e.g. because it is on-chip) you shouldn't make
> > > > assumptions about the UART driver or hardware beyond standard
> > > > behavior.
> > > >
> > > > But even if we assume that the driver you mention is used, I think you
> > > > are rather confirming Johan's concern than dispersing it:
> > > >
> > > 
> > > [Bala]: now understood the point.
> > > 
> > > > > will not support automatic flow control (based on the FIFO status)
> > > > > unless we explicitly enabled via software. i.e. if we enable the
> > > > > flow, hardware will look for it else it will not looks for CTS or
> > > > > RTS Line.
> > > >
> > > > So we agree that the UART hardware may change RTS if hardware flow
> > > > control is enabled?
> > > >
> > > > static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> > > > {
> > > >   ...
> > > >   hci_uart_set_flow_control(hu, false);
> > > >   ...
> > > > }
> > > >
> > > > I still find it utterly confusing that set_flow_control(false) enables
> > > > flow control, but that's what it does, hence after
> > > > qca_send_power_pulse() flow control is (re-)enabled.
> > > >
> > > > So far I haven't seen problems with qcom_geni_serial.c overriding the
> > > > level set with serdev_device_set_rts(), but I tend to agree with Johan
> > > > that this could be a problem (if not with this UART (driver) then with
> > > > another). I'm not keen about adding more flow control on/off clutter,
> > > > but if that is needed for the driver to operate reliably across
> > > > platforms so be it.
> > > >
> > > > Cheers
> > > >
> > > > Matthias
> > > 
> > > [Bala]: previously we have disabling the flow control, that is not
> > > pulling
> > > the RTS line if it disabled.
> > >         so that the reason we are explicilty pulling it by calling
> > > set_rts()
> > > with false.
> > > 
> > >         Johan concern can be fixed either of two ways.
> > > 
> > >         1. disable the flow control, but the uart driver should pull
> > > the RTS
> > > line high. as the line is unused
> > >         2. disable the flow control and call set_rts with false that
> > > will
> > > helps us to pull the RTS line.
> > 
> > I don't think you can rely on 1. You might succeed to convince a
> > specific UART driver/hardware to do this, however you'd have to ensure
> > the same behavior on all other types of UARTs that could be used in
> > combination with the chip, which doesn't seem feasible.
> > In case the hardware completely relinquishes control of the RTS pin
> > upon disabling flow control the state of the signal could depend on
> > the pin configuration, i.e. whether Linux (or the bootloader) enables
> > a pull-up/down, which may vary across boards, even if they use the
> > same SoC.
> > 
> > I think it will have to be the second option.
> > 
> > Cheers
> > 
> > Matthias
> 
> [Bala]: i have tried option 2, but sill i see frame reassembly errors.
>         1. disabling flow control
>         2. pull RTS

I can reproduce this. Apparently the geni serial port doesn't raise
RTS when flow control is disabled, even when told to do so. I don't
know if this is a bug or just undefined behavior when flow control is
disabled (e.g. the port might not even have a RTS signal
(configured)).

>         But even we have dynamic flow control, we will not have any issue.
>         let us assume we have an dynamic flow control and RTS line is pulled
> high.
>         but the during this stage for sure our FIFO we not be full, because
> this is an init sequence.
> 
>         01 48 fc 01 11(command we send and wait here for 300 ms)
>         04 ff 02 92 01(command specific event)
>         04 0e 04 01 00 00 00(command complete event)
> 
>        so we will only have 5 bytes to be sent. i don't think dynamic flow
> control will not active.

Flow control will always be active unless we disable it, I think you
are referring to the status of the RTS signal.

It seems you are talking about the TX FIFO ("5 bytes to be sent"),
however that shouldn't affect RTS.

I believe Johan is referring to the case where the port/driver asserts
RTS, because it is ready to receive more data.

>        I have an doubt that if HOST supports dynamic flow control, how would
> it helps BT chip it may cause the byte corruption.
>        here is the scenario, if the chip is not ready to accept any data
> from the HOST where as host as lot of data to sent,
>        then enabling dynamic flow control will cause an data loss between BT
> chip and HOST>

Enabled flow control is supposed to prevent that situation, I imagine
you refer to disabled flow control? That is a potential problem.

Using RTS seems|ed like a nice solutions, since it's the native way to
prevent the controller from sending data, instead of doing some custom
hack. However Johan seems to be fairly convinced that flow control and
manual toggling of RTS can be problematic, and we have seen that
disabling flow control has its own problems. Maybe it's time to
consider other solutions like the DISCARD_RX flag we discussed
earlier. Not that I really liked this custom solution, but in the end
it might be a more robust way to address the issue.

Johan/Marcel/others: Do you have any further ideas or input on this?

Thanks

Matthias
