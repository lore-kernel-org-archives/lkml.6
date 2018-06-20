Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EF62083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSB1Cpeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EF62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFTXFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:05:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40978 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTXFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:05:16 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so1763413lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQhNTftR2vxVaOW+CzxURHzqAy3Jug2LT75dhvX7qPc=;
        b=BSB1Cpeh1H/GslcYcrBj5ryPmbxC1OoNzICb5XB3E4ngYPsWDnJLkjujoMHeCmf7zR
         hzsCt8Ih41zcBohDFgUACFBUst8oeUhs/iWa842dAtbcVXDup6Y5x4RSagedZSakvmsA
         cZJMF87SYGYmK6hNXwxOPI8ayxLSgDFaHm2a1mshR07CpITQ6q2u8OyXBTBrd0V21xR6
         +67ejOgCsgGGQmI2zHK9cXjxVkzBBHUj4PlBXKChC+94iVU9gG1VFI0O5jqVFmXTtzh7
         WxCnRraRpExpLM0/rp9kFYaASEdBljt0L8cEbsvE1k9NLYrwI7b4ukV+Sb3e/pXM1lK2
         RrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQhNTftR2vxVaOW+CzxURHzqAy3Jug2LT75dhvX7qPc=;
        b=jppzVjGpW/x34p7hOx/A3oJndGkFi3YvcfYYsntfXVX9Ozkl8oNBXafgwn5S42nY7i
         oeBJ1Mf9r7G1bLA3Iy5NS401Gh2xolH89VefgbmnsXJ28o9KKPJUfxR4TJiUnpWD3tEF
         IMqB7w9pA8VjcVdHWEgMBMj5rRUt7XL7df8G5qL93BxXThqu3Nu5oKIU/xPSu1TUaL0p
         /BW9FAvnjEeq3PIMuFcLD02NUeATfQvrRrDHqI6w1sO90sA8krTVh7ZRrHxWRj42f5zO
         6MrQUgPrasj6nhy/hXTLE8EdjU3TpgkxTkLWl/T0tsCYpCUSuX8Z/b5ze4wlDNjWSXiB
         P94w==
X-Gm-Message-State: APt69E0kGLerWZySRED6cGDg2R2o6NkY57i3jedmIOTevyHOf0Mlosp+
        SQ/xFO1mKE6NC4BOx0aT09OQHUVdxrgPyoSCwXQ=
X-Google-Smtp-Source: ADUXVKJePtSOFtK1u988zw9JJNCYl2EmXUbH9ROBR75JWXFXkIOa29CjG4BJfbUWRvZHwlea8Om7vEM8WpzUfloqG6Y=
X-Received: by 2002:a2e:21c7:: with SMTP id h68-v6mr15073034lji.108.1529535915234;
 Wed, 20 Jun 2018 16:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <1511194526-3729-1-git-send-email-thierry.escande@collabora.com> <1511194526-3729-3-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1511194526-3729-3-git-send-email-thierry.escande@collabora.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 20 Jun 2018 16:05:03 -0700
Message-ID: <CAKdAkRRtv41c-s7vunaBde9Oj8L5b5YdfHcOFEueGYenHV=byg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cros_ec: Move cros_ec_dev module to drivers/mfd
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thierry Escande <thierry.escande@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2017 at 8:18 AM Thierry Escande
<thierry.escande@collabora.com> wrote:
>
> The cros_ec_dev module is responsible for registering the MFD devices
> attached to the ChromeOS EC. This patch moves this module to drivers/mfd
> so calls to mfd_add_devices() are not done from outside the MFD subtree
> anymore.

I am quite a bit late to the party, but what's the rationale for not
using mfd_add_devices() from outside of MFD tree? We do allow
registering i2c clients from outside of i2c core, and spi from outside
of spi core, etc, etc.

Right now I see cros_ec being split, quite haphazardly, between
drivers/platform/chrome and drivers/mfd, with some transport drivers
(i2C, SPI) and some interfaces living in MFD, while LPC transport and
host of other stuff living in drivers/platform. On top of that we have
cros_ec_keyb in input, RTC drivers, CEC, and god knows what else
spread across various subsystems:

dtor@dtor-ws:~/kernel/linus $ find -name 'cros_ec*.c'
./drivers/iio/light/cros_ec_light_prox.c
./drivers/iio/accel/cros_ec_accel_legacy.c
./drivers/iio/pressure/cros_ec_baro.c
./drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
./drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
./drivers/mfd/cros_ec_spi.c
./drivers/mfd/cros_ec.c
./drivers/mfd/cros_ec_i2c.c
./drivers/mfd/cros_ec_dev.c
./drivers/input/keyboard/cros_ec_keyb.c
./drivers/platform/chrome/cros_ec_vbc.c
./drivers/platform/chrome/cros_ec_debugfs.c
./drivers/platform/chrome/cros_ec_lpc.c
./drivers/platform/chrome/cros_ec_lightbar.c
./drivers/platform/chrome/cros_ec_lpc_reg.c
./drivers/platform/chrome/cros_ec_proto.c
./drivers/platform/chrome/cros_ec_lpc_mec.c
./drivers/platform/chrome/cros_ec_sysfs.c

The fact that sysfs/debugfs code is in platform but we instantiate it
from MFD is pure madness (it's driver private data, there is no reason
why it should be exported to nclude/linux/mfd/cros_ec.h). This all
creates unnecessary friction and I would love to move most of the code
into drivers/platform/chrome.

I see the wisdom of having code that could potentially be used in
several systems in respective subsystems code (pretty much majority of
drivers/mfd/ drivers are for chips/IP blocks that are used and reused
by different systems and boards), but I think cros ec is quite
different in that regard as it is only used by ChromeOS devices and
has little to no chance to be useful anywhere else.

Thanks.

-- 
Dmitry
