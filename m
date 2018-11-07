Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9737CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3859020883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Sr/p7s8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3859020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeKHIlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:41:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37718 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeKHIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:41:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id p17so12742055lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYGsWOt6ypVtJm8KJfPHV1Op26KV4ohQ4Ck+xoxGlZU=;
        b=Sr/p7s8CTv7TKMxpT4+LCSY3KeiSeub059kjtH0w1wJik6o/VAfdLBKFBZE9SR5dYh
         O0DoZswMBItltb9bRD+UcUp8lkTn7bNtFzjnaZCAhH9vjbQlQRVzCsaD4GT5XrftYSsh
         8C2P6r6UbDaSPyOBUI548zopXSstXGveZ66LJn4eQhlKYnm+/M/4FC7lydqyE21KsIde
         AG8F8mHUWTR2N/oXnbY04YCINauM2W/MocY0cAUkctJ5k4WtcbyYv8iEY9xNlbVD+ewL
         v/1tBrojH9S9xxuX0aywx7pm0Kk1WbumKGIlSnE0HCf9zHBZapyIDesdjd/CsTQ7kbzO
         1ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYGsWOt6ypVtJm8KJfPHV1Op26KV4ohQ4Ck+xoxGlZU=;
        b=fMR5YSRxnYJCoXV519zCGJ1Epg5pqp16FZ0qTRLWLPe1Bijkp+/Klf2i+LfIYA0MCG
         PPi3TPbpAMXSkkYESxA/C9tKBxU+aSCPig21YN9HLB1eMF/J6w1gZX8nGtwTlSePVklM
         AnzWenN4hNOPl9/xFG40npZlaxNPRRWwk5a4BXPW+g7C5PnwFBSuzfEvR6at1weWD1Sx
         nYRUh1TBPWePjn2GVuiUutxKs9xG12uh4ZuXGL8ZtY1yhJ8YigAXdJjgv7cBF+PswUEm
         0RVkCdoIpIbI/KWCENNNDh6P1fNIJTPIZPOC+7kBXdHb55F6L31u27z8VdnpBpfsUAHA
         5FTQ==
X-Gm-Message-State: AGRZ1gJ2uYHp/K/McvzYIa6J51LOt2FWIrY7KuWr5n9VsUD1cV02txqG
        7Pg3CVkXGT4EIWc6Wsq1fUbCG68m8cI6hE5+mPyYnQ==
X-Google-Smtp-Source: AJdET5fdY0yzVQo4NHzviiJIacGPwvpt2Pbq8nUB416Nr2ZM28GIN+PZTAlR/1XxQIjNsxvzXQ5/cqGmlo4bLaOJW2I=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr1318506lfa.32.1541632120846;
 Wed, 07 Nov 2018 15:08:40 -0800 (PST)
MIME-Version: 1.0
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com> <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
In-Reply-To: <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 7 Nov 2018 15:08:29 -0800
Message-ID: <CAOesGMgGGRK=Q-Q8BDk+4hk-VsnqocrkQSLNZoRMXtdJXNKMPg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
To:     frieder.schrempf@kontron.de
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        Mark Brown <broonie@kernel.org>, david.wolfe@nxp.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        frieder.schrempf@exceet.de, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, linux-imx@nxp.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Eric Anholt <eric@anholt.net>, Stefan Agner <stefan@agner.ch>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stefan Wahren <stefan.wahren@i2se.com>, yannick.fertre@st.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 8:36 AM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> Hi Olof,
>
> On 07.11.18 17:20, Olof Johansson wrote:
> > On Wed, Nov 7, 2018 at 6:44 AM Frieder Schrempf
> > <frieder.schrempf@kontron.de> wrote:
> >>
> >> From: Frieder Schrempf <frieder.schrempf@exceet.de>
> >>
> >> The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
> >> at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> >
> > Hi Frieder,
> >
> > This patch is part of a series that I didn't see the rest of, but in
> > general we prefer to merge these through arm-soc even if the driver
> > goes in through another tree. The way we'd prefer to handle it is that
> > once the driver lands, we'll take the config option change to turn it
> > on. To avoid our branches to break until both sides have landed, it
> > might be a good idea to keep both drivers on for a short while (one
> > release).
> >
> > So, I'm not going to ack this since we avoid taking defconfig changes
> > through driver trees (these two defconfigs tend to churn a lot and we
> > don't want to create merge conflicts where we don't have to), but
> > we'll be happy to pick it up when the time comes.
>
> Ok, thank you for explaining the common practice. I will drop the config
> changes for the next version and send it separately when the time is ready.
>
> Both the old driver and the new one use the same compatible strings for
> probing. Wouldn't that cause problems if both drivers are enabled for a
> while, or am I missing something?

Only one of them would be allowed to bind to a device, but it might
not be predictable which one does (especially in the case of modules).

So, it's far from ideal, but breaking the platform is possibly worse.
It might just be a good idea to merge the driver and not turn it on
until it's in for that case (i.e. we take the config change between
-rc1 and -rc2).


-Olof
