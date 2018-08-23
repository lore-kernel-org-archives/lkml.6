Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7812D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGJMoXqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7812D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeHXAtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:49:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33713 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeHXAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:49:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so11861042oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1Hf9GHKwELGvKAZn2jE3MTEGSUYwpD4UyLunTVvBNY=;
        b=KGJMoXqrJyPoQDTsn09OkLeXjjfPnVR066PQ9hZBhFNHLb6MQvHpNCkHkJBL7hBFQL
         BT9UM4JpYQ8GXmxnVSeHfqq5wZZvlbrAR1L2cHpGVlsKZAR3iF4Fao8BTfK56L4nBf0L
         p6VviEpv7dQbgJX2Ona/reiB6fm417wb6d+cjT4RZ6FeJkw20Ju1Xxf6Hh4KT5kW2cmE
         wMPgbVcWINA7daHd01Tw+rBMoquewUH88fBuv8EQWM5bASBv1VDkoPGEjjUqnAHlyAha
         Hz4mptwbLbbHmgfUxrClfzuFHZpV/Vw2KO13cSYxdwm996xblbSFiqozNtnnPCqXEjb1
         5ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1Hf9GHKwELGvKAZn2jE3MTEGSUYwpD4UyLunTVvBNY=;
        b=Wv0hltpO5on9ZeQLWralvaE7QqsxCvZc59jRkLpNEy2TxwZnlybp+wWN/lT03off4A
         bds8NUtodyrL+LyqXIXEhyircWIqpVSWqAC48UInzGhxDOFx9/ygmagWLFCQ0H2aUv9I
         nN4Xx1cMaDUkWwCn/WNeIlByUkvDnYZVhl8zu3B1LAaSboBHCHZdObKrcUnOsQBcEyuN
         XQqe8n2dQAMX4bjIKEt5PJqYqfbghHLlUibKozFh1z2UuXqrOGavcItiV/vQo6RPC5Ud
         HJAxwqXxupEYQiWVmrEh8pd5kd0V3EcgjorwGTxIZ2m2OAYr5jmH1oAZ61so4722Ip7p
         HKbw==
X-Gm-Message-State: APzg51AKD7oQhgEqvRjEjgl3wZPayjQYZq3ovzLTY7JkOX4zoC7N+jA1
        z2PCA0PrghWaVqTT9OePj1/rgCp8krqcYLzg8Ujtug==
X-Google-Smtp-Source: ANB0VdZlZwGtpIjWJp5jPuS592l9gWr/xSsHkDj2ZVtXcHjyA5tPEmwXi8Z34g4AxBq5+41Cj2bK9V7FE/yT57uChLE=
X-Received: by 2002:a54:4017:: with SMTP id x23-v6mr9439152oie.25.1535059092763;
 Thu, 23 Aug 2018 14:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180823205647.12417-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180823205647.12417-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Aug 2018 14:18:01 -0700
Message-ID: <CAFd5g457FQNwiprMmeGEaem8LTSObXuyifdxtN7LzS6k1PWmdg@mail.gmail.com>
Subject: Re: [PATCH i2c-next v5] i2c: aspeed: Handle master/slave combined irq
 events properly
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

On Thu, Aug 23, 2018 at 1:56 PM Jae Hyun Yoo
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
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes since v4:
> - Fixed an error printing message that handlers didn't handle all interrupts.
>
> Changes since v3:
> - Fixed typos in a comment.
>
> Changes since v2:
> - Changed the name of ASPEED_I2CD_INTR_ERRORS to ASPEED_I2CD_INTR_MASTER_ERRORS
> - Removed a member irq_status from the struct aspeed_i2c_bus and changed
>   master_irq and slave_irq handlers to make them return status_ack.
> - Added a comment to explain why it needs to try both irq handlers.
>
> Changes since v1:
> - Fixed a grammar issue in commit message.
> - Added a missing line feed character into a message printing.
>
>  drivers/i2c/busses/i2c-aspeed.c | 115 +++++++++++++++++++-------------
>  1 file changed, 70 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index a4f956c6d567..8341e384f4f1 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -82,6 +82,11 @@
>  #define ASPEED_I2CD_INTR_RX_DONE                       BIT(2)
>  #define ASPEED_I2CD_INTR_TX_NAK                                BIT(1)
>  #define ASPEED_I2CD_INTR_TX_ACK                                BIT(0)
> +#define ASPEED_I2CD_INTR_MASTER_ERRORS                                        \
> +               (ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |                             \
> +                ASPEED_I2CD_INTR_SCL_TIMEOUT |                                \
> +                ASPEED_I2CD_INTR_ABNORMAL |                                   \
> +                ASPEED_I2CD_INTR_ARBIT_LOSS)
>  #define ASPEED_I2CD_INTR_ALL                                                  \
>                 (ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |                             \
>                  ASPEED_I2CD_INTR_BUS_RECOVER_DONE |                           \
> @@ -227,20 +232,16 @@ static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
>  }
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> -static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
> +static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
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
> +               return 0;
>
>         command = readl(bus->base + ASPEED_I2C_CMD_REG);
> -       irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>
>         /* Slave was requested, restart state machine. */
>         if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> @@ -249,10 +250,8 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>         }
>
>         /* Slave is not currently active, irq was for someone else. */
> -       if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
> -               irq_handled = false;
> -               goto out;
> -       }
> +       if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
> +               return status_ack;
>
>         dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
>                 irq_status, command);
> @@ -281,19 +280,19 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
>                 status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                 bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>         }
> +       if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
> +               status_ack |= ASPEED_I2CD_INTR_TX_ACK;
>
>         switch (bus->slave_state) {
>         case ASPEED_I2C_SLAVE_READ_REQUESTED:
>                 if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
>                         dev_err(bus->dev, "Unexpected ACK on read request.\n");
>                 bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
> -
>                 i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
>                 writel(value, bus->base + ASPEED_I2C_BYTE_BUF_REG);
>                 writel(ASPEED_I2CD_S_TX_CMD, bus->base + ASPEED_I2C_CMD_REG);
>                 break;
>         case ASPEED_I2C_SLAVE_READ_PROCESSED:
> -               status_ack |= ASPEED_I2CD_INTR_TX_ACK;
>                 if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
>                         dev_err(bus->dev,
>                                 "Expected ACK after processed read.\n");
> @@ -317,14 +316,7 @@ static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
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
> +       return status_ack;
>  }
>  #endif /* CONFIG_I2C_SLAVE */
>
> @@ -380,21 +372,21 @@ static int aspeed_i2c_is_irq_error(u32 irq_status)
>         return 0;
>  }
>
> -static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> +static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
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
>         if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
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
> @@ -403,19 +395,22 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          * INACTIVE state.
>          */
>         ret = aspeed_i2c_is_irq_error(irq_status);
> -       if (ret < 0) {
> +       if (ret) {
>                 dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
>                         irq_status);
>                 bus->cmd_err = ret;
>                 bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +               status_ack |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
>                 goto out_complete;
>         }
>
>         /* We are in an invalid state; reset bus to a known state. */
>         if (!bus->msgs) {
> -               dev_err(bus->dev, "bus in unknown state\n");
> +               dev_err(bus->dev, "bus in unknown state. irq_status: 0x%x\n",
> +                       irq_status);
>                 bus->cmd_err = -EIO;
> -               if (bus->master_state != ASPEED_I2C_MASTER_STOP)
> +               if (bus->master_state != ASPEED_I2C_MASTER_STOP &&
> +                   bus->master_state != ASPEED_I2C_MASTER_INACTIVE)
>                         aspeed_i2c_do_stop(bus);
>                 goto out_no_complete;
>         }
> @@ -428,6 +423,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          */
>         if (bus->master_state == ASPEED_I2C_MASTER_START) {
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +                       if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_NAK))) {
> +                               bus->cmd_err = -ENXIO;
> +                               bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +                               goto out_complete;
> +                       }
>                         pr_devel("no slave present at %02x\n", msg->addr);
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         bus->cmd_err = -ENXIO;
> @@ -506,7 +506,9 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_STOP:
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> -                       dev_err(bus->dev, "master failed to STOP\n");
> +                       dev_err(bus->dev,
> +                               "master failed to STOP. irq_status:0x%x\n",
> +                               irq_status);
>                         bus->cmd_err = -EIO;
>                         /* Do not STOP as we have already tried. */
>                 } else {
> @@ -540,33 +542,56 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 bus->master_xfer_result = bus->msgs_index + 1;
>         complete(&bus->cmd_complete);
>  out_no_complete:
> -       if (irq_status != status_ack)
> -               dev_err(bus->dev,
> -                       "irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> -                       irq_status, status_ack);
> -       return !!irq_status;
> +       return status_ack;
>  }
>
>  static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  {
>         struct aspeed_i2c_bus *bus = dev_id;
> -       bool ret;
> +       u32 irq_received, irq_status, irq_acked;

Thinking more about how irq_status is used below, I think you can pick
a better name, maybe `irq_bits_remaining` or `irq_status_remaining`?

Come to think of it, `irq_acked` is a bit misleading too, maybe
`irq_handled`? This might seem pedantic, but you ack the bits at the
end of the function, so it does not actually contain acked bits.

It also might make more sense to just have the `irq_handled` and
`irq_received` fields, and then make the `irq_handled` cumulative.
That way, anywhere you use the `irq_status` it is immediately obvious
that you are comparing the received bits with the bits that have been
handled up to this point. I am not 100% sure, what do you think?

>
>         spin_lock(&bus->lock);
> +       irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +       irq_status = irq_received;
>
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> -       if (aspeed_i2c_slave_irq(bus)) {
> -               dev_dbg(bus->dev, "irq handled by slave.\n");
> -               ret = true;
> -               goto out;
> +       /*
> +        * In most cases, interrupt bits will be set one by one, although
> +        * multiple interrupt bits could be set at the same time. It's also
> +        * possible that master interrupt bits could be set along with slave
> +        * interrupt bits. Each case needs to be handled using corresponding
> +        * handlers depending on the current state.
> +        */
> +       if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> +               irq_acked = aspeed_i2c_master_irq(bus, irq_status);
> +               irq_status &= ~irq_acked;
> +               if (irq_status)
> +                       irq_acked = aspeed_i2c_slave_irq(bus, irq_status);
> +       } else {
> +               irq_acked = aspeed_i2c_slave_irq(bus, irq_status);
> +               irq_status &= ~irq_acked;
> +               if (irq_status)
> +                       irq_acked = aspeed_i2c_master_irq(bus, irq_status);
>         }
> +#else
> +       irq_acked = aspeed_i2c_master_irq(bus, irq_status);
>  #endif /* CONFIG_I2C_SLAVE */
>
> -       ret = aspeed_i2c_master_irq(bus);
> +       irq_status &= ~irq_acked;
> +       if (irq_status) {
> +               /*
> +                * 'irq_received ^ irq_status' indicates accumulated bits acked
> +                * by both master and slave irq handlers.
> +                */
> +               dev_err(bus->dev,
> +                       "irq acked != irq. expected 0x%08x, but was 0x%08x\n",
> +                       irq_received, irq_received ^ irq_status);

My point was that you are still using the `irq_received ^ irq_status`, right?

If you want a cumulative irq_acked, you can either or the first
instance of irq_acked with the following, or take a not of irq_status.
Xoring with a mask is not immediately clear.

> +       }
>
> -out:
> +       /* Ack all interrupt bits. */
> +       writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
>         spin_unlock(&bus->lock);
> -       return ret ? IRQ_HANDLED : IRQ_NONE;
> +       return irq_status ? IRQ_NONE : IRQ_HANDLED;
>  }
>
>  static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> --
> 2.18.0
>

Cheers
