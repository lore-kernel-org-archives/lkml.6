Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51EFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FA020657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8q//14y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FA020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJ2Wi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:38:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34648 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeJ2Wi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:38:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id z2-v6so9246505qts.1;
        Mon, 29 Oct 2018 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y23NbwmZ2nljHa//mgsjD3PEO6d9VhL85U2ozlmq6Sw=;
        b=H8q//14yozakf7H9aTktKFa98g8RFLWpK00AZsx9pbTKHy11YpeSGwXuoZMb5Z5qPv
         r3v8y938dbtVuyq4gNMUylnGlof9oo7OLM/Ef78cIRSBadpTfm5jV0xNdN0f86bcLBOt
         IXzuEEhw3Z9E2qzfHCuv93/kxRfcP/32oxzk2HdQea0+aVPAw5N/1l0qal7ldkqiUAOT
         NBsyFhUMUJob6RBLYiSaTXKim/N5punJrPZt6UdjE0gVB+lZPeBXvfHEfxOQW2HJsJeY
         6lqkAJc+SriblWF017wAHOfNqIvqrrFL2JsD690eDcOpwaCPOM7A3a9uhfbLrcE9BnZo
         Ti9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y23NbwmZ2nljHa//mgsjD3PEO6d9VhL85U2ozlmq6Sw=;
        b=KAMCeeoMG4LxafWRCpEHaqk9H+lU0NXeqor5x+F5ERCTA710wvhtm+WHnt9ypkWxnB
         pSdPX11psh/Ayx7CC/bxfEsdZqwowbT+SN0JO9z7NCeTcIiABVsvrGTyueDR7guRraXi
         i83wO/iej8xBXfKjG3rc/yKdUKilP2yszoX8IAXErth/IqLaUAVftz5imr1an/dW7cS7
         unMMMyQfYtXORKCR/Eg7tPUQ+2d3V2g0vl+FR8SRm8R00lwkE7onrCmUam7hGI8qVMi3
         B/swQhXq0t8G4ZVuYv4O0AqNv87qRoOa03wSqxt2LMUKotNhrcFcWy8u772Idk4D+gQi
         PM1g==
X-Gm-Message-State: AGRZ1gKbqBgDK3yTNas9TyvSLyuq8x1jzP+OOSue02OsD6eLRroURzyn
        RiMJxT+foKPgontO5a3jqFD4Zi/zG+6KGOfyoF2UrkGPr9g=
X-Google-Smtp-Source: AJdET5dzYKHCHvvGwUYtkvji6Jef/bxrb0EjIltz+aNB+44rcq8w6hD/s/5VVEvwfd/DyH6suTKLyK/9ymMLFGOhpxI=
X-Received: by 2002:ac8:764e:: with SMTP id i14-v6mr13074270qtr.373.1540821013182;
 Mon, 29 Oct 2018 06:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181026230723.12215-1-zombah@gmail.com>
In-Reply-To: <20181026230723.12215-1-zombah@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 15:50:02 +0200
Message-ID: <CAHp75Vdqm8ryJMRnOdsWd7Y8AKGLSuXDOgL37q-UE+_0S356FQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad: Add Y530-15ICH to no_hw_rfkill
To:     zombah@gmail.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Ike Panhc <ike.pan@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 2:08 AM Misha Komarovskiy <zombah@gmail.com> wrote:
>
> Lenovo Legion Y530-15ICH is another model without
> hardware radio switch. Add it to no_hw_rfkill to
> enable wireless.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Misha Komarovskiy <zombah@gmail.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index f856d59361f2..b6489cba2985 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1147,6 +1147,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
>                 },
>         },
>         {
> +               .ident = "Lenovo Legion Y530-15ICH",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Legion Y530-15ICH"),
> +               },
> +       },
> +       {
>                 .ident = "Lenovo Legion Y720-15IKB",
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> --
> 2.13.7
>


-- 
With Best Regards,
Andy Shevchenko
