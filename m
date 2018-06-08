Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id E6tzOyjmGls9XQAAmS7hNA
	; Fri, 08 Jun 2018 20:27:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 18DBF608B8; Fri,  8 Jun 2018 20:27:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwN4/jFt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6209660275;
	Fri,  8 Jun 2018 20:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6209660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeFHU1R (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:27:17 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41080 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeFHU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:27:15 -0400
Received: by mail-vk0-f65.google.com with SMTP id 128-v6so8983959vkf.8;
        Fri, 08 Jun 2018 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6hwRJOjRM/FBdK//jd5ZzExImzcUfgHrldWTH5yeCyE=;
        b=uwN4/jFtmMcaq2un31ADML5PSTLjQumGd37Wsbj9tDAnDt0ia8eVMfN33Ok6v5mrLI
         QcD07qvi2Q4WekeUOkVy4Wvn4uABFLFjRgCPwoT1lk5sMIEh/YJ0Gk1rr7/8K3+hwndx
         jkwXNpFUI9eP5g6niO5nSl0FIHgkrVKt8j8EEQdjjFqu+SnP8dcUbGKGablZuBrL4zKa
         fsJG0uZq3I3kvvfeCdj4ay4RzStSoidB++mv3b5slbcS0iFY7cXnkRnF/a5GMRgkcIWB
         ziqvq8jmd/mMFFY4nXfPdLPK/jXFVGNjGgPrC5hKBKFN616wCXIwRbjdHS0MbOzrHNld
         yaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6hwRJOjRM/FBdK//jd5ZzExImzcUfgHrldWTH5yeCyE=;
        b=kCwRCJkNJZAUIVAEeayuursEbfsz+H/y21yJ4HvBdQXRb+LYFdXxSnMDySyLQ7nShG
         Mnv1xopxuV18OsPwrABXcvBzl+AjIpfpp/KoFlkLTi7C10XQoHEdMlg8l/uXTpYFwn/a
         y+dv0FP+K6kKSpaKr6ekAiLlo/6IbVFifl6vUh3ksQBMHwfx0Uin2f3p+FpL14qiRFeS
         QXNODkH1LZ5mXbbtER3f8c825pPG6BAlJiN+Is7eW7OdqWp0rlAwkt85aB1eszmdfaFA
         Qs7rzZftcKkTvcrq1UwkXOlXNEUR1QwNcKxsrXDSQHHSFVoEXa7tffRbhJcZJvjMK70Q
         iEaA==
X-Gm-Message-State: APt69E0Eywve4h2NY/q8PkXMsLHp+Nq1AiXfubdIRSarb2rjISUMov5F
        NA0lAA16HCVBUgWnxc706qKm7j5y1MukEnLvJYM=
X-Google-Smtp-Source: ADUXVKIUsJeJ9zWyn3F98OiUzGbXKv8kGkLu1M7WXUf7eookIK8320cx/17OnzojcJT7xFKBCoB3liVGgEmvQPjNDQM=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr4783987vkd.187.1528489634877;
 Fri, 08 Jun 2018 13:27:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 13:27:14 -0700 (PDT)
In-Reply-To: <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de> <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Jun 2018 23:27:14 +0300
Message-ID: <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 2:54 PM, Yogesh Narayan Gaur
<yogeshnarayan.gaur@nxp.com> wrote:

Hi Frieder,

> +#define QUADSPI_MCR_RESERVED_MASK      (0xF << 16)

GENMASK()

> +#define QUADSPI_MCR_END_CFG_MASK       (0x3 << 2)

> +#define QUADSPI_BUF3CR_ADATSZ_MASK     (0xFF << QUADSPI_BUF3CR_ADATSZ_SHIFT)

> +#define QUADSPI_SMPR_DDRSMP_MASK       (7 << 16)

> +#define QUADSPI_RBCT_WMRK_MASK         0x1F

Ditto.

> +#define QUADSPI_LUT_OFFSET             (SEQID_LUT * 4 * 4)
> +#define QUADSPI_LUT_REG(idx)           (QUADSPI_LUT_BASE + \
> +                                       QUADSPI_LUT_OFFSET + (idx) * 4)

It looks slightly better when

#define FOO \
 (BAR1 + BAR2 ...)

> +/*
> + * An IC bug makes it necessary to rearrange the 32-bit data.
> + * Later chips, such as IMX6SLX, have fixed this bug.
> + */
> +static inline u32 fsl_qspi_endian_xchg(struct fsl_qspi *q, u32 a) {
> +       return needs_swap_endian(q) ? __swab32(a) : a; }

func()
{
...
}

Fix this everywhere.



> +static void qspi_writel(struct fsl_qspi *q, u32 val, void __iomem
> +*addr) {
> +       if (q->big_endian)
> +               iowrite32be(val, addr);
> +       else
> +               iowrite32(val, addr);
> +}
> +
> +static u32 qspi_readl(struct fsl_qspi *q, void __iomem *addr) {
> +       if (q->big_endian)
> +               return ioread32be(addr);
> +       else
> +               return ioread32(addr);
> +}

Better to define ->read() and ->write() callbacks and call them unconditionally.

> +static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {

> +       switch (width) {
> +       case 1:
> +       case 2:
> +       case 4:
> +               return 0;
> +       }


if (!is_power_of_2(width) || width >= 8)
 return -E...;

return 0;

?

> +
> +       return -ENOTSUPP;
> +}

> +static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q) {
> +       int ret;
> +
> +       ret = clk_prepare_enable(q->clk_en);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(q->clk);
> +       if (ret) {

> +               clk_disable_unprepare(q->clk_en);

Is it needed here?

> +               return ret;
> +       }
> +
> +       if (needs_wakeup_wait_mode(q))
> +               pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
> +
> +       return 0;
> +}

> +               qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));

Redundant parens.



> +       seq = seq ? 0 : 1;

seq = (seq + 1) % 2;

?

> +}

> +       for (i = 0; i < op->data.nbytes; i += 4) {
> +               u32 val = 0;
> +
> +               memcpy(&val, op->data.buf.out + i,

> +                      min_t(unsigned int, op->data.nbytes - i, 4));

You may easily avoid this conditional on each iteration.

> +
> +               val = fsl_qspi_endian_xchg(q, val);
> +               qspi_writel(q, val, base + QUADSPI_TBDR);
> +       }

> +       /* wait for the controller being ready */

FOREVER! See below.

> +       do {
> +               u32 status;
> +
> +               status = qspi_readl(q, base + QUADSPI_SR);
> +               if (status &
> +                   (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
> +                       udelay(1);
> +                       dev_dbg(q->dev, "The controller is busy, 0x%x\n",
> +                               status);
> +                       continue;
> +               }
> +               break;
> +       } while (1);

Please, avoid infinite loops.

unsigned int count = 100;
...
do {
...
} while (--count);

> +       if (of_get_available_child_count(q->dev->of_node) == 1)
> +               name = dev_name(q->dev);
> +       else
> +               name = devm_kasprintf(dev, GFP_KERNEL,
> +                                     "%s-%d", dev_name(q->dev),
> +                                     mem->spi->chip_select);
> +
> +       if (!name) {
> +               dev_err(dev, "failed to get memory for custom flash name\n");

> +               return dev_name(q->dev);

Might it be racy if in between device gets a name assigned?

> +       }

> +       if (q->ahb_addr)
> +               iounmap(q->ahb_addr);

Double unmap?

> +static struct platform_driver fsl_qspi_driver = {
> +       .driver = {
> +               .name   = "fsl-quadspi",
> +               .of_match_table = fsl_qspi_dt_ids,
> +       },
> +       .probe          = fsl_qspi_probe,
> +       .remove         = fsl_qspi_remove,

> +       .suspend        = fsl_qspi_suspend,
> +       .resume         = fsl_qspi_resume,

Why not in struct dev_pm_ops?

> +};


> +MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris
> +Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder
> +Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");

Wrong indentation.

-- 
With Best Regards,
Andy Shevchenko
