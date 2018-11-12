Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3227F224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWir2mnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3227F224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeKMFUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:20:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38611 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:20:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id v76-v6so1951543pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJxHabq1gPELeCOutnOM22abKANhwOVzDQ7GGs6a+fw=;
        b=uWir2mnxZoLvlL7o6qaZ9URKm/XPa1TZdLtBRHUJJPtVyDc/zo3bAnORc0fwiQAnrj
         J8POvFOsG7aL+I0InPYi6jXvlmPHA28HesBXx9FuTLOQy4FVUT8MrTpgG8C1Rfo0a82n
         nHnedmksOre4FZ0TzQ3uPZYG4drHXKGJ84Y8l6w8pixoFWgX7sE89l/h3TnrZrMreuLu
         iWYQMK8rDoHp14CBNEbS5Ofygks2UWdXJlBpd4c1t+vc9p6hO1p9c91PWrpw1P2GzBlD
         mcjsLbM3Hmrts0v98Hzzx6if0XDs/zHRsds3R7RrgpYmIb6/kB5+m7ThvsXwJfLBW5W6
         2xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJxHabq1gPELeCOutnOM22abKANhwOVzDQ7GGs6a+fw=;
        b=PzOiAnnD6KpoNWOtOoKFw/oDvlaLDkwhPPoMBCa/uEtWtnIQDpE6MbBONn5h7TJSOQ
         pseh6GWTW8Q0Ypy1Q6SnIg0dtpVhm2kc9WRtyG5dS/fkoxApkFwS2fZ6kFxEv5Yqb91N
         5uHdnCSiHPvya0oU6Y0i7AV+aafMWUYHL46nCFpX1kvSSz+GJrOeOYcbX9VZ01ACYb3q
         uGmMaNJ9O6NaA/2JzQxuZ5t7cX1pnH0qZ0iIWEE0OaqdkK2c1i29HmLhIkYVNSYJceXw
         Cn+AGfEkNQOPjTpRxNFqh760IXVHEDXmFEVvygcpOqnnLuoat4Qgc6U6S24azDJH71w/
         DjIQ==
X-Gm-Message-State: AGRZ1gK447OgOYMoyLD1+6aq79+/v87CIHBoiWshwOtAlvrn53YxqZtF
        86ELXXCAs2oG/zCm7+VzZhANdCU7XC5a8/uu0zWtRQ==
X-Google-Smtp-Source: AJdET5cyf2e+m2xO12K/WWTD7HROugWPeunMN5xsrBvevJKBsT72ignSAOGNF0t81EWpLSU+hqjWxuFLZOIasB/PnJ8=
X-Received: by 2002:a63:a064:: with SMTP id u36mr1917241pgn.145.1542050737997;
 Mon, 12 Nov 2018 11:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20181101005502.9171-1-natechancellor@gmail.com>
In-Reply-To: <20181101005502.9171-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Nov 2018 11:25:26 -0800
Message-ID: <CAKwvOdm+Phwn7GdfVTf0UpBjShrN+vyfjhU3ctXqj3WBat9dVw@mail.gmail.com>
Subject: Re: [PATCH] rtc: omap: Use define directive for PIN_CONFIG_ACTIVE_HIGH
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/rtc/rtc-omap.c:574:21: warning: implicit conversion from
> enumeration type 'enum rtc_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
>         ~                  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/rtc/rtc-omap.c:579:12: warning: implicit conversion from
> enumeration type 'enum rtc_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         PCONFDUMP(PIN_CONFIG_ACTIVE_HIGH, "input active high", NULL, false),
>         ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/144
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/rtc/rtc-omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 320b4a520eb3..bbff0e2deb84 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -566,9 +566,7 @@ static const struct pinctrl_ops rtc_pinctrl_ops = {
>         .dt_free_map = pinconf_generic_dt_free_map,
>  };
>
> -enum rtc_pin_config_param {
> -       PIN_CONFIG_ACTIVE_HIGH = PIN_CONFIG_END + 1,
> -};
> +#define PIN_CONFIG_ACTIVE_HIGH         (PIN_CONFIG_END + 1)
>
>  static const struct pinconf_generic_params rtc_params[] = {
>         {"ti,active-high", PIN_CONFIG_ACTIVE_HIGH, 0},
> --
> 2.19.1
>

Bumping for review

-- 
Thanks,
~Nick Desaulniers
