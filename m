Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7580C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0426E34
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ow0foArD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E0426E34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934239AbeFZTCM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:02:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33316 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeFZTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:02:09 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so8030139pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PvZphHkOBeAc+wulX1lasa0LGEQxQPXANYpmUq50zek=;
        b=Ow0foArDVQclJ/51Dk/wkWW26NkcxeG8Y9R8JPU/eaNJlEbrMbD3/LiY8mOSTMVAIe
         JmJMPXbFP3PitMXyT6s0uGH98gpJ1Wdu+O90GfZO5ope5//AVe0ekeg8uD1lQrPYDTQg
         3BCEToQSAAjC2fft1I3Yk00JT6XAzSVC7Wsc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PvZphHkOBeAc+wulX1lasa0LGEQxQPXANYpmUq50zek=;
        b=oDA0eETV4zwruQlG8bgYOY0g8Mm7rMwiZVUsXQ4PshbW6pNRiEQ4PdByifsUODf/TU
         ypIPIh32cT8AVf6mNbnmJCyuWcQhkb5LQipgn9mT7cFC45DHHL3qrTZo1pF3C1OGCRpF
         HwWgQli6tlFs90xUyRZWH/kvgdLH6zyvlYX/LWRqz9RVwL8UuP6ImkZSCIenRyiRlqnf
         +Rzb6SC0cwaeYuTSxoQYvIBir7uGx4gAGS83oeOvTXyGsXtwgAr5KyjG4L5VQIzZFYp+
         8XWOwDn6RFA0uBZRj4/bUSwuC5A2AgB7JB/sFJI7dvXRaWlnxOu8njUIqk4hgtG8p5kS
         HLoA==
X-Gm-Message-State: APt69E27UezKh7gH2fFQCm6bDAYsBD+X2zp7J6EnV/a3JyHO+YthRlT1
        0icX/gbDx6ETsh4vVHfwFkQC9g==
X-Google-Smtp-Source: AAOMgpcZUqzSuBId5mDAzfPikY0fLUh9FrHMgkwr3Ja1o1HexX/OGVwwjts5EnVCLMqtbzsFsPq0iw==
X-Received: by 2002:a62:be0a:: with SMTP id l10-v6mr2687746pff.180.1530039729084;
        Tue, 26 Jun 2018 12:02:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p88-v6sm3969636pfj.140.2018.06.26.12.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 12:02:08 -0700 (PDT)
Date:   Tue, 26 Jun 2018 12:02:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
Message-ID: <20180626190207.GN129942@google.com>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-5-bgodavar@codeaurora.org>
 <20180625234354.GI129942@google.com>
 <89b1e4ce98a26d79935bf2ba9a4bc278@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89b1e4ce98a26d79935bf2ba9a4bc278@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:01:18AM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-06-26 05:13, Matthias Kaehlcke wrote:
> > This is a nice improvement, a few remaining questions inline.
> > 
> > On Mon, Jun 25, 2018 at 07:10:10PM +0530, Balakrishna Godavarthi wrote:
> > > In function qca_setup, we set initial and operating speeds for
> > > Qualcomm
> > > Bluetooth SoC's. This block of code is common across different
> > > Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
> > > a wrapper function to set the speeds. So that future coming SoC's
> > > can use these wrapper functions to set speeds.
> > > 
> > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > ---
> > > Changes in v8:
> > >     * common function to set INIT and operating speeds.
> > >     * moved hardware flow control to qca_set_speed().
> > > 
> > > Changes in v7:
> > >     * initial patch
> > >     * created wrapper functions for init and operating speeds.
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 89
> > > +++++++++++++++++++++++++++----------
> > >  1 file changed, 65 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index fe62420ef838..38b7dbe6c897 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -119,6 +119,11 @@ struct qca_data {
> > >  	u64 votes_off;
> > >  };
> > > 
> > > +enum qca_speed_type {
> > > +	QCA_INIT_SPEED = 1,
> > > +	QCA_OPER_SPEED
> > > +};
> > > +
> > >  struct qca_serdev {
> > >  	struct hci_uart	 serdev_hu;
> > >  	struct gpio_desc *bt_en;
> > > @@ -923,6 +928,60 @@ static inline void host_set_baudrate(struct
> > > hci_uart *hu, unsigned int speed)
> > >  		hci_uart_set_baudrate(hu, speed);
> > >  }
> > > 
> > > +static unsigned int qca_get_speed(struct hci_uart *hu,
> > > +				  enum qca_speed_type speed_type)
> > > +{
> > > +	unsigned int speed = 0;
> > > +
> > > +	if (speed_type == QCA_INIT_SPEED) {
> > > +		if (hu->init_speed)
> > > +			speed = hu->init_speed;
> > > +		else if (hu->proto->init_speed)
> > > +			speed = hu->proto->init_speed;
> > > +	} else {
> > > +		if (hu->oper_speed)
> > > +			speed = hu->oper_speed;
> > > +		else if (hu->proto->oper_speed)
> > > +			speed = hu->proto->oper_speed;
> > > +	}
> > > +
> > > +	return speed;
> > > +}
> > > +
> > > +static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type
> > > speed_type)
> > > +{
> > > +	unsigned int speed, qca_baudrate;
> > > +	int ret;
> > > +
> > > +	if (speed_type == QCA_INIT_SPEED) {
> > > +		speed = qca_get_speed(hu, QCA_INIT_SPEED);
> > > +		if (speed)
> > > +			host_set_baudrate(hu, speed);
> > > +		else
> > > +			bt_dev_err(hu->hdev, "Init speed should be non zero");
> > 
> > The check for 'speed == 0' is done in multiple places. From this
> > code I deduce that it is expected that both INIT and OPER speed are
> > set to non-zero values. What happens if either of them is zero? Is the
> > driver still operational?
> > 
> [Bala]: yes in hci_uart_setup()(hci_serdev.c) function before calling
> qca_setup().
>         we actually set baudrate, but int  above code missed to restrict the
> further call to qca_setup()
>        if speed =0. so we are checking the same in the qca_setup().. i.e.
> qca_get_speed().

Sorry, didn't quite get you here. Yes, the driver is still operational?

Breaking it down in multiple questions:

1. Is it an error if one of the speeds isn't specified?

If yes we should probably check this early once and return an error
early, instead of doing the check repeatedly

2. If it is not an error, what is the driver supposed to do?

> > In the discussion on "[v7,8/8] Bluetooth: hci_qca: Add support for
> > Qualcomm Bluetooth chip wcn3990" you mentioned the possbility to move
> > the hci_uart_set_flow_control() calls into _set_speed(). This seemed
> > interesting but finally it isn't done in this series. Did you
> > encounter that it is not feasible/desirable for some reason?
> > 
> 
> [Bala]: this patch is for rome where flow control is not used.
>         after we integrate wcn3990, flow control is hidden in the
> qca_set_speed()
>         Pls check [v8 7/7] patch.

Sorry, my confusion

> > >  static int qca_setup(struct hci_uart *hu)
> > >  {
> > >  	struct hci_dev *hdev = hu->hdev;
> > > @@ -937,35 +996,17 @@ static int qca_setup(struct hci_uart *hu)
> > >  	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> > > 
> > >  	/* Setup initial baudrate */
> > > -	speed = 0;
> > > -	if (hu->init_speed)
> > > -		speed = hu->init_speed;
> > > -	else if (hu->proto->init_speed)
> > > -		speed = hu->proto->init_speed;
> > > -
> > > -	if (speed)
> > > -		host_set_baudrate(hu, speed);
> > > +	qca_set_speed(hu, QCA_INIT_SPEED);
> > > 
> > >  	/* Setup user speed if needed */
> > > -	speed = 0;
> > > -	if (hu->oper_speed)
> > > -		speed = hu->oper_speed;
> > > -	else if (hu->proto->oper_speed)
> > > -		speed = hu->proto->oper_speed;
> > > +	ret = qca_set_speed(hu, QCA_OPER_SPEED);
> > > +	if (ret)
> > > +		return ret;
> > > 
> > > -	if (speed) {
> > > +	speed = qca_get_speed(hu, QCA_OPER_SPEED);
> > > +	if (speed)
> > >  		qca_baudrate = qca_get_baudrate_value(speed);
> > 
> > Is the check here necessary? qca_get_baudrate_value() returns
> > QCA_BAUDRATE_115200 for a zero speed.
> 
> this if for no zero operating speed,

My point is:

static int qca_setup(struct hci_uart *hu)
{
	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;

	...

	if (speed)
		qca_baudrate = qca_get_baudrate_value(speed);
}

static uint8_t qca_get_baudrate_value(int speed)
{
        switch (speed) {

	...

        default:
                return QCA_BAUDRATE_115200;
        }
}

If qca_get_baudrate_value() is called with 'speed == 0' it returns
QCA_BAUDRATE_115200, which is the same value with which
QCA_BAUDRATE_115200 is initialized.

It seems the initialization and the check for 'speed == 0' could be removed.
