Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A6C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421DB206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8HSxRh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfBVOs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:48:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39770 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVOs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:48:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so1218909pfo.6;
        Fri, 22 Feb 2019 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tI3ABGxNVseRQwQYkzwqi23UW5q2r/ycKQGwMtQfvAg=;
        b=a8HSxRh5sFULpTwm7c8G7xKXj36M98l4HnhOGW/gPsk1Wmg25waHnA9aMhX9oqdTrH
         1itSpRyg5s9UIWUKvHPW5z7px2or3RQxWybJ6jYNZgjCyL5GgxcrrYZyHDpHna65TPt4
         GQpFSv2D+6Yim5vMVXxkUcJYSAgWGUgq+HxpG9CiCE6a0YaDxBbK3Wi1g+wqkTjK+9Y+
         9xSrDMJMtWIdRh2qEPMPWFNqa2ackbp/KGLqLeQ9qUeMLiJFoPrMzh6kvh/1wEv7crvD
         IBBppLIT74XR8+lwbFvZym6jWXUroJiUgbrptMO2IpnqZ9qQ5YoUAUSG1AzM1HVOVTwW
         hvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tI3ABGxNVseRQwQYkzwqi23UW5q2r/ycKQGwMtQfvAg=;
        b=XV4gjlWoRGZqFUq4YSu0jTUBaQC4c6+uTvq+5OPk/CpSeRwcxwMpSYmDvCIxjTmnYS
         W0WwErxbBr6igDkwS3OrBlyhEU59JteGwJtwbNW1ACTyXQEgs54pOZRs5uqw2ha5wgRL
         ALRorxmi6p3kJQVm7tJZ/E43Z+O0/BnnJlrDYGRh0vLGHh9aPqDEtCavs+fjMdyVJCCp
         9QgVX0cOis2Jw+nkMyUl3Gohts8JvAT9lPbSDKiyWl4ICIcFyxC9C53rNPdVreopmPsS
         kA4+41gY/n5sCiD7TisI18JM15lE+1Frqd5gJHBO5rkGUx1bfSBam635bS4WkPfONNkR
         QR2w==
X-Gm-Message-State: AHQUAubdaLfPdijBzUNtcDgFtPtdCfV3czdvIe/eKWchAptyfeagPX8H
        6vZBN4O/nJTLjczMaSaSQuHBU1OvXkmrUz2xxxE=
X-Google-Smtp-Source: AHgI3IZpUHCTOx6K4Hn24lAe79J0ACHZwDoY1zqYFChzobS1TEe9388fu16Cvy3DmSQsTjB3fyGmDCMJnIb7xfIzzrE=
X-Received: by 2002:a62:5e41:: with SMTP id s62mr4513385pfb.232.1550846905787;
 Fri, 22 Feb 2019 06:48:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550768574.git.hns@goldelico.com>
In-Reply-To: <cover.1550768574.git.hns@goldelico.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Feb 2019 16:48:14 +0200
Message-ID: <CAHp75VeMTd32S+bTgU2f1AS-NB67iuM+erT8qNJgPS7O0E1Cjg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] iio mount matrix - revitalize missing bindings
 documentation and provide code for bmc150, bmg160, bma180, itg3200, hmc584x
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 7:04 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Fixes V2:
> * make get_mount_matrix() functions more readable (use temp variable)
>   (suggested by Jonathan and Andy)
> * add these readability improvements also for ak8975 and mpu6050
>   (suggested by Jonathan and Andy)
> * squash bindings documentation into single commit for better discussion
>   (suggested by Linus)
> * FOR DISCUSSION: add some more clarifications to the bindings documentation
>   and an attempt to define the magnetometer orientation
> * add "iio: Allow to read mount matrix from ACPI" to the beginning of
>   the series to make it compile
>   (suggested by Andy)
> * replace of_iio_read_mount_matrix() by iio_read_mount_matrix()
>   (required by "iio: Allow to read mount matrix from ACPI")
> * drop patch to convert bma180 to devm (potential race)
>   (suggested by Jonathan)
>
> PATCH V1 2019-02-20 15:01:02:
> This patch series adds the mount-matrix to several iio sensor drivers
> used in handheld devices.
>
> The mount-matrix translates the quite arbitrary orientation of the sensor
> on some printed circuit board to user-tangible orientation in handheld
> devices that relates to typical screen orientation.
>
> There was a bindings documentation by Linus Walleij but the patch
> did not make it into mainline. Therefore I resend it here.
>
> Next I have added some clarifications (at least I hope it clarifies)
> in a second patch.
>
> Finally, the patch set implements the hooks for the mount matrix
> in several iio drivers: bmc150, bma180, bmg160, itg3200, hmc5843.
> This includes also one patch for the bma180 to convert it to devm API.
>
> We use them in different variants of the omap3-gta04 so a separate
> patch set will provide device tree additions for them.
>

Thank you, it looks nice.
FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


>
> Andy Shevchenko (1):
>   iio: Allow to read mount matrix from ACPI
>
> H. Nikolaus Schaller (8):
>   iio: accel: bmc150: add mount matrix support
>   iio: accel: bma180: add mount matrix support
>   iio: gyro: bmg160: add mount matrix support
>   iio: gyro: itg3200: add mount matrix support
>   iio: magnetometer: bmc150: add mount matrix support
>   iio: magnetometer: hmc5843: add mount matrix support
>   iio: mpu6050: improve code readability
>   iio: ak8975: improve code readability
>
> Linus Walleij (1):
>   iio: document bindings for mounting matrices
>
>  .../devicetree/bindings/iio/mount-matrix.txt  | 204 ++++++++++++++++++
>  drivers/iio/accel/bma180.c                    |  18 +-
>  drivers/iio/accel/bmc150-accel-core.c         |  21 ++
>  drivers/iio/accel/kxsd9.c                     |   4 +-
>  drivers/iio/gyro/bmg160_core.c                |  21 ++
>  drivers/iio/gyro/itg3200_core.c               |  20 ++
>  drivers/iio/gyro/mpu3050-core.c               |   3 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  10 +-
>  drivers/iio/industrialio-core.c               |  46 ++--
>  drivers/iio/magnetometer/ak8974.c             |   5 +-
>  drivers/iio/magnetometer/ak8975.c             |  13 +-
>  drivers/iio/magnetometer/bmc150_magn.c        |  21 ++
>  drivers/iio/magnetometer/hmc5843.h            |   1 +
>  drivers/iio/magnetometer/hmc5843_core.c       |  20 +-
>  include/linux/iio/gyro/itg3200.h              |   1 +
>  include/linux/iio/iio.h                       |   4 +-
>  16 files changed, 361 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
>
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
