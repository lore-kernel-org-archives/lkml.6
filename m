Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A0C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7791A21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZOxNlXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfBARlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:41:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37988 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfBARlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:41:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so3258089pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=i8YzeIZSV+tNbZg46nIA5KOLEsVwyQd4Wo46BC+13os=;
        b=BZOxNlXP96JquWanVsRZIXjYQJF0CKKbb/3ClWqbRj+RMPnHHMXxPPEdrbWFdZnSRY
         ZY6luGC95jZ0J6N54OQHDqFwKxK4Xvz7C6jJ6KF/eq43qamb039LNA7Up08plrtxYKzO
         td22y3Wl/N7FLW6yhhNFdbGTUBml4bjZGLt6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=i8YzeIZSV+tNbZg46nIA5KOLEsVwyQd4Wo46BC+13os=;
        b=QC3iiEyw5SVsczsF69HTjX2kLhyB7J1ZiTXZ6NG6BOhexFrm3WyvYVPSa9+hQPY3a7
         Mdrz7/2fVGo1+jgOqjpWY+rO0pQFBgkraW5Y+Z9rSXDx9Xl8kC/RNaX+SsZ6WRLHMxi5
         kMsBzE+2CwZ+gWSihTBdoQ7qcKeqEx04mYaflSTyrV0rR/uG7dNc/r+s4G0Xcw+Am+a5
         d7ovtwrAQCvZ2joXAQGLYOPm0uDSJK5jl/VtBnPJATsua0b/ByEJQavnaImP92sOUviQ
         TlazSUU+qmV+MNivJmXZJjgN8z7yjdq07yYD+2MvLO8iD7BH3eivhXgSgSqtMZhnbfMa
         KCcw==
X-Gm-Message-State: AJcUukdlPrEwoApfy5ldhw6VK56ssXstMfrE6TwQ8f1k6bUqPS0fqR+Y
        lyvEhLFT6yuQkfIy19q+tfgiyyBvTIw=
X-Google-Smtp-Source: ALg8bN6o4Yap5DaQWJNs7N+FV7mCdAPjkTAIZ7ym8XfZzN2rhFfFeZYOSu1umAVzKMulxDKrLxr+yg==
X-Received: by 2002:a62:c302:: with SMTP id v2mr40603811pfg.155.1549042876664;
        Fri, 01 Feb 2019 09:41:16 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b2sm10417704pgg.87.2019.02.01.09.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:41:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/9] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154904287525.169292.437324364877227469@swboyd.mtv.corp.google.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-3-evgreen@chromium.org>
User-Agent: alot/0.8
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190123221137.41722-3-evgreen@chromium.org>
Date:   Fri, 01 Feb 2019 09:41:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-23 14:11:30)
> Add a required reset to the SDM845 UFS phy to express the PHY reset
> bit inside the UFS controller register space. Before this change, this
> reset was not expressed in the DT, and the driver utilized two different
> callbacks (phy_init and phy_poweron) to implement a two-phase
> initialization procedure that involved deasserting this reset between
> init and poweron. This abused the two callbacks and diluted their
> purpose.
>=20
> That scheme does not work as regulators cannot be turned off in
> phy_poweroff because they were turned on in init, rather than poweron.
> The net result is that regulators are left on in suspend that shouldn't
> be.
>=20
> This new scheme gives the UFS reset to the PHY, so that it can fully
> initialize itself in a single callback. We can then turn regulators on
> during poweron and off during poweroff.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

