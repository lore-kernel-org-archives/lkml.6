Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94236C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B54320C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wifqlxNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B54320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeIYVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39944 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbeIYVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:07 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so2651584iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9jJnzzLM/Fq9pFO1IsRitvxgtntWgwRUBuCOXTiHbeU=;
        b=wifqlxNXyN9w1LATkccktgbazeO470NrYCpaGy1xmWVj5D0Kd78EZdTfMlUVR7gIUG
         J75LL4pA5+aPcs7B6fhlWY6DCyxn96NzIrDFe0meuX5rRmzhEJFdY5EIEeXxDu4G/wMT
         vSUKjlO7nJB8EYIXfNeerQZBx5PPJ9JEAQneqKfaNVUup+9fQm7OkW/LF5ZC5D0YyU9k
         ph1OZ84VISbqqZF14IhKJmgSEPuriYBTK8eHmCG6VjlXgQBUdTZqnaLckhq4kXov0fTC
         bjSQlDZSjm/JnMziQtnrj4bWD0qwpj0QRJQ683EH0x5I1bRkmUNnLdUBnP8xY1YBxWkR
         NsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9jJnzzLM/Fq9pFO1IsRitvxgtntWgwRUBuCOXTiHbeU=;
        b=RtReSFx6woDyIg4fXKLqynpNuLt3sv1JYCIgEYcsQderV5joy8RVJXruoYuZpNogTq
         qGkoBjHB8pa/BVNtP4pGj7RN2y/KuS5S/bGeBdzJ3CeiYTSvo0Y7FcK02Vj977JQyKdF
         IGEdq+5Mfj0zYn9z1y5558c4zgMqyuiO0ma5LYDzUySkkpKL9pCwx8S3YPQ96urNj+0p
         JT6EMtjQSmf83JL7ds4nvuMESIOnKzgapjtUMsbsZ1GUoAjilnv9LJCC2eR6L+lIQRyY
         PW9L7OEL79v1UJ+pu0i0QHi0HYGpi/u33FbHn26FPcAWCJtuF/cBURXvce0feshRjCI5
         8zcw==
X-Gm-Message-State: ABuFfojpWGvXkyUxTeO2Msu6lJgFOP00UKSGyroAcQZOTLP7Zo6fGX10
        tF2xTfEohlvOh2Yh1d6aEgc6WFk/GSPyD30cdiEoPA==
X-Google-Smtp-Source: ACcGV62LZV299cEecFo/U+zjd8XvOqy7xM87G81Y4TWfLUAX8GF6KrrNoXEXVW9lVgUc+H9goFVF4bcl4CgbVxLJXbs=
X-Received: by 2002:a5e:8c04:: with SMTP id n4-v6mr1346401ioj.258.1537888927964;
 Tue, 25 Sep 2018 08:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com> <1534441534-6357-1-git-send-email-mark.jonas@de.bosch.com>
In-Reply-To: <1534441534-6357-1-git-send-email-mark.jonas@de.bosch.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Sep 2018 17:21:57 +0200
Message-ID: <CAMRc=McXDkLomqHy6_KuKDABedv34+cNdJKU_iQVBLBYKFP0Ow@mail.gmail.com>
Subject: Re: [PATCH v2] eeprom: at24: Fix unexpected timeout under high load
To:     "Jonas Mark (ST-FIR/ENG1)" <mark.jonas@de.bosch.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wang Xin <xin.wang7@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 16 sie 2018 o 19:46 Mark Jonas <mark.jonas@de.bosch.com> napisa=C5=82=
(a):
>
> From: Wang Xin <xin.wang7@cn.bosch.com>
>
> Within at24_loop_until_timeout the timestamp used for timeout checking
> is recorded after the I2C transfer and sleep_range(). Under high CPU
> load either the execution time for I2C transfer or sleep_range() could
> actually be larger than the timeout value. Worst case the I2C transfer
> is only tried once because the loop will exit due to the timeout
> although the EEPROM is now ready.
>
> To fix this issue the timestamp is recorded at the beginning of each
> iteration. That is, before I2C transfer and sleep. Then the timeout
> is actually checked against the timestamp of the previous iteration.
> This makes sure that even if the timeout is reached, there is still one
> more chance to try the I2C transfer in case the EEPROM is ready.
>
> Example:
>
> If you have a system which combines high CPU load with repeated EEPROM
> writes you will run into the following scenario.
>
>  - System makes a successful regmap_bulk_write() to EEPROM.
>  - System wants to perform another write to EEPROM but EEPROM is still
>    busy with the last write.
>  - Because of high CPU load the usleep_range() will sleep more than
>    25 ms (at24_write_timeout).
>  - Within the over-long sleeping the EEPROM finished the previous write
>    operation and is ready again.
>  - at24_loop_until_timeout() will detect timeout and won't try to write.
>
> Signed-off-by: Wang Xin <xin.wang7@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>

Applied to at24/for-next.

Thanks,
Bartosz

> ---
> Changes in v2:
>  - Remove loop macro
>  - Accept superfluous sleep in case of timeout
>  - Add concrete example to commit message
> ---
>  drivers/misc/eeprom/at24.c | 43 ++++++++++++++++++++++------------------=
---
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index f5cc517..37a5c8b 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -106,23 +106,6 @@ static unsigned int at24_write_timeout =3D 25;
>  module_param_named(write_timeout, at24_write_timeout, uint, 0);
>  MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (defaul=
t 25)");
>
> -/*
> - * Both reads and writes fail if the previous write didn't complete yet.=
 This
> - * macro loops a few times waiting at least long enough for one entire p=
age
> - * write to work while making sure that at least one iteration is run be=
fore
> - * checking the break condition.
> - *
> - * It takes two parameters: a variable in which the future timeout in ji=
ffies
> - * will be stored and a temporary variable holding the time of the last
> - * iteration of processing the request. Both should be unsigned integers
> - * holding at least 32 bits.
> - */
> -#define at24_loop_until_timeout(tout, op_time)                         \
> -       for (tout =3D jiffies + msecs_to_jiffies(at24_write_timeout),    =
 \
> -            op_time =3D 0;                                              =
 \
> -            op_time ? time_before(op_time, tout) : true;               \
> -            usleep_range(1000, 1500), op_time =3D jiffies)
> -
>  struct at24_chip_data {
>         /*
>          * these fields mirror their equivalents in
> @@ -308,13 +291,22 @@ static ssize_t at24_regmap_read(struct at24_data *a=
t24, char *buf,
>         /* adjust offset for mac and serial read ops */
>         offset +=3D at24->offset_adj;
>
> -       at24_loop_until_timeout(timeout, read_time) {
> +       timeout =3D jiffies + msecs_to_jiffies(at24_write_timeout);
> +       do {
> +               /*
> +                * The timestamp shall be taken before the actual operati=
on
> +                * to avoid a premature timeout in case of high CPU load.
> +                */
> +               read_time =3D jiffies;
> +
>                 ret =3D regmap_bulk_read(regmap, offset, buf, count);
>                 dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>                         count, offset, ret, jiffies);
>                 if (!ret)
>                         return count;
> -       }
> +
> +               usleep_range(1000, 1500);
> +       } while (time_before(read_time, timeout));
>
>         return -ETIMEDOUT;
>  }
> @@ -358,14 +350,23 @@ static ssize_t at24_regmap_write(struct at24_data *=
at24, const char *buf,
>         regmap =3D at24_client->regmap;
>         client =3D at24_client->client;
>         count =3D at24_adjust_write_count(at24, offset, count);
> +       timeout =3D jiffies + msecs_to_jiffies(at24_write_timeout);
> +
> +       do {
> +               /*
> +                * The timestamp shall be taken before the actual operati=
on
> +                * to avoid a premature timeout in case of high CPU load.
> +                */
> +               write_time =3D jiffies;
>
> -       at24_loop_until_timeout(timeout, write_time) {
>                 ret =3D regmap_bulk_write(regmap, offset, buf, count);
>                 dev_dbg(&client->dev, "write %zu@%d --> %d (%ld)\n",
>                         count, offset, ret, jiffies);
>                 if (!ret)
>                         return count;
> -       }
> +
> +               usleep_range(1000, 1500);
> +       } while (time_before(write_time, timeout));
>
>         return -ETIMEDOUT;
>  }
> --
> 2.7.4
>
