Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523447524; cv=none;
        d=google.com; s=arc-20160816;
        b=ysMoy1nUjSgfBpqjHtjFbApONIt4nSy8c/yggtkZIYgFKtY1Q0O1jjx8e2VBeWLULJ
         UGIsQCy18tNbUef4Q+AJe5FeWrte9H3Js4piwiJABU2Od1kfhVbobe4R4MoWE4GHI2p8
         sF9l1tQRzp6MfUHtgCelT2+6PeA+RET9tM1rlybuecWZhprO86va0ULDnP0wH6w+i3H/
         nq6id9AGw0Ec/Qmm0KUsxtUl4917hIeeR+TQBOuN7ui6cAa2DGSU3Gai7TvdXVjtNbjn
         tWZHReOG6Tqb72kTqAkjpuUr8YGq7q359cbxu6qF/jwfojZswPhpNW+POqdRDFK1eOyM
         egYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kZWqitmvM9JWSCtKTw2cMLrBV0xAcx8l9wae3/4Rs5s=;
        b=W1nHI9zy4Z6fwqZslPF7TSr7PNm5NZ6S1jYKldPXUaPgcshArgXIFcH8EKLElG2xhR
         qu/pFOayBzQ4M6xj9iD5KG9NA5ogpA7dIBQo9B/FbNsT4kLMNu5gxMxGgNP3JFiYf9li
         iJB19ZfVrGaBU3YPr/zrh/h4Mixh3mqbHrOpMQV71vDXQh4R7O4t8uhxQN9+kCbrfbW8
         y4ORIgjd46OINg3lpIdClqnJEPeJSPvrEHLy6hSsICBXXgD3W5CHju03WmsXVJaeC+EF
         vDQWtN2Vz2Civa0sOWAa9skdWBmcOVM2vxU+mSoRMZOmMCqHrjfWB8Cam9YAb1PJMB3Q
         yl4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r3wSV/bt;
       dkim=pass header.i=@jms.id.au header.s=google header.b=VB6RNkzq;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r3wSV/bt;
       dkim=pass header.i=@jms.id.au header.s=google header.b=VB6RNkzq;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AIpwx4/0A3vCWCULvCHNwepIwih56YgyGt6yey85+S8YFYptMGg5sYI2Bbrw10l9080H/ifXYNnTMqSTUC3KOGcIYxY=
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180410183212.16787-7-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com> <20180410183212.16787-7-jae.hyun.yoo@linux.intel.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Apr 2018 21:21:43 +0930
X-Google-Sender-Auth: KFsfZFM82sqWoHa4miFWFLuxNJk
Message-ID: <CACPK8XdODUEZNZCkSe+Aq4xdptfhfE=ureUL_v7TgR7w+rMznw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] drivers/peci: Add a PECI adapter driver for
 Aspeed AST24xx/AST25xx
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>, Jean Delvare <jdelvare@suse.com>,
	Julia Cartwright <juliac@eso.teric.us>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, linux-hwmon@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385137876997151?=
X-GMAIL-MSGID: =?utf-8?q?1597450511901959449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Jae,

On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit adds PECI adapter driver implementation for Aspeed
> AST24xx/AST25xx.

The driver is looking good!

It looks like you've done some kind of review that we weren't allowed
to see, which is a double edged sword - I might be asking about things
that you've already spoken about with someone else.

I'm only just learning about PECI, but I do have some general comments below.

> ---
>  drivers/peci/Kconfig       |  28 +++
>  drivers/peci/Makefile      |   3 +
>  drivers/peci/peci-aspeed.c | 504 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 535 insertions(+)
>  create mode 100644 drivers/peci/peci-aspeed.c
>
> diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
> index 1fbc13f9e6c2..0e33420365de 100644
> --- a/drivers/peci/Kconfig
> +++ b/drivers/peci/Kconfig
> @@ -14,4 +14,32 @@ config PECI
>           processors and chipset components to external monitoring or control
>           devices.
>
> +         If you want PECI support, you should say Y here and also to the
> +         specific driver for your bus adapter(s) below.
> +
> +if PECI
> +
> +#
> +# PECI hardware bus configuration
> +#
> +
> +menu "PECI Hardware Bus support"
> +
> +config PECI_ASPEED
> +       tristate "Aspeed AST24xx/AST25xx PECI support"

I think just saying ASPEED PECI support is enough. That way if the
next ASPEED SoC happens to have PECI we don't need to update all of
the help text :)

> +       select REGMAP_MMIO
> +       depends on OF
> +       depends on ARCH_ASPEED || COMPILE_TEST
> +       help
> +         Say Y here if you want support for the Platform Environment Control
> +         Interface (PECI) bus adapter driver on the Aspeed AST24XX and AST25XX
> +         SoCs.
> +
> +         This support is also available as a module.  If so, the module
> +         will be called peci-aspeed.
> +
> +endmenu
> +
> +endif # PECI
> +
>  endmenu
> diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
> index 9e8615e0d3ff..886285e69765 100644
> --- a/drivers/peci/Makefile
> +++ b/drivers/peci/Makefile
> @@ -4,3 +4,6 @@
>
>  # Core functionality
>  obj-$(CONFIG_PECI)             += peci-core.o
> +
> +# Hardware specific bus drivers
> +obj-$(CONFIG_PECI_ASPEED)      += peci-aspeed.o
> diff --git a/drivers/peci/peci-aspeed.c b/drivers/peci/peci-aspeed.c
> new file mode 100644
> index 000000000000..be2a1f327eb1
> --- /dev/null
> +++ b/drivers/peci/peci-aspeed.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2012-2017 ASPEED Technology Inc.
> +// Copyright (c) 2018 Intel Corporation
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/peci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define DUMP_DEBUG 0
> +
> +/* Aspeed PECI Registers */
> +#define AST_PECI_CTRL     0x00

Nit: we use ASPEED instead of AST in the upstream kernel to distingush
from the aspeed sdk drivers. If you feel strongly about this then I
won't insist you change.

> +#define AST_PECI_TIMING   0x04
> +#define AST_PECI_CMD      0x08
> +#define AST_PECI_CMD_CTRL 0x0c
> +#define AST_PECI_EXP_FCS  0x10
> +#define AST_PECI_CAP_FCS  0x14
> +#define AST_PECI_INT_CTRL 0x18
> +#define AST_PECI_INT_STS  0x1c
> +#define AST_PECI_W_DATA0  0x20
> +#define AST_PECI_W_DATA1  0x24
> +#define AST_PECI_W_DATA2  0x28
> +#define AST_PECI_W_DATA3  0x2c
> +#define AST_PECI_R_DATA0  0x30
> +#define AST_PECI_R_DATA1  0x34
> +#define AST_PECI_R_DATA2  0x38
> +#define AST_PECI_R_DATA3  0x3c
> +#define AST_PECI_W_DATA4  0x40
> +#define AST_PECI_W_DATA5  0x44
> +#define AST_PECI_W_DATA6  0x48
> +#define AST_PECI_W_DATA7  0x4c
> +#define AST_PECI_R_DATA4  0x50
> +#define AST_PECI_R_DATA5  0x54
> +#define AST_PECI_R_DATA6  0x58
> +#define AST_PECI_R_DATA7  0x5c
> +
> +/* AST_PECI_CTRL - 0x00 : Control Register */
> +#define PECI_CTRL_SAMPLING_MASK     GENMASK(19, 16)
> +#define PECI_CTRL_SAMPLING(x)       (((x) << 16) & PECI_CTRL_SAMPLING_MASK)
> +#define PECI_CTRL_SAMPLING_GET(x)   (((x) & PECI_CTRL_SAMPLING_MASK) >> 16)
> +#define PECI_CTRL_READ_MODE_MASK    GENMASK(13, 12)
> +#define PECI_CTRL_READ_MODE(x)      (((x) << 12) & PECI_CTRL_READ_MODE_MASK)
> +#define PECI_CTRL_READ_MODE_GET(x)  (((x) & PECI_CTRL_READ_MODE_MASK) >> 12)
> +#define PECI_CTRL_READ_MODE_COUNT   BIT(12)
> +#define PECI_CTRL_READ_MODE_DBG     BIT(13)
> +#define PECI_CTRL_CLK_SOURCE_MASK   BIT(11)
> +#define PECI_CTRL_CLK_SOURCE(x)     (((x) << 11) & PECI_CTRL_CLK_SOURCE_MASK)
> +#define PECI_CTRL_CLK_SOURCE_GET(x) (((x) & PECI_CTRL_CLK_SOURCE_MASK) >> 11)
> +#define PECI_CTRL_CLK_DIV_MASK      GENMASK(10, 8)
> +#define PECI_CTRL_CLK_DIV(x)        (((x) << 8) & PECI_CTRL_CLK_DIV_MASK)
> +#define PECI_CTRL_CLK_DIV_GET(x)    (((x) & PECI_CTRL_CLK_DIV_MASK) >> 8)
> +#define PECI_CTRL_INVERT_OUT        BIT(7)
> +#define PECI_CTRL_INVERT_IN         BIT(6)
> +#define PECI_CTRL_BUS_CONTENT_EN    BIT(5)
> +#define PECI_CTRL_PECI_EN           BIT(4)
> +#define PECI_CTRL_PECI_CLK_EN       BIT(0)

I know these come from the ASPEED sdk driver. Do we need them all?

> +
> +/* AST_PECI_TIMING - 0x04 : Timing Negotiation Register */
> +#define PECI_TIMING_MESSAGE_MASK   GENMASK(15, 8)
> +#define PECI_TIMING_MESSAGE(x)     (((x) << 8) & PECI_TIMING_MESSAGE_MASK)
> +#define PECI_TIMING_MESSAGE_GET(x) (((x) & PECI_TIMING_MESSAGE_MASK) >> 8)
> +#define PECI_TIMING_ADDRESS_MASK   GENMASK(7, 0)
> +#define PECI_TIMING_ADDRESS(x)     ((x) & PECI_TIMING_ADDRESS_MASK)
> +#define PECI_TIMING_ADDRESS_GET(x) ((x) & PECI_TIMING_ADDRESS_MASK)
> +
> +/* AST_PECI_CMD - 0x08 : Command Register */
> +#define PECI_CMD_PIN_MON    BIT(31)
> +#define PECI_CMD_STS_MASK   GENMASK(27, 24)
> +#define PECI_CMD_STS_GET(x) (((x) & PECI_CMD_STS_MASK) >> 24)
> +#define PECI_CMD_FIRE       BIT(0)
> +
> +/* AST_PECI_LEN - 0x0C : Read/Write Length Register */
> +#define PECI_AW_FCS_EN       BIT(31)
> +#define PECI_READ_LEN_MASK   GENMASK(23, 16)
> +#define PECI_READ_LEN(x)     (((x) << 16) & PECI_READ_LEN_MASK)
> +#define PECI_WRITE_LEN_MASK  GENMASK(15, 8)
> +#define PECI_WRITE_LEN(x)    (((x) << 8) & PECI_WRITE_LEN_MASK)
> +#define PECI_TAGET_ADDR_MASK GENMASK(7, 0)
> +#define PECI_TAGET_ADDR(x)   ((x) & PECI_TAGET_ADDR_MASK)
> +
> +/* AST_PECI_EXP_FCS - 0x10 : Expected FCS Data Register */
> +#define PECI_EXPECT_READ_FCS_MASK      GENMASK(23, 16)
> +#define PECI_EXPECT_READ_FCS_GET(x)    (((x) & PECI_EXPECT_READ_FCS_MASK) >> 16)
> +#define PECI_EXPECT_AW_FCS_AUTO_MASK   GENMASK(15, 8)
> +#define PECI_EXPECT_AW_FCS_AUTO_GET(x) (((x) & PECI_EXPECT_AW_FCS_AUTO_MASK) \
> +                                       >> 8)
> +#define PECI_EXPECT_WRITE_FCS_MASK     GENMASK(7, 0)
> +#define PECI_EXPECT_WRITE_FCS_GET(x)   ((x) & PECI_EXPECT_WRITE_FCS_MASK)
> +
> +/* AST_PECI_CAP_FCS - 0x14 : Captured FCS Data Register */
> +#define PECI_CAPTURE_READ_FCS_MASK    GENMASK(23, 16)
> +#define PECI_CAPTURE_READ_FCS_GET(x)  (((x) & PECI_CAPTURE_READ_FCS_MASK) >> 16)
> +#define PECI_CAPTURE_WRITE_FCS_MASK   GENMASK(7, 0)
> +#define PECI_CAPTURE_WRITE_FCS_GET(x) ((x) & PECI_CAPTURE_WRITE_FCS_MASK)
> +
> +/* AST_PECI_INT_CTRL/STS - 0x18/0x1c : Interrupt Register */
> +#define PECI_INT_TIMING_RESULT_MASK GENMASK(31, 30)
> +#define PECI_INT_TIMEOUT            BIT(4)
> +#define PECI_INT_CONNECT            BIT(3)
> +#define PECI_INT_W_FCS_BAD          BIT(2)
> +#define PECI_INT_W_FCS_ABORT        BIT(1)
> +#define PECI_INT_CMD_DONE           BIT(0)
> +
> +struct aspeed_peci {
> +       struct peci_adapter     adaper;
> +       struct device           *dev;
> +       struct regmap           *regmap;
> +       int                     irq;
> +       struct completion       xfer_complete;
> +       u32                     status;
> +       u32                     cmd_timeout_ms;
> +};
> +
> +#define PECI_INT_MASK  (PECI_INT_TIMEOUT | PECI_INT_CONNECT | \
> +                       PECI_INT_W_FCS_BAD | PECI_INT_W_FCS_ABORT | \
> +                       PECI_INT_CMD_DONE)
> +
> +#define PECI_IDLE_CHECK_TIMEOUT_MS      50
> +#define PECI_IDLE_CHECK_INTERVAL_MS     10
> +
> +#define PECI_RD_SAMPLING_POINT_DEFAULT  8
> +#define PECI_RD_SAMPLING_POINT_MAX      15
> +#define PECI_CLK_DIV_DEFAULT            0
> +#define PECI_CLK_DIV_MAX                7
> +#define PECI_MSG_TIMING_NEGO_DEFAULT    1
> +#define PECI_MSG_TIMING_NEGO_MAX        255
> +#define PECI_ADDR_TIMING_NEGO_DEFAULT   1
> +#define PECI_ADDR_TIMING_NEGO_MAX       255
> +#define PECI_CMD_TIMEOUT_MS_DEFAULT     1000
> +#define PECI_CMD_TIMEOUT_MS_MAX         60000
> +
> +static int aspeed_peci_xfer_native(struct aspeed_peci *priv,
> +                                  struct peci_xfer_msg *msg)
> +{
> +       long err, timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
> +       u32 peci_head, peci_state, rx_data, cmd_sts;
> +       ktime_t start, end;
> +       s64 elapsed_ms;
> +       int i, rc = 0;
> +       uint reg;
> +
> +       start = ktime_get();
> +
> +       /* Check command sts and bus idle state */
> +       while (!regmap_read(priv->regmap, AST_PECI_CMD, &cmd_sts) &&
> +              (cmd_sts & (PECI_CMD_STS_MASK | PECI_CMD_PIN_MON))) {
> +               end = ktime_get();
> +               elapsed_ms = ktime_to_ms(ktime_sub(end, start));
> +               if (elapsed_ms >= PECI_IDLE_CHECK_TIMEOUT_MS) {
> +                       dev_dbg(priv->dev, "Timeout waiting for idle state!\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               usleep_range(PECI_IDLE_CHECK_INTERVAL_MS * 1000,
> +                            (PECI_IDLE_CHECK_INTERVAL_MS * 1000) + 1000);
> +       };

Could the above use regmap_read_poll_timeout instead?

> +
> +       reinit_completion(&priv->xfer_complete);
> +
> +       peci_head = PECI_TAGET_ADDR(msg->addr) |
> +                                   PECI_WRITE_LEN(msg->tx_len) |
> +                                   PECI_READ_LEN(msg->rx_len);
> +
> +       rc = regmap_write(priv->regmap, AST_PECI_CMD_CTRL, peci_head);
> +       if (rc)
> +               return rc;
> +
> +       for (i = 0; i < msg->tx_len; i += 4) {
> +               reg = i < 16 ? AST_PECI_W_DATA0 + i % 16 :
> +                              AST_PECI_W_DATA4 + i % 16;
> +               rc = regmap_write(priv->regmap, reg,
> +                                 (msg->tx_buf[i + 3] << 24) |
> +                                 (msg->tx_buf[i + 2] << 16) |
> +                                 (msg->tx_buf[i + 1] << 8) |
> +                                 msg->tx_buf[i + 0]);

That looks like an endian swap. Can we do something like this?

 regmap_write(map, reg, cpu_to_be32p((void *)msg->tx_buff))

> +               if (rc)
> +                       return rc;
> +       }
> +
> +       dev_dbg(priv->dev, "HEAD : 0x%08x\n", peci_head);
> +#if DUMP_DEBUG

Having #defines is frowned upon. I think print_hex_dump_debug will do
what you want here.

> +       print_hex_dump(KERN_DEBUG, "TX : ", DUMP_PREFIX_NONE, 16, 1,
> +                      msg->tx_buf, msg->tx_len, true);
> +#endif
> +
> +       rc = regmap_write(priv->regmap, AST_PECI_CMD, PECI_CMD_FIRE);
> +       if (rc)
> +               return rc;
> +
> +       err = wait_for_completion_interruptible_timeout(&priv->xfer_complete,
> +                                                       timeout);
> +
> +       dev_dbg(priv->dev, "INT_STS : 0x%08x\n", priv->status);
> +       if (!regmap_read(priv->regmap, AST_PECI_CMD, &peci_state))
> +               dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
> +                       PECI_CMD_STS_GET(peci_state));
> +       else
> +               dev_dbg(priv->dev, "PECI_STATE : read error\n");
> +
> +       rc = regmap_write(priv->regmap, AST_PECI_CMD, 0);
> +       if (rc)
> +               return rc;
> +
> +       if (err <= 0 || !(priv->status & PECI_INT_CMD_DONE)) {
> +               if (err < 0) { /* -ERESTARTSYS */
> +                       return (int)err;
> +               } else if (err == 0) {
> +                       dev_dbg(priv->dev, "Timeout waiting for a response!\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               dev_dbg(priv->dev, "No valid response!\n");
> +               return -EIO;
> +       }
> +
> +       for (i = 0; i < msg->rx_len; i++) {
> +               u8 byte_offset = i % 4;
> +
> +               if (byte_offset == 0) {
> +                       reg = i < 16 ? AST_PECI_R_DATA0 + i % 16 :
> +                                      AST_PECI_R_DATA4 + i % 16;

I find this hard to read. Use a few more lines to make it clear what
your code is doing.

Actually, the entire for loop is cryptic. I understand what it's doing
now. Can you rework it to make it more readable? You follow a similar
pattern above in the write case.

> +                       rc = regmap_read(priv->regmap, reg, &rx_data);
> +                       if (rc)
> +                               return rc;
> +               }
> +
> +               msg->rx_buf[i] = (u8)(rx_data >> (byte_offset << 3))
> +       }
> +
> +#if DUMP_DEBUG
> +       print_hex_dump(KERN_DEBUG, "RX : ", DUMP_PREFIX_NONE, 16, 1,
> +                      msg->rx_buf, msg->rx_len, true);
> +#endif
> +       if (!regmap_read(priv->regmap, AST_PECI_CMD, &peci_state))
> +               dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
> +                       PECI_CMD_STS_GET(peci_state));
> +       else
> +               dev_dbg(priv->dev, "PECI_STATE : read error\n");

Given the regmap_read is always going to be a memory read on the
aspeed, I can't think of a situation where the read will fail.

On that note, is there a reason you are using regmap and not just
accessing the hardware directly? regmap imposes a number of pointer
lookups and tests each time you do a read or write.

> +       dev_dbg(priv->dev, "------------------------\n");
> +
> +       return rc;
> +}
> +
> +static irqreturn_t aspeed_peci_irq_handler(int irq, void *arg)
> +{
> +       struct aspeed_peci *priv = arg;
> +       u32 status_ack = 0;
> +
> +       if (regmap_read(priv->regmap, AST_PECI_INT_STS, &priv->status))
> +               return IRQ_NONE;

Again, a memory mapped read won't fail. How about we check that the
regmap is working once in your _probe() function, and assume it will
continue working from there (or remove the regmap abstraction all
together).

> +
> +       /* Be noted that multiple interrupt bits can be set at the same time */
> +       if (priv->status & PECI_INT_TIMEOUT) {
> +               dev_dbg(priv->dev, "PECI_INT_TIMEOUT\n");
> +               status_ack |= PECI_INT_TIMEOUT;
> +       }
> +
> +       if (priv->status & PECI_INT_CONNECT) {
> +               dev_dbg(priv->dev, "PECI_INT_CONNECT\n");
> +               status_ack |= PECI_INT_CONNECT;
> +       }
> +
> +       if (priv->status & PECI_INT_W_FCS_BAD) {
> +               dev_dbg(priv->dev, "PECI_INT_W_FCS_BAD\n");
> +               status_ack |= PECI_INT_W_FCS_BAD;
> +       }
> +
> +       if (priv->status & PECI_INT_W_FCS_ABORT) {
> +               dev_dbg(priv->dev, "PECI_INT_W_FCS_ABORT\n");
> +               status_ack |= PECI_INT_W_FCS_ABORT;
> +       }

All of this code is for debugging only. Do you want to put it behind
some kind of conditional?

> +
> +       /**
> +        * All commands should be ended up with a PECI_INT_CMD_DONE bit set
> +        * even in an error case.
> +        */
> +       if (priv->status & PECI_INT_CMD_DONE) {
> +               dev_dbg(priv->dev, "PECI_INT_CMD_DONE\n");
> +               status_ack |= PECI_INT_CMD_DONE;
> +               complete(&priv->xfer_complete);
> +       }
> +
> +       if (regmap_write(priv->regmap, AST_PECI_INT_STS, status_ack))
> +               return IRQ_NONE;
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int aspeed_peci_init_ctrl(struct aspeed_peci *priv)
> +{
> +       u32 msg_timing_nego, addr_timing_nego, rd_sampling_point;
> +       u32 clk_freq, clk_divisor, clk_div_val = 0;
> +       struct clk *clkin;
> +       int ret;
> +
> +       clkin = devm_clk_get(priv->dev, NULL);
> +       if (IS_ERR(clkin)) {
> +               dev_err(priv->dev, "Failed to get clk source.\n");
> +               return PTR_ERR(clkin);
> +       }
> +
> +       ret = of_property_read_u32(priv->dev->of_node, "clock-frequency",
> +                                  &clk_freq);
> +       if (ret < 0) {
> +               dev_err(priv->dev,
> +                       "Could not read clock-frequency property.\n");
> +               return ret;
> +       }
> +
> +       clk_divisor = clk_get_rate(clkin) / clk_freq;
> +       devm_clk_put(priv->dev, clkin);
> +
> +       while ((clk_divisor >> 1) && (clk_div_val < PECI_CLK_DIV_MAX))
> +               clk_div_val++;

We have a framework for doing clocks in the kernel. Would it make
sense to write a driver for this clock and add it to
drivers/clk/clk-aspeed.c?

> +
> +       ret = of_property_read_u32(priv->dev->of_node, "msg-timing-nego",
> +                                  &msg_timing_nego);
> +       if (ret || msg_timing_nego > PECI_MSG_TIMING_NEGO_MAX) {
> +               dev_warn(priv->dev,
> +                        "Invalid msg-timing-nego : %u, Use default : %u\n",
> +                        msg_timing_nego, PECI_MSG_TIMING_NEGO_DEFAULT);

The property is optional so I suggest we don't print a message if it's
not present. We certainly don't want to print a message saying
"invalid".

The same comment applies to the other optional properties below.

> +               msg_timing_nego = PECI_MSG_TIMING_NEGO_DEFAULT;
> +       }
> +
> +       ret = of_property_read_u32(priv->dev->of_node, "addr-timing-nego",
> +                                  &addr_timing_nego);
> +       if (ret || addr_timing_nego > PECI_ADDR_TIMING_NEGO_MAX) {
> +               dev_warn(priv->dev,
> +                        "Invalid addr-timing-nego : %u, Use default : %u\n",
> +                        addr_timing_nego, PECI_ADDR_TIMING_NEGO_DEFAULT);
> +               addr_timing_nego = PECI_ADDR_TIMING_NEGO_DEFAULT;
> +       }
> +
> +       ret = of_property_read_u32(priv->dev->of_node, "rd-sampling-point",
> +                                  &rd_sampling_point);
> +       if (ret || rd_sampling_point > PECI_RD_SAMPLING_POINT_MAX) {
> +               dev_warn(priv->dev,
> +                        "Invalid rd-sampling-point : %u. Use default : %u\n",
> +                        rd_sampling_point,
> +                        PECI_RD_SAMPLING_POINT_DEFAULT);
> +               rd_sampling_point = PECI_RD_SAMPLING_POINT_DEFAULT;
> +       }
> +
> +       ret = of_property_read_u32(priv->dev->of_node, "cmd-timeout-ms",
> +                                  &priv->cmd_timeout_ms);
> +       if (ret || priv->cmd_timeout_ms > PECI_CMD_TIMEOUT_MS_MAX ||
> +           priv->cmd_timeout_ms == 0) {
> +               dev_warn(priv->dev,
> +                        "Invalid cmd-timeout-ms : %u. Use default : %u\n",
> +                        priv->cmd_timeout_ms,
> +                        PECI_CMD_TIMEOUT_MS_DEFAULT);
> +               priv->cmd_timeout_ms = PECI_CMD_TIMEOUT_MS_DEFAULT;
> +       }
> +
> +       ret = regmap_write(priv->regmap, AST_PECI_CTRL,
> +                          PECI_CTRL_CLK_DIV(PECI_CLK_DIV_DEFAULT) |
> +                          PECI_CTRL_PECI_CLK_EN);
> +       if (ret)
> +               return ret;
> +
> +       usleep_range(1000, 5000);

Can we probe in parallel? If not, putting a sleep in the _probe will
hold up the rest of drivers from being able to do anything, and hold
up boot.

If you decide that you do need to probe here, please add a comment.
(This is the wait for the clock to be stable?)

> +
> +       /**
> +        * Timing negotiation period setting.
> +        * The unit of the programmed value is 4 times of PECI clock period.
> +        */
> +       ret = regmap_write(priv->regmap, AST_PECI_TIMING,
> +                          PECI_TIMING_MESSAGE(msg_timing_nego) |
> +                          PECI_TIMING_ADDRESS(addr_timing_nego));
> +       if (ret)
> +               return ret;
> +
> +       /* Clear interrupts */
> +       ret = regmap_write(priv->regmap, AST_PECI_INT_STS, PECI_INT_MASK);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable interrupts */
> +       ret = regmap_write(priv->regmap, AST_PECI_INT_CTRL, PECI_INT_MASK);
> +       if (ret)
> +               return ret;
> +
> +       /* Read sampling point and clock speed setting */
> +       ret = regmap_write(priv->regmap, AST_PECI_CTRL,
> +                          PECI_CTRL_SAMPLING(rd_sampling_point) |
> +                          PECI_CTRL_CLK_DIV(clk_div_val) |
> +                          PECI_CTRL_PECI_EN | PECI_CTRL_PECI_CLK_EN);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static const struct regmap_config aspeed_peci_regmap_config = {
> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = AST_PECI_R_DATA7,
> +       .val_format_endian = REGMAP_ENDIAN_LITTLE,
> +       .fast_io = true,
> +};
> +
> +static int aspeed_peci_xfer(struct peci_adapter *adaper,
> +                           struct peci_xfer_msg *msg)
> +{
> +       struct aspeed_peci *priv = peci_get_adapdata(adaper);
> +
> +       return aspeed_peci_xfer_native(priv, msg);
> +}
> +
> +static int aspeed_peci_probe(struct platform_device *pdev)
> +{
> +       struct aspeed_peci *priv;
> +       struct resource *res;
> +       void __iomem *base;
> +       int ret = 0;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(&pdev->dev, priv);
> +       priv->dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +                                            &aspeed_peci_regmap_config);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (!priv->irq)
> +               return -ENODEV;
> +
> +       ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
> +                              IRQF_SHARED,

This interrupt is only for the peci device. Why is it marked as shared?

> +                              "peci-aspeed-irq",
> +                              priv);
> +       if (ret < 0)
> +               return ret;
> +
> +       init_completion(&priv->xfer_complete);
> +
> +       priv->adaper.dev.parent = priv->dev;
> +       priv->adaper.dev.of_node = of_node_get(dev_of_node(priv->dev));
> +       strlcpy(priv->adaper.name, pdev->name, sizeof(priv->adaper.name));
> +       priv->adaper.xfer = aspeed_peci_xfer;
> +       peci_set_adapdata(&priv->adaper, priv);
> +
> +       ret = aspeed_peci_init_ctrl(priv);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = peci_add_adapter(&priv->adaper);
> +       if (ret < 0)
> +               return ret;
> +
> +       dev_info(&pdev->dev, "peci bus %d registered, irq %d\n",
> +                priv->adaper.nr, priv->irq);
> +
> +       return 0;
> +}
> +
> +static int aspeed_peci_remove(struct platform_device *pdev)
> +{
> +       struct aspeed_peci *priv = dev_get_drvdata(&pdev->dev);
> +
> +       peci_del_adapter(&priv->adaper);
> +       of_node_put(priv->adaper.dev.of_node);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id aspeed_peci_of_table[] = {
> +       { .compatible = "aspeed,ast2400-peci", },
> +       { .compatible = "aspeed,ast2500-peci", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_peci_of_table);
> +
> +static struct platform_driver aspeed_peci_driver = {
> +       .probe  = aspeed_peci_probe,
> +       .remove = aspeed_peci_remove,
> +       .driver = {
> +               .name           = "peci-aspeed",
> +               .of_match_table = of_match_ptr(aspeed_peci_of_table),
> +       },
> +};
> +module_platform_driver(aspeed_peci_driver);
> +
> +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> +MODULE_DESCRIPTION("Aspeed PECI driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.16.2
>
