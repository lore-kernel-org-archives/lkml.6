Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B95C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647F720657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WneJxw+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfANWSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:18:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37919 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfANWSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:18:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so275872pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=jIt/iyaErjWY9gXu0JzTVlEHXQtIz8xJ/iRs/6v2cDw=;
        b=WneJxw+dZGD160JajiyvyPPZ1Zg2iBDoRwaNgwzqguSjQOVbIxpFGIKsuJJle94DbF
         BVDQWaRUO34Z4QpLLmV8yM0KRKc7cJTno1NvBvFx0yWd1rngtvgXKT+ZIrfmsieCKOhs
         gqGMkO0vN3tncIGK/1zA+KGgwx9H31d0UovK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=jIt/iyaErjWY9gXu0JzTVlEHXQtIz8xJ/iRs/6v2cDw=;
        b=r29zs5URLpg0UuS2WJvTqLze37RyapUHX86qjGX8CE6ERK5/2fWId4OmNYlmVwYvA+
         qrjFS7osgoULRCe9xsgiEuCMXzLG4vQnchPGnQ7n6ozeVaMRahilh4cC5blTvbjRiQOD
         V1LDIL4f+hiZjv8erCVk3KqRRqu4AWU8rMxGZx8ElsxMY8daTjhmYXWbqltJbZSYaANR
         l7DKaOXD8JslvO+ttGjb01Plo6xeNtz0UzjJpMOkjQyHjn3ACe31CC94z+lHld4aJxZL
         oh2AZtUvC18yk0g2Ufr8oFHBVSuo3cNeYnkU7Ep++GKo7U1mIP8Q99CTIF8QWnnXWG+E
         q9oQ==
X-Gm-Message-State: AJcUukeCakJxhLMWi21yZa4Wa3k/L0nyyKOrjuPDs7bloW72eynOzleK
        oS+/3vgaE+NTfMIa+cL3SJSVCw==
X-Google-Smtp-Source: ALg8bN4OCDykDd72YtAQuGXXxnGDiO4izVeRexs1wAyWoniTLN9ebLTSqnzZB2m+GRA/IDSaUC5Ivw==
X-Received: by 2002:a65:4646:: with SMTP id k6mr664602pgr.153.1547504300606;
        Mon, 14 Jan 2019 14:18:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m67sm2003856pfb.25.2019.01.14.14.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:18:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] arm64: dts: qcom: Correct "gpiio" typo in msm8996-pins
User-Agent: alot/0.8
In-Reply-To: <1544806891-12516-1-git-send-email-jakob.wuhrer@gmail.com>
References: <1544806891-12516-1-git-send-email-jakob.wuhrer@gmail.com>
Cc:     Jakob Wuhrer <jakobwuhrer@airmail.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     andy.gross@linaro.org, david.brown@linaro.org,
        jakob.wuhrer@gmail.com
Message-ID: <154750429886.169631.16525331290505403625@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 14:18:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting jakob.wuhrer@gmail.com (2018-12-14 09:01:30)
> From: Jakob Wuhrer <jakobwuhrer@airmail.cc>
>=20
> gpiio5 is missspelt in msm8996-pins.dtsi, fix that.
>=20
> Signed-off-by: Jakob Wuhrer <jakobwuhrer@airmail.cc>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

