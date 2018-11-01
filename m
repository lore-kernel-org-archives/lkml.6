Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A48C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178C420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kefc4CO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178C420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeKAWlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:41:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45200 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeKAWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:41:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so21023067qtj.12;
        Thu, 01 Nov 2018 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuTM7sGgHhD8wQ9YZaORRLHinF9WKXho2xHRzXJox0M=;
        b=kefc4CO8HWx6jl2LZxK4T/wtgpykW4UtwjaPddq50BLqDT7mExQgrdH0gutYeF6jc6
         zq2sxdYh9H1GW0FzTmfOsm22mLiudJEAil8M+sxIPu/tiyha3tVjydeFuumPhwqzZm9Z
         R2i/3XzNLf0QKzpEMh8q0EyKZktR8Pj9kqnQoIhOtrkbHZOF1QZIXEnyEtwhgb+qsQeh
         98MCfGLbJx3GqL0l+ze0QXqbVANPuI94lCzCCskdKBTVgpt6UZdYdLP0ljVijlplJuTd
         fRILQRmRE1g3A5EJ/HR8NWQWOcBxs1gpi9NIagGQezDehPmevqxJuEF8bNNmYMsXOeB1
         t5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuTM7sGgHhD8wQ9YZaORRLHinF9WKXho2xHRzXJox0M=;
        b=F0q+canzvGuKs6y1p6kczBZDKn50p//9miRhGiMy+4VLY5r44gnyOriqHardzolDlR
         7qHnNs68XyQWbZvJzmdfPfTzsRetL7SmD7rpjMHKRnYUlq3kDYeQm9EE72KM6PxRTQSG
         SC+3pFDzj3GJDMkB51BQQIfhiLKQ+0TlDFEMD5TlnK9LeYYkbU9n3ItObhdUWS1q2iOO
         UfOTXyJISO2sGEKtAPFcFL6AcSffAiLB0TYzYmvotcZmgnh3vFGPaUmbwqQOPjdBHuHR
         Uc9SEGmC45AGAE5Fl7IDj8ys6S+G6HHI28akpE4La+I+tkaRfyGPmri/laK+9gOeGETr
         TNNw==
X-Gm-Message-State: AGRZ1gJScafYWYKG1dA/GuiY2T9jtduwjiAhm/1Pzrqqex/3pnNegSXc
        HbLFF8pX1xYO5R4UXzNODwS60VHVboDY2ny0EZs=
X-Google-Smtp-Source: AJdET5d2yUTvwkC2ugstAvEEo92NYRXUc0rDzt5PrwH4HBgIb+suc9/F9sANBTnkipt7RUGlR07apEoECIKzTokuihc=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr6468488qtj.327.1541079516292;
 Thu, 01 Nov 2018 06:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
 <1541085002-42993-2-git-send-email-peng.hao2@zte.com.cn> <20181101113355.z6l3l33buhcpukl4@lakrids.cambridge.arm.com>
In-Reply-To: <20181101113355.z6l3l33buhcpukl4@lakrids.cambridge.arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Nov 2018 15:38:24 +0200
Message-ID: <CAHp75VdTzFJ9ggQ+eMn-bAfbtXC4w69R+7UjYvWom6ALV9NfPA@mail.gmail.com>
Subject: Re: [PATCH V5 2/8] misc/pvpanic: Remove one extra semicolon
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     peng.hao2@zte.com.cn, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:34 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Nov 01, 2018 at 11:09:56PM +0800, Peng Hao wrote:
> > There is an extra semicolon in pvpanic_device_ids, remove it.
>
> This is a comma, not a semicolon.
>
> How about:
>
>   Since there should be nothing after the sentinel entry in an
>   acpi_device_id list, it doesn't make sense for it to have a trailing
>   comma.
>
>   This patch removes the redundant comma.
>
> ... with that commit message (and the title fixed to say 'comma' rather
> than 'semicolon':

Agree on this, but...

>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Either that, or simply drop this patch entirely.

...point was to gather style changes here, like moving linux/acpi.h.

And definitely the style changes should go last in the series.
If you decide to leave this patch, it would be 8/8.

>
> Thanks,
> Mark.
>
> >
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> > ---
> >  drivers/misc/pvpanic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> > index fd86dab..059005c 100644
> > --- a/drivers/misc/pvpanic.c
> > +++ b/drivers/misc/pvpanic.c
> > @@ -35,7 +35,7 @@
> >
> >  static const struct acpi_device_id pvpanic_device_ids[] = {
> >       { "QEMU0001", 0 },
> > -     { "", 0 },
> > +     { "", 0 }
> >  };
> >  MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
> >
> > --
> > 1.8.3.1
> >



-- 
With Best Regards,
Andy Shevchenko
