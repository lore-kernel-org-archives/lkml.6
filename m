Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9522C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6032173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVlfXtPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfAJAPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:15:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38950 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAJAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:15:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4336437pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=keXGZ0bK7jf7zlwyxEbThUOH3JU3uoQZjV0oFFmVFhc=;
        b=nVlfXtPb3ug4WH3fD7Dy7MlvR+IxObqz4gqj6U0CElePcSlRvb2IzJc9C6yASRv1aM
         uAK0I7zOV0w8aKn2qRHYP6WSyyuFRsKtQNKVAOmXEtlAx4OATQF0zjk8HnwKQapANamB
         HNSAZm/rxZnNHoDXF5TvrVaZ04DVL30Bs5z4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=keXGZ0bK7jf7zlwyxEbThUOH3JU3uoQZjV0oFFmVFhc=;
        b=n4NPA+GAELB3fmYPjrZptGrh++8pZm5zcfBEqCvO0Aeidn3y0JTTth71H7YQnRAJE/
         QcBqtbjsUQy10I5KxxXVfgfkQ7bz95YaVGjle51uqPzmKloGzJIsXsb8OG1v1V79aFoX
         DGQUZkavFm+MRYHpQ0xIBhpKgcuH6Y7Lk1LWbPVriSCRWvze7idGi+G19Jbe33ZIfJvM
         Px92vu1dC3yZ9Xb/B8KqPEuQU3TWyuibbpjgWYDdj3ZHXVxLwLNbEUhIkxHyBYdH8EKc
         +EXq885jbqEpwB/BzCptAebOqFI/FnD7SWj5aa4/D+iN69KE6ux/FAcG24PGIB8wSRvG
         zTtQ==
X-Gm-Message-State: AJcUukec2Ew/fuxYICgkgWJ8WsHoERV4MAcKLMqyh/8ijDr4NsPtBXE4
        lK+Rhu+ivjlMfSayR+fgWstsfQ==
X-Google-Smtp-Source: ALg8bN7A8s6q9DTFSnXA76Fo0jtVT4+Sga3btLwNUgkS9bV4Mkdj1JNgQcVKBYueuELVgYhLzNv1Kw==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr8127171pld.236.1547079352356;
        Wed, 09 Jan 2019 16:15:52 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t90sm152858419pfj.23.2019.01.09.16.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:15:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/7] drivers: thermal: of-thermal: Print name of device node with error
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <52c46a3a4fd1674295d9c2577be87d73ce545044.1547078153.git.amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <cover.1547078153.git.amit.kucheria@linaro.org> <52c46a3a4fd1674295d9c2577be87d73ce545044.1547078153.git.amit.kucheria@linaro.org>
Message-ID: <154707935071.15366.2171988962628121832@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 16:15:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-09 16:00:50)
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/of-thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 4bfdb4a1e47d..5ca2a6b370ea 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device=
_node *np)
> =20
>         ret =3D of_property_read_u32(np, "polling-delay-passive", &prop);
>         if (ret < 0) {
> -               pr_err("missing polling-delay-passive property\n");
> +               pr_err("%s: missing polling-delay-passive property\n", np=
->name);

You should use %pOFn to print node names.

