Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1762086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OSWJEYl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAOBJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:09:20 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41612 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfAOBJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:09:20 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so652310vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkIQ/9hYjANw09B4at4a2YNZYz9LnIP9Tf7Zt75VHwA=;
        b=OSWJEYl6qHvBwnJh9ebHRfJocRCDr7jSMfFzpozemT5LbGaEgla69mDuam3HyddHQ2
         HBELgb0jQbNH4XKfOn9f8pT6bfu829XxByLmvsDx4brC3K0RI0BpfNQ157ebnPbqnspl
         zP7vRy9BqSvPs5v7ytrVhy9DML4ZyB91g9Cxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkIQ/9hYjANw09B4at4a2YNZYz9LnIP9Tf7Zt75VHwA=;
        b=oyNoh+FPxtCPlcKv/boiPtIGAlhlcozNnm2xvaUnMpL+9oA2T4UA7RgVvC9gwXSfzq
         htbBO4iowD+T3fGrRw8W/DlbGGBrijZbMN2T8ZzJg70JSBAfkQjriiU/ZbbtjASfm6OE
         kxZjJD+I5ogIhBZnIe9+JUilwHuV2qFrO3tRFCKwt/MoC7HSy9GTarE+on49qsOJrAGu
         D44bYlUk+e2WZBUUTy8g58HGVObVyI0EC+UbX30X+S+uF90PmCDWYb3KjWPZ8RWvnRpu
         5qRibdJbWZT07oZpKwsmNwJLiMiqJmr5GMOrkhusZQdRTyDvJs3PKVu34Wd4TO/55xWs
         1C3w==
X-Gm-Message-State: AJcUuke2fcnJUtABCtIEuFoQ9edTSVaU/cbc3uUsHuku2/4/z680GGis
        vtqe/uutKGg9CALibNXAMi3pOCqRZBU=
X-Google-Smtp-Source: ALg8bN5p1RW8ICbR7iT/RRWsmTCg0JQEwmAIr5KD+h/S76DnE7kQhn90pEpTPVjB0wl40+K86XA0pQ==
X-Received: by 2002:a67:8150:: with SMTP id c77mr573365vsd.233.1547514557966;
        Mon, 14 Jan 2019 17:09:17 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id l197sm54755010vke.18.2019.01.14.17.09.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:09:17 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id x28so634756vsh.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:09:16 -0800 (PST)
X-Received: by 2002:a67:2c13:: with SMTP id s19mr567937vss.172.1547514556337;
 Mon, 14 Jan 2019 17:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-2-w@1wt.eu>
In-Reply-To: <20190112152844.26550-2-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:09:05 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKQ9WFHFyhZwmLPki4hQcjsiyXoirnndVvA2yfDQ+yT-A@mail.gmail.com>
Message-ID: <CAGXu5jKQ9WFHFyhZwmLPki4hQcjsiyXoirnndVvA2yfDQ+yT-A@mail.gmail.com>
Subject: Re: [PATCH 2/8] libertas: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  drivers/net/wireless/marvell/libertas/debugfs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/libertas/debugfs.c b/drivers/net/wireless/marvell/libertas/debugfs.c
> index c83f44f9ddf1..ec73bd3a10db 100644
> --- a/drivers/net/wireless/marvell/libertas/debugfs.c
> +++ b/drivers/net/wireless/marvell/libertas/debugfs.c
> @@ -41,9 +41,9 @@ static ssize_t lbs_dev_info(struct file *file, char __user *userbuf,
>         if (!buf)
>                 return -ENOMEM;
>
> -       pos += snprintf(buf+pos, len-pos, "state = %s\n",
> +       pos += scnprintf(buf+pos, len-pos, "state = %s\n",
>                                 szStates[priv->connect_status]);
> -       pos += snprintf(buf+pos, len-pos, "region_code = %02x\n",
> +       pos += scnprintf(buf+pos, len-pos, "region_code = %02x\n",
>                                 (u32) priv->regioncode);
>
>         res = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
> @@ -105,7 +105,7 @@ static ssize_t lbs_sleepparams_read(struct file *file, char __user *userbuf,
>         if (ret)
>                 goto out_unlock;
>
> -       pos += snprintf(buf, len, "%d %d %d %d %d %d\n", sp.sp_error,
> +       pos += scnprintf(buf, len, "%d %d %d %d %d %d\n", sp.sp_error,
>                         sp.sp_offset, sp.sp_stabletime,
>                         sp.sp_calcontrol, sp.sp_extsleepclk,
>                         sp.sp_reserved);
> @@ -170,7 +170,7 @@ static ssize_t lbs_host_sleep_read(struct file *file, char __user *userbuf,
>         if (!buf)
>                 return -ENOMEM;
>
> -       pos += snprintf(buf, len, "%d\n", priv->is_host_sleep_activated);
> +       pos += scnprintf(buf, len, "%d\n", priv->is_host_sleep_activated);
>
>         ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
>
> @@ -251,7 +251,7 @@ static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
>                 freq  = got->freq;
>                 events = le16_to_cpu(subscribed->events);
>
> -               pos += snprintf(buf, len, "%d %d %d\n", value, freq,
> +               pos += scnprintf(buf, len, "%d %d %d\n", value, freq,
>                                 !!(events & event_mask));
>         }
>
> @@ -446,7 +446,7 @@ static ssize_t lbs_rdmac_read(struct file *file, char __user *userbuf,
>         ret = lbs_get_reg(priv, CMD_MAC_REG_ACCESS, priv->mac_offset, &val);
>         mdelay(10);
>         if (!ret) {
> -               pos = snprintf(buf, len, "MAC[0x%x] = 0x%08x\n",
> +               pos = scnprintf(buf, len, "MAC[0x%x] = 0x%08x\n",
>                                 priv->mac_offset, val);
>                 ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
>         }
> @@ -516,7 +516,7 @@ static ssize_t lbs_rdbbp_read(struct file *file, char __user *userbuf,
>         ret = lbs_get_reg(priv, CMD_BBP_REG_ACCESS, priv->bbp_offset, &val);
>         mdelay(10);
>         if (!ret) {
> -               pos = snprintf(buf, len, "BBP[0x%x] = 0x%08x\n",
> +               pos = scnprintf(buf, len, "BBP[0x%x] = 0x%08x\n",
>                                 priv->bbp_offset, val);
>                 ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
>         }
> @@ -588,7 +588,7 @@ static ssize_t lbs_rdrf_read(struct file *file, char __user *userbuf,
>         ret = lbs_get_reg(priv, CMD_RF_REG_ACCESS, priv->rf_offset, &val);
>         mdelay(10);
>         if (!ret) {
> -               pos = snprintf(buf, len, "RF[0x%x] = 0x%08x\n",
> +               pos = scnprintf(buf, len, "RF[0x%x] = 0x%08x\n",
>                                 priv->rf_offset, val);
>                 ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
>         }
> --
> 2.19.2
>


-- 
Kees Cook
