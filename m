Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79652C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3624E20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNF4Sokc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfAKXiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:38:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40111 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfAKXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:38:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so6944992pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yTpAZoRz5InVc9WOFDGY1AC49N8YGDB9z5+38FDNA5Q=;
        b=BNF4Sokc/tz9q9jmQcRHCCN3FkzFOsT8C20d2VtnJiNusDypcv5WL5nlmM8Ai7pYOD
         Kt60RmsXhcouB8aOpgybNKkpzgHbYywZ3nLnwxvT73Hm7KhReXcgebCt+HyMO/j4vyKm
         CsN84GimKJJgqqO7CpOxRQohPGr3wQRHgiuqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yTpAZoRz5InVc9WOFDGY1AC49N8YGDB9z5+38FDNA5Q=;
        b=uGYIscMN1Y8eG3bbT38BDuKILfmkYwHBfc9eSjG6J+L+JOI3QKEzqG6wpjNsy841/c
         TPLkD2aijMuT3OOAPYR2mpl9yYJ+0kc9TI4pGoA9SfzuAWL5ygPBfrJ9lKZfBSauEKyQ
         f7tXRRzi+pHHw5hjk7nlc1UmabDIhECpY6Ff4FqiKRTq8YCwiaQOcMFgKTF/diFMEuO6
         qa4IC8q0J3g5+1V3MD3kvcLusy93QEiz7FxquV3TVQoJv8UkqmbX7vlKlulJxYpgYwiy
         fRLYio5NtmoQLgnd+Q6kCXl7wwjTNPKLF9bhwN6Fu70/lBc8cLr9h7x+QvffIe1RSyIl
         +orA==
X-Gm-Message-State: AJcUukc2ALvgQpcnrs0ZRaaiq9r5k/KK/ay2k6ESvRDzdTVY+ImXgckY
        Z9ETobuvgilXn8SttO3teeGNMA==
X-Google-Smtp-Source: ALg8bN5KVpeZQhz2nnoqnpHCXNN9jc+UPfJcPxdXWRuLQAMK/1FFiefRqxVxHk9Tl4hfThMN+58fEg==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr5117675pgd.57.1547249893819;
        Fri, 11 Jan 2019 15:38:13 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h8sm84539784pgv.27.2019.01.11.15.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 15:38:12 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:38:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 1/5] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20190111233812.GJ261387@google.com>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
 <20181220144639.15928-2-bgodavar@codeaurora.org>
 <20181222015947.GF261387@google.com>
 <20190109143822.GM14782@localhost>
 <2d4ee183e3c2fa964c14a5ac702043c0@codeaurora.org>
 <20190111005532.GC261387@google.com>
 <5e4b077bbcc81b624c851643bebc45f7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e4b077bbcc81b624c851643bebc45f7@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:02:00PM +0530, Balakrishna Godavarthi wrote:
> On 2019-01-11 06:25, Matthias Kaehlcke wrote:
> > On Thu, Jan 10, 2019 at 08:18:37PM +0530, Balakrishna Godavarthi wrote:
> > > Hi Johan,
> > > 
> > > On 2019-01-09 20:08, Johan Hovold wrote:
> > > > On Fri, Dec 21, 2018 at 05:59:47PM -0800, Matthias Kaehlcke wrote:
> > > > > On Thu, Dec 20, 2018 at 08:16:35PM +0530, Balakrishna Godavarthi
> > > > > wrote:
> > > > > > wcn3990 requires a power pulse to turn ON/OFF along with
> > > > > > regulators. Sometimes we are observing the power pulses are sent
> > > > > > out with some time delay, due to queuing these commands. This is
> > > > > > causing synchronization issues with chip, which intern delay the
> > > > > > chip setup or may end up with communication issues.
> > > > > >
> > > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > > > ---
> > > > > >  drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
> > > > > >  1 file changed, 14 insertions(+), 24 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > > > index f036c8f98ea3..5a07c2370289 100644
> > > > > > --- a/drivers/bluetooth/hci_qca.c
> > > > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > > > @@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> > > > > >  		hci_uart_set_baudrate(hu, speed);
> > > > > >  }
> > > > > >
> > > > > > -static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> > > > > > +static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
> > > > > >  {
> > > > > > -	struct hci_uart *hu = hci_get_drvdata(hdev);
> > > > > > -	struct qca_data *qca = hu->priv;
> > > > > > -	struct sk_buff *skb;
> > > > > > +	int ret;
> > > > > >
> > > > > >  	/* These power pulses are single byte command which are sent
> > > > > >  	 * at required baudrate to wcn3990. On wcn3990, we have an external
> > > > > > @@ -1029,19 +1027,16 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
> > > > > >  	 * save power. Disabling hardware flow control is mandatory while
> > > > > >  	 * sending power pulses to SoC.
> > > > > >  	 */
> > > > > > -	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
> > > > > > -
> > > > > > -	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> > > > > > -	if (!skb)
> > > > > > -		return -ENOMEM;
> > > > > > -
> > > > > > +	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
> > > > > >  	hci_uart_set_flow_control(hu, true);
> > > > > > +	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
> > > > > > +	if (ret < 0) {
> > > > > > +		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
> > > > > > +			   cmd);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > >
> > > > > > -	skb_put_u8(skb, cmd);
> > > > > > -	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> > > > > > -
> > > > > > -	skb_queue_tail(&qca->txq, skb);
> > > > > > -	hci_uart_tx_wakeup(hu);
> > > > > > +	serdev_device_wait_until_sent(hu->serdev, 0);
> > > >
> > > > Again, do you really want to wait indefinitely here?
> > > >
> > > [Bala]: these commands are mandatory to turn ON or OFF the chip.
> > >         so blocking to the max time is required.
> > >         these commands are sent during the BT chip ON & OFF.
> > >         in the latest series, i have flushed the uart before sending
> > > this
> > > commands
> > >         so the uart FIFO(as just opened the port before calling this
> > > function) or the circular
> > >         buffer will be empty and also i am disabling the flow
> > > control too.
> > >        https://patchwork.kernel.org/patch/10744435/
> > 
> > The commands may be mandatory for switching the chip on or off, but
> > what is better if there is a problem with sending them (e.g. a buggy
> > UART driver):
> > 
> > 1. wait a reasonable time, report an error
> > 2. wait forever
> > 
> > ?
> > 
> > If the single byte command couldn't be sent after a few milliseconds,
> > it likely never will, waiting forever doesn't fix that. An error
> > report at least provides some information about the problem and the
> > driver is in a not-hanging state.
> > 
> > Cheers
> > 
> > Matthias
> 
> [Bala]: will update this with a bound TIMEOUT value. But wait_until_sent()
> is void return
>         type how could we know that the data is sent out on the lines.

Good point, I didn't check and expected it to return an error. If you
feel really motivated and have maintainer support you could possibly
change the API, however it seems this would be a somewhat larger
change.

I guess the next best thing to do is to proceed as if all data was
sent and if there was a problem it will likely manifest through
another error (especially for the ON pulse), which still seems better
than a hanging driver.

Cheers

Matthias
