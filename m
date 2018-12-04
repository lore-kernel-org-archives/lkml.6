Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE143C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D4C2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn/ZzqXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D4C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeLDUph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeLDUph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:45:37 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE0820834;
        Tue,  4 Dec 2018 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543956335;
        bh=HmjuJHkDrYNR8NPIHtzxbmWq9hBB6THigmUOeQ0PSJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wn/ZzqXQRqKtJeADQZ1t4WulJ+MjXHJO2nYJ/kLhGP2O4MWHy0WHB2bHvxLjBhBFv
         aURpYLun+5VafKAHePojUm/hv4JbjpXllm0+LFZYIzBsOCKxeSySOQxcMdutbLW9QM
         vM/GqGcRGVOyKWZJdZAkjlO6AdRGvsbHyko6ahrg=
Received: by mail-wr1-f52.google.com with SMTP id z5so17398442wrt.11;
        Tue, 04 Dec 2018 12:45:34 -0800 (PST)
X-Gm-Message-State: AA+aEWaNLzRzS1UWmqBbUIPFWmBX2D+7P5huIKzpEyf4YCuwse6aieli
        UpvJxdmrG8A8fZ7xmRN7RX5t6vL8hSC+4KxJ1Kg=
X-Google-Smtp-Source: AFSGD/V6bVA4gf7RKzW/jP3CW5k0DEj4H2UHgDWAg0ccYLKzj6SiUVs2GunoGiI4H3h861KuYwCl4y/z291xIDHcaFA=
X-Received: by 2002:adf:b243:: with SMTP id y3mr4839148wra.184.1543956333467;
 Tue, 04 Dec 2018 12:45:33 -0800 (PST)
MIME-Version: 1.0
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com> <1543843974-4054-4-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1543843974-4054-4-git-send-email-qii.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 4 Dec 2018 12:45:22 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoAtTR8q2pgYtQO9uru5YewKBGBSR5Cg03TU+qJD3=o-g@mail.gmail.com>
Message-ID: <CAGp9LzoAtTR8q2pgYtQO9uru5YewKBGBSR5Cg03TU+qJD3=o-g@mail.gmail.com>
Subject: Re: [PATCH 3/5] i2c: mediatek: Add offsets array for new i2c registers
To:     qii.wang@mediatek.com
Cc:     wsa@the-dreams.de, devicetree@vger.kernel.org,
        ryder.lee@mediatek.com, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<qii.wang@mediatek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=883=E6=97=A5 =E9=80=
=B1=E4=B8=80 =E4=B8=8A=E5=8D=885:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: qii wang <qii.wang@mediatek.com>
>
> New i2c registers would have different offsets, so we use different
> offsets array to distinguish different i2c registers version.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>

They are almost 1 to 1 function translation being taken here, so
Reviewed-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |  163 +++++++++++++++++++++++++--------=
------
>  1 file changed, 104 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt6=
5xx.c
> index 660de1e..428ac99 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -106,34 +106,62 @@ enum mtk_trans_op {
>  };
>
>  enum I2C_REGS_OFFSET {
> -       OFFSET_DATA_PORT =3D 0x0,
> -       OFFSET_SLAVE_ADDR =3D 0x04,
> -       OFFSET_INTR_MASK =3D 0x08,
> -       OFFSET_INTR_STAT =3D 0x0c,
> -       OFFSET_CONTROL =3D 0x10,
> -       OFFSET_TRANSFER_LEN =3D 0x14,
> -       OFFSET_TRANSAC_LEN =3D 0x18,
> -       OFFSET_DELAY_LEN =3D 0x1c,
> -       OFFSET_TIMING =3D 0x20,
> -       OFFSET_START =3D 0x24,
> -       OFFSET_EXT_CONF =3D 0x28,
> -       OFFSET_FIFO_STAT =3D 0x30,
> -       OFFSET_FIFO_THRESH =3D 0x34,
> -       OFFSET_FIFO_ADDR_CLR =3D 0x38,
> -       OFFSET_IO_CONFIG =3D 0x40,
> -       OFFSET_RSV_DEBUG =3D 0x44,
> -       OFFSET_HS =3D 0x48,
> -       OFFSET_SOFTRESET =3D 0x50,
> -       OFFSET_DCM_EN =3D 0x54,
> -       OFFSET_PATH_DIR =3D 0x60,
> -       OFFSET_DEBUGSTAT =3D 0x64,
> -       OFFSET_DEBUGCTRL =3D 0x68,
> -       OFFSET_TRANSFER_LEN_AUX =3D 0x6c,
> -       OFFSET_CLOCK_DIV =3D 0x70,
> +       OFFSET_DATA_PORT,
> +       OFFSET_SLAVE_ADDR,
> +       OFFSET_INTR_MASK,
> +       OFFSET_INTR_STAT,
> +       OFFSET_CONTROL,
> +       OFFSET_TRANSFER_LEN,
> +       OFFSET_TRANSAC_LEN,
> +       OFFSET_DELAY_LEN,
> +       OFFSET_TIMING,
> +       OFFSET_START,
> +       OFFSET_EXT_CONF,
> +       OFFSET_FIFO_STAT,
> +       OFFSET_FIFO_THRESH,
> +       OFFSET_FIFO_ADDR_CLR,
> +       OFFSET_IO_CONFIG,
> +       OFFSET_RSV_DEBUG,
> +       OFFSET_HS,
> +       OFFSET_SOFTRESET,
> +       OFFSET_DCM_EN,
> +       OFFSET_PATH_DIR,
> +       OFFSET_DEBUGSTAT,
> +       OFFSET_DEBUGCTRL,
> +       OFFSET_TRANSFER_LEN_AUX,
> +       OFFSET_CLOCK_DIV,
> +};
> +
> +static const u16 mt_i2c_regs_v1[] =3D {
> +       [OFFSET_DATA_PORT] =3D 0x0,
> +       [OFFSET_SLAVE_ADDR] =3D 0x4,
> +       [OFFSET_INTR_MASK] =3D 0x8,
> +       [OFFSET_INTR_STAT] =3D 0xc,
> +       [OFFSET_CONTROL] =3D 0x10,
> +       [OFFSET_TRANSFER_LEN] =3D 0x14,
> +       [OFFSET_TRANSAC_LEN] =3D 0x18,
> +       [OFFSET_DELAY_LEN] =3D 0x1c,
> +       [OFFSET_TIMING] =3D 0x20,
> +       [OFFSET_START] =3D 0x24,
> +       [OFFSET_EXT_CONF] =3D 0x28,
> +       [OFFSET_FIFO_STAT] =3D 0x30,
> +       [OFFSET_FIFO_THRESH] =3D 0x34,
> +       [OFFSET_FIFO_ADDR_CLR] =3D 0x38,
> +       [OFFSET_IO_CONFIG] =3D 0x40,
> +       [OFFSET_RSV_DEBUG] =3D 0x44,
> +       [OFFSET_HS] =3D 0x48,
> +       [OFFSET_SOFTRESET] =3D 0x50,
> +       [OFFSET_DCM_EN] =3D 0x54,
> +       [OFFSET_PATH_DIR] =3D 0x60,
> +       [OFFSET_DEBUGSTAT] =3D 0x64,
> +       [OFFSET_DEBUGCTRL] =3D 0x68,
> +       [OFFSET_TRANSFER_LEN_AUX] =3D 0x6c,
> +       [OFFSET_CLOCK_DIV] =3D 0x70,
>  };
>
>  struct mtk_i2c_compatible {
>         const struct i2c_adapter_quirks *quirks;
> +       const u16 *regs;
>         unsigned char pmic_i2c: 1;
>         unsigned char dcm: 1;
>         unsigned char auto_restart: 1;
> @@ -181,6 +209,7 @@ struct mtk_i2c {
>  };
>
>  static const struct mtk_i2c_compatible mt2712_compat =3D {
> +       .regs =3D mt_i2c_regs_v1,
>         .pmic_i2c =3D 0,
>         .dcm =3D 1,
>         .auto_restart =3D 1,
> @@ -191,6 +220,7 @@ struct mtk_i2c {
>
>  static const struct mtk_i2c_compatible mt6577_compat =3D {
>         .quirks =3D &mt6577_i2c_quirks,
> +       .regs =3D mt_i2c_regs_v1,
>         .pmic_i2c =3D 0,
>         .dcm =3D 1,
>         .auto_restart =3D 0,
> @@ -201,6 +231,7 @@ struct mtk_i2c {
>
>  static const struct mtk_i2c_compatible mt6589_compat =3D {
>         .quirks =3D &mt6577_i2c_quirks,
> +       .regs =3D mt_i2c_regs_v1,
>         .pmic_i2c =3D 1,
>         .dcm =3D 0,
>         .auto_restart =3D 0,
> @@ -211,6 +242,7 @@ struct mtk_i2c {
>
>  static const struct mtk_i2c_compatible mt7622_compat =3D {
>         .quirks =3D &mt7622_i2c_quirks,
> +       .regs =3D mt_i2c_regs_v1,
>         .pmic_i2c =3D 0,
>         .dcm =3D 1,
>         .auto_restart =3D 1,
> @@ -220,6 +252,7 @@ struct mtk_i2c {
>  };
>
>  static const struct mtk_i2c_compatible mt8173_compat =3D {
> +       .regs =3D mt_i2c_regs_v1,
>         .pmic_i2c =3D 0,
>         .dcm =3D 1,
>         .auto_restart =3D 1,
> @@ -238,6 +271,17 @@ struct mtk_i2c {
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
>
> +static u16 mtk_i2c_readw(struct mtk_i2c *i2c, enum I2C_REGS_OFFSET reg)
> +{
> +       return readw(i2c->base + i2c->dev_comp->regs[reg]);
> +}
> +
> +static void mtk_i2c_writew(struct mtk_i2c *i2c, u16 val,
> +                          enum I2C_REGS_OFFSET reg)
> +{
> +       writew(val, i2c->base + i2c->dev_comp->regs[reg]);
> +}
> +
>  static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  {
>         int ret;
> @@ -278,31 +322,31 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  {
>         u16 control_reg;
>
> -       writew(I2C_SOFT_RST, i2c->base + OFFSET_SOFTRESET);
> +       mtk_i2c_writew(i2c, I2C_SOFT_RST, OFFSET_SOFTRESET);
>
>         /* Set ioconfig */
>         if (i2c->use_push_pull)
> -               writew(I2C_IO_CONFIG_PUSH_PULL, i2c->base + OFFSET_IO_CON=
FIG);
> +               mtk_i2c_writew(i2c, I2C_IO_CONFIG_PUSH_PULL, OFFSET_IO_CO=
NFIG);
>         else
> -               writew(I2C_IO_CONFIG_OPEN_DRAIN, i2c->base + OFFSET_IO_CO=
NFIG);
> +               mtk_i2c_writew(i2c, I2C_IO_CONFIG_OPEN_DRAIN, OFFSET_IO_C=
ONFIG);
>
>         if (i2c->dev_comp->dcm)
> -               writew(I2C_DCM_DISABLE, i2c->base + OFFSET_DCM_EN);
> +               mtk_i2c_writew(i2c, I2C_DCM_DISABLE, OFFSET_DCM_EN);
>
>         if (i2c->dev_comp->timing_adjust)
> -               writew(I2C_DEFAULT_CLK_DIV - 1, i2c->base + OFFSET_CLOCK_=
DIV);
> +               mtk_i2c_writew(i2c, I2C_DEFAULT_CLK_DIV - 1, OFFSET_CLOCK=
_DIV);
>
> -       writew(i2c->timing_reg, i2c->base + OFFSET_TIMING);
> -       writew(i2c->high_speed_reg, i2c->base + OFFSET_HS);
> +       mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
> +       mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
>
>         /* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first =
*/
>         if (i2c->have_pmic)
> -               writew(I2C_CONTROL_WRAPPER, i2c->base + OFFSET_PATH_DIR);
> +               mtk_i2c_writew(i2c, I2C_CONTROL_WRAPPER, OFFSET_PATH_DIR)=
;
>
>         control_reg =3D I2C_CONTROL_ACKERR_DET_EN |
>                       I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> -       writew(control_reg, i2c->base + OFFSET_CONTROL);
> -       writew(I2C_DELAY_LEN, i2c->base + OFFSET_DELAY_LEN);
> +       mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
> +       mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>
>         writel(I2C_DMA_HARD_RST, i2c->pdmabase + OFFSET_RST);
>         udelay(50);
> @@ -454,7 +498,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>
>         reinit_completion(&i2c->msg_complete);
>
> -       control_reg =3D readw(i2c->base + OFFSET_CONTROL) &
> +       control_reg =3D mtk_i2c_readw(i2c, OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
>         if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >=3D 1))
>                 control_reg |=3D I2C_CONTROL_RS;
> @@ -462,40 +506,41 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c,=
 struct i2c_msg *msgs,
>         if (i2c->op =3D=3D I2C_MASTER_WRRD)
>                 control_reg |=3D I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
>
> -       writew(control_reg, i2c->base + OFFSET_CONTROL);
> +       mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>
>         /* set start condition */
>         if (i2c->speed_hz <=3D I2C_DEFAULT_SPEED)
> -               writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
> +               mtk_i2c_writew(i2c, I2C_ST_START_CON, OFFSET_EXT_CONF);
>         else
> -               writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> +               mtk_i2c_writew(i2c, I2C_FS_START_CON, OFFSET_EXT_CONF);
>
>         addr_reg =3D i2c_8bit_addr_from_msg(msgs);
> -       writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
> +       mtk_i2c_writew(i2c, addr_reg, OFFSET_SLAVE_ADDR);
>
>         /* Clear interrupt status */
> -       writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
> -       writew(I2C_FIFO_ADDR_CLR, i2c->base + OFFSET_FIFO_ADDR_CLR);
> +       mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +              I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> +
> +       mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
>
>         /* Enable interrupt */
> -       writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
> +       mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +              I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
>
>         /* Set transfer and transaction len */
>         if (i2c->op =3D=3D I2C_MASTER_WRRD) {
>                 if (i2c->dev_comp->aux_len_reg) {
> -                       writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN=
);
> -                       writew((msgs + 1)->len, i2c->base +
> -                              OFFSET_TRANSFER_LEN_AUX);
> +                       mtk_i2c_writew(i2c, msgs->len, OFFSET_TRANSFER_LE=
N);
> +                       mtk_i2c_writew(i2c, (msgs + 1)->len,
> +                                           OFFSET_TRANSFER_LEN_AUX);
>                 } else {
> -                       writew(msgs->len | ((msgs + 1)->len) << 8,
> -                              i2c->base + OFFSET_TRANSFER_LEN);
> +                       mtk_i2c_writew(i2c, msgs->len | ((msgs + 1)->len)=
 << 8,
> +                                           OFFSET_TRANSFER_LEN);
>                 }
> -               writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_=
LEN);
> +               mtk_i2c_writew(i2c, I2C_WRRD_TRANAC_VALUE, OFFSET_TRANSAC=
_LEN);
>         } else {
> -               writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
> -               writew(num, i2c->base + OFFSET_TRANSAC_LEN);
> +               mtk_i2c_writew(i2c, msgs->len, OFFSET_TRANSFER_LEN);
> +               mtk_i2c_writew(i2c, num, OFFSET_TRANSAC_LEN);
>         }
>
>         /* Prepare buffer data to start transfer */
> @@ -607,14 +652,14 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c,=
 struct i2c_msg *msgs,
>                 if (left_num >=3D 1)
>                         start_reg |=3D I2C_RS_MUL_CNFG;
>         }
> -       writew(start_reg, i2c->base + OFFSET_START);
> +       mtk_i2c_writew(i2c, start_reg, OFFSET_START);
>
>         ret =3D wait_for_completion_timeout(&i2c->msg_complete,
>                                           i2c->adap.timeout);
>
>         /* Clear interrupt mask */
> -       writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -              I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
> +       mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR =
|
> +              I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
>
>         if (i2c->op =3D=3D I2C_MASTER_WR) {
>                 dma_unmap_single(i2c->dev, wpaddr,
> @@ -724,8 +769,8 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_i=
d)
>         if (i2c->auto_restart)
>                 restart_flag =3D I2C_RS_TRANSFER;
>
> -       intr_stat =3D readw(i2c->base + OFFSET_INTR_STAT);
> -       writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
> +       intr_stat =3D mtk_i2c_readw(i2c, OFFSET_INTR_STAT);
> +       mtk_i2c_writew(i2c, intr_stat, OFFSET_INTR_STAT);
>
>         /*
>          * when occurs ack error, i2c controller generate two interrupts
> @@ -737,8 +782,8 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_i=
d)
>         if (i2c->ignore_restart_irq && (i2c->irq_stat & restart_flag)) {
>                 i2c->ignore_restart_irq =3D false;
>                 i2c->irq_stat =3D 0;
> -               writew(I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG | I2C_TRANSAC_ST=
ART,
> -                      i2c->base + OFFSET_START);
> +               mtk_i2c_writew(i2c, I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG |
> +                                   I2C_TRANSAC_START, OFFSET_START);
>         } else {
>                 if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
>                         complete(&i2c->msg_complete);
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
