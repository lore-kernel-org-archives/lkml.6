Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F092C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC7420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a3x617ZI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XD/EG6Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391951AbfAKPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:07:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbfAKPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:07:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04C2960C88; Fri, 11 Jan 2019 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547219235;
        bh=WcJPmd3NCPTKlP7lq6+SBoO91OCru3O5TiDPQWaStJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a3x617ZIZEn6DrtBZNjSuou9dV3M6ARs9SORtqycvqG8Ey5xi0L9JPGnXSkI0wPYF
         nbLufpHZGhp6p0Co8xKDSbEz+cVo3K2a8LeDe7gtoHkYK6ycM2/8jEqKWxJEB/uajr
         j0O2aBmJDczdhFedxoE3coXWejww1q/W0Nv2pp3M=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 99E83609BD;
        Fri, 11 Jan 2019 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547219232;
        bh=WcJPmd3NCPTKlP7lq6+SBoO91OCru3O5TiDPQWaStJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XD/EG6YgTbYXAXwMopjiNin80nZYxpJUxIAJtgtLEVDgH2Kg2e4PznlEY2tBIUxJG
         Q//RAr9UVC9s/jBxLu/fvNKhkwMARP/ULKfx3YdPPHAjAzQksFup0E1e/0OwF5Dfoi
         p9/ixhWeFdo7d0FKEzd6eNBM2THKvQ17AtIW493E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Jan 2019 20:37:12 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20190111013707.GD261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
Message-ID: <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-11 07:07, Matthias Kaehlcke wrote:
> On Thu, Jan 10, 2019 at 08:22:12PM +0530, Balakrishna Godavarthi wrote:
>> Hi Johan,
>> 
>> On 2019-01-10 20:09, Johan Hovold wrote:
>> > On Thu, Jan 10, 2019 at 08:04:12PM +0530, Balakrishna Godavarthi wrote:
>> > > Hi Johan,
>> > >
>> > > On 2019-01-09 20:22, Johan Hovold wrote:
>> > > > On Thu, Dec 20, 2018 at 08:16:36PM +0530, Balakrishna Godavarthi wrote:
>> > > >> This patch will help to stop frame reassembly errors while changing
>> > > >> the baudrate. This is because host send a change baudrate request
>> > > >> command to the chip with 115200 bps, Whereas chip will change their
>> > > >> UART clocks to the enable for new baudrate and sends the response
>> > > >> for the change request command with newer baudrate, On host side
>> > > >> we are still operating in 115200 bps which results of reading garbage
>> > > >> data. Here we are pulling RTS line, so that chip we will wait to send
>> > > >> data
>> > > >> to host until host change its baudrate.
>> >
>> > > >> +		/* Deassert RTS while changing the baudrate of chip and host.
>> > > >> +		 * This will prevent chip from transmitting its response with
>> > > >> +		 * the new baudrate while the host port is still operating at
>> > > >> +		 * the old speed.
>> > > >> +		 */
>> > > >> +		qcadev = serdev_device_get_drvdata(hu->serdev);
>> > > >> +		if (qcadev->btsoc_type == QCA_WCN3990)
>> > > >> +			serdev_device_set_rts(hu->serdev, false);
>> > > >> +
>> > > >
>> > > > This may not do what you want unless you also disable hardware flow
>> > > > control.
>> >
>> > > Here my requirement here is to block the chip to send its data before
>> > > HOST changes it is baudrate. So if i disable flow control lines of
>> > > HOST which will be in low state.  so that the chip will send it data
>> > > before HOST change the baudrate of HOST. which results in frame
>> > > reassembly error.
>> >
>> > Not sure I understand what you're trying to say above. My point is that
>> > you cannot reliable control RTS when you have automatic flow control
>> > enabled (i.e. it is managed by hardware and it's state reflects whether
>> > there's room in the UART receive FIFO).
>> >
>> > Johan
>> 
>> [Bala]: Yes i got your point, but our driver
> 
> I suppose with "our driver" you refer to a Qualcomm UART driver like
> qcom_geni_serial.c. Unless the Bluetooth controller is really tied to
> some specific SoC (e.g. because it is on-chip) you shouldn't make
> assumptions about the UART driver or hardware beyond standard
> behavior.
> 
> But even if we assume that the driver you mention is used, I think you
> are rather confirming Johan's concern than dispersing it:
> 

[Bala]: now understood the point.

>> will not support automatic flow control (based on the FIFO status)
>> unless we explicitly enabled via software. i.e. if we enable the
>> flow, hardware will look for it else it will not looks for CTS or
>> RTS Line.
> 
> So we agree that the UART hardware may change RTS if hardware flow
> control is enabled?
> 
> static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> {
>   ...
>   hci_uart_set_flow_control(hu, false);
>   ...
> }
> 
> I still find it utterly confusing that set_flow_control(false) enables
> flow control, but that's what it does, hence after
> qca_send_power_pulse() flow control is (re-)enabled.
> 
> So far I haven't seen problems with qcom_geni_serial.c overriding the
> level set with serdev_device_set_rts(), but I tend to agree with Johan
> that this could be a problem (if not with this UART (driver) then with
> another). I'm not keen about adding more flow control on/off clutter,
> but if that is needed for the driver to operate reliably across
> platforms so be it.
> 
> Cheers
> 
> Matthias

[Bala]: previously we have disabling the flow control, that is not 
pulling the RTS line if it disabled.
         so that the reason we are explicilty pulling it by calling 
set_rts() with false.

         Johan concern can be fixed either of two ways.

         1. disable the flow control, but the uart driver should pull the 
RTS line high. as the line is unused
         2. disable the flow control and call set_rts with false that 
will helps us to pull the RTS line.

will experiment more on this and post the change.


-- 
Regards
Balakrishna.
