Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344B4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAB23C60
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHB74hxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAAB23C60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeGCFf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:35:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55484 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbeGCFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:35:56 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so1435286itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fRxUMA2CprNHf/bP5/bQNOmfKVyJQc084YSxudG72Zo=;
        b=bHB74hxcr8ZvKQaOafD41T21tisUz5+5QtbAt+MiLBlRmjmDRwNBTr0PvuAY50V6u5
         ci660sQ0u9HtekyLiOnEugm0JbwqCDawz7NQXfYj2Gqws4Y5HwKZmUbqA4/jAUijZe0Q
         P7p0ArenY99ywWEoDq2lQbUAFSGD9Pv9h5TnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fRxUMA2CprNHf/bP5/bQNOmfKVyJQc084YSxudG72Zo=;
        b=YUceB3tgTYBiBtqJBaiXNM1N0jYmGpQSnW1gTgQG9PXBsdl+albXM2kUIidYDnKpve
         aU9E/Cpo/D9tyogm9y1/upHWRJSJNq80zmhI37KEEv6fNYrFGzr18SyL4oTFeK8k5Cu0
         jIYW1LZ6yYIJLVYbWZPptW/XeQu+1lnoLX4abK+bYgmByH3Ap2MhPdpyxcni1lRt34Zm
         vOczSkL15MqhfXQpqvI0ac1MJ1gag+sh2A4I9SUC/o2M/3eTZVViPPau6ggcxmup7Ooz
         o90XCK9q1aSsNCyGTVQecYGfgCvofLHL4em7KRdQydopnorNVXigNn0+b3mvMMjN54nZ
         7rdg==
X-Gm-Message-State: APt69E2H5NyDsnfr/H+G5qV7u55/oSSop+0snH3+dzbj/R0s+Wv+WWyU
        luFV/CKIOanYzTxeQWED/Fa0fzgYK1KOwmIbuO2Tmw==
X-Google-Smtp-Source: AAOMgpfAoeEizmxGtl4OS0FrNqlD04zPQBDRD6BgIDg80fzOOoXG5u4l6WGO/1lBg5LsunGB48bZAfFxjBY8CaEVY1I=
X-Received: by 2002:a02:570c:: with SMTP id u12-v6mr23171686jaa.142.1530596155467;
 Mon, 02 Jul 2018 22:35:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 22:35:54 -0700 (PDT)
In-Reply-To: <CAOMZO5A7=ptbOiSUDywwQrFd+DAZ3vsE3dSPab7cwOF3_T3qeQ@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
 <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5A7=ptbOiSUDywwQrFd+DAZ3vsE3dSPab7cwOF3_T3qeQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Jul 2018 07:35:54 +0200
Message-ID: <CAPDyKFoVLT1zUPma7xRz_JFzFYpr=YCzENARmCkzwUnTZEX_8A@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
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

On 3 July 2018 at 04:25, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jul 2, 2018 at 11:13 PM, Anson Huang <anson.huang@nxp.com> wrote:
>
>> I think either way is OK, since flexible array is used in kernel code quite commonly,
>> so I prefer to make code change as small as possible, the original patch can also prevent
>> similar bug in future. And like below commit Fabio pointed out, it also has same kind
>> of fix: a158531f3c92 ("gpio: 74x164: Fix crash during .remove()"). Thanks.
>
> I am also fine with this patch or the one from Linus.
>
> Maybe Anson's patch could be applied to 4.18-rc as a bug fix and
> Linus' patch could be applied to 4.19-rc1 as a cleanup/improvement?

Good idea!

I have queued up Anson's v2 patch as a fix for 4.18.

Linus, can please re-post a re-based version of your change on top!? I
guess you can add Anson's and Fabio's reviewed by tags for it as well.

Kind regards
Uffe
