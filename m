Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED91720882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0U0NciV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED91720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbeGINVe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:21:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34247 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbeGINVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:21:22 -0400
Received: by mail-it0-f66.google.com with SMTP id d191-v6so11786316ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pb4XIiKiKr0CQbMUlvcnVxtu0WWkoMlulhXk0gf41ns=;
        b=Q0U0NciVNJefYuEhJUK9TQMl4/72+QhmJ0AoMfp8rXbCBBAiRtXSMWRdRMs/sG2qhh
         s8J5v3PgmRtu/7yGdAKhJbjr8RVblZjzuhuGNIz2uopBbCO85cu8LLD2cKt2/LxeXNCO
         SPosOfZP9mEPcmS/3br5FNuXgW5/GmYiAk6k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pb4XIiKiKr0CQbMUlvcnVxtu0WWkoMlulhXk0gf41ns=;
        b=SH7SsAo0YGo5KfaC2h4kB3d1JeTJ++KasVbUPQcJzqJbFYWLNv1ukVjVAQj+gB5yxm
         IQ3L7en81kIix6wg6LJ9sHaPe1KWNbcyezLQRostrYq0AfTww3FW8Mlkuf5gPxKaqTYx
         XPOSMUGVVR0tAGMw2ogNgry912vNZDv1Ayu03WC9s0/iDaAMVRAJlIkt8s/l4xy+L8aA
         OzLq3iqLQSLPwWoV3YcLf7jBQMf40bCDkH/hhGBnGDKrS8Fiy1D3Qjv9Pg3SU0Y1Jbjq
         G+0lgRk+malpcPKlgqxwYXhxcbBC/g98iUFtSDMVx/+hiWYyDcLLDj34hLgfWS56vfxw
         +oVQ==
X-Gm-Message-State: APt69E29X+/SNP22KyKlwNIzdovNsw8YyGkT58wbSmGwwpIYZptf+JnQ
        5wMjVQ7eGZgOhfHDGAfmovlXgyFN8wY8hTzISevr2Q==
X-Google-Smtp-Source: AAOMgpd1BMuUD8FapRzL9GKl6zNv0xZlmYMQlzMUn1F0t2ogU2gfXD1gPtDpFP4TR/V0XHWj/Q+3e74r5biIS41i7nQ=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr15769065itf.70.1531142481704;
 Mon, 09 Jul 2018 06:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
 <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5A7=ptbOiSUDywwQrFd+DAZ3vsE3dSPab7cwOF3_T3qeQ@mail.gmail.com> <CAPDyKFoVLT1zUPma7xRz_JFzFYpr=YCzENARmCkzwUnTZEX_8A@mail.gmail.com>
In-Reply-To: <CAPDyKFoVLT1zUPma7xRz_JFzFYpr=YCzENARmCkzwUnTZEX_8A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 15:21:10 +0200
Message-ID: <CACRpkdYs6RCw3Z9jqaPf3H_OExY+AtDFb21rNJXr6Gr2oVUTWQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>, evgreen@chromium.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 7:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 July 2018 at 04:25, Fabio Estevam <festevam@gmail.com> wrote:
> > On Mon, Jul 2, 2018 at 11:13 PM, Anson Huang <anson.huang@nxp.com> wrote:
> >
> >> I think either way is OK, since flexible array is used in kernel code quite commonly,
> >> so I prefer to make code change as small as possible, the original patch can also prevent
> >> similar bug in future. And like below commit Fabio pointed out, it also has same kind
> >> of fix: a158531f3c92 ("gpio: 74x164: Fix crash during .remove()"). Thanks.
> >
> > I am also fine with this patch or the one from Linus.
> >
> > Maybe Anson's patch could be applied to 4.18-rc as a bug fix and
> > Linus' patch could be applied to 4.19-rc1 as a cleanup/improvement?
>
> Good idea!
>
> I have queued up Anson's v2 patch as a fix for 4.18.
>
> Linus, can please re-post a re-based version of your change on top!? I
> guess you can add Anson's and Fabio's reviewed by tags for it as well.

Sure thing! I'll fold in Andy's suggested fix as well.

Yours,
Linus Walleij
