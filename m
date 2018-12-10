Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B0FC6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C3620851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Er9KWsV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeLJPwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:52:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46723 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbeLJPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:52:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so5130401pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=SKjVSf8dpmsTtLFnF0xryQKCuUU5YZDVw+X78jCeUXU=;
        b=Er9KWsV5uYTnRy72a8QhaBtfikaJ9/SvYiWmiwU73BQohrg60w1JvffR9ZP2dCXriR
         02xR4VnNFKVc4GQUNN72a4+BDLDZGgQMwP+EEjZwdNTN+gIqD0dLgDiLto+u0NKkoVQH
         p7cMJ4lxq5BuP+aFmsotbQtiU8FXYSZz9rzcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=SKjVSf8dpmsTtLFnF0xryQKCuUU5YZDVw+X78jCeUXU=;
        b=mxxE43bydYYdwkI26cIbKVWIWPzRyQYCxKvseseTafS5Lefzmw4IcLeiaDotgfhrE9
         01b6ZuyswE8Gc/19cF7WaH7m+SGwwwIwKHsSXvKspzyj7BYuQuwo7YggZIOOG88d1PqN
         qDv9NZUZPLiJpleli3GHbzOx2U6SPe8KjqSc0yCV/IDolZ/ABewXxE3pFgCoP3/C4LBz
         OBxwO5MMO4JDJbM51aKfH7qKXAyFcV16yzVUYygUG0ypcaCTjqEfpLz3iXvFi5u0TgF0
         8Z+nV13swmFI2eHUXiwDJV8C1FuCOZYLsFOiZYG5A6SUWdqBmbLuTVF70Ox9AkbzCLMi
         x/8w==
X-Gm-Message-State: AA+aEWaxCD0zhUDhxwzJffd6+j9dP4n23XQEPYab4z6YMopF/xIcf7qD
        Z7a5YxSjzBMwIzpeFQXn3QajPg==
X-Google-Smtp-Source: AFSGD/X3ojzuxlUxuoxH6041iJmWzOxr1K1Bgto+0GU0gkfpiVO53WXZuEdfzT4moY6r9Ow/XmvrpA==
X-Received: by 2002:a62:220d:: with SMTP id i13mr12745610pfi.162.1544457156011;
        Mon, 10 Dec 2018 07:52:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h128sm14096883pgc.15.2018.12.10.07.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:52:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181204224234.62619-6-mka@chromium.org>
Message-ID: <154445715454.17204.5993193179251214562@swboyd.mtv.corp.google.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 5/8] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181204224234.62619-1-mka@chromium.org> <20181204224234.62619-6-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Date:   Mon, 10 Dec 2018 07:52:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-04 14:42:31)
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>=20
> Note: This change could break old out-of-tree DTS files that
> use the 10nm PHY
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v4:
> - none
>=20
> Changes in v3:
> - fixed check for EPROBE_DEFER
> - added note to commit message about breaking old DTS files
> - added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag
>=20
> Changes in v2:
> - remove anonymous array in clk_init_data assignment
> - log error code if devm_clk_get() fails
> - don't log devm_clk_get() failures for -EPROBE_DEFER
> - updated commit message
> ---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm=
/msm/dsi/pll/dsi_pll_10nm.c
> index 4c03f0b7343ed..2d23372acd20d 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> @@ -91,6 +91,7 @@ struct dsi_pll_10nm {
>         void __iomem *phy_cmn_mmio;
>         void __iomem *mmio;
> =20
> +       struct clk *vco_ref_clk;

Same comment, and also get the name in probe or pass the clk pointer
around instead of storing it forever.

>         u64 vco_ref_clk_rate;
>         u64 vco_current_rate;
> =20
