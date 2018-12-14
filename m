Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D331C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF6D20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544800037;
	bh=fMbRbW/E9cuLnK+EugAhK6YSX8DI/CNVYoJux0dsYaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jHFVQIkaZTz6mtWQI0T/522lvhhHI9+DAVFHfDaFvzHTMHJ1WoCvgmI5RaqBeEHW5
	 1kU4NykhgyczqXggPSOA1oizPlCNZI/pb77pYAn8+cGYNhIV4d9tdiOxYaL4vkIZ9m
	 VYrTAZS1j6wdAfjiTSnATR8+L6H8OVnDYJUvVteg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbeLNPHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbeLNPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:07:15 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAA32070D;
        Fri, 14 Dec 2018 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544800034;
        bh=fMbRbW/E9cuLnK+EugAhK6YSX8DI/CNVYoJux0dsYaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yEQUsJZSdkWEI7yKWSIAcJq3g+X/pbn2JW79i9p65IWkxSGeY/DY4kkR9tdjipHyC
         VWiNEb1tUBmYhEddbVmeOo91eE3KfFaE22yvrnLDMPeDUjhYmuC0vXkm/UahPgpbLo
         3hGx1sDjNoYafQxvRsUGIcfGCN+ec1FmCr7dhVHw=
Received: by mail-qk1-f171.google.com with SMTP id q70so3389570qkh.6;
        Fri, 14 Dec 2018 07:07:14 -0800 (PST)
X-Gm-Message-State: AA+aEWaBMVRMhjv0BdD4XVByvQZtWUqAJatle9+bQEh6F9L93FwR14fi
        2k/2ZNDeIbKaxeRIpZSx8gQCzyGRbpn3uVINHw==
X-Google-Smtp-Source: AFSGD/VDmD2EauGOjdmVWNo3S9FJRdWOdNPkU0P3P0TepPOmM06PFcLhdLHyDIRYi3beWz0C20xZYKVEvTv89cfab4M=
X-Received: by 2002:a37:b646:: with SMTP id g67mr2933392qkf.326.1544800033909;
 Fri, 14 Dec 2018 07:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org> <20181208170216.32555-6-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-6-georgi.djakov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Dec 2018 09:07:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrCBDegU5CpFfDrZeyfcbAAdhcn2AscrVA=uK7XqkvGw@mail.gmail.com>
Message-ID: <CAL_JsqJrCBDegU5CpFfDrZeyfcbAAdhcn2AscrVA=uK7XqkvGw@mail.gmail.com>
Subject: Re: [PATCH v12 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 8, 2018 at 11:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +

This and the binding header should have been a separate patch, but I'm
not going to tell you that now on v12.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 838 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1029 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
