Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AADC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F10208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORbIarsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F10208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeKTTZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:25:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35783 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeKTTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:25:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so783254lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0sNcUwpQ+eh9RxR7GKW3XiY3wgjXk3twtwBLkSGRDc=;
        b=ORbIarsSTy/cbaXfHYxFXHk4fpVb6H7iZjVhtdD0vWzThxwTSNK7fYvPLhlDqYwCas
         I7BmHEsmrZPE2WCHrUll/bnuYcny+7Vq1ZJTTwcPouwLkbmcp3yHFGomdFDCyV8/IOGF
         uW1Q12CW2FVUbtaxtHKOc1O9zIsPZ43WxHAmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0sNcUwpQ+eh9RxR7GKW3XiY3wgjXk3twtwBLkSGRDc=;
        b=LYtJahEoBvuExmhuXA7eNc/bPEACXQhngjc5bwz2ZfJ5RagU/O5SoTFR6adzVmynSt
         SNDdCkWikFX+X6wu31pOFuu1ZcrA8MlieOoJcyWPtlSUtU1+PK9gsJi/v9IRRpoz4MeO
         wXeO8AOx67BF4GrOBLK53XdSCeNNvsXbJBcMF+7u1Q+RajJ7VItfdCm3jNYcQf6uiRji
         WUmeyarYez4KErgOksGRBR1P2ORUR0prgZa+g8lpjdzrdb/u7vgd3cKxhmjCN59ygpxi
         SqTGb1/iSU/1T3Nf1UcNhim4e2o9yvDa/eAaRo61tapKRYupdmjlP7/6OrxV+mNCZd03
         Rs8A==
X-Gm-Message-State: AGRZ1gKEovmtP1itArBLwJpIbOSG0UQ477qkI9KQ0kwEvsYnC83V7gfG
        SOp53u70sn3YngWWRZhvtwgK4iAVVu+9S3y+CaEmHw==
X-Google-Smtp-Source: AJdET5dAlaIFurLHCjXTc/lDNq+eARttFzCszOoJoBYwdwasfTRLerrtFCMCw/qV1ntFE60m3jzDu/0zc27bowyLg3c=
X-Received: by 2002:a19:c801:: with SMTP id y1mr615564lff.53.1542704230050;
 Tue, 20 Nov 2018 00:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
 <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com> <20181120050650.GC5885@Mani-XPS-13-9360>
 <86pnv0rwna.wl-marc.zyngier@arm.com>
In-Reply-To: <86pnv0rwna.wl-marc.zyngier@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:56:58 +0100
Message-ID: <CACRpkdan96Vj58s=g9jiAoyLBpZqPCKcjqD82mgDj5WqRP7vDQ@mail.gmail.com>
Subject: Re: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, zhao_steven@263.net,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 9:17 AM Marc Zyngier <marc.zyngier@arm.com> wrote:

> How does this change anything with the fact that the above code is
> broken? 56 or 64 bit, you cannot read this counter with a single
> access, or two. The canonical way of reading such a counter is
> something like this:
>
>         do {
>                 lo = readl_relaxed(LO);
>                 hi = readl_relaxed(HI);
>         } while (hi != read_relaxed(HI));

To be fair, I have seen hardware that employ a logic latch
such that when a read access is done to the LO register,
the value of the whole counter is latched, also for the HI
register, so when you read the HI register in the second
step, it is never subject to wrapping. (Conversely reading
the HI before the LO will always give you insane values
:D)

However the above code should be fine unless you know
for sure the hardware was constructed with a clever latch.

Yours,
Linus Walleij
