Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC07C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D619218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD2fA6ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAXVdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:33:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35003 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXVdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:33:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so3501920plo.2;
        Thu, 24 Jan 2019 13:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EM0TQLXzPNTmtvpn4fAchwz+4uGmD+ivBeMLTEQyFI=;
        b=iD2fA6ZEdqpN11e7zjsPXWTYN1ZOEDJYBgLTqggnYF4LTXjspz2QB0OFPE4/Zp+jHa
         3NFZss96Ls6NpjOLD7gT99l3Xr6xSGwfDmKxt+TxvODi/Cr9zj0lkuouNu2EF55VzU1s
         dba1Jvpkx4SRu1ClYhpg5RsUCsWHuR/xCObYAYi+gpukobIt6UWTYi7ZB17EOvzq9WIT
         S7OycizgyjLOm/IAW9XSdjc74GjUZnkC0vpEPTmLHGfr1OXVKSk2E3Gtvu0OSRSz+tbJ
         Q+a1ki34wOGATcAiaahVA+yM7nDXOWg2Eow9AC67lJx058/xYlOkWvbNMGMKCAB502Ld
         UAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EM0TQLXzPNTmtvpn4fAchwz+4uGmD+ivBeMLTEQyFI=;
        b=epYd5G0+c4mJNQMKDtne71QYrxgF4UM4/jvGApd3G8uWWC5yodWOvyiDZ0mhRBXFT9
         /0sRlD5dyP37GUKexyvHxYt+I7Imm0mKBgVTXuy9Ii4cpdL0Ra3ockgpdioaofi9NLZp
         d+ZyWjMPSu7WORngp8uDiRs0Q5g+MFIA8eRzFGdDvWMl+V3S8nB5aF941TpdfeJj9XvS
         MCBTP+4XP4dpEKwJVCjLm9ZPv7fPQ3exLjWcHGfu8rbjP8+UWQR3g7y9euzQk3698jlj
         gCE29e/F4cOyIshQjFnYjgYo3TIoAbN8Z5yYi90EKukZcUNjv2F89s9wPk0G6iDaVo7r
         WU+w==
X-Gm-Message-State: AJcUukfxsSfad+4jWiMxGRDNsrTfQ7hUY8HMZabpBLUwpjhGL1Dv0wni
        7w57Q49R/Uc0LhxbPOxHoQOMdo0dlVaJ9qXWcwU=
X-Google-Smtp-Source: ALg8bN72mxKNYD6X/61hCdfUbJC5uegKRAsW/kPoimstpXxZcNuj8q6WNBC1nweznewKso2uIzDu61gq7h/DTRJ+AaQ=
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr8289274pls.12.1548365587890;
 Thu, 24 Jan 2019 13:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20190124193101.24519-1-okaya@kernel.org>
In-Reply-To: <20190124193101.24519-1-okaya@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Jan 2019 23:32:56 +0200
Message-ID: <CAHp75VerwCxYqozQmaJZL8tcbfDFLBp+nTheP0Ran4qWPqTcLw@mail.gmail.com>
Subject: Re: [for next][PATCH v3 1/2] platform/x86: Fix unmet dependency
 warning for ACPI_CMPC
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 9:31 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
> warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
>
> ACPI_CMPC selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
> depends on BACKLIGHT_LCD_SUPPORT.
>
> Copy BACKLIGHT_LCD_SUPPORT dependency into ACPI_CMPC to fix
>
> WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
>   Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
>   Selected by [y]:
>   - ACPI_CMPC [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n)
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for both patches in case Rafael takes care of them.

> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5e2109c54c7c..11810591840d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -905,6 +905,7 @@ config TOSHIBA_WMI
>  config ACPI_CMPC
>         tristate "CMPC Laptop Extras"
>         depends on ACPI && INPUT
> +       depends on BACKLIGHT_LCD_SUPPORT
>         depends on RFKILL || RFKILL=n
>         select BACKLIGHT_CLASS_DEVICE
>         help
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
