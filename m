Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E063DC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265D21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpVEC3Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfBARld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:41:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfBARlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:41:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3238248pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=xhaUDjq3zJX8CeA8X/Qr23csv+mR1pEjP2Xb7sAQ1Mo=;
        b=ZpVEC3KdMDY85soE2APBwmVuk7uz8ILKNK8qoSsMzCvnGiPq/3qVFFOnXzzPwQsXJU
         r5g78eyHlV2VfGJ52ryK9wuRE8G089vS+IN7suW8QZW1VUyp+3OPlic06jOTDc6o+vvF
         Pi5Fii47/nljhnNxQYbItZ669RkYUV8uBm7Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=xhaUDjq3zJX8CeA8X/Qr23csv+mR1pEjP2Xb7sAQ1Mo=;
        b=i9+4LIbIgCsUzCymAU9Jen7CcScyY/2IpnNQ5FgdAs/Pt0TQQdNoklmR2Q+izA3V0D
         atiO9tx7eUFsS8K4FAf6g0gXbakqItOKzLaBf3LfZ5afDD7AyZCkZNrKS5+eUF81hTGt
         XWdBgU4DgUUdaQNkFfVA/ZAA7+QZGE526P3W8NJX4FfXPfnGY+qmCP0lxQoNFExh2mbW
         qzk/3MQ/l0zB3QFIgnwc8CTh4HIpGX1zDRICtxCT/yQj4rPoh3Bo9aPzNR4uLrdcB5Gx
         gSvJlDdLeAicyEjVOvJyufvvFMfVAQv4kqiKVWlfrcMZDKCFxSHCzI/8aEV+jx5A5kAx
         nO1w==
X-Gm-Message-State: AHQUAuYaToojFR6uRwo5wizEADvqIQ/w1c2tJUvM57s5LTA0BgfQE3hM
        fM/HOD8Z6uXF3Rl7tGrQKvnxwA==
X-Google-Smtp-Source: AHgI3IaCgg2Mnga91En1HmLod/vHFCiwxhV6XGRhSxrbkZxOlkrii8aFdfkPI+IQZxOVNURloL2kdw==
X-Received: by 2002:a63:193:: with SMTP id 141mr3152922pgb.136.1549042891757;
        Fri, 01 Feb 2019 09:41:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d129sm14040178pfc.31.2019.02.01.09.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:41:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/9] dt-bindings: phy: qcom-ufs: Add resets property
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154904289035.169292.3983054171703334142@swboyd.mtv.corp.google.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-4-evgreen@chromium.org>
User-Agent: alot/0.8
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190123221137.41722-4-evgreen@chromium.org>
Date:   Fri, 01 Feb 2019 09:41:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-23 14:11:31)
> Add a resets property to the PHY that represents the PHY reset
> register in the UFS controller itself. This better describes the
> complete specification of the PHY, and allows the PHY to perform
> its initialization in a single function, rather than relying on
> back-channel sequencing of initialization through the PHY framework.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

