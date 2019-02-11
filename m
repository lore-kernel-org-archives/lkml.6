Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668C5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE1F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHUQunYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBKLcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:32:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKLcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:32:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so4823995pgk.10;
        Mon, 11 Feb 2019 03:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLzq7H6qzcGqyLv4myMisOnBFNrhiPgTl3LawcpFBhA=;
        b=SHUQunYQ0bTe7K6jZxvKmeHCU0Ua/TR1KxbnybFgUFyZMbna0WjbVG9p0sVriAaj5D
         PFWTiLfyRfILrMSD+rc7AjbgZvLj4OnWhae9PLiLu0jOhvoCcElT6jytVaeeSzv+ag2x
         ju51GtLa+XtXnCiT8/hkKSIG+N+z1Grw5nUlD9a6o4MiVmgnUW5sQT+uRkops+Ymx1II
         DTfKW1CTTt2mfKd3IC6AUZDk2NPprMWkYv9ItWtGFMR4C9VSfNZVFJGN30HBTkQXa9Jo
         sp6wrST1LxJhKJ9TF8Ul1F6jv9RmBCnYO6H8nTCUR2W89W5G6/6714VqNb0iqjpq44eL
         XUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLzq7H6qzcGqyLv4myMisOnBFNrhiPgTl3LawcpFBhA=;
        b=KZmDPYOQrIYNOsRtOq4IaCB67LoCynfIiYy/DCJqPPqUA0FLygOdPpagw0hZw6Wd/N
         95aX32VPvyfqlOaeD0Hv5VD+pUbleUaxKzxaRl3GbEpFIM8vx5YXjiSewD1jugJcYhh/
         kl/DNlWM4leIChbbL2e3lQVrtkXY5Z/GIJ6eQv/Cwe8WSbsIgPBiMyeZXKE6cfNtDWJp
         7fkjWZjY21NoEuYawerm/nR1HkNEoa/wjXdpT53ltd/UL4E0gBKOV3enoRsjP1yGq8uA
         Fa0VBgTB79Dv53mTZvSJH/SpRRyeeKTFjRUblqpHuRJJJwGO/zwFeOiysgtFcHXS9qwa
         6H9g==
X-Gm-Message-State: AHQUAuZaRyRZSAl7Iw6J4ky6SEuulqt12JrkCRPlQYSE+GPAfAwavfBM
        9UwCvdax9TBDz5HXqSmQLj9Y749yXjcK6jmVTI0Zzlii
X-Google-Smtp-Source: AHgI3IZMxKEe4MJwdTzUAkmzM6t5YlhGWLd0qoXyru3sNtyEUlxtzZpqKy72CEGOrVGlAIoH5xRXaxE6he4iyK3nr80=
X-Received: by 2002:a62:5e41:: with SMTP id s62mr35926820pfb.232.1549884729940;
 Mon, 11 Feb 2019 03:32:09 -0800 (PST)
MIME-Version: 1.0
References: <16ce109c-69a3-1f27-7fd4-9b99c9780565@infradead.org>
In-Reply-To: <16ce109c-69a3-1f27-7fd4-9b99c9780565@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Feb 2019 13:31:58 +0200
Message-ID: <CAHp75VeLCFD8EKG+hHGNUyoE9VJrFEgTvv9aD23NH49n6SMOgg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix lg-laptop.rst warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matan Ziv-Av <matan@svgalib.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix markup warnings by inserting blank lines.
> Also correct one typo.
>
> Documentation/laptops/lg-laptop.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/laptops/lg-laptop.rst:16: WARNING: Unexpected indentation.
> Documentation/laptops/lg-laptop.rst:17: WARNING: Block quote ends without a blank line; unexpected unindent.
>

Thanks!

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matan Ziv-Av <matan@svgalib.org>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  Documentation/laptops/lg-laptop.rst |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- lnx-50-rc6.orig/Documentation/laptops/lg-laptop.rst
> +++ lnx-50-rc6/Documentation/laptops/lg-laptop.rst
> @@ -1,4 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0+
> +
>  LG Gram laptop extra features
>  =============================
>
> @@ -9,6 +10,7 @@ Hotkeys
>  -------
>
>  The following FN keys are ignored by the kernel without this driver:
> +
>  - FN-F1 (LG control panel)   - Generates F15
>  - FN-F5 (Touchpad toggle)    - Generates F13
>  - FN-F6 (Airplane mode)      - Generates RFKILL
> @@ -16,7 +18,7 @@ The following FN keys are ignored by the
>    This key also changes keyboard backlight mode.
>  - FN-F9 (Reader mode)        - Generates F14
>
> -The rest of the FN key work without a need for a special driver.
> +The rest of the FN keys work without a need for a special driver.
>
>
>  Reader mode
>
>


-- 
With Best Regards,
Andy Shevchenko
