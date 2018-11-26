Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB8FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6F2208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2fKPwk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6F2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeK0Hnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:43:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeK0Hnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:43:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so17942539lji.11;
        Mon, 26 Nov 2018 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CiYmec0OEdzxGLglzGhuj+8DP4rqQkpu08YMwbNeAM=;
        b=j2fKPwk9mnKDiG6GKCRIS8Yis3QdmHp1vPQFngozurafYREKwfsOjO34wtununEB8R
         s4X5i0hIOSFQi/dBpaHuE37sXuIF4n/qx6ZZRr8BYjnCeZxiHoxU1xNS2GjUEmCSXOkP
         QFMvHuhvVGOr8MnkzRybL1qSZmc9dOYmM6AZ4G/1sgzPoqCjHzt4UenbYD8Ot4ki+3/K
         5FRI1b6Ito+GUmOIevNQyb5Vv+y36RTMFVxZI4WU17A0dSW4dmFh1Wv/YPcRD6VyGp4Y
         elnw6jsZAnwQkd1brSPdR0X6d3ia/3+wFJ6OH5bTXkN8Y7bv6gaS9ITYRTfo8DplKkHe
         BeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CiYmec0OEdzxGLglzGhuj+8DP4rqQkpu08YMwbNeAM=;
        b=bEFrEiu6Ll5fuK9aGcfOjZzlyt93XVxg/KMvRiflTwen1YU5v5SaFd2YXh03puCG9f
         3JVWPh2yTA5xdPGbgadpGbPD8K6bSCTj/ZY3Gv2IQUazEuIhNdvBCMzwzvC2fITM2Efh
         8ugD1wTSpQJHlix6NZTxdnJfOK4AVonRsn20o+Xj0cYz2CNlZKVjeyqOxmB5shQcLZdN
         ldQE4Ucb2/qhI6zY+rVr0xwhYLmbVo+bckrvYZXKDviVPPS/QK02VvP/sXHlALuSShjn
         iSW7mmOhpjSNIp36cye3Iic26qSXJH2ddSDTyNsJRP8by88EluNphsZN2FTZ4uCnlfL5
         WN5A==
X-Gm-Message-State: AA+aEWZjAVwxBR0gB1UJnU+2wg3GZ0t5Ob/8k5yDBEyDDeGMPwdMDidc
        CzaFCipppsTa213uOYpm3HA=
X-Google-Smtp-Source: AFSGD/WT2QH0irouVTko+96E6m8ovhQ0uyGKFQ0KkcgzZaMecNnF9Xl0yabi1cXhhoBdrwqv7ZKYcw==
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr2491351ljd.31.1543265308304;
        Mon, 26 Nov 2018 12:48:28 -0800 (PST)
Received: from localhost (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id 1-v6sm213600lju.61.2018.11.26.12.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:48:27 -0800 (PST)
Date:   Mon, 26 Nov 2018 21:48:07 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: chemical: add support for Sensirion SPS30 sensor
Message-ID: <20181126204803.GA19277@arch>
References: <20181124221415.10081-1-tduszyns@gmail.com>
 <20181124221415.10081-3-tduszyns@gmail.com>
 <20181125104434.GA19309@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181125104434.GA19309@himanshu-Vostro-3559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 04:14:34PM +0530, Himanshu Jha wrote:
> On Sat, Nov 24, 2018 at 11:14:14PM +0100, Tomasz Duszynski wrote:
> > Add support for Sensirion SPS30 particulate matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  drivers/iio/chemical/Kconfig  |  11 ++
> >  drivers/iio/chemical/Makefile |   1 +
> >  drivers/iio/chemical/sps30.c  | 359 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 371 insertions(+)
> >  create mode 100644 drivers/iio/chemical/sps30.c
>
> []
>
> > +#define pr_fmt(fmt) "sps30: " fmt
>
> I don't see its usage ?
>

Hint: checkout how dev_err() is defined.

> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/module.h>
> > +
> > +#define SPS30_CRC8_POLYNOMIAL 0x31
> > +
> > +/* SPS30 commands */
> > +#define SPS30_START_MEAS 0x0010
> > +#define SPS30_STOP_MEAS 0x0104
> > +#define SPS30_RESET 0xd304
> > +#define SPS30_READ_DATA_READY_FLAG 0x0202
> > +#define SPS30_READ_DATA 0x0300
> > +#define SPS30_READ_SERIAL 0xD033
>
> Could you please put a tab and align these macros.
>
>   #define SPS30_START_MEAS		0x0010
>   #define SPS30_STOP_MEAS		0x0104
>

In my opinion this sort of alignment does not pay off in the long run.
Adding a new definition, a slightly longer one perhaps, can easily break
formatting.

So I would stay with current one.

>
> > +static int sps30_write_then_read(struct sps30_state *state, u8 *buf,
> > +				 int buf_size, u8 *data, int data_size)
> > +{
> > +	/* every two received data bytes are checksummed */
> > +	u8 tmp[data_size + data_size / 2];
>
> No VLAs!
>
> https://lore.kernel.org/lkml/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com/
>

Looks like -Wvla is some fairly recent addition to KBUILD_CFLAGS.

> > +	int ret, i;
> > +
> > +	/*
> > +	 * Sensor does not support repeated start so instead of
> > +	 * sending two i2c messages in a row we just send one by one.
> > +	 */
> > +	ret = i2c_master_send(state->client, buf, buf_size);
> > +	if (ret != buf_size)
> > +		return ret < 0 ? ret : -EIO;
> > +
> > +	if (!data)
> > +		return 0;
> > +
> > +	ret = i2c_master_recv(state->client, tmp, sizeof(tmp));
> > +	if (ret != sizeof(tmp))
> > +		return ret < 0 ? ret : -EIO;
> > +
> > +	for (i = 0; i < sizeof(tmp); i += 3) {
> > +		u8 crc = crc8(sps30_crc8_table, &tmp[i], 2, CRC8_INIT_VALUE);
> > +
> > +		if (crc != tmp[i + 2]) {
> > +			dev_err(&state->client->dev,
> > +				"data integrity check failed\n");
> > +			return -EIO;
> > +		}
> > +
> > +		*data++ = tmp[i];
> > +		*data++ = tmp[i + 1];
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
> > +{
> > +	/* depending on the command up to 3 bytes may be needed for argument */
> > +	u8 buf[sizeof(cmd) + 3] = { cmd >> 8, cmd };
>
> This is fine, since sizeof returns constant integer expression.
>
> > +	switch (cmd) {
> > +	case SPS30_START_MEAS:
> > +		buf[2] = 0x03;
> > +		buf[3] = 0x00;
> > +		buf[4] = 0xac; /* precomputed crc */
> > +		return sps30_write_then_read(state, buf, 5, NULL, 0);
> > +	case SPS30_STOP_MEAS:
> > +	case SPS30_RESET:
> > +		return sps30_write_then_read(state, buf, 2, NULL, 0);
> > +	case SPS30_READ_DATA_READY_FLAG:
> > +	case SPS30_READ_DATA:
> > +	case SPS30_READ_SERIAL:
> > +		return sps30_write_then_read(state, buf, 2, data, size);
> > +	default:
> > +		return -EINVAL;
> > +	};
> > +}
>
>
> > +static int sps30_read_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan,
> > +			  int *val, int *val2, long mask)
> > +{
> > +	struct sps30_state *state = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		switch (chan->type) {
> > +		case IIO_MASSCONCENTRATION:
> > +			mutex_lock(&state->lock);
> > +			switch (chan->channel2) {
> > +			case IIO_MOD_PM2p5:
>
> I think lock should be placed here
>
> > +				ret = sps30_do_meas(state, val, val2);
>
> ... and unlock here.
>
> > +				break;
> > +			case IIO_MOD_PM10:
> > +				ret = sps30_do_meas(state, val2, val);
> > +				break;
> > +			default:
> > +				break;
> > +			}
> > +			mutex_unlock(&state->lock);
> > +			if (ret)
> > +				return ret;
> > +
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
>
> []
>
> > +static int sps30_probe(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct sps30_state *state;
> > +	u8 buf[32] = { };
>
> This is not valid in ISO-C but only in C++.
>
> Instead,
>
> 	u8 buf[32] = {0};
>
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return -EOPNOTSUPP;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*state));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	state = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	state->client = client;
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &sps30_info;
> > +	indio_dev->name = client->name;
> > +	indio_dev->channels = sps30_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(sps30_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = sps30_scan_masks;
> > +
> > +	mutex_init(&state->lock);
> > +	crc8_populate_msb(sps30_crc8_table, SPS30_CRC8_POLYNOMIAL);
> > +
> > +	/*
> > +	 * Power-on-reset causes sensor to produce some glitch on i2c bus
> > +	 * and some controllers end up in error state. Recover simply
> > +	 * by placing something on the bus.
> > +	 */
> > +	ret = sps30_do_cmd(state, SPS30_RESET, NULL, 0);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to reset device\n");
> > +		return ret;
> > +	}
> > +	usleep_range(2500000, 3500000);
>
> Isn't that range too high ?
> msleep_interruptible ?
>

Might be.

> > +	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> > +
> > +	ret = sps30_do_cmd(state, SPS30_READ_SERIAL, buf, sizeof(buf));
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to read serial number\n");
> > +		return ret;
> > +	}
> > +	dev_info(&client->dev, "serial number: %s\n", buf);
> > +
> > +	ret = sps30_do_cmd(state, SPS30_START_MEAS, NULL, 0);
> > +	if (ret) {
> > +		dev_err(&client->dev, "failed to start measurement\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> > +					      sps30_trigger_handler, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static int sps30_remove(struct i2c_client *client)
>
> Perfect candidate for `devm_add_action_or_reset()` ?
>
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct sps30_state *state = iio_priv(indio_dev);
> > +
> > +	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> > +
> > +	return 0;
> > +}
>
>
> --
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology
