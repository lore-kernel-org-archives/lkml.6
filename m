Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FC6C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908372429F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anye8HJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908372429F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeGCCZp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:25:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42649 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753818AbeGCCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:25:43 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so759865oib.9;
        Mon, 02 Jul 2018 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=77Oce+qhGCTYGLIaR/xRfUAPa3pBexP0ykriZSPiF6c=;
        b=Anye8HJdoBV+jP8YqgIuK/Bx1M+cSnj+GYXfEj3pIohSVi2TjjdnviCSIDz6OX7FrR
         7G9J6VwYt5eQpbMM9UNUMs7uf94clHPBnh86FRTgagEJWsuV9zg52ZBENVjyoqpeZ1hI
         /P5F+OF7QHeInJGVfsubO7CX5z7zGpkim5q0zBMAaFDmz9d85np6qBuItAwCzI7K5lqK
         CWxkRdcO+8HeOm3hnZpKy3/Q2YbQCLkJER/a6MUe3sEQUqAyZIfL31gCFuP7FZhYzD4r
         TkpkWbFfzzFVfRQM32brHNUlRNfLcVjtH1KBv/yN6Ap8EFkdPR0csgLUMbuzI1Sqx2cE
         IfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=77Oce+qhGCTYGLIaR/xRfUAPa3pBexP0ykriZSPiF6c=;
        b=Tl8FWUiJkKIMAXMY5+dUcF3y57IMwGffM/gI6hFmNCIV+oDryl7kQ9+lpX4J8R3hjz
         ieVW5htUY8TFX9fHG8yJGdobX5vtnFCbhpBuKs0fuPVriUR2n/Z/B7AB4OALtjcHAXuS
         k89xgsK7oOcpzwdaC5E0TFtu5uSNsYMmhygenDIiu2CQzf2kkipe8BsbdiuFcQVYOT0p
         wbm3KhowSPXN8wPhGhL8ptbQPCNUKEJKNC+M+B1hmYuhoS9VcAbQkSqvA8MngjsFrRZ+
         1vfsBHeXWzfo8fte4sZNd4Gar0PTwnHO52CG4pc/1QXIuv1ZGtFTEjWVvmn1JeCZUyJD
         Okhw==
X-Gm-Message-State: APt69E34bvZVrGbLMNUnlW/wOzyHLuUPhKZIapXvRypJrl1KRdHOJaNY
        6V7mVY1gkU2KPicOkt9u1Zm6x63rVxiYHlWIR8Y=
X-Google-Smtp-Source: AAOMgpee6P2crT3Wm34rD4D3UEeOIlCGRyxEriiZQ3Q/GhOcml7cfmOACCByiPYn208tR5GnlfUMaaWsSb8mmU6oPdM=
X-Received: by 2002:aca:400b:: with SMTP id n11-v6mr19848868oia.44.1530584741942;
 Mon, 02 Jul 2018 19:25:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 19:25:41 -0700 (PDT)
In-Reply-To: <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com> <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Jul 2018 23:25:41 -0300
Message-ID: <CAOMZO5A7=ptbOiSUDywwQrFd+DAZ3vsE3dSPab7cwOF3_T3qeQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:13 PM, Anson Huang <anson.huang@nxp.com> wrote:

> I think either way is OK, since flexible array is used in kernel code quite commonly,
> so I prefer to make code change as small as possible, the original patch can also prevent
> similar bug in future. And like below commit Fabio pointed out, it also has same kind
> of fix: a158531f3c92 ("gpio: 74x164: Fix crash during .remove()"). Thanks.

I am also fine with this patch or the one from Linus.

Maybe Anson's patch could be applied to 4.18-rc as a bug fix and
Linus' patch could be applied to 4.19-rc1 as a cleanup/improvement?

Ulf,

What would you prefer?

Thanks
