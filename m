Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16FFC61CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830A220449
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRYOGPlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfARWU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:20:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36220 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfARWU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:20:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so6941329plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=42dEh9DrRFlwPyHlwPBEPmb9CqXY58Tv36DNpzWBWBQ=;
        b=VRYOGPlTgF0BbpJm2VK6EE5styHr4uyXRDkwdwX+ckASDzBs7Ty558DNJDb4it14bj
         ogPKa0BmoShUI1gC82O3z0CAJvxbpTpKRS7c0yVBpMtJyuxwN4XTzAE7kjOgknQWT0XW
         sYsZU8cpga/t4bXkEcZ8K59NQ03hF3ZhJvZSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=42dEh9DrRFlwPyHlwPBEPmb9CqXY58Tv36DNpzWBWBQ=;
        b=CQvsJI8v2FXFFlY3Eyynq38ElyyBThZpXpGoE82PaTCR5naWjDtCYDS/2wANXWyo5M
         wYw9SGtb8toAP4ffgePDxqPRYdMLC9kFS2y9hL6ENtOYvf5bgFkKRRmggu6KLuWwjJ0g
         rnIDDIYEqbU60Ql9LR9pGdeeJ62Bvf806PEeTgvVL+bNXVoR+cg6PwOPfJi6vkaGpBDW
         Fs45NqXmRNYKF2G1QoPDBGhFCES6HFP1HNs/XtpmN1UyaQL0jHKMXOWY/te66u3G9pFF
         HIf1/gsaxjQh78LFZVtgFjjmkU3qjYE2Slh9XEvIH8s4qPdXdOUrAPGrmUgmN6zR7rZp
         yBoQ==
X-Gm-Message-State: AJcUukcJjEVxM6QLn9G8vU3EWM0nDH7uW8sbfeZGWOzzVl1DGk8FD7Ja
        RqRJlQ7LZwBIVAFCyBPua6YsjQ==
X-Google-Smtp-Source: ALg8bN6VxrHC8YLMzLSkLhEsxkbyaKfCz7ehomdQRubnpTbxOw8Bln9JF7mKGw39b8+XyZ6TuBKDow==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr20481995plb.113.1547850028537;
        Fri, 18 Jan 2019 14:20:28 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l5sm11615231pgu.86.2019.01.18.14.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:20:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/8] arm64: dts: sdm845: Add UFS PHY reset
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-4-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-4-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154785002671.169631.10875218484757543459@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 14:20:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:24)
> Wire up the reset controller in the Qcom UFS controller for the PHY.
> This will be used to toggle PHY reset during initialization of the PHY.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

