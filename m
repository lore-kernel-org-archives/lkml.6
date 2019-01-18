Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C05C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450412054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcpGFzJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfARWdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:33:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42823 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfARWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:33:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so6938281plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=lNzFkQoHMz0Z/rXo+NIQfnZ8LpDmaeZwQs3/Pd4lD44=;
        b=AcpGFzJJzwJ4s9LLPd2VEaJCF8Ywi7qgj9JvuXd5382wlgZ5uxxYLdzGryJdpOBkHc
         Pd6wgfu1gYbj78cHLJe/cnGdcMmvU66ft1YCVRfr1Sde4NU44f5npWHPVMiDGCbNYzC0
         pv05jrQg1rEn0w26YPou1AV0fT2OSXH5v5up4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=lNzFkQoHMz0Z/rXo+NIQfnZ8LpDmaeZwQs3/Pd4lD44=;
        b=dnOZEIhxdr4sgjAXVn/jQz4AdiyRBxYHHRZgBXS+ccdY9q82X/O8KizwCpiUGnXd9/
         d5kRb6hyVu5D0tbcbd/zjFcAOcKHH+n4Uf5R9wYRmij+0l2h2rDZk9wqq4Q7efu/5dO2
         Q7VmzW4UfVx/I/3TIEOXxkc7sibGHBsRnuB1r1fRlSAIMRcQM9B8j1nfhHxBF5/wywDE
         Nwar1rzW1fih7yTEXzGeQKvZOavOkjPPyOFLyQ/OnSG+z5WAlqttal+vfaakdOzS3WAK
         YGQAcBC0JtUIueyTSBDRPQ9s9Hm9EnkIsINmDHFdKweRAELwgwhSZFRIpa8aSrpMrLmr
         JgXQ==
X-Gm-Message-State: AJcUukffDfbS8pwuKmQSTWATaKns6lQDbJoXJe0tLdgZt0VgwJPpswNB
        tdC+c6u/rfbsKt00taqA/H1Uyw==
X-Google-Smtp-Source: ALg8bN4GxVjBefnS039Pq2g9MG2FqtqFZ2NZ8h3KSqLI57QYC3H1LUq/reIYlFPWYJ4qH8Zj9m1dZQ==
X-Received: by 2002:a17:902:bd86:: with SMTP id q6mr20329714pls.16.1547850814689;
        Fri, 18 Jan 2019 14:33:34 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y9sm1262094pfi.74.2019.01.18.14.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:33:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 6/8] phy: qcom-qmp: Utilize UFS reset controller
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-7-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-7-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154785081323.169631.13477061319849880987@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 14:33:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:27)
> @@ -1214,6 +1225,32 @@ static int qcom_qmp_phy_init(struct phy *phy)
> =20
>         dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> =20
> +       if (cfg->has_ufsphy_reset) {
> +               /*
> +                * Get UFS reset, which is delayed until now to avoid a
> +                * circular dependency where UFS needs its PHY, but the P=
HY
> +                * needs this UFS reset.
> +                */
> +               if (!qmp->ufs_reset) {
> +                       qmp->ufs_reset =3D of_reset_control_get(qmp->dev-=
>of_node,

Can you use devm_reset_control_get()? Put another way, why is this DT
specific instead of using a firmware/platform agnostic API?

> +                                                             "ufsphy");
> +
> +                       if (IS_ERR(qmp->ufs_reset)) {
> +                               dev_err(qmp->dev,
> +                                       "failed to get UFS reset: %d\n",
> +                                       PTR_ERR(qmp->ufs_reset));
> +
> +                               return PTR_ERR(qmp->ufs_reset);
> +                       }
> +               }
> +
> +               ret =3D reset_control_assert(qmp->ufs_reset);
> +               if (ret) {
> +                       dev_err(qmp->dev, "ufsphy reset deassert failed\n=
");

It's an assert though. Maybe just ignore the error message because the
user won't be able to do anything anyway?

