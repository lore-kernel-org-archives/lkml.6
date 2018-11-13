Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE46C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40402245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40402245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbeKNDZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:25:25 -0500
Received: from shell.v3.sk ([90.176.6.54]:39971 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbeKNDZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:25:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 89875C5812;
        Tue, 13 Nov 2018 18:26:17 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0fSXzr9MCGlQ; Tue, 13 Nov 2018 18:26:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3D445C677C;
        Tue, 13 Nov 2018 18:26:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tP18bakb2Awa; Tue, 13 Nov 2018 18:26:11 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CCF4AC674B;
        Tue, 13 Nov 2018 18:26:10 +0100 (CET)
Message-ID: <8881f5e48613c9d9d133e3964031fe2ab57f4801.camel@v3.sk>
Subject: Re: [PATCH 06/15] Platform: OLPC: Add XO-1.75 EC driver
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Date:   Tue, 13 Nov 2018 18:26:09 +0100
In-Reply-To: <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-7-lkundrak@v3.sk>
         <CAHp75VcefOJHZ3WdZYrGEJFjqg2s1oJ75Jg9gKmQFre_ScAPZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first of all -- thanks for such a careful review. It is very helpful.

Wherever I don't respond to you, I'm just following what you wrote. It
would perhaps be tiresome to respond to "Yes, will fix in next version"
to every single point.

I'll be following up with a new version in a few days; I'm mostly done
with this one but I've not finished addressing the followup ones.

On Fri, 2018-10-19 at 19:06 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> > 
> > Modified to plug into the olpc-ec driver infrastructure (so that
> > battery
> > interface and debugfs could be reused) and the SPI slave framework.
> > +#include <asm/system_misc.h>
> 
> asm/* goes after linux/*
> 
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/completion.h>
> > +#include <linux/slab.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/ctype.h>
> > +#include <linux/olpc-ec.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/reboot.h>
> > +#include <linux/input.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/module.h>
> > +#include <linux/power_supply.h>
> 
> Easy to maintain when it's sorted.
> 
> > +       { 0 },
> 
> Terminators are better without trailing comma.
> 
> > +#define EC_CMD_LEN             8
> > +#define EC_MAX_RESP_LEN                16
> > +#define LOG_BUF_SIZE           127
> 
> 127 sounds slightly strange. Is it by specification of protocol?
> Would
> it be better to define it 128 bytes / items?
> 
> > +static int olpc_xo175_ec_is_valid_cmd(u8 cmd)
> > +{
> > +       const struct ec_cmd_t *p;
> > +
> > +       for (p = olpc_xo175_ec_cmds; p->cmd; p++) {
> > +               if (p->cmd == cmd)
> > +                       return p->bytes_returned;
> > +       }
> > +
> > +       return -1;
> 
> -EINVAL ?
> 
> > +}
> > +static void olpc_xo175_ec_complete(void *arg);
> 
> Hmm... Can we avoid forward declaration?

I don't think we can.

> > +       channel = priv->rx_buf[0];
> > +       byte = priv->rx_buf[1];
> 
> Maybe specific structures would fit better?
> 
> Like
> 
> struct olpc_ec_resp_hdr {
>  u8 channel;
>  u8 byte;
> ...
> }
> 
> > +               dev_warn(dev, "kbd/tpad not supported\n");
> 
> Please, spell it fully as touchpad and keyboard.
> 
> > +                       pm_wakeup_event(priv->pwrbtn->dev.parent,
> > 1000);
> 
> Magic number.
> 
> > +                       /* For now, we just ignore the unknown
> > events. */
> 
> dev_dbg(dev, "Ignored unknown event %.2x\n", byte);
> 
> ?
> 
> > if (isprint(byte)) {
> > +                       priv->logbuf[priv->logbuf_len++] = byte;
> > +                       if (priv->logbuf_len == LOG_BUF_SIZE)
> > +                               olpc_xo175_ec_flush_logbuf(priv);
> > +               }
> 
> You may consider to take everything and run %pE when printing instead
> of %s.
> 
> > +static int olpc_xo175_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8
> > *resp,
> > +                                       size_t resp_len, void
> > *ec_cb_arg)
> > +{
> > +       struct olpc_xo175_ec *priv = ec_cb_arg;
> > +       struct device *dev = &priv->spi->dev;
> > +       unsigned long flags;
> > +       int nr_bytes;
> > +       int ret = 0;
> > +
> > +       dev_dbg(dev, "CMD %x, %d bytes expected\n", cmd, resp_len);
> > +
> > +       if (inlen > 5) {
> 
> Magic number.
> 
> > +               dev_err(dev, "command len %d too big!\n",
> > resp_len);
> > +               return -EOVERFLOW;
> > +       }
> > +       WARN_ON(priv->suspended);
> > +       if (priv->suspended)
> 
> if (WARN_ON(...)) ?
> 
> > +               return -EBUSY;
> > +       if (resp_len > nr_bytes)
> > +               resp_len = nr_bytes;
> 
> resp_len = min(resp_len, nr_bytes);
> 
> > +       priv->cmd[0] = cmd;
> > +       priv->cmd[1] = inlen;
> > +       priv->cmd[2] = 0;
> 
> Perhaps specific struct header for this?
> 
> > +       memset(resp, 0, resp_len);
> 
> Wouldn't be better to do this in where actual response has been
> filled?
> 
> > +       if (!wait_for_completion_timeout(&priv->cmd_done,
> > +                       msecs_to_jiffies(4000))) {
> 
> Magic number.
> 
> > +       }
> > +       /* Deal with the results. */
> 
> Somehow feels noisy / unneeded comment.
> 
> > +       if (priv->cmd_state == CMD_STATE_ERROR_RECEIVED) {
> > +               /* EC-provided error is in the single response byte
> > */
> > +               dev_err(dev, "command 0x%x returned error 0x%x\n",
> > +                                                       cmd, priv-
> > >resp[0]);
> 
> Indentation.
> 
> > +               ret = -EREMOTEIO;
> > +       } else if (priv->resp_len != nr_bytes) {
> > +               dev_err(dev, "command 0x%x returned %d bytes,
> > expected %d bytes\n",
> > +                                               cmd, priv-
> > >resp_len, nr_bytes);
> > +               ret = -ETIMEDOUT;
> 
> In the message I see nothing about timeout.
> 
> > +       } else {
> > +       }
> > +}
> > +static int olpc_xo175_ec_set_event_mask(unsigned int mask)
> > +{
> > +       unsigned char args[2];
> 
> u8
> 
> > +
> > +       args[0] = mask & 0xff;
> > +       args[1] = (mask >> 8) & 0xff;
> 
> ...mask >> 0;
> ...mask >> 8;
> 
> > +       return olpc_ec_cmd(CMD_WRITE_EXT_SCI_MASK, args, 2, NULL,
> > 0);
> > +}
> > +
> > +static void olpc_xo175_ec_restart(enum reboot_mode mode, const
> > char *cmd)
> > +{
> > +       while (1) {
> > +               olpc_ec_cmd(CMD_POWER_CYCLE, NULL, 0, NULL, 0);
> > +               mdelay(1000);
> > +       }
> > +}
> > +
> > +static void olpc_xo175_ec_power_off(void)
> > +{
> > +       while (1) {
> > +               olpc_ec_cmd(CMD_POWER_OFF, NULL, 0, NULL, 0);
> > +               mdelay(1000);
> > +       }
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int olpc_xo175_ec_suspend(struct device *dev)
> 
> __maybe_unused  instead of ugly #ifdef?
> 
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);
> 
> dev_get_drvdata() or how is it called?
> 
> > +       unsigned char hintargs[5];
> 
> struct olpc_ec_hint_cmd {
> u8 ...
> u32 ...
> };
> 
> ?
> 
> > +       static unsigned int suspend_count;
> 
> u32 I suppose.
> 
> > +
> > +       suspend_count++;
> > +       dev_dbg(dev, "%s: suspend sync %08x\n", __func__,
> > suspend_count);
> 
> __func__ can be issued if user asked for via Dynamic Debug interface.
> 
> > +       /*
> > +        * First byte is 1 to indicate suspend, the rest is an
> > integer
> > +        * counter.
> > +        */
> > +       hintargs[0] = 1;
> > +       memcpy(&hintargs[1], &suspend_count, 4);
> > +       olpc_ec_cmd(CMD_SUSPEND_HINT, hintargs, 5, NULL, 0);
> 
> What do you need this counter for?

It doesn't seem to be actually used in the EC; the firmware just
includes it in its debug log. I'm not sure if all firmware versions
behave this way and I'd prefer to keep it.

I'm adding a comment.

> 
> > +       priv->suspended = true;
> 
> Hmm... Who is the user of it?
> 
> > +       return 0;
> > +}
> > +
> > +static int olpc_xo175_ec_resume_noirq(struct device *dev)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);
> > +
> > +       priv->suspended = false;
> > +
> > +       return 0;
> > +}
> > +
> > +static int olpc_xo175_ec_resume(struct device *dev)
> > +{
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct olpc_xo175_ec *priv = platform_get_drvdata(pdev);
> > +       unsigned char x = 0;
> 
> u8
> 
> > +       priv->suspended = false;
> 
> Isn't it redundant since noirq callback above?
> 
> > +       /*
> > +        * The resume hint is only needed if no other commands are
> > +        * being sent during resume. all it does is tell the EC
> > +        * the SoC is definitely awake.
> > +        */
> > +       olpc_ec_cmd(CMD_SUSPEND_HINT, &x, 1, NULL, 0);
> > +
> > +       /* Enable all EC events while we're awake */
> > +       olpc_xo175_ec_set_event_mask(0xffff);
> 
> #define EC_ALL_EVENTS GENMASK(15, 0)
> 
> > +}
> > +#endif
> > +static struct platform_device *olpc_ec;
> 
> I would rather see this at the top of file.
> 
> > +static int olpc_xo175_ec_probe(struct spi_device *spi)
> > +{
> > +       if (olpc_ec) {
> > +               dev_err(&spi->dev, "OLPC EC already
> > registered.\n");
> > +               return -EBUSY;
> > +       }
> 
> It's racy against parallel probe called. I don't think it would be a
> real issue, just let you know.
> 
> 
> > +       /* Set up power button input device */
> > +       priv->pwrbtn = devm_input_allocate_device(&spi->dev);
> > +       if (!priv->pwrbtn)
> > +               return -ENOMEM;
> > +       priv->pwrbtn->name = "Power Button";
> > +       priv->pwrbtn->dev.parent = &spi->dev;
> > +       input_set_capability(priv->pwrbtn, EV_KEY, KEY_POWER);
> > +       ret = input_register_device(priv->pwrbtn);
> > +       if (ret) {
> > +               dev_err(&spi->dev, "error registering input device:
> > %d\n", ret);
> > +               return ret;
> > +       }
> 
> I would split out power button driver, but it's up to you.
> 
> 
> > +       /* Enable all EC events while we're awake */
> > +       olpc_xo175_ec_set_event_mask(0xffff);
> 
> See above about this magic.
> 
> > +}
> > +#ifdef CONFIG_PM
> > +       .suspend        = olpc_xo175_ec_suspend,
> > +       .resume_noirq   = olpc_xo175_ec_resume_noirq,
> > +       .resume         = olpc_xo175_ec_resume,
> > +#endif
> 
> SET_SYSTEM_SLEEP_PM_OPS() ?
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() ?
> 
> > +static const struct of_device_id olpc_xo175_ec_of_match[] = {
> > +       { .compatible = "olpc,xo1.75-ec" },
> > +       { },
> 
> No comma for terminators.
> 
> > +};

Thanks,
Lubo

