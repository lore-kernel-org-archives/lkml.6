Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8418C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821D5206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544799871;
	bh=3rvvYwC3KoBUNHXdC65+dArf+DJXLB5CK9AiCdUHf+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QJAIUm0hFrexc7+8r0VlosO7neEXItM7gazHXHN6kVuMd7kLzOohquf7JULj0c3Ma
	 UC0JqjBGOzND3nRezG4cwIzXrRVax/ehMbEhC6R6Erikan0yGpAtf/dfDEGuWrvxDg
	 v9nBAEqT0i7JMASbSYlIW5zVgzyqryzdXRm9ToIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeLNPEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbeLNPE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:04:29 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4E5206E0;
        Fri, 14 Dec 2018 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544799868;
        bh=3rvvYwC3KoBUNHXdC65+dArf+DJXLB5CK9AiCdUHf+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tzKP8KUTz1aaRfnHZ9mtXM8jl2/c7vb44cKAorMb2K7w8WWxQ9+MWYUJw00qki2C5
         SB8AWIToiohfcexDzBM47Ybt3ZJUG7Qba+BjTuP2bmJIpCd+FKjslT4KUhnLlxmvor
         qNrZA4+eoylyQZNRUJwFcqb+3MdPoqe1udmn7hmU=
Received: by mail-qt1-f178.google.com with SMTP id i7so6443159qtj.10;
        Fri, 14 Dec 2018 07:04:28 -0800 (PST)
X-Gm-Message-State: AA+aEWbmM0neAiwu4/jUYtGzJmfOl4BwnDDmQhoMmbwEn03KPLDQpe9i
        3SQCh48z8U9gor1Ann8mPJX9wv59IcAlDzOW4A==
X-Google-Smtp-Source: AFSGD/WZ0D+UHfc5Yk3vnIfpZ7wuDjoVQAfSYXBasUi7Z2msbx6SPvsVX3LP6jY8EORVANKvKB+/Z5M8mzOEzQabTRc=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr3229883qts.144.1544799867957;
 Fri, 14 Dec 2018 07:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org> <20181208170216.32555-3-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-3-georgi.djakov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Dec 2018 09:04:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLG32ZE2Ljfkz5wC_yfs4NVWYA0VfQPaB9Q-3=vFjO4=Q@mail.gmail.com>
Message-ID: <CAL_JsqLG32ZE2Ljfkz5wC_yfs4NVWYA0VfQPaB9Q-3=vFjO4=Q@mail.gmail.com>
Subject: Re: [PATCH v12 2/7] dt-bindings: Introduce interconnect binding
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
> This binding is intended to represent the relations between interconnect
> controllers (providers) and consumer device nodes. It will allow creating
> links between consumers and interconnect paths (exposed by interconnect
> providers).
>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

Reviewed-by: Rob Herring <robh@kernel.org>
