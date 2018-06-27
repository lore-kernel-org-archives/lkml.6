Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC3426805
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0TfORrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC3426805
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932884AbeF0Hgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:36:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42080 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753377AbeF0Hgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:36:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so963629oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsMuLrJDumj75RThyQBdAZdwUqHcZgrSW9NbIurWvus=;
        b=d0TfORrliQhBtXkkIA2Y8ZGlAkHPpBJs6Vs470V5sxp45cn0SWTT0trqpW5PJaFI20
         AbblZAHd+RVoM0PGFbutgz0xYpwUIKgYHrWxgZNoT6E2mT9nq08iCdEhq9xTO1sOlxYe
         aTlE0Y6NFHvZs3fAbWneP/bKJ6R4p3QpS49bSiy59Ni4u1/0/RuDKdSjziVLNeRunqBC
         Wda6/c6op/Zgzdt0G4adCSWg8F4o10894k/wwwn8DlMz8c3b7yrbR2Bb2JkHDcYqvTyH
         0og51kV2bQGGYASNLhHCYbqil7XKuqXNaTYXFsKeeDfAeT+UGZ/RJfHXqbO4cAgxuuB+
         VGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsMuLrJDumj75RThyQBdAZdwUqHcZgrSW9NbIurWvus=;
        b=gGzujxhkwyIwDQZBwwXLtB9QXJ5RVh8xKmTW2Pd6B3iQ5maWQm7yTSlYVOT00Z9TO9
         xgbK+jtVGcIdFScSa/KFyS+dcYzEX+JY8Sh46CZ63Yo1pnaRIcxF101M8oIVbVak5ZV1
         ezI2NdBIj/rgxbPP190eQ41Yu8UHg/E3yKBb6aPhkQJtXyCrVXbV8FKQbSsePL/3reKz
         bgUkPRVKdiCF2Lij+V7jH//TjU6iggf1DO9bjCb8ojI/248Sost6UWo++f1kAay6MGfy
         yFKg/4EQdMXGxXv1jS9N7Dm/BloMELTa1t9CQnfl1HUtBlxXhuf1WWx3BnoUcrpqYesl
         0c9Q==
X-Gm-Message-State: APt69E0Q9l4aH3B5y1R42tRFTbkSBF8uIOaZsuMCYW2RyHWjVyEUNREg
        F1mGwh6yxkm27htYQ/AFE03ef+UBan4lWjKurg3NBQ==
X-Google-Smtp-Source: AAOMgpf/InhsPfOmLxEtGCMGx3fE35s0Td8EiWJk3ZzDfAoneGndgo1uK+kndYB5Szj5gJBKk0T26WRtltR7sybpOkI=
X-Received: by 2002:aca:a641:: with SMTP id p62-v6mr2692013oie.151.1530085001196;
 Wed, 27 Jun 2018 00:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 27 Jun 2018 00:36:29 -0700
Message-ID: <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        james.feist@linux.intel.com, vernon.mauery@linux.intel.com,
        Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 9:58 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> BMC firmware should support some multi-master use cases such as multi-node,
> IPMB, BMC-ME link and so on but the current ASPEED I2C driver is a bit
> unstable for the multi-master use case. So this patch improves ASPEED I2C
> driver to support the multi-master use case stably.
>
> Changes:
> * Added XFER_MODE status register checking logic into
>   aspeed_i2c_master_xfer to improve the current bus busy checking logic.
> * Changed the order of enum aspeed_i2c_master_state and
>   enum aspeed_i2c_slave_state defines to make their initial values set to
>   ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
>   In case of multi-master use with previous code, if a slave data comes
>   ahead of the first master xfer, master_state starts from an invalid
>   state. This change fixed the issue.
> * Adjusted spin_lock scope to make it wrap the whole irq handler using
>   a single lock and unlock pair covers both master and slave handlers.
> * Added irq_status variable as a member of the struct aspeed_i2c_bus to
>   collect handled interrupt bits throughout the master and the slave irq
>   handlers.
> * Added control logic to put an order on calling the master and the slave
>   irq handlers based on their current states.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 200 +++++++++++++++++++-------------
>  1 file changed, 118 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..ac3e17d9a365 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -4,6 +4,7 @@
>   *  Copyright (C) 2012-2017 ASPEED Technology Inc.
>   *  Copyright 2017 IBM Corporation
>   *  Copyright 2017 Google, Inc.
> + *  Copyright (c) 2018 Intel Corporation
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
> @@ -12,6 +13,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> @@ -82,6 +84,11 @@
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
> @@ -94,6 +101,7 @@
>                  ASPEED_I2CD_INTR_TX_ACK)
>
>  /* 0x14 : I2CD Command/Status Register   */
> +#define ASPEED_I2CD_XFER_MODE_STS_MASK                 GENMASK(22, 19)
>  #define ASPEED_I2CD_SCL_LINE_STS                       BIT(18)
>  #define ASPEED_I2CD_SDA_LINE_STS                       BIT(17)
>  #define ASPEED_I2CD_BUS_BUSY_STS                       BIT(16)
> @@ -110,23 +118,27 @@
>  /* 0x18 : I2CD Slave Device Address Register   */
>  #define ASPEED_I2CD_DEV_ADDR_MASK                      GENMASK(6, 0)
>
> +/* Timeout for bus busy checking */
> +#define BUS_BUSY_CHECK_TIMEOUT                         250000 /* 250ms */
> +#define BUS_BUSY_CHECK_INTERVAL                                10000  /* 10ms */

Could you add a comment on where you got these values from?

Also, please use the same naming pattern as above.

> +
>  enum aspeed_i2c_master_state {
> +       ASPEED_I2C_MASTER_INACTIVE,
>         ASPEED_I2C_MASTER_START,
>         ASPEED_I2C_MASTER_TX_FIRST,
>         ASPEED_I2C_MASTER_TX,
>         ASPEED_I2C_MASTER_RX_FIRST,
>         ASPEED_I2C_MASTER_RX,
>         ASPEED_I2C_MASTER_STOP,
> -       ASPEED_I2C_MASTER_INACTIVE,
>  };
>
>  enum aspeed_i2c_slave_state {
> +       ASPEED_I2C_SLAVE_STOP,
>         ASPEED_I2C_SLAVE_START,
>         ASPEED_I2C_SLAVE_READ_REQUESTED,
>         ASPEED_I2C_SLAVE_READ_PROCESSED,
>         ASPEED_I2C_SLAVE_WRITE_REQUESTED,
>         ASPEED_I2C_SLAVE_WRITE_RECEIVED,
> -       ASPEED_I2C_SLAVE_STOP,
>  };
>
>  struct aspeed_i2c_bus {
> @@ -150,6 +162,7 @@ struct aspeed_i2c_bus {
>         int                             cmd_err;
>         /* Protected only by i2c_lock_bus */
>         int                             master_xfer_result;
> +       u32                             irq_status;
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>         struct i2c_client               *slave;
>         enum aspeed_i2c_slave_state     slave_state;
> @@ -229,37 +242,30 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>  {
> -       u32 command, irq_status, status_ack = 0;
> +       u32 command, status_ack = 0;
>         struct i2c_client *slave = bus->slave;
> -       bool irq_handled = true;
>         u8 value;
>
> -       spin_lock(&bus->lock);
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
> @@ -274,28 +280,29 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
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
> @@ -318,15 +325,8 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
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
> -       spin_unlock(&bus->lock);
> -       return irq_handled;
> +       bus->irq_status ^= status_ack;
> +       return !bus->irq_status;
>  }
>  #endif /* CONFIG_I2C_SLAVE */
>
> @@ -384,20 +384,19 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
>
>  static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>  {
> -       u32 irq_status, status_ack = 0, command = 0;
> +       u32 status_ack = 0, command = 0;
>         struct i2c_msg *msg;
>         u8 recv_byte;
>         int ret;
>
> -       spin_lock(&bus->lock);
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
> @@ -405,20 +404,23 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          * should clear the command queue effectively taking us back to the
>          * INACTIVE state.
>          */
> -       ret = aspeed_i2c_is_irq_error(irq_status);
> -       if (ret < 0) {
> -               dev_dbg(bus->dev, "received error interrupt: 0x%08x",
> -                       irq_status);
> +       ret = aspeed_i2c_is_irq_error(bus->irq_status);
> +       if (ret) {
> +               dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
> +                       bus->irq_status);
>                 bus->cmd_err = ret;
>                 bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +               status_ack |= (bus->irq_status & ASPEED_I2CD_INTR_ERRORS);
>                 goto out_complete;
>         }
>
>         /* We are in an invalid state; reset bus to a known state. */
>         if (!bus->msgs) {
> -               dev_err(bus->dev, "bus in unknown state");
> +               dev_err(bus->dev, "bus in unknown state irq_status: 0x%x\n",
> +                       bus->irq_status);
>                 bus->cmd_err = -EIO;
> -               if (bus->master_state != ASPEED_I2C_MASTER_STOP)
> +               if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
> +                   bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
>                         aspeed_i2c_do_stop(bus);
>                 goto out_no_complete;
>         }
> @@ -430,7 +432,13 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
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
>                         pr_devel("no slave present at %02x", msg->addr);
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         bus->cmd_err = -ENXIO;
> @@ -450,12 +458,13 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>
>         switch (bus->master_state) {
>         case ASPEED_I2C_MASTER_TX:
> -               if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> -                       dev_dbg(bus->dev, "slave NACKed TX");
> +               if (unlikely(bus->irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> +                       dev_dbg(bus->dev, "slave NACKed TX\n");
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         goto error_and_stop;
> -               } else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> -                       dev_err(bus->dev, "slave failed to ACK TX");
> +               } else if (unlikely(!(bus->irq_status &
> +                                     ASPEED_I2CD_INTR_TX_ACK))) {
> +                       dev_err(bus->dev, "slave failed to ACK TX\n");
>                         goto error_and_stop;
>                 }
>                 status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> @@ -473,12 +482,12 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_RX_FIRST:
>                 /* RX may not have completed yet (only address cycle) */
> -               if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
> +               if (!(bus->irq_status & ASPEED_I2CD_INTR_RX_DONE))
>                         goto out_no_complete;
>                 /* fallthrough intended */
>         case ASPEED_I2C_MASTER_RX:
> -               if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> -                       dev_err(bus->dev, "master failed to RX");
> +               if (unlikely(!(bus->irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> +                       dev_err(bus->dev, "master failed to RX\n");
>                         goto error_and_stop;
>                 }
>                 status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> @@ -508,8 +517,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 }
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_STOP:
> -               if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> -                       dev_err(bus->dev, "master failed to STOP");
> +               if (unlikely(!(bus->irq_status &
> +                              ASPEED_I2CD_INTR_NORMAL_STOP))) {
> +                       dev_err(bus->dev,
> +                               "master failed to STOP irq_status:0x%x\n",
> +                               bus->irq_status);
>                         bus->cmd_err = -EIO;
>                         /* Do not STOP as we have already tried. */
>                 } else {
> @@ -520,8 +532,8 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_complete;
>         case ASPEED_I2C_MASTER_INACTIVE:
>                 dev_err(bus->dev,
> -                       "master received interrupt 0x%08x, but is inactive",
> -                       irq_status);
> +                       "master received interrupt 0x%08x, but is inactive\n",
> +                       bus->irq_status);
>                 bus->cmd_err = -EIO;
>                 /* Do not STOP as we should be inactive. */
>                 goto out_complete;
> @@ -543,26 +555,61 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 bus->master_xfer_result = bus->msgs_index + 1;
>         complete(&bus->cmd_complete);
>  out_no_complete:
> -       if (irq_status != status_ack)
> -               dev_err(bus->dev,
> -                       "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> -                       irq_status, status_ack);
> -       spin_unlock(&bus->lock);
> -       return !!irq_status;
> +       bus->irq_status ^= status_ack;
> +       return !bus->irq_status;
>  }
>
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>         struct aspeed_i2c_bus *bus = dev_id;
> +       u32 irq_received;
> +
> +       spin_lock(&bus->lock);
> +       irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +       bus->irq_status = irq_received;
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> -       if (aspeed_i2c_slave_irq(bus)) {
> -               dev_dbg(bus->dev, "irq handled by slave.\n");
> -               return IRQ_HANDLED;
> +       if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> +               if (!aspeed_i2c_master_irq(bus))

Why do you check the slave if master fails (or vice versa)? I
understand that there are some status bits that have not been handled,
but it doesn't seem reasonable to assume that there is state that the
other should do something with; the only way this would happen is if
the state that you think you are in does not match the status bits you
have been given, but if this is the case, you are already hosed; I
don't think trying the other handler is likely to make things better,
unless there is something that I am missing.

> +                       aspeed_i2c_slave_irq(bus);
> +       } else {
> +               if (!aspeed_i2c_slave_irq(bus))
> +                       aspeed_i2c_master_irq(bus);
>         }
> +#else
> +       aspeed_i2c_master_irq(bus);
>  #endif /* CONFIG_I2C_SLAVE */
>
> -       return aspeed_i2c_master_irq(bus) ? IRQ_HANDLED : IRQ_NONE;
> +       if (bus->irq_status)
> +               dev_err(bus->dev,
> +                       "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> +                       irq_received, irq_received ^ bus->irq_status);
> +
> +       /* Ack all interrupt bits. */
> +       writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> +       spin_unlock(&bus->lock);
> +       return bus->irq_status ? IRQ_NONE : IRQ_HANDLED;
> +}
> +
> +static int aspeed_i2c_check_bus_busy_timeout(struct aspeed_i2c_bus *bus)
> +{
> +       ktime_t timeout = ktime_add_us(ktime_get(), BUS_BUSY_CHECK_TIMEOUT);
> +
> +       might_sleep();
> +
> +       for (;;) {
> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +                     (ASPEED_I2CD_BUS_BUSY_STS |
> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))

Is using the Transfer Mode State Machine bits necessary? The
documentation marks it as "for debugging purpose only," so relying on
it makes me nervous.

> +                       return 0;
> +               if (ktime_compare(ktime_get(), timeout) > 0)
> +                       break;
> +               usleep_range((BUS_BUSY_CHECK_INTERVAL >> 2) + 1,

Where did you get this minimum value?

> +                            BUS_BUSY_CHECK_INTERVAL);
> +       }
> +
> +       dev_err(bus->dev, "timeout waiting for idle. attempting recovery\n");
> +       return aspeed_i2c_recover_bus(bus);
>  }
>
>  static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> @@ -570,22 +617,11 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>  {
>         struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
>         unsigned long time_left, flags;
> -       int ret = 0;
> -
> -       spin_lock_irqsave(&bus->lock, flags);
> -       bus->cmd_err = 0;
>
> -       /* If bus is busy, attempt recovery. We assume a single master
> -        * environment.
> -        */
> -       if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
> -               spin_unlock_irqrestore(&bus->lock, flags);
> -               ret = aspeed_i2c_recover_bus(bus);
> -               if (ret)
> -                       return ret;
> -               spin_lock_irqsave(&bus->lock, flags);
> -       }
> +       if (aspeed_i2c_check_bus_busy_timeout(bus))
> +               return -EAGAIN;
>
> +       spin_lock_irqsave(&bus->lock, flags);
>         bus->cmd_err = 0;
>         bus->msgs = msgs;
>         bus->msgs_index = 0;
> @@ -851,7 +887,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>         bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
>         if (IS_ERR(bus->rst)) {
>                 dev_err(&pdev->dev,
> -                       "missing or invalid reset controller device tree entry");
> +                       "missing or invalid reset controller device tree entry\n");
>                 return PTR_ERR(bus->rst);
>         }
>         reset_control_deassert(bus->rst);
> --
> 2.17.1
>
