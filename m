Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4912087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0maNDv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4912087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeKQBaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:30:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55431 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:30:22 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so25977144itg.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HudQ1q/dH+9fKxBn7PYfOAMqZsslM9UgGhMkLdfwl8=;
        b=d0maNDv1K87eBC8CWQuGxgRNTpTSiulcxIaIOquOnlXY/UpnEEXQ2SX0OM63B576aH
         On23ghlvde6JEoql4jNWT3Euc0Qg6EI3PysHp+m65xkZUELRhDb5WamK1XUWoLZdSfOU
         YzJ1ZDN8G8iqKpy3c8LJ0ZFRl6vbpjR+JUg8cVX7Uzsy8b8Rk/bJyPo9dE3QvXJ/FRx3
         TmoUTzbcWSofJnqODMWKODBExCzslEzCJYrBPXrvwS3lpgjo1MqQzrQQxXoD721w1dox
         pl2mvgTVjsFeiyyWTNsljh8GfbPJQQjdlQbhFM8Vyu6N2uPmJ5aCs7EPcegPycYqim5S
         K9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HudQ1q/dH+9fKxBn7PYfOAMqZsslM9UgGhMkLdfwl8=;
        b=WHtFzy9QSnXIN5Vz0IkydZb3+lD0ufE9b5eFa5QAzNMgEiaG0PkeghRxlc4Te9DM68
         U6S8YPst0rLyUROp+xr4r+1Wuul8WgbhY9LemUswF6vueZ4R9Tz0F48lA2WF7JMUSck2
         cGr6+b0INhsufBLrYXPdtkqpdC+7n0wG4rVbbotqSt9tBCk2Z2COQcKlF2t9Buo+jUhH
         /8kuR2eFdSI99oehMhaIEuohKNo3+n9UA4zKvM8u/ppA2/oUGswSgw3Y1tcWksLaTHGf
         4uezNiSKJQUR6hdq1ZHr9wf5s8ysRFnflXeHt/XiUq/HREnAqJm9zOK8sFKlUdf+yf0G
         vylQ==
X-Gm-Message-State: AA+aEWaKq/d/2V+7M70hUDy/70yzls20hTHUCImiJnetbn85hFs9eT2D
        NvlxGIXnh7DnyTkOeuUFvqiokDwiDOlSRCfq1LQ=
X-Google-Smtp-Source: AFSGD/VYgHvAPbCcImAyiMOJxINx9BRui6cfeR3N2ASANuO9tUwsWaRXMnCvqUuOYMXGTpDegxM4iDJQYdcJMqmKIjs=
X-Received: by 2002:a24:1303:: with SMTP id 3-v6mr9675784itz.176.1542381454421;
 Fri, 16 Nov 2018 07:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Fri, 16 Nov 2018 20:47:21 +0530
Message-ID: <CAFqtX7kfSuWkjYHPWsxRaYcsQRD4OtJVyUBAezZu3HQT4QjoYg@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
To:     Stuart Yoder <stuyoder@gmail.com>, laurentiu.tudor@nxp.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 3:21 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/fsl/mc.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Any comment on this patch?

> ---
>  drivers/bus/fsl-mc/dpbp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> index 17e3c5d2f22e..9003cd3698a5 100644
> --- a/drivers/bus/fsl-mc/dpbp.c
> +++ b/drivers/bus/fsl-mc/dpbp.c
> @@ -5,7 +5,6 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/fsl/mc.h>
> -#include <linux/fsl/mc.h>
>
>  #include "fsl-mc-private.h"
>
> --
> 2.17.1
>
