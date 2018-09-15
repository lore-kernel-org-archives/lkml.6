Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC51ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0134920866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjMjbNDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0134920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeIOFf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:35:56 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:39509 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeIOFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:35:56 -0400
Received: by mail-yb1-f173.google.com with SMTP id c4-v6so5540982ybl.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d9ZEAutal0vfWMQCZVYlwbekGBlsgbY9ZoYrn+HzBbA=;
        b=MjMjbNDdR0E0QfpgAr6FoDrVZF1oPV2obgjUo0ZoE4AoMIxTENVb/2CmVvQiCRbKLs
         07v5HnzRgVDKZKzepTROburJ2FbvTCfIOCj/X6oryO0kL13LQsftGZyEDe0L7acSB/9H
         P0DyAr5iowg/EWYHFsppwrHzX7jv+H68ht0AsdNOhI0NQ0dEPjIdP/6kWlsxhB0yJKuP
         j8ENdbox4GpRRfYRUhiUq95pkeyGFrZBP/llYlbJTrBw2mxK/4BskrQpCfbACEZSrt0F
         K+JZVJ8MAwcFt0udcRgiT7GGdFHjEaDR/xXk7hgA/vfl0YlkG2Pn638vfoex5R7+aqX3
         WLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d9ZEAutal0vfWMQCZVYlwbekGBlsgbY9ZoYrn+HzBbA=;
        b=V+DqVGS2WWz5QBF3IPAxtOHJ6atvXYtqjp7w2kV3wlrsFsM+0NZCKvpLHBDKYPJn2q
         RlLhczpfV0IOdVZ2mjlFhVqQMIjA8EhhB2iO6dx3qHErQggz0/rf5LtDUev5bYW/97k8
         GylGwBxybQYp6eZUBao7ySAlIUxMtFEpIdBbvbTFqEFfxJwEx+KTPZn5iuHVps+JelAN
         raDBYos1FltLNtZPBtEEbzqSbEWexPftVyRRYo458dupmnD8bhHX3R6oHySNNOTyhehl
         BaXIOElO+FhF6zpIu+xC6XV9m06oUR+AdSJ7ZGJlWlA4mHgUqj0BrZHYvg8ucBwfRMtJ
         Fr0g==
X-Gm-Message-State: APzg51Df12ol2tVP01UwvZqyL33QIXtYAlqOVHod0GqRZvmCxIze/c9r
        0XWpcIvJACAdrhVAs8ekmtoBh71D6DOgb/Sw2Rgu9A==
X-Google-Smtp-Source: ANB0Vda0p0hT1loA0kwwZpZrR4aPg6+n7DL252PlMq1npoESTFPP35fE8FpBfEUNyc7uJaHWXiPCsmZXzXMiOrr8m/M=
X-Received: by 2002:a25:3f83:: with SMTP id m125-v6mr6545944yba.224.1536970750432;
 Fri, 14 Sep 2018 17:19:10 -0700 (PDT)
MIME-Version: 1.0
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 14 Sep 2018 17:18:34 -0700
Message-ID: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
Subject: pinctrl-icelake: driver writes to wrong offsets?
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is to report what I think is a problem in the pinctrl-icelake
driver. It seems that when trying to control GPIO pins GPP_A* and
GPIO_B*, the driver ends up writing to incorrect PADCFG registers.
I've reached this conclusion by putting debug prints in the driver,
although this can be seen by the following commands too. Please let me
know if something is wrong in my experiments. For example, when trying
to control GPP_B8/ISH_I2C1_SCL, the driver ends up writing to
GPP_A6/ESPI_RESETB registers.

I want to control the pin GPP_B8 i.e. ISH_I2C1_SCL and drive it low or
high. I looked at the driver code, and it tells me that I need to use
pin number 16:

static const struct pinctrl_pin_desc icllp_pins[] = {
       ....
        /* GPP_B */
       ....
        PINCTRL_PIN(16, "ISH_I2C1_SCL"),
       .....

The pin number 16 is mapped to GPIO 224 as per the below output:

localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/gpio-ranges
GPIO ranges handled:
0: INT3455:00 GPIOS [184 - 191] PINS [0 - 7]
32: INT3455:00 GPIOS [216 - 241] PINS [8 - 33]
64: INT3455:00 GPIOS [248 - 272] PINS [34 - 58]
96: INT3455:00 GPIOS [280 - 303] PINS [59 - 82]
128: INT3455:00 GPIOS [312 - 332] PINS [83 - 103]
160: INT3455:00 GPIOS [344 - 363] PINS [104 - 123]
192: INT3455:00 GPIOS [376 - 404] PINS [124 - 152]
224: INT3455:00 GPIOS [408 - 431] PINS [153 - 176]
256: INT3455:00 GPIOS [440 - 463] PINS [183 - 206]
288: INT3455:00 GPIOS [472 - 479] PINS [216 - 223]
320: INT3455:00 GPIOS [504 - 511] PINS [224 - 231]
localhost /sys/class/gpio #

So I did this:

localhost /sys/class/gpio # ls
export  gpiochip184  unexport
localhost /sys/class/gpio # cat gpiochip184/label
INT3455:00
localhost /sys/class/gpio # cat gpiochip184/ngpio
328
localhost /sys/class/gpio # echo 224 > export
localhost /sys/class/gpio # ls
export  gpio224  gpiochip184  unexport
localhost /sys/class/gpio #

Before trying to change the value, I decided to take a dump of the
PADCFG of the pins before and after I tried to change it. Here is the
dump I took before changing:

localhost /sys/class/gpio # cat gpio224/active_low
0
localhost /sys/class/gpio # cat gpio224/direction
in
localhost /sys/class/gpio # cat gpio224/edge
none
localhost /sys/class/gpio # cat gpio224/value
0
localhost /sys/class/gpio #
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"ISH_I2C1_SCL\|ESPI_RESETB"
pin 16 (ISH_I2C1_SCL) GPIO 0x44000102 0x00000028 0x00000000 [ACPI]
pin 40 (ESPI_RESETB) mode 1 0x44000700 0x0000003e 0x00000100 [ACPI]
localhost /sys/class/gpio #

Here is when I tried to change it and then dump the values again:

localhost /sys/class/gpio # echo out > gpio224/direction
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"ISH_I2C1_SCL\|ESPI_RESETB"
pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
pin 40 (ESPI_RESETB) mode 1 0x44000700 0x0000003e 0x00000100 [ACPI]
localhost /sys/class/gpio #

Note that things look good so far (the PADCFG DW0 for pin 16 is
corrrectly changed).
But now when I try to write the value, it is the PADCFG DW0 for pin 40
that gets written to, while the pin16 value does not change:

localhost /sys/class/gpio #
localhost /sys/class/gpio # echo 1 > gpio224/value
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"ISH_I2C1_SCL\|ESPI_RESETB"
pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
pin 40 (ESPI_RESETB) mode 1 0x44000701 0x0000003e 0x00000100 [ACPI]
localhost /sys/class/gpio #
localhost /sys/class/gpio #
localhost /sys/class/gpio # echo 0 > gpio224/value
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"ISH_I2C1_SCL\|ESPI_RESETB"
pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
pin 40 (ESPI_RESETB) mode 1 0x44000700 0x0000003e 0x00000100 [ACPI]
localhost /sys/class/gpio #
localhost /sys/class/gpio # echo 1 > gpio224/value
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"ISH_I2C1_SCL\|ESPI_RESETB"
pin 16 (ISH_I2C1_SCL) GPIO 0x44000200 0x00000028 0x00000000 [ACPI]
pin 40 (ESPI_RESETB) mode 1 0x44000701 0x0000003e 0x00000100 [ACPI]
localhost /sys/class/gpio #
localhost /sys/class/gpio #

I have also verified this using an oscilloscope on the external pin
that the ISH_I2C1_SCL does not change. Also the gpio224/value stays
stuck at 0.

localhost /sys/class/gpio # cat gpio224/value
0
localhost /sys/class/gpio #

I failed to understand how could it be that the correct pin (16) is
picked up when setting direction but incorrect pin (40) is picked up
when setting value. I suspect some mux related call is being missed
out while setting the value, may be? Can you please check this at your
end?

Thanks,

Rajat
