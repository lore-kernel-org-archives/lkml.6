Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD55C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368A2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fh54rnDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368A2208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeGaKLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:11:45 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53961 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeGaKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:11:45 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so3199456itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OFXBxoFqHrGmIo4X4+LPdS9MfUbw7/eaKNM3ng6ni6E=;
        b=fh54rnDAzWovTBWeByNuU8wZWe6BWD7zOdMy1eWXJ7DBU5uzydpFbNh+Le27Cie8Nf
         P+Ftezs1j00lfnyVFbUsLYJr1LFFZ3XKy7abZgl302oEDa3nxa8jSCmBwjlxUs9r3lj4
         ogd5ECQTLxt8t45tvSQLvXvLVbxq9IEiWx3N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OFXBxoFqHrGmIo4X4+LPdS9MfUbw7/eaKNM3ng6ni6E=;
        b=LroYJF1hCTNiyPw/QEHwiEigg06QMZFmt1FnWykMo57ZHgm9PmWCOEXnqYxWJQNZPv
         I7D2vyFPmnXJc6Uj6n1RCH1f8b2hRpvrjLi5A9tEdbAc1wvSzoeFXqGs2bSZGbtKcVFP
         BGZT4HbsWjWMJf0HXDQztUFj3Vgmv2PPjESVFqYYFvQggy25GK+4tya+QAReGR7uU6Jm
         YvyrxyZDqwflQMp/UPX7CQZv/kQbt6Ys6mZZrjCuLd8vD/2mnjsZ4KvnaThf8CmOmT9+
         e+Cg6Jpk82S4gplD0bdZB977TA62w48pC1jRdH6WAGZgFoMRpbXMMvOMlFhRKY4stQDW
         cLnA==
X-Gm-Message-State: AOUpUlERalTxF5mSmkqbhehs3B53FYKXvj/v21KoQdkbdjhkG/B3PeYQ
        RTB2I+eg5RN6p+64Aga9V0/iqNwtnJH8/Vm24yaPhw==
X-Google-Smtp-Source: AAOMgpdO1LzkGFSNyTo/fhT1wxbX41YmUODlTNgHVHo9S4fAABM2VgxNlStz8clBm1c0SXitqVxOSXWWsU0OVTOr85A=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr19435254jad.107.1533025951970;
 Tue, 31 Jul 2018 01:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 01:32:31
 -0700 (PDT)
In-Reply-To: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
References: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 31 Jul 2018 10:32:31 +0200
Message-ID: <CAPDyKFpN99iDYf1mcG-G1=AAkiw8OjoynvK+5cBV8GvCs6WtKg@mail.gmail.com>
Subject: Re: [RFC] PCI: imx: Add multi-pd support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2018 at 20:17, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> which can be power-gated independently. The driver needs to handle this
> by keeping both domain active.
>
> This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
> it's own domain. Defining the DISPMIX domain requires a way for pcie to
> keep it active or it will break when displays are off.
>
> The power-domains on imx6sx are meant to look like this:
>         power-domains = <&pd_disp>, <&pd_pci>;
>         power-domain-names = "pcie", "pcie_phy";
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

See some comments below...

> ---
>
> Right now if a device has a single power domain it will be activated
> before probe but if it has multiple domains they need to be explicitly
> "attached" to and controlled. Supporting both is a bit awkward, this
> patch makes the distinction based on (dev->pm_domain != NULL).
>
> Maybe the PM core should make this distinction based on a flag in struct
> device_driver instead of number of power-domains? So by default when a
> device has multiple power domains they would would be activated
> together and this patch would be unnecessary.

Activation is deliberately left to be manged by each user, as the PM
core/genpd can't know when powering on the PM domains make sense.

The main reason to why genpd powers on the PM domain for the single PM
domain case, is because of legacy behaviors in drivers. Some drivers
don't call pm_runtime_get_sync() during ->probe(), but instead use
pm_runtime_set_active(), to synchronize the state with the HW. This
means the ->runtime_resume() callback doesn't get invoked for genpd,
hence genpd must power on the PM domain already at attache to cover
this case.

>
> This is marked as "RFC" mostly because I believe it should be handled
> inside PM core, without driver code. Does this make sense to anyone else?
>
> This is independent of recent patches adding suspend/resume support to
> imx pci, but supporting suspend with multi-pd requires adding device
> links, not just activating pds at probe time.
>
> The device_link is marked as "STATELESS" because otherwise a warning is
> triggered in device_links_driver_bound. This seems to happen because the
> pd devices are always marked as "DL_DEV_NO_DRIVER". Maybe they should be
> instead always be marked as DL_DEV_DRIVER_BOUND?

Using STATELESS is correct, because the supplier devices, which are
managed by genpd don't have any driver attached to them.

[...]

Kind regards
Uffe
