Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B82218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFEfadjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbeLUAx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:53:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37841 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388380AbeLUAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:53:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so1665134plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :in-reply-to:user-agent:references:message-id:date;
        bh=YwqAQrS6U2HgrHrXdYvfquS5nQLto8PCMYPBgLcuTu8=;
        b=CFEfadjUFv/2Cyrz91+3b1j4pelvbRYG2IklmkaLkO5l76rn6R0InsWwrUGad3zOFX
         zP0pDMa4Wzt7N5+gCZj5B7PizjrreC5rfv/vyBkjYZhyYoQHOLUoMVbQ3MmoCOHWUekT
         p6Bxzr/q2Baq3b1cav646TyS5L/LfK9wfxcSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:from:in-reply-to:user-agent:references:message-id:date;
        bh=YwqAQrS6U2HgrHrXdYvfquS5nQLto8PCMYPBgLcuTu8=;
        b=ZvyS3ZUW9sM+IQN21jtpHyvl0HbMm8641wtn2uLENJg0Ri0T6TDjdv9vCSRZBsUb4x
         76HNxldcaewIhMzYPJDtogvz9mHgECw2mmeroNHMrWkrV/shmphQhSs/cpeZiGfT1xuG
         U6/FhbW88wCyIXjH4VTGY47sb1HkFYuCskyisXwWmlkdOss3uCt7XWDnJoZECvJbh/cE
         2QeVTZQDPwLLMLJm61+rxkuayDEqBmSpFgvKPLijr0HXu+27SG4qn+loHZwCFgOFsuMY
         hcNtoe5mCopD9TY/SGn52a7nxnHQt6zb8O36M9z9/IR8zxTd3vn4pa64cOhyn/i8UXry
         JLjA==
X-Gm-Message-State: AJcUukcqMN8M1yx7n0PpbiMI/RknC+/MuMdAC31CL+X+KV/SR6jFb0Hg
        kBYt8BPpePZy8oRGt2Nip/E0Jg==
X-Google-Smtp-Source: ALg8bN5/ATMmDyOr3O2+zpRSbsVJDiySWzuhvWyLHnyDQpVCDlCxXvFTSvoMxULs1SSqwQILeRG0nA==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr365520plq.275.1545353605371;
        Thu, 20 Dec 2018 16:53:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f67sm47522891pff.29.2018.12.20.16.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 16:53:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/8] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181219235528.114830-5-mka@chromium.org>
User-Agent: alot/0.8
References: <20181219235528.114830-1-mka@chromium.org> <20181219235528.114830-5-mka@chromium.org>
Message-ID: <154535360384.13075.2908354282137993320@swboyd.mtv.corp.google.com>
Date:   Thu, 20 Dec 2018 16:53:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-19 15:55:24)
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>=20
> Note: This change could break old out-of-tree DTS files that
> use the 14nm PHY.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

