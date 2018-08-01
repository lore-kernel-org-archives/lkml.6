Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F65520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP3afg0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F65520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbeHAI2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:28:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46060 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbeHAI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:28:23 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so32622013oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+nBGWF62OhFjZhhtlWufIy1IhYsNCGv9FhlbMC13cY=;
        b=jP3afg0syl5AORtMhb67jkI4Ab6998hW9yh7z587ENwH7PEsytfEBeELN50d9JK5Mw
         tTA8c/4rmhNcQgHcyc2qOud5GBhJXmHaCyneokzDoXVm8tLgPEUjypyuiSOlyDY+NCgd
         XNNgr2WGTMuR/qkMmZoiZ+8ZtKsc5AohZb83BxV4yY4hhrlAv/qVE89O0zTRzW6keObm
         Lx/wwXKXyEQfws42fphyNlCxWe7PkjDWQsmp5yVZobJSbvG9fIamLlhfF3+70rMNZiwf
         5pIgcGOUD34x2XPcqC6c8s+qggBdhSCkQgZiGKS6l2so2S9gBnFXHQbnfjx6fZdBpU0t
         IzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+nBGWF62OhFjZhhtlWufIy1IhYsNCGv9FhlbMC13cY=;
        b=TAE0Idl1Qv/O7oGlRSZRnMFNbzn9pJRC2d6uCAcQIGurMyUgl1HPDICsx6Gp4WzoPd
         Dvdb13YHDk+0XglDkzYuE8sDh8fftdNCGGVihfbntnWc6PNSWQpB9ufyuLm+pgrbkd5W
         gbmODrGRmexKIrImA4LkYKc9X6swAOjHWj7DsmNcOfkiw5szDz6cWspNEOTu/TLq1WW2
         IDw7tPhUhM+knUBEIBnSA+D1Tgr/ROjQjmtk8SyKx02E3TlQwFV7qMLR2gy/shv5HXhr
         cVnZ24cNbtwF0w3acnB4VREZAmO1xZuct1xgduQl9OB2Ldbt+x9omDHizLQhmEXiza7o
         NqgQ==
X-Gm-Message-State: AOUpUlEAJmlYdrcWFiK3+zE3xBwdJ/8/TTRipPJIo9g7Xyvg7IuP42nA
        uGJlpTJDI4K0Cmcbtjl+PaBDIhHo5r1MIBbXumZM+g==
X-Google-Smtp-Source: AAOMgpfH2UeGye+zgoohH5LzFJ8zCkDyiGh5chYQIuZmeHGWs43qP0yLbl7CA/y7Ja3RdsRxk19WF+SbH8mEalDmmY4=
X-Received: by 2002:aca:c2c1:: with SMTP id s184-v6mr2403814oif.117.1533105853191;
 Tue, 31 Jul 2018 23:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180724173123.4377-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180724173123.4377-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 31 Jul 2018 23:44:01 -0700
Message-ID: <CAFd5g46VKJeggUSMdF9Lta42FrpF0qVfrSHi3Bz=gU2qnSrAPA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: aspeed: Handle master/slave combined irq events properly
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:31 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> In most of cases, interrupt bits are set one by one but there are
> also a lot of other cases that Aspeed I2C IP sends multiple
> interrupt bits with combining master and slave events using a
> single interrupt call. It happens much more in multi-master
> environment than single-master. For an example, when master is
> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
> SLAVE_MATCH and RX_DONE interrupts could come along with the
> NORMAL_STOP in case of an another master immediately sends data
> just after acquiring the bus. In this case, the NORMAL_STOP
> interrupt should be handled by master_irq and the SLAVE_MATCH and
> RX_DONE interrupts should be handled by slave_irq. This commit
> modifies irq hadling logic to handle the master/slave combined
> events properly.
>
> Changes since v1:
> - Fixed a grammer issue in commit message.
> - Added a missing line feed character into a message printing.

This should not go in the commit log. Please move this to the comment section.

>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 135 ++++++++++++++++++--------------
>  1 file changed, 75 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index efb89422d496..75431e305073 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -82,6 +82,11 @@
>  #define ASPEED_I2CD_INTR_RX_DONE                       BIT(2)
>  #define ASPEED_I2CD_INTR_TX_NAK                                BIT(1)
>  #define ASPEED_I2CD_INTR_TX_ACK                                BIT(0)
> +#define ASPEED_I2CD_INTR_ERRORS                                                       \
> +               (ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |                             \
> +                ASPEED_I2CD_INTR_SCL_TIMEOUT |                                \
> +                ASPEED_I2CD_INTR_ABNORMAL |                                   \
> +                ASPEED_I2CD_INTR_ARBIT_LOSS)
>  #define ASPEED_I2CD_INTR_ALL                                                  \
>                 (ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |                             \
>                  ASPEED_I2CD_INTR_BUS_RECOVER_DONE |                           \
> @@ -150,6 +155,7 @@ struct aspeed_i2c_bus {
>         int                             cmd_err;
>         /* Protected only by i2c_lock_bus */
>         int                             master_xfer_result;
> +       u32                             irq_status;
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>         struct i2c_client               *slave;
>         enum aspeed_i2c_slave_state     slave_state;
> @@ -229,36 +235,30 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)

I think it will be cleaner if both this and aspeed_i2c_master_irq return the
status_ack; that way you will not have to add the irq_status field to the
struct.

>  {
> -       u32 command, irq_status, status_ack = 0;
> +       u32 command, status_ack = 0;
>         struct i2c_client *slave = bus->slave;
> -       bool irq_handled = true;
>         u8 value;
>
> -       if (!slave) {
> -               irq_handled = false;
> -               goto out;
> -       }
> +       if (!slave)
> +               return false;
>
>         command = readl(bus->base + ASPEED_I2C_CMD_REG);
> -       irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>
>         /* Slave was requested, restart state machine. */
> -       if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> +       if (bus->irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
>                 status_ack |= ASPEED_I2CD_INTR_SLAVE_MATCH;
>                 bus->slave_state = ASPEED_I2C_SLAVE_START;
>         }
>
>         /* Slave is not currently active, irq was for someone else. */
> -       if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
> -               irq_handled = false;
> -               goto out;
> -       }
> +       if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
> +               return false;
>
>         dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
> -               irq_status, command);
> +               bus->irq_status, command);
>
>         /* Slave was sent something. */
> -       if (irq_status & ASPEED_I2CD_INTR_RX_DONE) {
> +       if (bus->irq_status & ASPEED_I2CD_INTR_RX_DONE) {
>                 value = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
>                 /* Handle address frame. */
>                 if (bus->slave_state == ASPEED_I2C_SLAVE_START) {
> @@ -273,28 +273,29 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>         }
>
>         /* Slave was asked to stop. */
> -       if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
> +       if (bus->irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
>                 status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
>                 bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>         }
> -       if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
> +       if (bus->irq_status & ASPEED_I2CD_INTR_TX_NAK) {
>                 status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                 bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>         }
> +       if (bus->irq_status & ASPEED_I2CD_INTR_TX_ACK) {
> +               status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +       }
>
>         switch (bus->slave_state) {
>         case ASPEED_I2C_SLAVE_READ_REQUESTED:
> -               if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
> +               if (bus->irq_status & ASPEED_I2CD_INTR_TX_ACK)
>                         dev_err(bus->dev, "Unexpected ACK on read request.\n");
>                 bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
> -
>                 i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
>                 writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
>                 writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
>                 break;
>         case ASPEED_I2C_SLAVE_READ_PROCESSED:
> -               status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> -               if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
> +               if (!(bus->irq_status & ASPEED_I2CD_INTR_TX_ACK))
>                         dev_err(bus->dev,
>                                 "Expected ACK after processed read.\n");
>                 i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
> @@ -317,14 +318,8 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>                 break;
>         }
>
> -       if (status_ack != irq_status)
> -               dev_err(bus->dev,
> -                       "irq handled != irq. expected %x, but was %x\n",
> -                       irq_status, status_ack);
> -       writel(status_ack, bus->base + ASPEED_I2C_INTR_STS_REG);
> -
> -out:
> -       return irq_handled;
> +       bus->irq_status ^= status_ack;

Here and elsewhere, you are trying to mask out the bits you handled, right?
Please use `&= ~status_ack;` instead.

> +       return !bus->irq_status;
>  }
>  #endif /* CONFIG_I2C_SLAVE */
>
> @@ -382,19 +377,19 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
>
>  static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>  {
> -       u32 irq_status, status_ack = 0, command = 0;
> +       u32 status_ack = 0, command = 0;
>         struct i2c_msg *msg;
>         u8 recv_byte;
>         int ret;
>
> -       irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> -       /* Ack all interrupt bits. */
> -       writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
> -
> -       if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
> +       if (bus->irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
>                 bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
>                 status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
>                 goto out_complete;
> +       } else {
> +               /* Master is not currently active, irq was for someone else. */
> +               if (bus->master_state == ASPEED_I2C_MASTER_INACTIVE)
> +                       goto out_no_complete;
>         }
>
>         /*
> @@ -402,20 +397,23 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          * should clear the command queue effectively taking us back to the
>          * INACTIVE state.
>          */
> -       ret = aspeed_i2c_is_irq_error(irq_status);
> -       if (ret < 0) {
> +       ret = aspeed_i2c_is_irq_error(bus->irq_status);
> +       if (ret) {
>                 dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
> -                       irq_status);
> +                       bus->irq_status);
>                 bus->cmd_err = ret;
>                 bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +               status_ack |= (bus->irq_status & ASPEED_I2CD_INTR_ERRORS);

ASPEED_I2CD_INTR_ERRORS only occur in master mode? Please make that more clear
in the name.

>                 goto out_complete;
>         }
>
>         /* We are in an invalid state; reset bus to a known state. */
>         if (!bus->msgs) {
> -               dev_err(bus->dev, "bus in unknown state\n");
> +               dev_err(bus->dev, "bus in unknown state irq_status: 0x%x\n",
> +                       bus->irq_status);
>                 bus->cmd_err = -EIO;
> -               if (bus->master_state != ASPEED_I2C_MASTER_STOP)
> +               if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
> +                   bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
>                         aspeed_i2c_do_stop(bus);
>                 goto out_no_complete;
>         }
> @@ -427,7 +425,13 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          * then update the state and handle the new state below.
>          */
>         if (bus->master_state == ASPEED_I2C_MASTER_START) {
> -               if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +               if (unlikely(!(bus->irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +                       if (unlikely(!(bus->irq_status &
> +                                    ASPEED_I2CD_INTR_TX_NAK))) {
> +                               bus->cmd_err = -ENXIO;
> +                               bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +                               goto out_complete;
> +                       }
>                         pr_devel("no slave present at %02x\n", msg->addr);
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         bus->cmd_err = -ENXIO;
> @@ -447,11 +451,12 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>
>         switch (bus->master_state) {
>         case ASPEED_I2C_MASTER_TX:
> -               if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> +               if (unlikely(bus->irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
>                         dev_dbg(bus->dev, "slave NACKed TX\n");
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         goto error_and_stop;
> -               } else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +               } else if (unlikely(!(bus->irq_status &
> +                                     ASPEED_I2CD_INTR_TX_ACK))) {
>                         dev_err(bus->dev, "slave failed to ACK TX\n");
>                         goto error_and_stop;
>                 }
> @@ -470,11 +475,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_RX_FIRST:
>                 /* RX may not have completed yet (only address cycle) */
> -               if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
> +               if (!(bus->irq_status & ASPEED_I2CD_INTR_RX_DONE))
>                         goto out_no_complete;
>                 /* fallthrough intended */
>         case ASPEED_I2C_MASTER_RX:
> -               if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> +               if (unlikely(!(bus->irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
>                         dev_err(bus->dev, "master failed to RX\n");
>                         goto error_and_stop;
>                 }
> @@ -505,8 +510,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 }
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_STOP:
> -               if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> -                       dev_err(bus->dev, "master failed to STOP\n");
> +               if (unlikely(!(bus->irq_status &
> +                              ASPEED_I2CD_INTR_NORMAL_STOP))) {
> +                       dev_err(bus->dev,
> +                               "master failed to STOP irq_status:0x%x\n",
> +                               bus->irq_status);
>                         bus->cmd_err = -EIO;
>                         /* Do not STOP as we have already tried. */
>                 } else {
> @@ -518,7 +526,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>         case ASPEED_I2C_MASTER_INACTIVE:
>                 dev_err(bus->dev,
>                         "master received interrupt 0x%08x, but is inactive\n",
> -                       irq_status);
> +                       bus->irq_status);
>                 bus->cmd_err = -EIO;
>                 /* Do not STOP as we should be inactive. */
>                 goto out_complete;
> @@ -540,33 +548,40 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 bus->master_xfer_result = bus->msgs_index + 1;
>         complete(&bus->cmd_complete);
>  out_no_complete:
> -       if (irq_status != status_ack)
> -               dev_err(bus->dev,
> -                       "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> -                       irq_status, status_ack);
> -       return !!irq_status;
> +       bus->irq_status ^= status_ack;
> +       return !bus->irq_status;
>  }
>
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>         struct aspeed_i2c_bus *bus = dev_id;
> -       bool ret;
> +       u32 irq_received;
>
>         spin_lock(&bus->lock);
> +       irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +       bus->irq_status = irq_received;
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> -       if (aspeed_i2c_slave_irq(bus)) {
> -               dev_dbg(bus->dev, "irq handled by slave.\n");
> -               ret = true;
> -               goto out;
> +       if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {

It might be nice to have a comment here about why you might try both handlers.

> +               if (!aspeed_i2c_master_irq(bus))
> +                       aspeed_i2c_slave_irq(bus);
> +       } else {
> +               if (!aspeed_i2c_slave_irq(bus))
> +                       aspeed_i2c_master_irq(bus);
>         }
> +#else
> +       aspeed_i2c_master_irq(bus);
>  #endif /* CONFIG_I2C_SLAVE */
>
> -       ret = aspeed_i2c_master_irq(bus);
> +       if (bus->irq_status)
> +               dev_err(bus->dev,
> +                       "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> +                       irq_received, irq_received ^ bus->irq_status);
>
> -out:
> +       /* Ack all interrupt bits. */
> +       writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);

You should probably ACK as soon as you read the bits.

>         spin_unlock(&bus->lock);
> -       return ret ? IRQ_HANDLED : IRQ_NONE;
> +       return bus->irq_status ? IRQ_NONE : IRQ_HANDLED;
>  }
>
>  static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> --
> 2.18.0
>
