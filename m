Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E68FC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442302064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPKA2SgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442302064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeJXVhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:37:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38307 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:37:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id p3-v6so3064339qkb.5;
        Wed, 24 Oct 2018 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2WA/9dXCgE1Z+b9KaL6pyu0pVHFn4CmbwE6KMoMHL0=;
        b=nPKA2SgSqP9+PyL+gMlMj0v1Dfl6mHpaB37klTd00cYWvjV8laPnLkR1xBkzooH5R5
         /ETQHLqoSTY+nRAoztayOcStYbq8Dw5cMkEpPE5IEjoFYDTHW1k3LOtxF9HOUwb/rvx8
         1bi0QUdIUH2kR5C2CErJfdRfDKtw/xJXkUqempyrbbxRmtUNWfOAq7X4hyvT/q/4mDbr
         AWp9zA/OXpXv0B1bb8Qr92rrZlcX0OQCcRiwh37c5YkRhEQKDLYkXjupYbpLbZdwGvk4
         I/FpiUDe2odzygL8MieOoItq8LWQQ05bhhLHH2usYXvM7R5molAdysweoy0OoqSbB3hS
         0OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2WA/9dXCgE1Z+b9KaL6pyu0pVHFn4CmbwE6KMoMHL0=;
        b=KsRdoiud3oimZqTHGIYSMMzx2c15bJIa9E558U2c9avre9QBI0X1ijHV6mvbbi8LQE
         jpHa31P+yQd+dt4wAdhEHcMBIqIS1oWA5YmsbXLsQPG7qIC5pmyiGPUYW39ZZBtxo4zn
         O9NQG/wNDraU/WcITx7fLQMoVVKBEx34B3bwWHiJ1Ay6UWVpkBz+mCFAZ909jb6RqYk+
         ifbd4ASh9mJjtJRr522yfNG5doeBQzfD9nZqfoTC4yfB9xk2f6Qp06jhS+1G7bfCw+NV
         o3FkRoLtInz3wgwKA2HzdrxFt0VY8jGEHtpstKoatdJ1YQ+XMmZIwPfqs3SRNuDuqcAU
         zXDg==
X-Gm-Message-State: AGRZ1gIQyWuIGj8HQhWHzPpjOUhPcIGQjBoDuzz45tnzHn1d2Bg78+Sy
        0FkpADshdXTKppSDyaVn70xURgLE0Pj5TwjlIAI=
X-Google-Smtp-Source: AJdET5fzheOV0LbAqrL2BJ6+J396OfJFVpKd9vkm1bCCOPNhxoRLIioi9H0Yi57o8Xm+7+rkUW/kBtb90PddXg0IQLI=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr2275047qkg.70.1540386567574;
 Wed, 24 Oct 2018 06:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1540401136-78500-1-git-send-email-peng.hao2@zte.com.cn> <1540401136-78500-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540401136-78500-2-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Oct 2018 16:09:15 +0300
Message-ID: <CAHp75Ves+GCP8ZfOCXDcZNkyEo31hiPTyarRoYvhkjHeV+9dug@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:02 PM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> this can be used standalone. Add MMIO support to the pvpanic driver.
>

No global variables, please.

If your switch to ioreadxx()iowritexx() it would really help you here.

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index fd86dab..bcfefdd 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -43,6 +43,8 @@
>
>  static u16 port;
>
> +static void __iomem *base;
> +
>  static struct acpi_driver pvpanic_driver = {
>         .name =         "pvpanic",
>         .class =        "QEMU",
> @@ -57,7 +59,10 @@
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -       outb(event, port);
> +       if (port)
> +               outb(event, port);
> +       else if (base)
> +               writeb(event, base);
>  }
>
>  static int
> @@ -77,6 +82,8 @@
>  static acpi_status
>  pvpanic_walk_resources(struct acpi_resource *res, void *context)
>  {
> +       struct acpi_resource_fixed_memory32 *fixmem32;
> +
>         switch (res->type) {
>         case ACPI_RESOURCE_TYPE_END_TAG:
>                 return AE_OK;
> @@ -85,6 +92,11 @@
>                 port = res->data.io.minimum;
>                 return AE_OK;
>
> +       case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +               fixmem32 = &res->data.fixed_memory32;
> +               base = ioremap(fixmem32->address, fixmem32->address_length);
> +               return AE_OK;
> +
>         default:
>                 return AE_ERROR;
>         }
> @@ -104,7 +116,7 @@ static int pvpanic_add(struct acpi_device *device)
>         acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>                             pvpanic_walk_resources, NULL);
>
> -       if (!port)
> +       if (!port && !base)
>                 return -ENODEV;
>
>         atomic_notifier_chain_register(&panic_notifier_list,
> @@ -118,6 +130,8 @@ static int pvpanic_remove(struct acpi_device *device)
>
>         atomic_notifier_chain_unregister(&panic_notifier_list,
>                                          &pvpanic_panic_nb);
> +       if (base)
> +               iounmap(base);
>         return 0;
>  }
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
