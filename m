Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69CC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA822086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnckiiMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfARRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:39:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46342 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfARRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:39:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so6911045pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=LYvuL/Va9SbXKCN0GGrysXrY9M5Jz9MIkq/UJ4/Hgos=;
        b=VnckiiMeslGc63kJpFFZCv2PPpkbvOGvgPLuBx+nAO0GAHcRjiIMo5mThP6gal+ZPk
         52gJQhaKtKKFCGI4O8Di8yJzUbgWqmEooIlvNnh9McxhNKCLXTr2se4ah+dsoxE37Hft
         BAVC1mKtIGuQhSkey9iUGl4SmqKrQkZYsnZGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=LYvuL/Va9SbXKCN0GGrysXrY9M5Jz9MIkq/UJ4/Hgos=;
        b=DWROxKGZrRwryx0DsEHNl/eDrd7kJro8akGV9/Im1fgnOpYGK0pMSflKNiB17kNtO9
         qrmT5yfyCauH4Dzy+RsrCk4ksiHbti3WZc3WaWptOqUTivgf2WIqHnGBdx013xoype7/
         V70Rs7s++ePhj2BUMAQND5zc2zVamgJ/L0TWBamRNjwV8+myWNB3z3N90pZLwoCLJuU+
         xLEd/4v8mQCY5jdCLzsvnE/72jTRm/LMgTzm71vfLo7P5dx4tUhhxXmz+A0eSk9eou29
         1HIbHj42P/M8hDOSE5E1cXzX6l5AWzCO/qOYFDqKLtRF1AYp0rFcrIRCA68DTmR+GGuP
         OpAw==
X-Gm-Message-State: AJcUukcUmGh3blBMbvmcaoDWzCr1elwkAI8/Fm/JTWWr1r6YTnHMBK+k
        NdkQzwQ/vcNoeCU408LpfT/3gw==
X-Google-Smtp-Source: ALg8bN7+GmPAO++UEgwylXIuH8T6h+dZla2pPZgRupBD8bB+BeCteAauGw3TvUzohujmhUgF873/Cw==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr18023753pgm.354.1547833190014;
        Fri, 18 Jan 2019 09:39:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i2sm8539473pfi.66.2019.01.18.09.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:39:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] soc: qcom: update config dependencies for QCOM_RPMPD
User-Agent: alot/0.8
In-Reply-To: <20190118044801.7312-1-rnayak@codeaurora.org>
References: <20190118044801.7312-1-rnayak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org
Message-ID: <154783318835.169631.6614930101893188915@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 09:39:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-01-17 20:48:01)
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a5d5167c3f16..1ee298f6bf17 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -109,7 +109,7 @@ config QCOM_RPMHPD
> =20
>  config QCOM_RPMPD
>         bool "Qualcomm RPM Power domain driver"

Just curious, does it need to be bool for some reason?

