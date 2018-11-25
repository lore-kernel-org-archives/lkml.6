Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1CCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96242084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgUw/5d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96242084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeKYVf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:35:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34531 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeKYVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:35:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so12497378plo.1;
        Sun, 25 Nov 2018 02:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h7weriofn7VQt6OR94EhdryMNpfwBwGXpKipdfPsM5E=;
        b=UgUw/5d57OWc1lgGm4W8rfe9lHuaHIhrY/v9uyARRvcFmQl5vmrLO04H7TmqbhHXZI
         eGfQ/L7RqOh4qLoRvJSieaT1gbh5S/GflUF0oubBgyYOVmYEOxo9L9UmS13od2wScAFp
         fR2dD4aPvlKjJj1WE9JyVHg1Wwxtm84OTYWM/qxBLYhZBiXELQZaooRERuMy1uK117F8
         IdRev3Wm9cU5/Zd9pF0WbVMJOfXtu0dgEyUlvxAn3o8dCytxa4WhvN6GrGN0gAXRR3O3
         rHwFNNh7lxgEPyYze7b3rtZ/eAg9G0VX+9heLWJJFeI+1zWpPsn+T8Yy9pFLozfvsLF4
         yjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7weriofn7VQt6OR94EhdryMNpfwBwGXpKipdfPsM5E=;
        b=oIWJUKLrAYkhVkb8Wpt3TA4vuMcHv2/lepsV+uK/vpWEx9Py/svmifPqjmZ703lZ86
         u9FkvSbLLGKbgESiLC1PPE4XhO7nCDRCrTcEFXiQ0pPA6Rwq3cb1gaYYZrMgge4MCoZN
         8WDMZSLhGAvrQF6TiP32HBJxIfU2a5uwkDTHSC4oLN+jodJav0TNoIE+lfcvl679QZ0d
         HSkf8/8vN7qp3GuhW4aujf4UePMws8aXZChFMdqflThHL4o5N28rIsZmVhK98gQnZlxa
         2VBCLIFF8Ylfk0V7qfuFWExqqr5QgvcjnxsS2ijJBJVbts5hjpuyLzhwj0v+RM8ngmtm
         9wyQ==
X-Gm-Message-State: AA+aEWaNDCpGj+ernEsKlys+195uZzWw4cCwZwWDJvcDf3uh8mw9BaHN
        Qkn+mNgPsX1+7/zptDY0gbu19hQb
X-Google-Smtp-Source: AFSGD/UmvCwcXYqHYR/4lVn60mf0vW4ixQytgpTCkPZ4WBl9E8/1T1oyDQWfL+lvjywQXMg1Bc43eg==
X-Received: by 2002:a17:902:e201:: with SMTP id ce1-v6mr23126779plb.138.1543142680544;
        Sun, 25 Nov 2018 02:44:40 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id x127sm58110731pfd.156.2018.11.25.02.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 02:44:40 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:14:34 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: chemical: add support for Sensirion SPS30 sensor
Message-ID: <20181125104434.GA19309@himanshu-Vostro-3559>
References: <20181124221415.10081-1-tduszyns@gmail.com>
 <20181124221415.10081-3-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124221415.10081-3-tduszyns@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 11:14:14PM +0100, Tomasz Duszynski wrote:
> Add support for Sensirion SPS30 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/chemical/Kconfig  |  11 ++
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/sps30.c  | 359 ++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 drivers/iio/chemical/sps30.c

[]

> +#define pr_fmt(fmt) "sps30: " fmt

I don't see its usage ?

> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/module.h>
> +
> +#define SPS30_CRC8_POLYNOMIAL 0x31
> +
> +/* SPS30 commands */
> +#define SPS30_START_MEAS 0x0010
> +#define SPS30_STOP_MEAS 0x0104
> +#define SPS30_RESET 0xd304
> +#define SPS30_READ_DATA_READY_FLAG 0x0202
> +#define SPS30_READ_DATA 0x0300
> +#define SPS30_READ_SERIAL 0xD033

Could you please put a tab and align these macros.

  #define SPS30_START_MEAS		0x0010
  #define SPS30_STOP_MEAS		0x0104


> +static int sps30_write_then_read(struct sps30_state *state, u8 *buf,
> +				 int buf_size, u8 *data, int data_size)
> +{
> +	/* every two received data bytes are checksummed */
> +	u8 tmp[data_size + data_size / 2];

No VLAs!

https://lore.kernel.org/lkml/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com/

> +	int ret, i;
> +
> +	/*
> +	 * Sensor does not support repeated start so instead of
> +	 * sending two i2c messages in a row we just send one by one.
> +	 */
> +	ret = i2c_master_send(state->client, buf, buf_size);
> +	if (ret != buf_size)
> +		return ret < 0 ? ret : -EIO;
> +
> +	if (!data)
> +		return 0;
> +
> +	ret = i2c_master_recv(state->client, tmp, sizeof(tmp));
> +	if (ret != sizeof(tmp))
> +		return ret < 0 ? ret : -EIO;
> +
> +	for (i = 0; i < sizeof(tmp); i += 3) {
> +		u8 crc = crc8(sps30_crc8_table, &tmp[i], 2, CRC8_INIT_VALUE);
> +
> +		if (crc != tmp[i + 2]) {
> +			dev_err(&state->client->dev,
> +				"data integrity check failed\n");
> +			return -EIO;
> +		}
> +
> +		*data++ = tmp[i];
> +		*data++ = tmp[i + 1];
> +	}
> +
> +	return 0;
> +}
> +
> +static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
> +{
> +	/* depending on the command up to 3 bytes may be needed for argument */
> +	u8 buf[sizeof(cmd) + 3] = { cmd >> 8, cmd };

This is fine, since sizeof returns constant integer expression.

> +	switch (cmd) {
> +	case SPS30_START_MEAS:
> +		buf[2] = 0x03;
> +		buf[3] = 0x00;
> +		buf[4] = 0xac; /* precomputed crc */
> +		return sps30_write_then_read(state, buf, 5, NULL, 0);
> +	case SPS30_STOP_MEAS:
> +	case SPS30_RESET:
> +		return sps30_write_then_read(state, buf, 2, NULL, 0);
> +	case SPS30_READ_DATA_READY_FLAG:
> +	case SPS30_READ_DATA:
> +	case SPS30_READ_SERIAL:
> +		return sps30_write_then_read(state, buf, 2, data, size);
> +	default:
> +		return -EINVAL;
> +	};
> +}


> +static int sps30_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct sps30_state *state = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_MASSCONCENTRATION:
> +			mutex_lock(&state->lock);
> +			switch (chan->channel2) {
> +			case IIO_MOD_PM2p5:

I think lock should be placed here

> +				ret = sps30_do_meas(state, val, val2);

... and unlock here.

> +				break;
> +			case IIO_MOD_PM10:
> +				ret = sps30_do_meas(state, val2, val);
> +				break;
> +			default:
> +				break;
> +			}
> +			mutex_unlock(&state->lock);
> +			if (ret)
> +				return ret;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +}

[]

> +static int sps30_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct sps30_state *state;
> +	u8 buf[32] = { };

This is not valid in ISO-C but only in C++.

Instead,

	u8 buf[32] = {0};

> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	state->client = client;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &sps30_info;
> +	indio_dev->name = client->name;
> +	indio_dev->channels = sps30_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sps30_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = sps30_scan_masks;
> +
> +	mutex_init(&state->lock);
> +	crc8_populate_msb(sps30_crc8_table, SPS30_CRC8_POLYNOMIAL);
> +
> +	/*
> +	 * Power-on-reset causes sensor to produce some glitch on i2c bus
> +	 * and some controllers end up in error state. Recover simply
> +	 * by placing something on the bus.
> +	 */
> +	ret = sps30_do_cmd(state, SPS30_RESET, NULL, 0);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to reset device\n");
> +		return ret;
> +	}
> +	usleep_range(2500000, 3500000);

Isn't that range too high ?
msleep_interruptible ?

> +	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> +
> +	ret = sps30_do_cmd(state, SPS30_READ_SERIAL, buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(&client->dev, "failed to read serial number\n");
> +		return ret;
> +	}
> +	dev_info(&client->dev, "serial number: %s\n", buf);
> +
> +	ret = sps30_do_cmd(state, SPS30_START_MEAS, NULL, 0);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to start measurement\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +					      sps30_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static int sps30_remove(struct i2c_client *client)

Perfect candidate for `devm_add_action_or_reset()` ?

> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct sps30_state *state = iio_priv(indio_dev);
> +
> +	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
> +
> +	return 0;
> +}


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
