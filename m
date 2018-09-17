Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA37ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EAF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EAF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeIQLp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:45:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51495 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeIQLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:45:29 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so9667891itf.1;
        Sun, 16 Sep 2018 23:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ykf9hCBCdOANlmVkJNyU6o9UBWU4QyPWO+4KoVPuiMU=;
        b=AQlyRhIAJPJBwsnZCI+Hl76GF5Y0+aZtFDGozRxiNrSAoemW0/STGbU//s5dyZLRE9
         3uKUpl2jqNPDI7h2yOoywObIosVOo731ClZdIL3aU7t8SEfCPXBj+2uFOTiblIHhNB/+
         5jh/lLk0jAtpGENVzE8ptxWVlGPWQZhuZNJgOvNVuqUFKe4Od239CGd8yd9Dcg5oNhay
         bxB1kKH2sRMmBHKORucbIZ74I4kZhIcX9gXFucz4Cv23Adbf0tIExYRE80dWs1qMhC8X
         By1H+QkiHHFuJoQZKnSFe3yCDZLdLjVB48hX0SCvsmOOjDJ4QatXCwwz2opLSPgrXGW1
         wxRg==
X-Gm-Message-State: APzg51AenU3dGmVT3tZ6vxqRVCT3kqAQcARC7Qr6ee9x9YHM574rpxj+
        eM+kIn4f5tx/HzVbAN5GxEXZf9TZjQ==
X-Google-Smtp-Source: ANB0VdZ7Uiwq/AL+nbyQkk2h7EvnWfxPiAwtb1/VuIXb0AK5/gv1qs1nKNmNhgEjw2QGwKc3sWHmQg==
X-Received: by 2002:a24:27d5:: with SMTP id g204-v6mr11780432ita.47.1537165174796;
        Sun, 16 Sep 2018 23:19:34 -0700 (PDT)
Received: from localhost ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id l186-v6sm2726339ith.42.2018.09.16.23.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 23:19:34 -0700 (PDT)
Date:   Mon, 17 Sep 2018 02:19:33 -0400
From:   Rob Herring <robh@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        himanshujha199640@gmail.com,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180917061933.GA15262@bogus>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915095752.8116-1-songqiang.1304521@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 05:57:52PM +0800, Song Qiang wrote:
> This driver was originally written by ST in 2016 as a misc input device
> driver, and hasn't been maintained for a long time. I grabbed some code
> from it's API and reformed it into an iio proximity device driver.
> This version of driver uses i2c bus to talk to the sensor and
> polling for measuring completes, so no irq line is needed.
> This version of driver supports only one-shot mode, and it can be
> tested with reading from
> /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> 
> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>

checkpatch.pl complains that the author and signoff emails don't match. 
I think gmail ignores '.' in email names, but better to be consistent 
IMO.

> ---
> Changes in v5:
> 	- Correct some spell problems.
> 	- Change tries-- to --tries to fix the count error.
> 	- Add MODULE_DEVICE_TABLE().
> 	- Add some comments.
> 
> Changes in v4:
> 	- Add datasheet link, default i2c address and TODO list.
> 	- Make capitalization of defines consistent.
> 	- Replace i2c_transfer() with i2c_smbus_read_i2c_block_data().
> 	- Remove IIO_CHAN_SOFT_TIMESTAMP() since no buffer/trigger
> 	  support.
> 	- Add information to MAINTAINERS.
> 
> Changes in v3:
> 	- Recover ST's copyright.
> 	- Clean up indio_dev member in vl53l0x_data struct since it's
> 	  useless now.
> 	- Replace __le16_to_cpu() with le16_to_cpu().
> 	- Remove the iio_device_{claim|release}_direct_mode() since it's
> 	  only needed when we use buffered mode.
> 	- Clean up some coding style problems.
> 
> Changes in v2:
> 	- Clean up the register table.
> 	- Sort header files declarations.
> 	- Replace some bit definations with GENMASK() and BIT().
> 	- Clean up some code and comments that's useless for now.
> 	- Change the order of some the definations of some variables to reversed
> 	  xmas tree order.
> 	- Using do...while() rather while and check.
> 	- Replace pr_err() with dev_err().
> 	- Remove device id declaration since we recommend to use DT.
> 	- Remove .owner = THIS_MODULE.
> 	- Replace probe() with probe_new() hook.
> 	- Remove IIO_BUFFER and IIO_TRIGGERED_BUFFER dependences.
> 	- Change the driver module name to vl53l0x-i2c.
> 	- Align all the parameters if they are in the same function with open
> 	  parentheses.
> 	- Replace iio_device_register() with devm_iio_device_register
> 	  for better resource management.
> 	- Remove the vl53l0x_remove() since it's not needed.
> 	- Remove dev_set_drvdata() since it's already setted above.
> 
>  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
>  MAINTAINERS                                   |   7 +

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/iio/proximity/Kconfig                 |  11 ++
>  drivers/iio/proximity/Makefile                |   2 +
>  drivers/iio/proximity/vl53l0x-i2c.c           | 180 ++++++++++++++++++
>  5 files changed, 212 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
>  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
