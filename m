Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD600C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828572070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547044703;
	bh=4vCfxTDEf2fyNHGNoo+04vzuE2nnmmFHMJ0cgAdLKik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EpLMF5XsaG0cZLUyqaVr/v8pK6YpeixBaWyNSVbg3VapiggPiRN7BmSOXPg3Lexd9
	 uWE+VANmJrntj2hnHrF3pPNSl1lGHC1xqiNMkSPk8dG8VjOQeZyzF1fjQeobAbaC3m
	 LEGQEGebxDC+yuYvygWHBxCg77DMQRiJ+zdGsgeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfAIOiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:38:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33915 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730970AbfAIOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:38:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so5830080lfc.1;
        Wed, 09 Jan 2019 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOnxee4pjb82+qMo5Dymv4MznA1xHHxBnKk3ivQNKH4=;
        b=NyX0Na3dJMRZWaRn++Q/bf6pi8AoUiONQklKK1M6zv68vFMpWKO0EgRGM0P/z7DOIn
         XNy4pumuz2Y/9vogkBj33LS3DebOf95+5qx5ZsFuMJ2lVD6kx4fQRDrSxcaHuB9iryU+
         IyradCh132p+W96w09WxMUoOO/CbH5SKe4Ub3BJTR2SSDpKL4TiqhFi8DWlPbwFXpOuv
         BHJIcfTWgSyHx3nBkfnu23wwsxO1i1u7dY17IXv/8PTnpmlQCBdDeTkAMKxbvlk4f83t
         WalSxDZ7qW/q2B+UQz+kMcUKWwer8krMXePzoyj6lyxxjgd8hr5t7h8QlViGxicS/eND
         tJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOnxee4pjb82+qMo5Dymv4MznA1xHHxBnKk3ivQNKH4=;
        b=dG3bywT0uy4wIB4MihW5i386p7GGOwQ4qRPY8BESyYQcw01d5RFERki4M3ferkmoiH
         /yQFaKq31UsOaZt/QNy6BDg9EnCB8tUCIsHiCfYlwmcCd+HBlZ5Ntgx20I4Me1KTGHde
         MFrR/hx10DLDit/fYjqvs9bj+XYLKj5YNR7sTGq1ZJlXuhSkS9ufUNawFS2I883XBw+P
         25ajXeRblaOtskqLftGdjgCu1HpfzRAmLV9tyHw4jJfgAVRT4/boFwd+kFS1JCotRY9Y
         wwiAIVcPgRMyLU8OwA+ibMVZd6DbKj+O3jnCKozGBbqDrw5bisjJRAODv9QxDZZysf2v
         SMxw==
X-Gm-Message-State: AJcUukfb7tLyQSpinvBkue/xC0gO43MLf4RA0INTIt7CrFHdq1ENzj1Y
        P0n32jRbggJ0559MnHM44xE=
X-Google-Smtp-Source: ALg8bN7+gR9tY8HziylqRossMIAHS1DFB5krWaLsJrUrnASa/EnDFr8/biVGq131bmTAK641qZlxNg==
X-Received: by 2002:a19:2395:: with SMTP id j143mr3538693lfj.107.1547044699081;
        Wed, 09 Jan 2019 06:38:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l21-v6sm14826499ljj.48.2019.01.09.06.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 06:38:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghEzu-0000Z8-0p; Wed, 09 Jan 2019 15:38:22 +0100
Date:   Wed, 9 Jan 2019 15:38:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20190109143822.GM14782@localhost>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222015947.GF261387@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:59:47PM -0800, Matthias Kaehlcke wrote:
> On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi wrote:
> > wcn3990 requires a power pulse to turn ON/OFF along with
> > regulators. Sometimes we are observing the power pulses are sent
> > out with some time delay, due to queuing these commands. This is
> > causing synchronization issues with chip, which intern delay the
> > chip setup or may end up with communication issues.
> > 
> > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > ---
> >  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
> >  1 file changed, 14 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index f036c8f98ea3..5a07c2370289 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> >  		hci_uart_set_baudrate(hu, speed);
> >  }
> >  
> > -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> > +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> >  {
> > -	struct hci_uart *hu = hci_get_drvdata(hdev);
> > -	struct qca_data *qca = hu->priv;
> > -	struct sk_buff *skb;
> > +	int ret;
> >  
> >  	/* These power pulses are single byte command which are sent
> >  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> > @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> >  	 * save power. Disabling hardware flow control is mandatory while
> >  	 * sending power pulses to SoC.
> >  	 */
> > -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> > -
> > -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> > -	if (!skb)
> > -		return -ENOMEM;
> > -
> > +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
> >  	hci_uart_set_flow_control(hu, true);
> > +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> > +	if (ret < 0) {
> > +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> > +			   cmd);
> > +		return ret;
> > +	}
> >  
> > -	skb_put_u8(skb, cmd);
> > -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> > -
> > -	skb_queue_tail(&qca->txq, skb);
> > -	hci_uart_tx_wakeup(hu);
> > +	serdev_device_wait_until_sent(hu->serdev, 0);

Again, do you really want to wait indefinitely here?

> serdev_device_wait_until_sent() might only guarantee that the UART
> circular buffer is empty (see
> https://elixir.bootlin.com/linux/v4.19/source/drivers/tty/tty_ioctl.c#L225),
> not that the data has actually sent (e.g. it might be sitting in
> the UART FIFO).

For serial core, uart_wait_until_sent() makes sure also the UART FIFO is
empty, although it may time out when using flow control (as then the
FIFO may never empty, and flow control appears to be enabled here).

Johan
