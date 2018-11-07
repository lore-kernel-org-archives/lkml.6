Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7010E20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="GXI/DaYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7010E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbeKHBvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:51:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45178 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:51:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so11878624lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sai0rEWO5dfIo6EMYKgTwNRZXaZlmh2kFhl257Ay/BY=;
        b=GXI/DaYnfhpQm/Ru+LxgxLsxFjYdnECwObsGGtsO8Dtl9aivCU3rPVR43zqId5yC6+
         Xt+fDdFXJ7g1vFSEGkpG5KW2hkFB7n8PJw9WQ05L5sNf2UB+lAghnCiD67xSWyzGoNjr
         Nk+6gsZcEbYVxkHLT6BPpAJve97MyY6rhX3zdXOqjRlklXgVqZpnW8YG223/P77JVSVA
         tFzxV0BCXlStzgc7Fr4ZZqUJgHy0wa0Ep3Zm3A+BHRka2dQEKE28QuGhzKIC+ZmFBC/z
         z3aQ1FE231F5gApme/v9u/9D1Mkl03DSwW7HgkCPORkLl5Fotx/ZO0PKBqxcKZ3XIzoG
         +BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sai0rEWO5dfIo6EMYKgTwNRZXaZlmh2kFhl257Ay/BY=;
        b=KgrUA8R0KziDgH1W8PTJvtVWm9MxFzQePzz8z8XI5aNKCSQM9+xzS2WthiYMfFOMdr
         8n2+aPUgdbTmPYjLy84y+HmzOGdMexAoM+iExS5bECTqvOj9Q0gymIK9PhDuNx331RRR
         lLVdxLpbAiRizg/BYhobG1d7Hc9VC3N6/o4d0y8qrSJ4SRyTEdzM6LNbySV7WbrHB6sB
         AFB/5PEoVHRq0V5OiIsMzPTmoWQwZrUgkBXILiPEx7lRafjC6PLgnzXVrnF6KJPnQh+e
         r8yiuRsAMgZK9Cd/6CvzZgJI59F9RIdJD+GaUN8Ie/7ij26ExGozrgAIE7ZwcbTJL07/
         sOPg==
X-Gm-Message-State: AGRZ1gK5FbHNe0D+iJ3NQEBhIMVuXK8wRZwDuWp8UjHt6c1zQhXSrcYk
        r5exi3tukn7v2Qb5NnbcG7YvwMWFXneb4s0kbYPkvQ==
X-Google-Smtp-Source: AJdET5cPrhGlt9AbeUsx0cmqc6bLxkylZekPhdnckbp1fPn1dLmvft3JBmrzv36yC0YzJxBf+iASkXHk7JAN0VKxvP4=
X-Received: by 2002:a19:2d16:: with SMTP id k22mr531826lfj.12.1541607637278;
 Wed, 07 Nov 2018 08:20:37 -0800 (PST)
MIME-Version: 1.0
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de> <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 7 Nov 2018 08:20:25 -0800
Message-ID: <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
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

On Wed, Nov 7, 2018 at 6:44 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@exceet.de>
>
> The new driver at spi/spi-fsl-qspi.c replaces the old SPI NOR driver
> at mtd/fsl-quadspi.c. Switch to the new driver in the defconfigs.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>

Hi Frieder,

This patch is part of a series that I didn't see the rest of, but in
general we prefer to merge these through arm-soc even if the driver
goes in through another tree. The way we'd prefer to handle it is that
once the driver lands, we'll take the config option change to turn it
on. To avoid our branches to break until both sides have landed, it
might be a good idea to keep both drivers on for a short while (one
release).

So, I'm not going to ack this since we avoid taking defconfig changes
through driver trees (these two defconfigs tend to churn a lot and we
don't want to create merge conflicts where we don't have to), but
we'll be happy to pick it up when the time comes.


Thanks,

-Olof
