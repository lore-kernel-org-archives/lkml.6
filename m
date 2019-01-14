Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C273C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB07D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFW7WsSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfANGxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:53:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38630 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfANGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:53:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so9693823plb.5;
        Sun, 13 Jan 2019 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFNsRig2am7lFZljbzB4OQRSTLw+lwJncAXZ7wH2QME=;
        b=tFW7WsSbMHkBDVg72BG6cbW3JaSbKdbqd2KC5qlF4AlcoR3v9A14ANxwI/H8IAOzrs
         bFeqqwWOdMh9cjQIhePgxQsFisZhSQ9+UKhwQa/mzyqQZNeWa54hJYjQ3ppgXkdSh0eg
         E3x4e+MjSEe/GuY4if4zWzRED/eam+xLW/Cknnl/9mZA/xRGJ6AtY/cJYPp6OyF6ZrhR
         Db3bSlQ3tPnHi1a/cbwboshv8otGk6In9wo2KzqHnEk9hYAsTFFHn/+tu8QfJwXxxLR5
         LVIzF0a8eWvEpnQMMwiiLmnLjJapiUwmiCx0TMmJyrp/5KYLfIVRiw+4xuIQdx63WNrF
         m/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFNsRig2am7lFZljbzB4OQRSTLw+lwJncAXZ7wH2QME=;
        b=JEXDhg6XnqlvWZgDt0EN0htfJNZadrN/QpVuAGCaHo8Sb6TCxJapIDR4Yzw3Y2xS6p
         sx+/fEWCkC86F+LvCCABS2J0hnRn3VLL7GceePTPupMSvFb9CGyfEajvJ6EEMCt1Z+f1
         +AxnAGrKZ8CshiqRXZ+YVBfTgXInI9ictgTsIojnup3tqU3KfI7aUP1JSdg0IShSq4r4
         M5vqa45X4rOsDmD3L9x0P1jBFzAxbtf/mlvHIzkPVQ1luS+/r8gp77TOk8D+swnNrAQi
         YKAGGyVIUT6R+jawUx+BjvhZUDjkElsZXG1oLLYENcDT0/oDIpEaD2l6bVYMmfPw7HJA
         +fWA==
X-Gm-Message-State: AJcUukf3HuPyBJPNoOfiu1O4rQGg+rEnqqTh5r7GtasXeSkjzkYBsWCv
        BJ7PBH6xlLG4x36m8A2+LR0=
X-Google-Smtp-Source: ALg8bN4RDS/NrOJq5YBQRDT2XscM21PAxKDZH2/Uq6bQ9Jg1G/7X2OigZgDU/M2nbVc2Z1tRsVxP4Q==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr23213733plz.32.1547448798667;
        Sun, 13 Jan 2019 22:53:18 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 202sm154626308pfy.87.2019.01.13.22.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 22:53:17 -0800 (PST)
Date:   Sun, 13 Jan 2019 22:53:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     matthias.bgg@gmail.com, lee.jones@linaro.org,
        chen.zhong@mediatek.com, jrdr.linux@gmail.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
Message-ID: <20190114065316.GC217283@dtor-ws>
References: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 10:39:07AM +0530, Brajeswar Ghosh wrote:
> Remove linux/kernel.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied, thank you.

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

-- 
Dmitry
