Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E0D214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJFnUEOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E0D214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeIQXpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:45:49 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32851 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeIQXpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:45:49 -0400
Received: by mail-yb1-f195.google.com with SMTP id y9-v6so4157701ybh.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCvv9G021xE5LetzLjao10wQ//d6/munYg0sLqXWK4I=;
        b=QJFnUEOJtr/eeZnOjRBQlfBGUJNeTNmv909joX9GL83rWqdTspAT/zCFM2B7dIsRnF
         C+HcHgxlYHlEwR8Xkfa2aw5oo46IMdHTlBhRKebt+wZ9oiyqU3QQbQGU24JR9ARMRtu7
         fbAlzRMoFDjfLe5bd4hBaiSXwHJYU66/YYnRZxE7JRrQs/tyifprXxISHQBEKLq2B3DB
         9lP+d22nPTM6IpzyTF1t02KpBD9Cs6dgMdty7yns6AR1sk74ZSzlqlW66lLe/awLCG67
         FBbJICZERaAnodT1r8jthwVct1I2j19XwMfTxJSnFbo1AqzPRnj2ANxAnxHxkVs/N4aT
         /iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCvv9G021xE5LetzLjao10wQ//d6/munYg0sLqXWK4I=;
        b=aQSg+BS1+iw+VWoAiapcUIoeZDnjwTRNcfM71M2kvTvYh6deaakQOK/hKPMotyDOaM
         8Gso5neOCoWA8EklKHk8tvbNOOGjawN2flPV+O8H4MIjF01Kb9f4WkhFFFvjXKUvn/vO
         Y29CngSqHwTWi++VYfNymX0ijc6QKfDwAOG2iOrN/yWqOAzwy42k50h/kkGsIowatdR6
         F+pe05GWCwT33l07onEcsVcSgdWsGu0m5uQqNg0QTuLJJMBJ2cGYv37bL3svheezJO4C
         lXmVk+prnxOtgCWClkRN8rQch3RJZqwDZYpkJF+5VerjTgKDfHq3dm8Yj+QfqRCyoq0l
         8gWA==
X-Gm-Message-State: APzg51C30b7QaAqgev+KNP3zoCZA0i9N4ZAmGZsk+jCWpAcda3juMX8A
        eceZrzGXhvc36IE+ar7g5m+FkL63XM6h9IajjqNEXBv1STo=
X-Google-Smtp-Source: ANB0VdaO7SrqKZe5TISI2A0Fa/1v1ILgbe/v1LTN+HhxxGEabE6ZXOfR1vv0wvPYqqtHU7tjKZu9gg+wqvPWTV/F8o8=
X-Received: by 2002:a25:bc92:: with SMTP id e18-v6mr11300618ybk.182.1537208238148;
 Mon, 17 Sep 2018 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
 <20180917081249.GM14465@lahna.fi.intel.com>
In-Reply-To: <20180917081249.GM14465@lahna.fi.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 17 Sep 2018 11:16:41 -0700
Message-ID: <CACK8Z6EpPCCGWRZX_FEewyoySLjBUUKDPzKZof4LvvKatU_NLg@mail.gmail.com>
Subject: Re: pinctrl-icelake: driver writes to wrong offsets?
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 1:13 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, Sep 14, 2018 at 05:18:34PM -0700, Rajat Jain wrote:
> > This is to report what I think is a problem in the pinctrl-icelake
> > driver. It seems that when trying to control GPIO pins GPP_A* and
> > GPIO_B*, the driver ends up writing to incorrect PADCFG registers.
> > I've reached this conclusion by putting debug prints in the driver,
> > although this can be seen by the following commands too. Please let me
> > know if something is wrong in my experiments. For example, when trying
> > to control GPP_B8/ISH_I2C1_SCL, the driver ends up writing to
> > GPP_A6/ESPI_RESETB registers.
>
> Hmm, when you add debug prints to the driver and you access GPIO 224
> (GPP_B8/ISH_I2C1_SCL) from userspace you can see that the driver
> actually uses PADCFG registers of GPP_A6/ESPI_RESETB? So that it is not
> just a side-effect of how the pins are wired on your board.

Right, also I don't have to use put debug prints as it can be seen
from the following debug files. And it is not isolated to just this
pin. For instance, in this examples you can see that another pin 18
(GPP_B10/I2C5_SCL) that I'm trying to write , the value actually gets
written to the PADCFG for (GPP_A8/I2S2_SFRM) i.e. pin42. So there is
clearly a pattern:

static const struct pinctrl_pin_desc icllp_pins[] = {
 ...
        /* GPP_B */
..
        PINCTRL_PIN(18, "I2C5_SCL"),  <----- GPP_B10/I2C5_SCL = Pin 18
....
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/gpio-ranges
GPIO ranges handled:
0: INT3455:00 GPIOS [184 - 191] PINS [0 - 7]
32: INT3455:00 GPIOS [216 - 241] PINS [8 - 33]  <---- pin 18 = gpio 226
....

localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"I2C5_SCL\|(I2S2_SFRM)"
pin 18 (I2C5_SCL) mode 1 0x44000702 0x0000002a 0x00000000 [ACPI]
pin 42 (I2S2_SFRM) mode 2 0x44000b00 0x00000040 0x00000100 [ACPI]
localhost /sys/class/gpio #
localhost /sys/class/gpio # echo 226 > export
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"I2C5_SCL\|(I2S2_SFRM)"
pin 18 (I2C5_SCL) GPIO 0x44000102 0x0000002a 0x00000000 [ACPI]
pin 42 (I2S2_SFRM) mode 2 0x44000b00 0x00000040 0x00000100 [ACPI]
localhost /sys/class/gpio #
localhost /sys/class/gpio #
localhost /sys/class/gpio # cat gpio226/value
0
localhost /sys/class/gpio # cat gpio226/direction
in
localhost /sys/class/gpio # echo out > gpio226/direction
localhost /sys/class/gpio # cat gpio226/direction
out
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"I2C5_SCL\|(I2S2_SFRM)"
pin 18 (I2C5_SCL) GPIO 0x44000200 0x0000002a 0x00000000 [ACPI]
pin 42 (I2S2_SFRM) mode 2 0x44000b00 0x00000040 0x00000100 [ACPI]
localhost /sys/class/gpio #
localhost /sys/class/gpio #
localhost /sys/class/gpio # cat gpio226/value
0
localhost /sys/class/gpio # echo 1 > gpio226/value
localhost /sys/class/gpio # cat gpio226/value
0
localhost /sys/class/gpio # cat
/sys/kernel/debug/pinctrl/INT3455\:00/pins | grep
"I2C5_SCL\|(I2S2_SFRM)"
pin 18 (I2C5_SCL) GPIO 0x44000200 0x0000002a 0x00000000 [ACPI]
pin 42 (I2S2_SFRM) mode 2 0x44000b01 0x00000040 0x00000100 [ACPI]
localhost /sys/class/gpio #

As you can see in the above example, when I export the pins and change
the directions from "in" to "out" PADCFG get updated correctly for pin
18, but when writing the value, it is the PADCFG for pin 42 that gets
updated which is incorrect.

So this looks like a driver issue to me. Please let me know if I need
to file a bug on bugzilla for this.

Thanks,

Rajat
