Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D782084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEvJUX7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeLQI1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:27:34 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42316 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbeLQI1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:27:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so7179778vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePRLGvAvByKgzB9cfX2ljCN93S/dzHvixVBNukQwq3k=;
        b=HEvJUX7Lwc65ev82aaEutpI/r2TGz359VQn79FR9tc0VHjbqXNDnGXflJ5od6Pl3V4
         Fx8DlFap59l6/8NfVEqUx8uGtjElBHIsRnZbqKRwEUChsC9e6Rt74L0b12rpci9WtCgM
         y0IC+dRvvpkyOZOOSN6ZZgDS2h80QKrFmIyy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePRLGvAvByKgzB9cfX2ljCN93S/dzHvixVBNukQwq3k=;
        b=Ho9kZ3NNR7akEVBr5jqTbj5RhbVScru0+wM4L5NLOc/hNV4WP4xRksJx3ghC4Rx2tQ
         Pwzt1ZbiHm3PfYHGyq4Fx6yhWeHjMgPzYYTzNmVy7afMU5QcqvetiAfRyWpbG96pHuoA
         CgmEIiDgfTUgodI/5jM/6+o19zXzjz+r7BlrjtO5FR4RzIfG7ayoAhPDht5e/L/5PGdE
         Ua00ofyW2MHN4dIUuRze0TvreEvE12GJ4AV810wpZo0GbvwFH9d7t00SfEV5vce/hPBv
         z2N11MRZiK4LHRKrbEI5V6aidnSHik3KkbhznHgo2tASfty7TvkjNfa4oMEp25OdJHuE
         m5YQ==
X-Gm-Message-State: AA+aEWacKtOnsbgVhRm9F3fQqgYy7bJ3W5d+dW9dsG/Fk0sSV0o7J26X
        LufkUs2X4Q0WalW9FVebiUp9/2vyDE14mdjfCMMxpw==
X-Google-Smtp-Source: AFSGD/W1DVp03FXlfyH9tz4mSw3V0LLdyuUbsKtQizq/soTXcUbw3xdgW20uZ14I7uzCz76JLrM4bO6R0uKQ0eRUe7Q=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr5879700vsa.165.1545035252165;
 Mon, 17 Dec 2018 00:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20181210183507.9617-1-faiz_abbas@ti.com> <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
 <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
In-Reply-To: <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 09:26:56 +0100
Message-ID: <CAPDyKFpPCmuCVXEK0S5dOauDChKQShGUTenM1RzqSCPF29=3iQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
To:     Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>, Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 09:24, Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 17/12/18 1:45 PM, Faiz Abbas wrote:
> > Hi,
> >
> > On 11/12/18 12:05 AM, Faiz Abbas wrote:
> >> The following patches add driver support for MMCSD on TI's AM654
> >> platforms.
> >>
> >> Previously I had added the support to sdhci-of-arasan driver with
> >> a separate phy driver[1]. Since then it has turned out that tuning
> >> operation (for HS200, HS400 and SDR104 speed modes) will require
> >> configuration of phy registers. This completely breaks the model of
> >> the sdhci-of-arasan driver which relies on a separate driver to
> >> configure the phy register space.
> >>
> >> Because of this, I am creating a new driver with both the sdhci and
> >> phy register spaces. This helps me use the phy registers in a future
> >> patch that adds tuning support.
> >>
> >> DT patches will be posted in a separate series.
> >>
> >> Changes in v3:
> >>  1. Removed reference to clk_ahb as its not being used.
> >>  2. Added comment for pm_runtime being used for enabling
> >>     clocks.
> >>
> >> Changes in v2:
> >>  1. Reset OTAP delay back to default value in init.
> >>  2. Improved patch description for patch 2.
> >>  3. Minor style fixes.
> >>
> >> [1] driver and phy patches posted before
> >>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
> >>
> >> Faiz Abbas (3):
> >>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
> >>     controllers on TI's AM654 SOCs
> >>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
> >>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> >>
> >>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
> >>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
> >>  drivers/mmc/host/Kconfig                      |  12 +
> >>  drivers/mmc/host/Makefile                     |   1 +
> >>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
> >>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
> >>  6 files changed, 428 insertions(+), 46 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> >>  create mode 100644 drivers/mmc/host/sdhci_am654.c
> >
> >
> > Gentle ping.
>
> I see these in linux-next.
>
> aff88ff23512 (Faiz Abbas) 6 days ago  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
> 7f6e4cc6727d (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for AM65
> 351b766ef2c7 (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs

Correct!

Apologize for not confirming that I have applied them. I don't know
why I missed that for this series.

Kind regards
Uffe
