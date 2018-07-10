Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52579208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LajSa0+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52579208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933732AbeGJOzu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:55:50 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45646 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933311AbeGJOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:55:48 -0400
Received: by mail-yb0-f193.google.com with SMTP id h127-v6so8704390ybg.12;
        Tue, 10 Jul 2018 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y0qf7AH8kpSUKHzE056yPCosciJU73z81OF5run+aO0=;
        b=LajSa0+o5cWkmvy9Z6KX2gSq/aqQBBDFGobVUe0ecfp8dElNpkuYlmIezTuXsoyVz/
         9aptm/H2KZ9R81f0xUIsN+6GjdTvz6Sz7pg9X7ydUMH2+hQFqCjHqxpM/GJ4zQeWQtcq
         yy+IFzJwxxCSPBqq6i55NTtbqRlzRxbdr4Eu4oFOltoYkSJRlS6zFDvnb9i9ypHpceQQ
         Y7//n4BkKvA4bBEUvDcSTPcDa8Vv2nUSCdtoUkF3j0dVLvFawU8fLIPYngFFLfRJ21ay
         SwpUA8iYvADsi8buolJtS9bisemE6ojve8PivTCeS47HCRNiVMaiJ50zZtQtrVG4io8g
         EsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y0qf7AH8kpSUKHzE056yPCosciJU73z81OF5run+aO0=;
        b=Qtuqp2ofjyOlGHDNfTAoYeAsypkhrfGnoUcoSOlqDdvoHYdaA8NVHPwgYcdfAov9Fy
         o6b1N+g3ye5CU3d+QKHHq465csT6Pohrj8T31sybOKm0Gfvma/7CsCuoXsTsrRXjXG4+
         hMeqBNEtaW5YInAlLD3RDrNaexNxQXGoZgR9CqxHF0jc5IME1Zz2PL8Lpo94NoZkr+XC
         6mX2NQsFD6XGlbVeDogMMd7wcjQu99qgwq2YEDNQsc83sINdp9NVrW71Ce3NGxVemOYo
         ZGnWAAZC7ww2eAv1rQwZb84rg0zGEul3+gxik6DfmNBv8NZin3Y6RalDW6n5PuhWP7CG
         y9HQ==
X-Gm-Message-State: APt69E0Zm3JnfeNobsZjU/IZZE1c5IxPbnvzg48lSIt7MKaiXZmYJOpr
        S1O5SVqXbPD4Ej3hLGvm7UxkIwn7xhlHKrPAwhk=
X-Google-Smtp-Source: AAOMgpc7ikCLHZhUp9sn8WiPnU4voQXNTcbGioBGoK1+6bEj8cYafFrKn23fe3OXmHI3RkSVUrcAGKOH6L7FgAAHCiU=
X-Received: by 2002:a25:8102:: with SMTP id o2-v6mr13097264ybk.379.1531234547470;
 Tue, 10 Jul 2018 07:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180611155001.3506-1-peron.clem@gmail.com>
In-Reply-To: <20180611155001.3506-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 10 Jul 2018 16:55:36 +0200
Message-ID: <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
To:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there still some remark against merging this ?

Thanks,
Clement

On Mon, 11 Jun 2018 at 17:50, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> From: Cl=C3=A9ment Peron <clement.peron@devialet.com>
>
> As suggested in the commit message we have added the device tree support,
> proper bindings and we moved the driver into the correct folder.
>
> Moreover we made some changes like use of relaxed IO accesor,
> implement sched_clock, delay_timer and reduce the clockevents min_delta.
>
> Changes since v6:
> -fix indent
>
> Changes since v5:
> - change epit to timer in doc example
> - fix typo in imx6sl.dtsi
>
> Changes since v4:
> - removed ipg clk
> - change in dt epit to timer
> - add introduction in doc
> - add all compatibles in doc
> - update epit entry for other i.MX device-trees
>
> Changes since v3:
> - Clean Kconfig
> - Rename imx6q-epit to imx31-epit
> - Update doc and bindings
> - Indent and fix
>
> Changes since v2 (Thanks Fabio Estevam):
> - Removed unused ckil clock
> - Add out_iounmap
> - Check and handle if clk_prepare_enable failed
> - Fix comment typo
>
> Changes since v1 (Thanks Vladimir Zapolskiy):
> - Add OF dependency in Kconfig
> - Sort header
> - Use BIT macro
> - Remove useless comments
> - Fix incorrect indent
> - Fix memory leak
> - Add check and handle possible returned error
>
> Cl=C3=A9ment Peron (2):
>   ARM: imx: remove inexistant EPIT timer init
>   dt-bindings: timer: add i.MX EPIT timer binding
>
> Colin Didier (3):
>   clk: imx6: add EPIT clock support
>   clocksource: add driver for i.MX EPIT timer
>   ARM: dts: imx: add missing compatible and clock properties for EPIT
>
>  .../devicetree/bindings/timer/fsl,imxepit.txt |  21 ++
>  arch/arm/boot/dts/imx25.dtsi                  |   8 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                |  10 +-
>  arch/arm/boot/dts/imx6sl.dtsi                 |  10 +-
>  arch/arm/boot/dts/imx6sx.dtsi                 |  10 +-
>  arch/arm/boot/dts/imx6ul.dtsi                 |  10 +-
>  arch/arm/mach-imx/common.h                    |   1 -
>  drivers/clk/imx/clk-imx6q.c                   |   2 +
>  drivers/clocksource/Kconfig                   |  11 +
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-imx-epit.c          | 265 ++++++++++++++++++
>  include/dt-bindings/clock/imx6qdl-clock.h     |   4 +-
>  12 files changed, 341 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.t=
xt
>  create mode 100644 drivers/clocksource/timer-imx-epit.c
>
> --
> 2.17.1
>
