Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E0C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A707A206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWtMOrP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfAFL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 06:58:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39654 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfAFL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 06:58:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so28252664lfh.6;
        Sun, 06 Jan 2019 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1YVVh/H4ZXqJKR4EyzOpe1vykPXUi/qY2yUy/s572s=;
        b=kWtMOrP19wga2FhOmAG3U4WSJ68TM7MKVbbQg0nBEnT9WPRLnDdnA04ch092bg9mBe
         r4jSXIAjVJcazDW1g4TovfmCVYD7PNFGbjYmBuUEU8kMt7lmsxh+NKe+zY5XyYyysPV8
         1vvj88ZfigvkqtBGOKV13N6djMbUwPuUjAxF8/XMbNeYiEzPNzMt0V6OovcBUQYtMlGB
         Yx6gDvx73uy4LBl9MdwuQcE3NeVu6K6JTSbhgOA55iTThX1PqyXgAuoh/CN6jcTHOv38
         jQn2GZ6PzRe6h9d/5bo35JOV59CgKBVLv34Ujx+XQCvElzbLZxDY9J1ftaNEVhLcxNbu
         CMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1YVVh/H4ZXqJKR4EyzOpe1vykPXUi/qY2yUy/s572s=;
        b=Qp8VLlGgzuA97SSQXB7C5sPhc2LWo4Lq/7WuGjOC+aiIJbFBzdwjFy4bIK6Ez2n7Kv
         CiPxWCq6H85/d0w3CseY20i27z8X/BNzuxpXs9V6uJjaURbl2JstrvHhyBp2vOdDf67V
         lmjEcqX6APvab7zQV5WeYMJEcnxcF/7r0vBku8C+/IKV2sZdCECYwuCaR3n7OlosJ7L3
         vAm4AC3pJ4QQXeAiRF557lMq4+Ou1uYwDUCxHeSW6wEmwAiete7XzESe/ZtShcsrP1EK
         FH8pWjgDjOKeBjLy4bloE+QksDl/FG/pTvV/pmV025SXJ4y9D7SArzmmA/chzeg/dmAa
         SfpQ==
X-Gm-Message-State: AA+aEWYt/PfbJQ2XHQ0Q24UD2By+A7BcXEnLT3ddRpkEFWT8A4gl97x1
        5401RgyBtk4muPvzoqnyWsQLvgmBatIbQTlsLFc=
X-Google-Smtp-Source: AFSGD/XVBvw1ojot5A/rijs9domEzwbU0K58hSib/su4CImD7wBWLHZm8bC62vRujl18Vm/rCnJNSMJtKCgRS0r5Kag=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr27548085lfg.24.1546775929751;
 Sun, 06 Jan 2019 03:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 6 Jan 2019 17:32:41 +0530
Message-ID: <CAFqt6zb9Wk63Mne+p9x5zfZJfADV-VOQQvGYwvky5a6nffRmhw@mail.gmail.com>
Subject: Re: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     dmitry.torokhov@gmail.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        lee.jones@linaro.org, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 10:39 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/kernel.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1749fc..5027ebb7b4e8 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> --
> 2.17.1
>
