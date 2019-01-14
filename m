Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FC8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681AC205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aHQpeLr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfANX67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:58:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47017 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfANX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:58:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so363199pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=a98CcbltBM1dUi+YPMK4QT+0QLyfIgsUpuaG7XU3hnY=;
        b=aHQpeLr0w7ERuYZ94fJM62w7ruoJtNwPNlv1w8TNn38G4fMPF5eVvmpMVM6u7szrlI
         hxVFMfIiUd6h3xqE6uOkLPXRKHQBvcDDf5UE20qTEuH2VwPNHeJH5a2OY5k4biSeLw86
         uiqtcqNruMNMuahgnJSEZCFJMrvUNvBPrH+FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=a98CcbltBM1dUi+YPMK4QT+0QLyfIgsUpuaG7XU3hnY=;
        b=oIxgMY0w22Pfo2/WroLSz4+hqvdSZ+vDrpdNw/61KPlIUPqICwLRkCrwrfXEirHhtg
         K3L4Dm8lyqa9FNlavf+dgZwtC6w2ShCCKrHyRsXTZzDS0vjJNEyXohv6zE5KKz69p7WZ
         Q31iTMY6YezML7sfFcgYh+lNu2WIQI8q3eYHar2LSCpaH5wuxT+7HxJNXaTgjVWMulFE
         7UhVYhhyzx2/C7SjfVKIQNnmUOXqr0oTUF8wsjccv4yxfwNdNZDT4CDDQ2VmZQOVourU
         SLJhA3uWId8ZojqSpiFf7JxFrPfqrPX60DG3b1CHXVgH9RJBLQdZ5ruRGokEMWvPEBAQ
         FMgA==
X-Gm-Message-State: AJcUukeaLAVyLEB6L60tKkITQUtcd9Z8zAO/D3oRSDoIKbPoEnn61KpZ
        jRaYVAT887WWNwNs1G1drM6D0Q==
X-Google-Smtp-Source: ALg8bN5WRph/P0Bp3xk2UG4OeM+RwAKmksN9QChtH+Lei1VaFwMJ4dcD2ZiKb+jL0aYQ13Kw9Tf9Bg==
X-Received: by 2002:a63:a002:: with SMTP id r2mr1037458pge.212.1547510338834;
        Mon, 14 Jan 2019 15:58:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w23sm1741948pgc.72.2019.01.14.15.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:58:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
User-Agent: alot/0.8
In-Reply-To: <b5e5698973c156f16af825ee92b8c94af224e634.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <b5e5698973c156f16af825ee92b8c94af224e634.1547458732.git.amit.kucheria@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Message-ID: <154751033725.169631.501138616256305502@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 15:58:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:08)
> Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
> to auto-register the driver as a cooling device.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

