Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C5CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86670208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlWnR2kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86670208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeFUNT1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:19:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52632 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeFUNT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:19:26 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so4616442itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxLEDntwfK97HviszUO+jw8FleRLw9KuH/XFF0ZYA+Q=;
        b=TlWnR2kSMhn7LA5bNjx+PY665VZV7HjDVSONM66/aiwT1tGTVm0vLJt6S5Nj77rmMs
         O9bqQuh+FLabPk5NLi05dROagYlEhMlxdzV3CfPeXfTBDQnHsJA+Co9SLNX371W/6JfP
         cujlCpc/3axWscNXyHslXBD/zK9WyYzoq5yNTsHsEi0Qti0okXrCiZ8o6rJtBcq9bgK2
         +NoeP3E83ZMg10D/vq/lkGaNy1WtQYhGDexcq8SSnNnvTU9et6hB1UVVYtAsftMg6QdK
         /kXi45icOWS9OzEjeUmqQfptTGisl6RXhi3dMPndakf6k+8h2l+u0uP4OP5WysM0/Gfe
         jRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxLEDntwfK97HviszUO+jw8FleRLw9KuH/XFF0ZYA+Q=;
        b=l/vz0g7sOaFZzGppv10h5D7B2MiE3BwLZNyLDCRyZjMJ/93ejCS3CCCidrR1M4WNXq
         gQMa8K+VcA/6Pql/myZhfg9Z8mkg8tZN+F59jrGgpg+uvKsxg5Fjq8d0Zlagylf16szA
         T6Ry05xMu/M6hDy0SY0mRDqHprpEzsAE/pVK9MrE/sZSCTKz4vqJztOzP1NYEXxDBy5B
         thBSoGJnFr7NWO4sYfLbPQS4xid0kG2wI2KMSoE1ElJ4Ez0xDkjL2v8w5iJWUAamQ1D9
         +E+Gp6TYBmtxbFvIlNXYDtAB56OJ4pCLACQgzrx/Lw9CEdPoCBZNvFD8UxV2O7tgbIN8
         qKcg==
X-Gm-Message-State: APt69E0ZDMzGSEqxAJKRPDO6Xof0GpwGvaGoMgvYreov8xiZeVfuZ/hj
        5juhtetyY5cRF0fmGWwc8pZjS3TrFtM+0phqpSQ=
X-Google-Smtp-Source: ADUXVKIiuiOTcTL96DyHhD7UQLz6vae/7FVOVMl0yjtavqrm4oyujVyIJJvCr8kYK3eAWYCjcKWPPm1c7J66BmD5X5c=
X-Received: by 2002:a24:a501:: with SMTP id k1-v6mr5063749itf.79.1529587165425;
 Thu, 21 Jun 2018 06:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180620182600.GA24297@beast>
In-Reply-To: <20180620182600.GA24297@beast>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 21 Jun 2018 06:19:13 -0700
Message-ID: <CAHQ1cqF9so3TSHpLRvtUDtrxogse_dhVzs_H1MB+G=bB6GfA=A@mail.gmail.com>
Subject: Re: [PATCH] nvmem: rave-sp-eeprom: Remove VLA usage
To:     keescook@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:26 AM Kees Cook <keescook@chromium.org> wrote:
>
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the maximum allocation size for the stack and adds a sanity check,
> similar to what has already be done for the regular rave-sp driver.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I completely forgot that I was using VLAs in this driver. Thanks for
fixing that!

Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

> ---
>  drivers/nvmem/rave-sp-eeprom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
> index 50aeea6ec6cc..66699d44f73d 100644
> --- a/drivers/nvmem/rave-sp-eeprom.c
> +++ b/drivers/nvmem/rave-sp-eeprom.c
> @@ -35,6 +35,7 @@ enum rave_sp_eeprom_header_size {
>         RAVE_SP_EEPROM_HEADER_SMALL = 4U,
>         RAVE_SP_EEPROM_HEADER_BIG   = 5U,
>  };
> +#define RAVE_SP_EEPROM_HEADER_MAX      RAVE_SP_EEPROM_HEADER_BIG
>
>  #define        RAVE_SP_EEPROM_PAGE_SIZE        32U
>
> @@ -97,9 +98,12 @@ static int rave_sp_eeprom_io(struct rave_sp_eeprom *eeprom,
>         const unsigned int rsp_size =
>                 is_write ? sizeof(*page) - sizeof(page->data) : sizeof(*page);
>         unsigned int offset = 0;
> -       u8 cmd[cmd_size];
> +       u8 cmd[RAVE_SP_EEPROM_HEADER_MAX + sizeof(page->data)];
>         int ret;
>
> +       if (WARN_ON(cmd_size > sizeof(cmd)))
> +               return -EINVAL;
> +
>         cmd[offset++] = eeprom->address;
>         cmd[offset++] = 0;
>         cmd[offset++] = type;
> --
> 2.17.1
>
>
> --
> Kees Cook
> Pixel Security
