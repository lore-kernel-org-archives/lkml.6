Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 60E4CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170D6208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWzYrcy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D6208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754839AbeFNJFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:05:42 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46404 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbeFNJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:05:39 -0400
Received: by mail-vk0-f68.google.com with SMTP id b134-v6so3200266vke.13;
        Thu, 14 Jun 2018 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0njODMDEt4N1jlP4FQTSswF4xdecj4R+HhJQN7HuOJY=;
        b=QWzYrcy6nuBdyjN8jqicMvH5u2RRAMD3+2XFfrlRinaUmMB4bPuDfXyZNmwQLcFQ6c
         5jU4/tdB4vbWQR3j3kcZ1pUu2lPca8xxSSa606pBWu0Os1Mvj8qigvywSNo20XeuMEg/
         gCrC1PqpRzb+u9srDY6dLv1yAEFg3fTV7Jg417+lj3/ZQxdtW/HxqNAht1KMWGrQOXeU
         9ydzuXj9DhIIZwax1DzMAj9MC8Y58Nc6THddLin1p/I6F/FPAqbgQ/o57Odnl6QrrFvx
         DHgZ+8cL1XXZKpepKlYlhB3zH/O2LFvwhg4oLxnW0RlEP99hBdYB8Sb9RR40dhpyYmnL
         1l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0njODMDEt4N1jlP4FQTSswF4xdecj4R+HhJQN7HuOJY=;
        b=dG+LVZFgFaD54GbEMGzAlWZHbG2UNWpTfCPQjpmKFCZAid8BVAsmKwQyIrPwPbhjRE
         aQhghIpeVFXQymlVrSM7e3MbtG90TonZuWJMLtH3nO1Vtz+jZastDZUCZBJC0xpQBWSt
         OZ6w8cZjcDxVu0u/smwtSfNTH8Lg68AtO7oEoIxfz584AdoRt6LvbYIy6XIlsBTzItIl
         f2KPGCHxCrNB0HBF0p0OgrD/iqpn42DI9aYAwhYH+Eq3LCv/JFvN//uEQG8U97eFyIV9
         HG8qB2t0psRpavNoR1QS8G97PRijMgmAbikbOzPmM7nRTBnHx88oWmfF3pt0lXajS40M
         vGMA==
X-Gm-Message-State: APt69E3FBLWtBkO3GN1/qFlZ2FYScqlLzeBnawog7c5b2qoNfM/WGVg5
        x/9DCcGTd+iatQZLOuWtK5Q7ECsI4mLSbaYsS5WjewnP
X-Google-Smtp-Source: ADUXVKIVqpAi8N/ECKFPU7bwwCXxihrIQVk3O0x2eW6AjHUJHNhKC0PgYgRVU3i4e8EqBM51BCjxEAtsbDGwTwrgac4=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr1019031vke.176.1528967138739;
 Thu, 14 Jun 2018 02:05:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 02:05:38
 -0700 (PDT)
In-Reply-To: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 12:05:38 +0300
Message-ID: <CAHp75Vd9Y5VNVZZxB3-tOiUuC2peE7skBGMgv9nGxCBH178bTg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:36 PM, Eddie James
<eajames@linux.vnet.ibm.com> wrote:
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.
>

You missed to include tag I gave

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

be careful next time.

> Changes since v9
>  - Switch the status masks to use a combination of bits rather than directly
>    coding the value
>  - Remove the interrupt mask definition as it was unused
>  - Fixed return value of master_xfer function (return number of xfrs, not 0)
>
> Changes since v8
>  - Drop unecessary else statements
>  - Use i++ instead of ++i
>  - Use kzalloc/kfree instead of devm_kzalloc/devm_kfree for port structure
>  - Drop the list_empty check in remove
>
> Changes since v7
>  - Fix grammer in Kconfig (a -> an)
>  - Change I2C registers to use BIT and GENMASK
>  - Remove custom macros and use FIELD_PREP and FIELD_GET
>  - Fix a few unecessary initializations and "return rc" that are always zero
>  - Clean up the read/write fifo functions a bit
>  - Few other clean-up items
>
> Changes since v6
>  - Remove spinlock for reset functionality; it's unecessary and doesn't work
>    with the latest FSI core.
>  - Use a mutex instead of a semaphore, and don't wait for timeout to get the
>    lock.
>  - Use usleeps instead of schedule_timeout; it's not worth the overhead when
>    the wait should be very short in between sending the command and receiving
>    the response.
>
> Changes since v5
>  - Fix reset functionality and do a reset after every transfer failure
>
> Eddie James (7):
>   dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
>   i2c: Add FSI-attached I2C master algorithm
>   i2c: fsi: Add port structures
>   i2c: fsi: Add abort and hardware reset procedures
>   i2c: fsi: Add transfer implementation
>   i2c: fsi: Add I2C master locking
>   i2c: fsi: Add bus recovery
>
>  Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
>  drivers/i2c/busses/Kconfig                        |  11 +
>  drivers/i2c/busses/Makefile                       |   1 +
>  drivers/i2c/busses/i2c-fsi.c                      | 727 ++++++++++++++++++++++
>  4 files changed, 779 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
>  create mode 100644 drivers/i2c/busses/i2c-fsi.c
>
> --
> 1.8.3.1
>



-- 
With Best Regards,
Andy Shevchenko
