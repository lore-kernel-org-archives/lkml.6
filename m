Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F981ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66CF21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RESvqiBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66CF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeJTANy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:13:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46585 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJTANy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:13:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so38850136qtk.13;
        Fri, 19 Oct 2018 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCum8aPwn/o8pLcR8Vrwj3mlpgZVr0gX860wcaVkbGw=;
        b=RESvqiBHlvz1wDrPp3HUUn4wnjCgvQIeWPoMQlgXosGgAaXGzgT7ZfluCdc9zPlOEP
         qd7gvc1gKl/yiiU4k+HarZOBqjJEjHY3bawFZVT3WQx0pnhAAjfAi3Tf2xPJx/xmpYsM
         SUjnOCuhs1sTPRNjxjiWEUU1a+7RTT9NplPhtCiQXeaS9zrX+rLuabG868RQGA3LhZEQ
         W/iZORASPgC0H+nD+v5zEBjoXACz91zO/js8uPmwBOu0NXLlCz2NRqnWzlhhXjfKy6JC
         UJTmrTKACpx7cT6rihjYwcxhlo9b6oWAluo+axgFke92gwa3diL+aQ2oKrlJxqxNOBC3
         Obqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCum8aPwn/o8pLcR8Vrwj3mlpgZVr0gX860wcaVkbGw=;
        b=qdJgVMkQ3wmbprjx/GDBRH3az6HB+8/U75fQrVtcWyT4o2BW3VmEirEsDhVJozG8UO
         bjFT3/evZcjbWzp5mNUqE+UatS14bI3iliPRMTt6WEeHLXIAT4Jq4YvGOJVWzRlCm7wo
         YKjMQGiahLf+1M5y8eTPWnBTEhyh9occor0hUZcNTg8rFxwpaQdPdBRhtzKTzNiuBYyX
         V9pqEMR8ykfFTbOclTwfFdgKtvc/C4bFq2KobMMqm29Z0UX8bf8BFCVf43yTH5/1/S7r
         An6zdXs4M0A3wa6zn/9Nu4JKeuOjm5mcsz6ZA7AWdEeRxKZsJj0NHRNSZSQGAAF6Hq+1
         cEFA==
X-Gm-Message-State: AGRZ1gJt0rMIm706MPs+8r5cVjBg3+uYjZeeEkhjWjLb5fPbfqWxk5f6
        Hw9KDhyg9Y3nHFedxRq9krc2HAyFFy82NHk5omg=
X-Google-Smtp-Source: ACcGV60jhbDR/vAW+06Gup3ftmEn0ZrD/ryKwQc/krC27TSITEruQrMYiW8/xpC2mrjPkW0E+rnLRWwixqm8TengASs=
X-Received: by 2002:ac8:191a:: with SMTP id t26-v6mr1941326qtj.327.1539965228454;
 Fri, 19 Oct 2018 09:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-7-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-7-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 19:06:56 +0300
Message-ID: <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
Subject: Re: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> It's based off the driver from the OLPC kernel sources. Somewhat
> modernized and cleaned up, for better or worse.
>
> Modified to plug into the olpc-ec driver infrastructure (so that battery
> interface and debugfs could be reused) and the SPI slave framework.


> +#include <asm/system_misc.h>

asm/* goes after linux/*

> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/spinlock.h>
> +#include <linux/completion.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/ctype.h>
> +#include <linux/olpc-ec.h>
> +#include <linux/spi/spi.h>
> +#include <linux/reboot.h>
> +#include <linux/input.h>
> +#include <linux/kfifo.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>

Easy to maintain when it's sorted.

> +       { 0 },

Terminators are better without trailing comma.

> +#define EC_CMD_LEN             8
> +#define EC_MAX_RESP_LEN                16

> +#define LOG_BUF_SIZE           127

127 sounds slightly strange. Is it by specification of protocol? Would
it be better to define it 128 bytes / items?

> +static int olpc_xo175_ec_is_valid_cmd(u8 cmd)
> +{
> +       const struct ec_cmd_t *p;
> +
> +       for (p = olpc_xo175_ec_cmds; p->cmd; p++) {
> +               if (p->cmd == cmd)
> +                       return p->bytes_returned;
> +       }
> +
> +       return -1;

-EINVAL ?

> +}

> +static void olpc_xo175_ec_complete(void *arg);

Hmm... Can we avoid forward declaration?

> +       channel = priv->rx_buf[0];
> +       byte = priv->rx_buf[1];

Maybe specific structures would fit better?

Like

struct olpc_ec_resp_hdr {
 u8 channel;
 u8 byte;
...
}

> +               dev_warn(dev, "kbd/tpad not supported\n");

Please, spell it fully as touchpad and keyboard.

> +                       pm_wakeup_event(priv->pwrbtn->dev.parent, 1000);

Magic number.

> +                       /* For now, we just ignore the unknown events. */

dev_dbg(dev, "Ignored unknown event %.2x\n", byte);

?

> if (isprint(byte)) {
> +                       priv->logbuf[priv->logbuf_len++] = byte;
> +                       if (priv->logbuf_len == LOG_BUF_SIZE)
> +                               olpc_xo175_ec_flush_logbuf(priv);
> +               }

You may consider to take everything and run %pE when printing instead of %s.

> +static int olpc_xo175_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *resp,
> +                                       size_t resp_len, void *ec_cb_arg)
> +{
> +       struct olpc_xo175_ec *priv = ec_cb_arg;
> +       struct device *dev = &priv->spi->dev;
> +       unsigned long flags;
> +       int nr_bytes;
> +       int ret = 0;
> +
> +       dev_dbg(dev, "CMD %x, %d bytes expected\n", cmd, resp_len);
> +
> +       if (inlen > 5) {

Magic number.

> +               dev_err(dev, "command len %d too big!\n", resp_len);
> +               return -EOVERFLOW;
> +       }

> +       WARN_ON(priv->suspended);
> +       if (priv->suspended)

if (WARN_ON(...)) ?

> +               return -EBUSY;

> +       if (resp_len > nr_bytes)
> +               resp_len = nr_bytes;

resp_len = min(resp_len, nr_bytes);

> +       priv->cmd[0] = cmd;
> +       priv->cmd[1] = inlen;
> +       priv->cmd[2] = 0;

Perhaps specific struct header for this?

> +       memset(resp, 0, resp_len);

Wouldn't be better to do this in where actual response has been filled?

> +       if (!wait_for_completion_timeout(&priv->cmd_done,
> +                       msecs_to_jiffies(4000))) {

Magic number.

> +       }

> +       /* Deal with the results. */

Somehow feels noisy / unneeded comment.

> +       if (priv->cmd_state == CMD_STATE_ERROR_RECEIVED) {
> +               /* EC-provided error is in the single response byte */
> +               dev_err(dev, "command 0x%x returned error 0x%x\n",
> +                                                       cmd, priv->resp[0]);

Indentation.

> +               ret = -EREMOTEIO;
> +       } else if (priv->resp_len != nr_bytes) {

> +               dev_err(dev, "command 0x%x returned %d bytes, expected %d bytes\n",
> +                                               cmd, priv->resp_len, nr_bytes);
> +               ret = -ETIMEDOUT;

In the message I see nothing about timeout.

> +       } else {

> +       }

> +}


> +static int olpc_xo175_ec_set_event_mask(unsigned int mask)
> +{
> +       unsigned char args[2];

u8

> +
> +       args[0] = mask & 0xff;
> +       args[1] = (mask >> 8) & 0xff;

...mask >> 0;
...mask >> 8;

> +       return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL, 0);
> +}

> +
> +static void olpc_xo175_ec_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       while (1) {
> +               olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
> +               mdelay(1000);
> +       }
> +}
> +

> +static void olpc_xo175_ec_power_off(void)
> +{
> +       while (1) {
> +               olpc_ec_cmd(CMD_POWER_OFF, NULL, 0, NULL, 0);
> +               mdelay(1000);
> +       }
> +}
> +

> +#ifdef CONFIG_PM
> +static int olpc_xo175_ec_suspend(struct device *dev)

__maybe_unused  instead of ugly #ifdef?

> +{

> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);

dev_get_drvdata() or how is it called?

> +       unsigned char hintargs[5];

struct olpc_ec_hint_cmd {
u8 ...
u32 ...
};

?

> +       static unsigned int suspend_count;

u32 I suppose.

> +
> +       suspend_count++;
> +       dev_dbg(dev, "%s: suspend sync %08x\n", __func__, suspend_count);

__func__ can be issued if user asked for via Dynamic Debug interface.

> +       /*
> +        * First byte is 1 to indicate suspend, the rest is an integer
> +        * counter.
> +        */
> +       hintargs[0] = 1;
> +       memcpy(&hintargs[1], &suspend_count, 4);
> +       olpc_ec_cmd(CMD_SUSPEND_HINT, hintargs, 5, NULL, 0);

What do you need this counter for?

> +       priv->suspended = true;

Hmm... Who is the user of it?

> +       return 0;
> +}
> +
> +static int olpc_xo175_ec_resume_noirq(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);
> +
> +       priv->suspended = false;
> +
> +       return 0;
> +}
> +
> +static int olpc_xo175_ec_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);

> +       unsigned char x = 0;

u8

> +       priv->suspended = false;

Isn't it redundant since noirq callback above?

> +       /*
> +        * The resume hint is only needed if no other commands are
> +        * being sent during resume. all it does is tell the EC
> +        * the SoC is definitely awake.
> +        */
> +       olpc_ec_cmd(CMD_SUSPEND_HINT, &x, 1, NULL, 0);
> +

> +       /* Enable all EC events while we're awake */
> +       olpc_xo175_ec_set_event_mask(0xffff);

#define EC_ALL_EVENTS GENMASK(15, 0)

> +}
> +#endif

> +static struct platform_device *olpc_ec;

I would rather see this at the top of file.

> +static int olpc_xo175_ec_probe(struct spi_device *spi)
> +{

> +       if (olpc_ec) {
> +               dev_err(&spi->dev, "OLPC EC already registered.\n");
> +               return -EBUSY;
> +       }

It's racy against parallel probe called. I don't think it would be a
real issue, just let you know.


> +       /* Set up power button input device */
> +       priv->pwrbtn = devm_input_allocate_device(&spi->dev);
> +       if (!priv->pwrbtn)
> +               return -ENOMEM;
> +       priv->pwrbtn->name = "Power Button";
> +       priv->pwrbtn->dev.parent = &spi->dev;
> +       input_set_capability(priv->pwrbtn, EV_KEY, KEY_POWER);
> +       ret = input_register_device(priv->pwrbtn);
> +       if (ret) {
> +               dev_err(&spi->dev, "error registering input device: %d\n", ret);
> +               return ret;
> +       }

I would split out power button driver, but it's up to you.


> +       /* Enable all EC events while we're awake */
> +       olpc_xo175_ec_set_event_mask(0xffff);

See above about this magic.

> +}

> +#ifdef CONFIG_PM
> +       .suspend        = olpc_xo175_ec_suspend,
> +       .resume_noirq   = olpc_xo175_ec_resume_noirq,
> +       .resume         = olpc_xo175_ec_resume,
> +#endif

SET_SYSTEM_SLEEP_PM_OPS() ?
SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() ?

> +static const struct of_device_id olpc_xo175_ec_of_match[] = {
> +       { .compatible = "olpc,xo1.75-ec" },

> +       { },

No comma for terminators.

> +};

-- 
With Best Regards,
Andy Shevchenko
