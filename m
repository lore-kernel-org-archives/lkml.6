Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C59C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CA5208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JynqMflL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CA5208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeGKFpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:45:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39811 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeGKFpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:45:38 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so47030575oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1o2Aoh1iq8Rf+AQ7Vq1j+bTA8DsOk6tU5Yw5sYMx54=;
        b=JynqMflLMLEuEtbFPYIirlKbZRSz1Cp8Ei3s/eIyUP/TUXU1pS+k+jw8x8yCtsoKev
         gtXuI2ooo80vd67vY4S4KW0X9l/lO9NjJ2lflHddRnI8w6hDA2+WWac4Ua1SVbWhbZTE
         K1/rsh8/8yD6A/wo84npLECrELVgf/B6LgY2p7ZmfS1MMToraYAzjb8ENidsviBg6Jk9
         sCAQEyMMVtlNLr/wP//sTavk4HwV+oxZJGJgdm8A9nLunffFYSJP3bDMkx1XiEjaF/so
         F2Sn0qpBb7AFEOJJIH1vkfld6vz4RXyICJNF1pPPp+z4LxEF6OcNEVl67BIO6aX25r0P
         fVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1o2Aoh1iq8Rf+AQ7Vq1j+bTA8DsOk6tU5Yw5sYMx54=;
        b=NWsI8qOfP3SQGt/jsZl3raq8YBslvoQ8VVkkg420XZm5ospEYMIH8UTP/2bfuke+tt
         AqRgKwliBRUxLYmdbupfVOnMeyKdOkQWNL7GumxOw4iZSOMRv4RrywyXTyGySfjR0LVR
         UeYwy96McLwOPU9lYWQCV6FLMrrE4YU13AcLRkY5GswEYXt9DKx/F99LO6zm+M7ZJXWd
         b4QhP99BNrocW5z2H40gr4gArVE1CUVAjdXHewaMoAuQSQFW0JVnRmAwnqCRVE4G2Y2j
         yyRjHDY4pgAE/GdTPp30TCt9nlo4XiR4iIsDhk4o8/ZSozixMh+y6ah/F0VgVS4BgB09
         PigQ==
X-Gm-Message-State: APt69E3kGa2bzsZwTrcxZEy7Q0DHS4rkTMnak9ftd51deqQgiaBkOXZ5
        qRjOkE5VZcIPqUDSo7g7oaBRRBvLGDH4aOtnE/CqiA==
X-Google-Smtp-Source: AAOMgperpPDh+CwyS81DwnNXot10RlhQnYd0JNp//SGlNYjIq9lQGnKydP2w8w/uQHDJPtj3etY9LcyNVFXwwC+oOAw=
X-Received: by 2002:aca:3c02:: with SMTP id j2-v6mr32790547oia.238.1531287784072;
 Tue, 10 Jul 2018 22:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Jul 2018 22:42:52 -0700
Message-ID: <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message printings.
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

On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> There are some log printing without a newline character. This
> patch adds the missing newline characters.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..e3007c1c4ac5 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -407,7 +407,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          */
>         ret = aspeed_i2c_is_irq_error(irq_status);
>         if (ret < 0) {
> -               dev_dbg(bus->dev, "received error interrupt: 0x%08x",
> +               dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
>                         irq_status);
>                 bus->cmd_err = ret;
>                 bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> @@ -416,7 +416,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>
>         /* We are in an invalid state; reset bus to a known state. */
>         if (!bus->msgs) {
> -               dev_err(bus->dev, "bus in unknown state");
> +               dev_err(bus->dev, "bus in unknown state\n");
>                 bus->cmd_err = -EIO;
>                 if (bus->master_state != ASPEED_I2C_MASTER_STOP)
>                         aspeed_i2c_do_stop(bus);
> @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>          */
>         if (bus->master_state == ASPEED_I2C_MASTER_START) {
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> -                       pr_devel("no slave present at %02x", msg->addr);
> +                       pr_devel("no slave present at %02x\n", msg->addr);

Unless something changed in the last couple versions of the kernel, this is the
only line that actually changes anything. dev_* inserts a newline for every
call.

Admittedly, the rest of the file is pretty inconsistent, so if you really want
to make all these changes, I don't feel super strongly about it.

>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         bus->cmd_err = -ENXIO;
>                         aspeed_i2c_do_stop(bus);
> @@ -451,11 +451,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>         switch (bus->master_state) {
>         case ASPEED_I2C_MASTER_TX:
>                 if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> -                       dev_dbg(bus->dev, "slave NACKed TX");
> +                       dev_dbg(bus->dev, "slave NACKed TX\n");
>                         status_ack |= ASPEED_I2CD_INTR_TX_NAK;
>                         goto error_and_stop;
>                 } else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> -                       dev_err(bus->dev, "slave failed to ACK TX");
> +                       dev_err(bus->dev, "slave failed to ACK TX\n");
>                         goto error_and_stop;
>                 }
>                 status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> @@ -478,7 +478,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 /* fallthrough intended */
>         case ASPEED_I2C_MASTER_RX:
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> -                       dev_err(bus->dev, "master failed to RX");
> +                       dev_err(bus->dev, "master failed to RX\n");
>                         goto error_and_stop;
>                 }
>                 status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> @@ -509,7 +509,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_no_complete;
>         case ASPEED_I2C_MASTER_STOP:
>                 if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> -                       dev_err(bus->dev, "master failed to STOP");
> +                       dev_err(bus->dev, "master failed to STOP\n");
>                         bus->cmd_err = -EIO;
>                         /* Do not STOP as we have already tried. */
>                 } else {
> @@ -520,7 +520,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
>                 goto out_complete;
>         case ASPEED_I2C_MASTER_INACTIVE:
>                 dev_err(bus->dev,
> -                       "master received interrupt 0x%08x, but is inactive",
> +                       "master received interrupt 0x%08x, but is inactive\n",
>                         irq_status);
>                 bus->cmd_err = -EIO;
>                 /* Do not STOP as we should be inactive. */
> @@ -851,7 +851,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
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

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
