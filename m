Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3C1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC126838
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC126838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933000AbeF1EL5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:11:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36560 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeF1EL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:11:56 -0400
Received: by mail-qk0-f194.google.com with SMTP id a132-v6so2288622qkg.3;
        Wed, 27 Jun 2018 21:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5TpnrO7julsyRfsSpAK7CcSX+w22T2Pd7TNT22eFajM=;
        b=T0GYg3JkOGso0u5vH0+5eahuEA8Ukj2GhgcvYpvUDC5bXgrWnIHAhF4dvVXcvWo77T
         vhlmbzOWOVADX/b/29q9DeEOv1vxJPgKgFnn29glbZ5TFt80n21s3OyiJ7+ZMIwctCd3
         ZrrX0AseWUD3cZCaRrcFOMZUAqD2/PFclKkk+ojyxQXz6AuNA0in4snk+NFhJQ51rKoe
         ifqv6gBWz/hjyKUpnh8V7WW97AKO3RvTdg9Fy8H9HYTGINXaDDPFSFgcMr7FUoT5aF4T
         kr1XOb/XTYbp6WVSNt2ZrKL50D6b/x57tDWtWLoP3oATsUfwGPvDiBHmhLAk1Mv5nF9X
         9DWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5TpnrO7julsyRfsSpAK7CcSX+w22T2Pd7TNT22eFajM=;
        b=D7ipYEH3Pvom1fDyK5R09vECY241ZtDGF+J0G/C6He+K2k1mvluBISN6J9Z1FW0LhC
         II9bWY4rfChihgNh5DEVEKmCXeTPOvezlcoLOKptIDtI8ix0RnEkQ/6F8TlzfeDGjxiv
         33BxGuXbed8NbtCf/RG2RAuHfx0prMAN+bqB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5TpnrO7julsyRfsSpAK7CcSX+w22T2Pd7TNT22eFajM=;
        b=V8G9G2v73SGDkMmfeurhSXFrrXRiLThmgGx2OQAD74P5cQS47SBEQW008zoAO69IGe
         Ad7IwtYRrfbzE5qQXWTt6k9n/2GIchLY26zqGRcu8o0dDwOb74DxmV3oriI0+I4szTCS
         XLu72qI8lhVwz1DRJ/KFW4tR9QfMwY9S4H4RkFkUrNRMnmCSTyjfNjo3SvftIcrlSj89
         o/oHELQD4RPOdcKmQFia8EJk+jQ18+KdI3lNS46WyVVrdHpJ+hTwCZhW2jc2aWT8WpxO
         6rjqp2PYjJd25pJj4Xe7ep+tkfBRPy4FUxg3r5iGeXstiIT6e0f/r0izzPBFPwOxzuZ/
         75+Q==
X-Gm-Message-State: APt69E2cW7m8VZPO3WR/7NQJ2IKcNG/wGlcNB8CwNzi0G1I2In4fKz79
        SE04PJLdBRh+zmMGtdgnBrIzKOrKt06US4VnVoo=
X-Google-Smtp-Source: AAOMgpd0FYI3DCUziVl9qjLx/z+K+WbGWDNoGyRVX/N000GtqcJJnxo1HSUT8eGRP/F/7+LYdXZ4kVbXh8Y0d9YoQEk=
X-Received: by 2002:a37:c44d:: with SMTP id h13-v6mr7436304qkm.422.1530159115284;
 Wed, 27 Jun 2018 21:11:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:11:34
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-7-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-7-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:41:34 +0930
X-Google-Sender-Auth: QOIuqfArhNTJ1RTvyMoGPSE24dc
Message-ID: <CACPK8XfZPCiCPeNL5-TpPMcHrA_fyiLu=5pArSxBXd6wT8jkFA@mail.gmail.com>
Subject: Re: [PATCH 06/14] fsi: master-gpio: Add more tracepoints
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This adds a few more tracepoints that have proven useful when
> debugging issues with the FSI bus.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/fsi/fsi-master-gpio.c          | 16 ++++---
>  include/trace/events/fsi_master_gpio.h | 59 ++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> index 48e0e65b2982..a00a85aa6d56 100644
> --- a/drivers/fsi/fsi-master-gpio.c
> +++ b/drivers/fsi/fsi-master-gpio.c
> @@ -130,10 +130,17 @@ static void set_sda_output(struct fsi_master_gpio *master, int value)
>
>  static void clock_zeros(struct fsi_master_gpio *master, int count)
>  {
> +       trace_fsi_master_gpio_clock_zeros(master, count);
>         set_sda_output(master, 1);
>         clock_toggle(master, count);
>  }
>
> +static void echo_delay(struct fsi_master_gpio *master)
> +{
> +       clock_zeros(master, master->t_echo_delay);
> +}

This doesn't look like it belongs in this patch.

You've just moved it up. Not worth a re-spin.

> +
> +
>  static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
>                         uint8_t num_bits)
>  {
> @@ -279,16 +286,19 @@ static void build_ar_command(struct fsi_master_gpio *master,
>                 addr_bits = 2;
>                 opcode_bits = 2;
>                 opcode = FSI_GPIO_CMD_SAME_AR;
> +               trace_fsi_master_gpio_cmd_same_addr(master);
>
>         } else if (check_relative_address(master, id, addr, &rel_addr)) {
>                 /* 8 bits plus sign */
>                 addr_bits = 9;
>                 addr = rel_addr;
>                 opcode = FSI_GPIO_CMD_REL_AR;
> +               trace_fsi_master_gpio_cmd_rel_addr(master, rel_addr);
>
>         } else {
>                 addr_bits = 21;
>                 opcode = FSI_GPIO_CMD_ABS_AR;
> +               trace_fsi_master_gpio_cmd_abs_addr(master, addr);
>         }
>
>         /*
> @@ -337,12 +347,6 @@ static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
>         msg_push_crc(cmd);
>  }
>
> -static void echo_delay(struct fsi_master_gpio *master)
> -{
> -       set_sda_output(master, 1);
> -       clock_toggle(master, master->t_echo_delay);
> -}
> -
>  static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
>  {
>         cmd->bits = 0;
