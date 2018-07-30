Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CC160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719E420893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0pvs9xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719E420893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeG3QmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:42:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40273 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeG3QmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:42:16 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so10111086iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oNOZ1+LmnsDLqKcNEAWmiznzrywAVpjj/XkeTwxzX7E=;
        b=Y0pvs9xr3aFKecSAfO14eyBUIjcxd/Qr0wyJ+9TvAqHN0aIJl0Ndc+DNVHrNNDrfQP
         oHVPEPWzk60KckcwvSW3/xDJa/ErqTBxLeNzsiQ/HLZb6L3/4SsIPhSgRBJP9+9lMBmb
         /ya9gxqwvkIFPLhRmB+UwW775ZjOpDbqhU1oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oNOZ1+LmnsDLqKcNEAWmiznzrywAVpjj/XkeTwxzX7E=;
        b=KfP5+xY3J/LF+xm/uLfX/+PGAyvleQXgXb/0jmreExIMMfdOpv4UUzQH6sCq4XrY4P
         G/deE+VPCBQgIzwOeJ0CTdGe01N8mUXEhupuVln3MIvkZbFYDYTjO7CuYq+kG9vlcxVj
         tmyij4l6jsFncm890MFQlmkCVV1NlCCNCGsu1HTldp6V6Uw2nl69LNN0yUD64roSIzT6
         QKct6tlo2Ccj8+UOwnNW0pT14TIg18/MCj+DvUgT+KR/VNRuJgUmVXqaNBmziDSmVKUG
         b4TSaMJwXwmOriJdxHjhR44erc0IFQTpyRCPW5JbnbOUvNjm3S/B4OcEE0jyuM3OC5V1
         jjCw==
X-Gm-Message-State: AOUpUlGYlJTVhY5ZnGeK3at2QkzkvGZsg4ewUvm/SVt9vQ3j5R6eudoa
        Ruza/w7fzv7mKVe6TK2bjEBNj7Z3W54pbKJm9recfFLx
X-Google-Smtp-Source: AAOMgpfV0bw08xTOAEOeNiVqkU6Q1v40o/pTLUMExF+8P36328/73Vcv1ISTXgFmCHfuWoKBtihsXATmn4odDyT07SE=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr14464571iof.266.1532963211593;
 Mon, 30 Jul 2018 08:06:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:06:51
 -0700 (PDT)
In-Reply-To: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532508374-28957-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:06:51 +0200
Message-ID: <CAPDyKFrbyiYhj_Q_hWCoxFG0pdg805ors9CuNm8Hb7Xh+2Wksg@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: remove unneeded variable in tmio_mmc_start_command()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 10:46, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Pass TMIO_MASK_CMD to tmio_mmc_enable_mmc_irqs() directly,
> and remove the variable, irq_mask.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/tmio_mmc_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 3080299..3cb554c 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -309,7 +309,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
>  {
>         struct mmc_data *data = host->data;
>         int c = cmd->opcode;
> -       u32 irq_mask = TMIO_MASK_CMD;
>
>         switch (mmc_resp_type(cmd)) {
>         case MMC_RSP_NONE: c |= RESP_NONE; break;
> @@ -349,7 +348,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
>                         c |= TRANSFER_READ;
>         }
>
> -       tmio_mmc_enable_mmc_irqs(host, irq_mask);
> +       tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_CMD);
>
>         /* Fire off the command */
>         sd_ctrl_write32_as_16_and_16(host, CTL_ARG_REG, cmd->arg);
> --
> 2.7.4
>
