Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0756A2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGKzpSnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0756A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeJ2UrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:47:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46839 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeJ2UrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:47:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id c16-v6so8737319qtj.13;
        Mon, 29 Oct 2018 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCEehFaUebTW4fNviATPLpbyvaSH1ltp0+F+mlQKsHg=;
        b=nGKzpSnCiqhg68BNZOT9dxaD/1CIux1TbnGQ75s2rZuTco5nmOkMNbMted2jd7xeRM
         yBYw6hGchoJTs49upL8h52tCtVW95Mi+sDDGpHe0ogl/CusdTYg8Qb/leSXkR2jWWuiS
         Use/AJgy/RYskhQYdMS6U+4jjKVbpjtJP9WYrcqB3HSZYqvCUXkbbOeWggJJgALCujAg
         92+ZV4z59Vs0V2FifuJQgWbdOgvq26jC4pIG4d/KsIdF1+5B9LQfGVQAUB6uq0lf3bjP
         I9Cu22nuY7fS/1Rti9YSmSKeMAlgMR703H2ZGTSxkxX2V3vDvILurwj6stc6r4hBgZDt
         cBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCEehFaUebTW4fNviATPLpbyvaSH1ltp0+F+mlQKsHg=;
        b=FSBEgIx6KdlVw517k6VgTw4GEvMZR4JhfTePND8Qcxzw0xg2iqYxWV2h53Uvd9Ix2t
         ciY29ahKG0Z+PIm0VX2sDI6WU3ee2R/NnM5hRkFC05rQAmGhfHBggaas+z1F6NRcQfOy
         myvSkRphUOKs7VDtNKZks7v7Rh/nmtJswy6vAIxskGqJ/7nT2EQ51a6BOwzWDD8jJcdQ
         xLa5Nye3MqPgDhv9oPxV6qYPzmHBFwC6vRe77yE8LcPCtNdLdCWUKwgpV9QvRhN8Dr7Z
         30w+CvqjbcS871mSB+Xe+SBGIXoGZA+wO4a6A0jac7YQfHByjfBljQVyc+Gy14AbWbGK
         JItQ==
X-Gm-Message-State: AGRZ1gKgndQs9dq5A/9VzBwIK9O3ifGSr72a+dT2UanWcFfXMAOI+Kmx
        VD5NXaP4SuTdlZYqhmDCZpZsJhSZ2N1cRyc3bHo=
X-Google-Smtp-Source: AJdET5dnE129p3+qYj7Wuxs2AazwFKbU1sO8vMPUb4j3m6j/USynTzOjSBxlNH+2/RzvwlezX2wokitCDmPEfq1ZtqU=
X-Received: by 2002:aed:3e56:: with SMTP id m22-v6mr3104185qtf.99.1540814322512;
 Mon, 29 Oct 2018 04:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181020102100.14111-1-hdegoede@redhat.com>
In-Reply-To: <20181020102100.14111-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 13:58:31 +0200
Message-ID: <CAHp75VeHpCbJTT-U8QPS8J5O7OZ53HjMCz+tHQL6J-iC4qOzrw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add min-x and min-y
 settings for various models
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 1:21 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add min-x and min-y settings now that we've support for this and for some
> models also update the width/height settings with slighly more accurate
> values.
>
> This fixes touches along the edges registering at the wrong coordinates.
>
> While at it also set max-fingers to 10 in a couple of cases where the
> touchpad can handle 10 fingers (rather then the default 5) and that was
> missing.

Applied, thanks!

>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 33 +++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index f852009e0e30..3a65a37f8ac8 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -51,10 +51,13 @@ static const struct ts_dmi_data chuwi_hi8_data = {
>  };
>
>  static const struct property_entry chuwi_hi8_pro_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-chuwi-hi8-pro.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>         PROPERTY_ENTRY_BOOL("silead,home-button"),
>         PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
>         { }
> @@ -75,6 +78,8 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
>  };
>
>  static const struct property_entry chuwi_vi8_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1724),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> @@ -121,9 +126,9 @@ static const struct ts_dmi_data chuwi_vi10_data = {
>
>  static const struct property_entry connect_tablet9_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-min-x", 9),
> -       PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 10),
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1664),
> -       PROPERTY_ENTRY_U32("touchscreen-size-y", 878),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 880),
>         PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-connect-tablet9.fw"),
> @@ -137,8 +142,10 @@ static const struct ts_dmi_data connect_tablet9_data = {
>  };
>
>  static const struct property_entry cube_iwork8_air_props[] = {
> -       PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
> -       PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1664),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 896),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-cube-iwork8-air.fw"),
>         PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> @@ -222,11 +229,14 @@ static const struct ts_dmi_data gp_electronic_t701_data = {
>  };
>
>  static const struct property_entry itworks_tw891_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 5),
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1600),
> -       PROPERTY_ENTRY_U32("touchscreen-size-y", 890),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 896),
>         PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl3670-itworks-tw891.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>         { }
>  };
>
> @@ -250,8 +260,10 @@ static const struct ts_dmi_data jumper_ezpad_6_pro_data = {
>  };
>
>  static const struct property_entry jumper_ezpad_mini3_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 23),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1700),
> -       PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1138),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-jumper-ezpad-mini3.fw"),
>         PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> @@ -403,11 +415,14 @@ static const struct ts_dmi_data pov_mobii_wintab_p800w_v20_data = {
>  };
>
>  static const struct property_entry pov_mobii_wintab_p800w_v21_props[] = {
> -       PROPERTY_ENTRY_U32("touchscreen-size-x", 1800),
> -       PROPERTY_ENTRY_U32("touchscreen-size-y", 1150),
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1794),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
>         PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>         PROPERTY_ENTRY_STRING("firmware-name",
>                               "gsl3692-pov-mobii-wintab-p800w.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>         PROPERTY_ENTRY_BOOL("silead,home-button"),
>         { }
>  };
> @@ -494,6 +509,8 @@ static const struct ts_dmi_data trekstor_surftab_twin_10_1_data = {
>  };
>
>  static const struct property_entry trekstor_surftab_wintron70_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 12),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 884),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 632),
>         PROPERTY_ENTRY_STRING("firmware-name",
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
