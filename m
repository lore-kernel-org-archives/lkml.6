Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD8C20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZFPjS6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfA2OnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:43:06 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38719 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2OnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:43:05 -0500
Received: by mail-yb1-f193.google.com with SMTP id x9so8241750ybj.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQ0zmxnQA+VDsZt6oEB7dC83/E7Za3Z7DPHdWzyDSrY=;
        b=bZFPjS6F9+kxzb9rrax7M/OIbofdRzVLJTZSVaqZfurQNEF1HX+0OoOM+kvBP/NBPY
         uSu14UL97zIO47Lz4ThWhzwX9lmO27PaIHl3eEAhEBHdCuTejgO2Y7VLlCyvHhc+828F
         aihbi5jsVC6frVIP3FwRjEeEZG2lT9KKxFcTMWCS1wFRKSsOi3MTDgXltdnYUdkUDfef
         DJf7RgJY4I1M+TbecRmnEMIja1kZBLxfUC6x+0yTuTe98rXR9WF1yLWIU6v2T6V+oH09
         6gWQRJIDmUBlaH8QNYBKh2Ilq9gkl+frF/822vQ3YpjgSkix2wKKKioe63uhG0dYctjP
         xV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQ0zmxnQA+VDsZt6oEB7dC83/E7Za3Z7DPHdWzyDSrY=;
        b=iSp9sctpZKEdnRma1ZonEjmFUpXIEe1Q4sr2Mh4IoPvrgyPUtag8wEP7yiHctXw7+K
         nD9wQjuImuw2PtlsFIeRT9+Ivn3dpFDY90w//L7znqPSDsQem0mQBkpXI+6B6fNqyoh5
         JSqBW5o8ZC6VCSFxd3w+9BgUakmFlMZX9aPO38BSOfryBWKgTWvpADxvT6q41wIZR+SB
         L9izDppH9sjHjIlfzHKG+cLP1XJvUjbsbPe+dvXX9F8A0lN5vfDNUo6eLgbJto7ptEoj
         n0o/MkRzjp3YwDeHPhYB1s4lza8kFBkpsF7TRm2d5RuqcbgRu3tr4wMZh74rJ4OYkpyc
         kmTQ==
X-Gm-Message-State: AJcUukeGwP4DsQgA7GozKUU0NVieDClpAxSsmrkMVONtUCo895LgsP4h
        qSoQTB6If3ck6tpAeSknY0QeMO33J2r3UjUrw5Akhg==
X-Google-Smtp-Source: ALg8bN7/XHMRMeDxsuaCaNu2tdN9KrKUqmfdCFTVTzYb63k8qewVuMDYtIQymtmhUBSjkSSEzdbyfD73WE1CR060GYo=
X-Received: by 2002:a25:8685:: with SMTP id z5mr24752229ybk.247.1548772984339;
 Tue, 29 Jan 2019 06:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20190129093823.27137-1-enric.balletbo@collabora.com> <20190129093823.27137-7-enric.balletbo@collabora.com>
In-Reply-To: <20190129093823.27137-7-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 29 Jan 2019 06:42:52 -0800
Message-ID: <CABXOdTeTTQtOJdp+9xQO=itm8XT8w_y8ju+ADW6nuw5KMkkzdQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] platform/chrome: cros_ec_i2c: switch to SPDX identifier
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 1:38 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management. Also fix the module license mismatch and change the
> description for a more descriptive phrase.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - cros_ec_i2c: Fix SPDX license tag.
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_i2c.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index 739b985c97e1..419d1b9fa143 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -1,17 +1,7 @@
> -/*
> - * ChromeOS EC multi-function device (I2C)
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// I2C interface for ChromeOS Embedded Controller
> +//
> +// Copyright (C) 2012 Google, Inc
>
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> @@ -373,5 +363,5 @@ static struct i2c_driver cros_ec_driver = {
>
>  module_i2c_driver(cros_ec_driver);
>
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("ChromeOS EC multi function device");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("I2C interface for ChromeOS Embedded Controller");
> --
> 2.20.1
>
