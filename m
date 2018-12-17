Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56738C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CB62086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjlXt01N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbeLQITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:19:45 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33990 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeLQITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:19:44 -0500
Received: by mail-ua1-f67.google.com with SMTP id z23so4132762uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN27ykVXVUWtwZNzxrc2mxDHw85OZQ30maX31gmW/aw=;
        b=HjlXt01NUdfArjdbnqwowaSxCMylajisodKuLgC+SDpfWhyDy1UzGrm3BwXfPu1HqP
         fYLGlZhZyKkO0Wb2Z1GJMH8N3o61akoX0ErptMJWjhsjpVOOem3HJwXxGwc0oo7M9i6w
         979sCnYZDn7JqYgG/8d45TcrLZ9bt6WsGX8o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN27ykVXVUWtwZNzxrc2mxDHw85OZQ30maX31gmW/aw=;
        b=IPxw59cyoJgHGRAAflaJlDt4f1bXBMqMK8ZTpK6XmTJJ/gjeE/6hwksPcMCK6VmKIO
         cnO/ashUIWAl5tj013lFqRyhxGduLcijJ2FmCrd5tA0RwZ+M5jxOfaM1/XrvI66kXQfM
         5onYVdLncKkWZCPSVqQNRsIy2GESLTAF++lUS24ZD8itETTD+QUqPvuGtejBAafTklZ0
         qirJMqNll6hkWZ6HNJ+JWTvUrFx+Uqq7AIMrTs76rPWrEcT0W6gGGLOPFJJUMVdUNt/x
         3q2Q+uf2Lcd2ERQ856/gIn+CClJAkb24zLKQWJ5v9k0BBglg5mwtiHThkAtQQk2QUke/
         2iyg==
X-Gm-Message-State: AA+aEWbnNubPcIMNC1p5NXUwSRDB6MZLySlUJaDAsUPPfgYOTtxBfiOf
        qcQ5c48HJsc9agHbr5fYRlQl563CvEyoxbZL//DOlA==
X-Google-Smtp-Source: AFSGD/VzLVEHVOezm4Gs7cEI0TW4HlpSlV51Imgw9uZFU4VurcM8LM18gcK9b3/6iGsvwNL3Wx1OshfU+q9Y5OGaUfo=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr5408239uad.119.1545034783454;
 Mon, 17 Dec 2018 00:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20181215084526.27210-1-tiny.windzz@gmail.com>
In-Reply-To: <20181215084526.27210-1-tiny.windzz@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 09:19:07 +0100
Message-ID: <CAPDyKFq5oxDc1drn-0Tj-aBJCPCXcd_AO0q=56s9sumgiY4Dpg@mail.gmail.com>
Subject: Re: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2018 at 09:45, Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
> such a macro, so remove define_genpd_open_function and
> define_genpd_debugfs_fops.
>
> Convert them to DEFINE_SHOW_ATTRIBUTE.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/base/power/domain.c | 71 +++++++++++++------------------------
>  1 file changed, 24 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7f38a92b444a..10a61d6147d0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
>         return 0;
>  }
>
> -static int genpd_summary_show(struct seq_file *s, void *data)
> +static int summary_show(struct seq_file *s, void *data)

Why rename the function(s)?

[...]

Kind regards
Uffe
