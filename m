Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5CD2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J2S7zlBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfA1T2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:28:16 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33739 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1T2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:28:15 -0500
Received: by mail-yw1-f68.google.com with SMTP id p65so7222413ywe.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXqys+F8VNcO6urF4x5LaRyjeKzfHx52VPwVu/rPMH4=;
        b=J2S7zlBbMS/lJP7dE3EbZj3UvKwS66lNgsU5D9p/7yg4KDTgTfSUvrfDbO7thamxMa
         EavbE4dlkAKWB9HSzDFql1TBzOrL1GOwFedXXbji/E3+wed4Pa1q6sT5MIApE7gD2fxs
         c/izQCyhNc4ZbO8/dSDNFZwnm3+7AJLn1YDxDBzC+2RDgdzAgAHEIn7ZhCcu9R7MXru9
         aC/xTOVXkdftBztxdlgNOfarMVThkxbO2vMcQWHwU8TdhEDlV7YftkncCv657/L0BfGe
         LKZ8g0ijijH0t833jX10UmV9eE1zcVtg3hd3zjGTIxS/VXOiWpIACdbCf7Jjbu9jpZtn
         DFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXqys+F8VNcO6urF4x5LaRyjeKzfHx52VPwVu/rPMH4=;
        b=KS7yL2YWbZvttUk/EbY3rbI9dsRU+0FLEIVzsiNdNYdiLT4QBkxkNya+c8gNVYK44j
         poZw2bo4N3RzzSMx4Y2a3lXsInJScdVLKNr1E05IIv0InU7unosV9g8PaDWWLBwgN/ZJ
         dHzzmXZwBWjRdq0rS4UN60maKJRSgPr5Uq7PfCs7r8yFVChKSuDTnHjid1eQz8l5Tb9X
         Ot/tCVhbQT8CXBk+WKXfeM+LEMBo/qASL9c8VgKF/LVZMG1BCKF0r60yQQJKMu0nFzhI
         oO7carSyHCF0rcs6VDb/p0AI6nor9s6MaKa4Rhik3gcn6kMN1FfsHbmHf0zGcOMboXTO
         e++w==
X-Gm-Message-State: AJcUukcXj6/XL5+Xsyylrp+WjW1GFppCPL3IpgEIZn8XTjhxTiFS6rRX
        MqqR55j4zLnC1zBLwiXKfTsCWyIFh3zNeuvotrP9dw==
X-Google-Smtp-Source: ALg8bN6GxxqpUoZWxmJRWVqYC3IYKjSRiIPaE1Mrb08fjS0xewEZvvRuJtz9bPGC0XjtnWtglqAaybMhF2G/MeSA1cg=
X-Received: by 2002:a81:ec12:: with SMTP id j18mr21117867ywm.17.1548703694063;
 Mon, 28 Jan 2019 11:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-2-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-2-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:28:02 -0800
Message-ID: <CABXOdTcY4TyiVzjaDCs4TiMpku5xF36s2B+PfY1=5tP4pWjeeQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] platform/chrome: cromeos_pstore: switch to SPDX identifier
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 1:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management. Also fix the module license mismatch and change the term
> 'Chrome OS' for 'ChromeOS' to be coherent with other drivers.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2:
> - Removed the patches that removed the unnused includes (were wrong).
> - Add patches for all files in platform/chrome that didn't switch yet.
>
>  drivers/platform/chrome/chromeos_pstore.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
> index b0693fdec8c6..d13770785fb5 100644
> --- a/drivers/platform/chrome/chromeos_pstore.c
> +++ b/drivers/platform/chrome/chromeos_pstore.c
> @@ -1,12 +1,7 @@
> -/*
> - *  chromeos_pstore.c - Driver to instantiate Chromebook ramoops device
> - *
> - *  Copyright (C) 2013 Google, Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation, version 2 of the License.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Driver to instantiate Chromebook ramoops device.
> +//
> +// Copyright (C) 2013 Google, Inc.
>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> @@ -138,5 +133,5 @@ static void __exit chromeos_pstore_exit(void)
>  module_init(chromeos_pstore_init);
>  module_exit(chromeos_pstore_exit);
>
> -MODULE_DESCRIPTION("Chrome OS pstore module");
> -MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS pstore module");
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>
