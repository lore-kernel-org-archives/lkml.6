Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B9218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Lk8sUNcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9B9218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeHQMDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:03:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45791 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeHQMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:03:44 -0400
Received: by mail-io0-f196.google.com with SMTP id y24-v6so2602412iob.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OhvFaXyTU7uTX/zK+X62xvQPCrwNdqhRsrxXRhWImyw=;
        b=Lk8sUNcXSNaSJvtxhBtzRUWXXTJexkiqpir6wyPfzo0lJ6aKGd4BgOnJQRvZYrV3XK
         Y9OLPXpqbPTAKX9TB8y1kTn0tS6z+LdMFRFeHBGw11jDw3nZQe3hVM+haFlPiTRPU8pW
         7GpCBSEc7luO303JKsBNkuUbSSTXbcgPfhkZ588TrJ++iGYOjtTgiEm2u7sh21UOnazt
         CKlCgs/CHtgWvsR54iV4YAeo8cMTRoAjWvVEztAKn+i4kxFUY793PA2zRS6WkT7oKcMM
         b7HRCUkWDDqHiaA/sVW6On/08jVP+n41d+xRupWIYImx6rz7REuIldl4ibJ5zDigrs93
         nZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OhvFaXyTU7uTX/zK+X62xvQPCrwNdqhRsrxXRhWImyw=;
        b=SJzRLCPIDsNI1EVLgdVUCA2xQG63vAXqILEqlUAX727RANtWV9sUCgeew3XxdDZ6CX
         xS1VyTCPSzi0psaCpyMcATGojxiK6JxH5gvhu9PO5Yl3JNzWEhlCtQmZVs3i34cBi06/
         8ArqZ4+8JblnX8hnqwy1brZ7E7AyhXwiCNMtvXRKEloZ8WbVlPmuyXjomva905VHuXYe
         K8oDXdgnE4LLWXqlA2jRDk9rEZHjomCl0bODSwGXlQMcJezN49JwE3q02NyVEC02ER3U
         MCj4GPRn2UTtD0GtNHV0//D+OlnlIsVprE6VYD22g/E1OStJd28j4Vy/vHB+pyCUswjR
         vRMg==
X-Gm-Message-State: APzg51CeSFs/CigrXOSzgBAFGn1MbIurS+rAmzv++W9laS3FFu34Oe5U
        61YH2weNCtiO8fG+Q+arLpew7m7vTiVnVssJA9XZOA==
X-Google-Smtp-Source: ANB0VdbMVIgvJIKcxl2tjI5M8fyzuU6CCJP7I6+dLdTjnPAK1SP0kzyRIbnNmiqquq7g+EEB0MvmY/eHy738OXagD+c=
X-Received: by 2002:a6b:c807:: with SMTP id y7-v6mr2131915iof.187.1534496468402;
 Fri, 17 Aug 2018 02:01:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9405:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 02:01:07
 -0700 (PDT)
In-Reply-To: <1534441534-6357-1-git-send-email-mark.jonas@de.bosch.com>
References: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com> <1534441534-6357-1-git-send-email-mark.jonas@de.bosch.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 17 Aug 2018 11:01:07 +0200
Message-ID: <CAMRc=MfMZ7pDJ-ULn5JSQq2jYVMgrefk9vmqUinFs=wzZ4rJ3w@mail.gmail.com>
Subject: Re: [PATCH v2] eeprom: at24: Fix unexpected timeout under high load
To:     Mark Jonas <mark.jonas@de.bosch.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wang Xin <xin.wang7@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-16 19:45 GMT+02:00 Mark Jonas <mark.jonas@de.bosch.com>:
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
> ---
> Changes in v2:
>  - Remove loop macro
>  - Accept superfluous sleep in case of timeout
>  - Add concrete example to commit message
> ---
>  drivers/misc/eeprom/at24.c | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index f5cc517..37a5c8b 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -106,23 +106,6 @@ static unsigned int at24_write_timeout = 25;
>  module_param_named(write_timeout, at24_write_timeout, uint, 0);
>  MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
>
> -/*
> - * Both reads and writes fail if the previous write didn't complete yet. This
> - * macro loops a few times waiting at least long enough for one entire page
> - * write to work while making sure that at least one iteration is run before
> - * checking the break condition.
> - *
> - * It takes two parameters: a variable in which the future timeout in jiffies
> - * will be stored and a temporary variable holding the time of the last
> - * iteration of processing the request. Both should be unsigned integers
> - * holding at least 32 bits.
> - */
> -#define at24_loop_until_timeout(tout, op_time)                         \
> -       for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),     \
> -            op_time = 0;                                               \
> -            op_time ? time_before(op_time, tout) : true;               \
> -            usleep_range(1000, 1500), op_time = jiffies)
> -
>  struct at24_chip_data {
>         /*
>          * these fields mirror their equivalents in
> @@ -308,13 +291,22 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>         /* adjust offset for mac and serial read ops */
>         offset += at24->offset_adj;
>
> -       at24_loop_until_timeout(timeout, read_time) {
> +       timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
> +       do {
> +               /*
> +                * The timestamp shall be taken before the actual operation
> +                * to avoid a premature timeout in case of high CPU load.
> +                */
> +               read_time = jiffies;
> +
>                 ret = regmap_bulk_read(regmap, offset, buf, count);
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
> @@ -358,14 +350,23 @@ static ssize_t at24_regmap_write(struct at24_data *at24, const char *buf,
>         regmap = at24_client->regmap;
>         client = at24_client->client;
>         count = at24_adjust_write_count(at24, offset, count);
> +       timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
> +
> +       do {
> +               /*
> +                * The timestamp shall be taken before the actual operation
> +                * to avoid a premature timeout in case of high CPU load.
> +                */
> +               write_time = jiffies;
>
> -       at24_loop_until_timeout(timeout, write_time) {
>                 ret = regmap_bulk_write(regmap, offset, buf, count);
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

Looks good to me, I'll test it after v4.19-rc1 is tagged.

Bart
