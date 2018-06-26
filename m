Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01DAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C051726AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="Xq+m4WFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C051726AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935171AbeFZMiv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:38:51 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:23376 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFZMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:38:49 -0400
X-Greylist: delayed 689 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 08:38:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530016728;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BlcpGMsalnTPcnzhVBCZ0Ure5/uA1Xq2r9enrCP6X0c=;
        b=Xq+m4WFDgnI6nrZ6qMWD8MARa/2PLO1bA5cmNDnYcOXxlXyNIbP84LN1KWVqxZw5f7
        P/GaYKIggnzWhVp0J4GTjymd2FJC1z6pSGkcU0UitUiabZSeeLRCs8byMvwfzAcRjg9d
        wGfISm6Qqbv9M3m+/cjphp7BdVFk7DQxhrhHxS2u2+dqm6OQKoeJf0G6c3VXP+cAoshG
        1zkq9mjNWRzU8god8++3DyzuDs5oWByuwW2h8XQdm7ireq8Mf7FldzBuhcNKQLqSfOGc
        e9cf75tczLHNHzbHZ+I7roJ9LcgcNz4Zdhwe/jfITK2mJefhR8cvtbQGdsBZuG7b26xx
        Dh1Q==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 43.11 AUTH)
        with ESMTPSA id Q03609u5QCQU0Jt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 26 Jun 2018 14:26:30 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
Message-ID: <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de>
Date:   Tue, 26 Jun 2018 14:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 08.06.2018 22:27, Andy Shevchenko wrote:
> On Fri, Jun 8, 2018 at 2:54 PM, Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com> wrote:
> 
> Hi Frieder,
> 
>> +#define QUADSPI_MCR_RESERVED_MASK      (0xF << 16)
> 
> GENMASK()

Ok.

> 
>> +#define QUADSPI_MCR_END_CFG_MASK       (0x3 << 2)
> 
>> +#define QUADSPI_BUF3CR_ADATSZ_MASK     (0xFF << QUADSPI_BUF3CR_ADATSZ_SHIFT)
> 
>> +#define QUADSPI_SMPR_DDRSMP_MASK       (7 << 16)
> 
>> +#define QUADSPI_RBCT_WMRK_MASK         0x1F
> 
> Ditto.

Ok.

> 
>> +#define QUADSPI_LUT_OFFSET             (SEQID_LUT * 4 * 4)
>> +#define QUADSPI_LUT_REG(idx)           (QUADSPI_LUT_BASE + \
>> +                                       QUADSPI_LUT_OFFSET + (idx) * 4)
> 
> It looks slightly better when
> 
> #define FOO \
>   (BAR1 + BAR2 ...)

Ok.

> 
>> +/*
>> + * An IC bug makes it necessary to rearrange the 32-bit data.
>> + * Later chips, such as IMX6SLX, have fixed this bug.
>> + */
>> +static inline u32 fsl_qspi_endian_xchg(struct fsl_qspi *q, u32 a) {
>> +       return needs_swap_endian(q) ? __swab32(a) : a; }
> 
> func()
> {
> ...
> }
> 
> Fix this everywhere.

I will fix this.

> 
> 
> 
>> +static void qspi_writel(struct fsl_qspi *q, u32 val, void __iomem
>> +*addr) {
>> +       if (q->big_endian)
>> +               iowrite32be(val, addr);
>> +       else
>> +               iowrite32(val, addr);
>> +}
>> +
>> +static u32 qspi_readl(struct fsl_qspi *q, void __iomem *addr) {
>> +       if (q->big_endian)
>> +               return ioread32be(addr);
>> +       else
>> +               return ioread32(addr);
>> +}
> 
> Better to define ->read() and ->write() callbacks and call them unconditionally.

Ok.

> 
>> +static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {
> 
>> +       switch (width) {
>> +       case 1:
>> +       case 2:
>> +       case 4:
>> +               return 0;
>> +       }
> 
> 
> if (!is_power_of_2(width) || width >= 8)
>   return -E...;
> 
> return 0;
> 
> ?

Your proposition is a bit shorter, but I think it's slightly harder to read.

> 
>> +
>> +       return -ENOTSUPP;
>> +}
> 
>> +static int fsl_qspi_clk_prep_enable(struct fsl_qspi *q) {
>> +       int ret;
>> +
>> +       ret = clk_prepare_enable(q->clk_en);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = clk_prepare_enable(q->clk);
>> +       if (ret) {
> 
>> +               clk_disable_unprepare(q->clk_en);
> 
> Is it needed here?

No, this is probably superfluous. I will remove it.

> 
>> +               return ret;
>> +       }
>> +
>> +       if (needs_wakeup_wait_mode(q))
>> +               pm_qos_add_request(&q->pm_qos_req, PM_QOS_CPU_DMA_LATENCY, 0);
>> +
>> +       return 0;
>> +}
> 
>> +               qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
> 
> Redundant parens.

Ok, I thought this is better for readability.

> 
> 
> 
>> +       seq = seq ? 0 : 1;
> 
> seq = (seq + 1) % 2;
> 
> ?

Ok.

> 
>> +}
> 
>> +       for (i = 0; i < op->data.nbytes; i += 4) {
>> +               u32 val = 0;
>> +
>> +               memcpy(&val, op->data.buf.out + i,
> 
>> +                      min_t(unsigned int, op->data.nbytes - i, 4));
> 
> You may easily avoid this conditional on each iteration.

Do you mean something like this, or are there better ways?

u32 val = 0;

for (i = 0; i < ALIGN_DOWN(op->data.nbytes, 4); i += 4)
{
	memcpy(&val, op->data.buf.out + i, 4);
	val = fsl_qspi_endian_xchg(q, val);
	qspi_writel(q, val, base + QUADSPI_TBDR);
}

memcpy(&val, op->data.buf.out + i, op->data.nbytes);
val = fsl_qspi_endian_xchg(q, val);
qspi_writel(q, val, base + QUADSPI_TBDR);

> 
>> +
>> +               val = fsl_qspi_endian_xchg(q, val);
>> +               qspi_writel(q, val, base + QUADSPI_TBDR);
>> +       }
> 
>> +       /* wait for the controller being ready */
> 
> FOREVER! See below.
> 
>> +       do {
>> +               u32 status;
>> +
>> +               status = qspi_readl(q, base + QUADSPI_SR);
>> +               if (status &
>> +                   (QUADSPI_SR_IP_ACC_MASK | QUADSPI_SR_AHB_ACC_MASK)) {
>> +                       udelay(1);
>> +                       dev_dbg(q->dev, "The controller is busy, 0x%x\n",
>> +                               status);
>> +                       continue;
>> +               }
>> +               break;
>> +       } while (1);
> 
> Please, avoid infinite loops.
> 
> unsigned int count = 100;
> ...
> do {
> ...
> } while (--count);

Ok, will change that.

> 
>> +       if (of_get_available_child_count(q->dev->of_node) == 1)
>> +               name = dev_name(q->dev);
>> +       else
>> +               name = devm_kasprintf(dev, GFP_KERNEL,
>> +                                     "%s-%d", dev_name(q->dev),
>> +                                     mem->spi->chip_select);
>> +
>> +       if (!name) {
>> +               dev_err(dev, "failed to get memory for custom flash name\n");
> 
>> +               return dev_name(q->dev);
> 
> Might it be racy if in between device gets a name assigned?

Ok, I will change that to make sure that dev_name() is only called once.

> 
>> +       }
> 
>> +       if (q->ahb_addr)
>> +               iounmap(q->ahb_addr);
> 
> Double unmap?

Right, this is redundant. I will remove it.

> 
>> +static struct platform_driver fsl_qspi_driver = {
>> +       .driver = {
>> +               .name   = "fsl-quadspi",
>> +               .of_match_table = fsl_qspi_dt_ids,
>> +       },
>> +       .probe          = fsl_qspi_probe,
>> +       .remove         = fsl_qspi_remove,
> 
>> +       .suspend        = fsl_qspi_suspend,
>> +       .resume         = fsl_qspi_resume,
> 
> Why not in struct dev_pm_ops?

This was taken from the original driver. I will add a struct dev_pm_ops 
to hold fsl_qspi_suspend() and fsl_qspi_resume().

> 
>> +};
> 
> 
>> +MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris
>> +Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder
>> +Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");
> 
> Wrong indentation.

What is wrong? Some newlines are missing here between the MODULE_ 
macros, but in my original patch it seems correct.

Thank you for your review,

Frieder
