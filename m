Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53822086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPhjSu9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfBUMPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:15:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44127 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBUMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:15:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so5490390qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O256mb489CkCwHSGAIomC7XdYJWSTMTnu8br84Mlqcg=;
        b=jPhjSu9tEt4NtHmiRkAVXyllyUg76CeQTANSiX8G0JY8AB0hPHLdxC+82lYlWehbmR
         LmaVdSxHgIHSYumReXWAJyYvSeWQzC0E2W1ZbUXLo24KTCFyALXIJw6zA5I7VyEAlGCM
         zut47Nh71a5+II09PuJF7EMRIFjJMG5R28wrXAs3rLA9OZXj/cLEHlFmkS3aH7jm6k9h
         3LQ8O/c1CxKANKkbs8wv+m6VHQstgTK/URUjGJ4mAZp9RkBlQSaHo+4DySCMEJA1Nuyn
         JrofcXq83SSXj1uodgn/VEmviTvVJx8Zf785/49SvtKFrkyr3vI0Ba9PTP3AyevwZbzL
         7Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O256mb489CkCwHSGAIomC7XdYJWSTMTnu8br84Mlqcg=;
        b=KN3Y1ohI1LCly2xqDnboc0yILLiv9dHHneycX5e+2Fl00KdIMZiX8hz1EPX2yWldMs
         Pg5UzuDGjFgMCCShT/neL0qoTHQSc0F0SK8r/6Lb24s6jAvKaCTPf17gk+Kir1q5n5Uo
         CG/0JY2O3XcTpSIj1GvHQNxmOs/Ul9UxRpDQALo+jSLf6B20wlCu2cJnlg6WDISll8hO
         PWQrFArSQPN/7u0Smy8iyL4C0mnrXNxTtLQUG9vE+HXCEcUwWUTqkDaWFl91lA+NvHuv
         h6laBJViQuERQ0xdqDMfEjGm7OLSfg00CaahOSIQ5KbYR6BtGw+iHuNpTejS2rZNMYhM
         tfjQ==
X-Gm-Message-State: AHQUAuZQV9ItaPJDbs+/CP5uO8zF3N7NITZnKEdHmj+YhGVnkmUZu0Ie
        IRLa0HfswsX8Q2bCNM18DHd0ax7L8/fMV+b1zM0r8A==
X-Google-Smtp-Source: AHgI3IaCCbdEFmX3a2vM+D+JZbEsvYhOhaP+apmvveVaq6A8hXOzg67EQ9N2+C/kLY69eX3zj+MaGuS5LMdXcm9lP6Q=
X-Received: by 2002:a0c:b60d:: with SMTP id f13mr5796710qve.209.1550751340645;
 Thu, 21 Feb 2019 04:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20190219191253.21712-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190219191253.21712-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 13:15:27 +0100
Message-ID: <CACRpkdYJw+Kap6LjZAbOp=6eC4DSLOF8unx35t8J89uOeFanmw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: Reorder debug print
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:12 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> It's reasonable to expect that people turn to the "gpio" debugfs file to
> first and foremost learn about the direction and value of a gpio, and
> second to that about it's pinconf. So reorder the value so each line
> reads:
>
> gpioN: direction value ...
>
> This also makes it consistent with the TLMM pinctrl driver's output in
> the same dump.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied.

Yours,
Linus Walleij
