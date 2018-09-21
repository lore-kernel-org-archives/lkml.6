Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABF02154D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABF02154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbeIUH6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:58:55 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:42844 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeIUH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:58:55 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 03:58:54 EDT
Received: (qmail 14378 invoked by uid 5089); 21 Sep 2018 02:05:42 -0000
Received: by simscan 1.2.0 ppid: 14281, pid: 14282, t: 0.0469s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 21 Sep 2018 02:05:41 -0000
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
To:     Song Qiang <songqiang1304521@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <4633d30b-b493-d70b-dd7b-3f5bc3e16e78@electromag.com.au>
Date:   Fri, 21 Sep 2018 10:05:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920131340.6699-1-songqiang1304521@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 9:13 PM, Song Qiang wrote:
> PNI RM3100 magnetometer is a high resolution, large signal immunity
> magnetometer, composed of 3 single sensors and a processing chip.
> PNI is currently not in the vendors list, so this is also adding it.
> 

In the subject: Isn't the RM3100 a 3axis mag.
The 9axis bit comes when you combine it with an accel / gryo I think.

... snip

> +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> @@ -0,0 +1,57 @@
> +* PNI RM3100 9-axis magnetometer sensor
> +
> +I2C Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-i2c"
> +- reg : the I2C address of the magnetometer
> +

... snip

> +SPI Bus:
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100-spi"
> +- reg : address of sensor, usually 0 or 1.
> +

Looking at other drivers supporting i2c / spi.
They use the same compatible for both.

eg: see iio/accel/adxl345_*.c

and it's binding doc:

Required properties:
  - compatible : should be "adi,adxl345"
  - reg : the I2C address or SPI chip select number of the sensor

