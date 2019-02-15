Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E92C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E885222DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DDB884Gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbfBOVSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:18:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45885 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfBOVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:18:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so2403409pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=kEeR4v7xQkZjq0BVPH4RffYg8Gx/Bx2D+XYWhaFGZSY=;
        b=DDB884Gyq0Vlx1MSm9FYgVNq5wxX5byRWZGEjtbmJqEmvI/fudyefDU1JjTbgnBNPN
         XDwipY1kEsaKS0LqXn9U28G+TBbgBYqMlLNBzn+1wyBOklmKCmxLMV65PcR0p4V9lTLl
         9FqYcHihHGz2AOk3fDLRWL8Ahm1+SSRcrMNgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=kEeR4v7xQkZjq0BVPH4RffYg8Gx/Bx2D+XYWhaFGZSY=;
        b=bvnrAbncVG2MRIQ0f6p+G8LKWe2VhMqQNnjxOgTyEP18Vt3tQTQ/wB1JySQRZLCcb/
         U3QKE3yzsnMFnQr/HMfllPfPe2TkdaLYh2D2P8xSeCo5qbocck/BHbEUEB3HF+5smiaq
         VMt/d60pO+HdVDMqrH0nEC5BFnW/6BF2QnSBp8+Urliq4XcAu2T8rp08adYmZlqBLvxI
         tN1V1OuBUuHRbUWUM5gFDu9Xc4Y27b7FvuQ7MozDisyhlxYmvvzNn+nvdks6qw2MTyDJ
         a2xk+4WffiSzgQCiCTCe/v9+r+pJ0ZgyMkqDtJanmq6xSp2DAwVcIjwxmOnMMUQPqg+E
         +nag==
X-Gm-Message-State: AHQUAubPdgL+hWZUXRZh+qpPuNugYh/SS8oc18CF9N5JykBPN2ktzUdu
        M3rGok29yxvQZWQIeJJjmgmPL2+c1Wo=
X-Google-Smtp-Source: AHgI3IYXrBmhq2fqa3ZI6ZXImaYL2d/almDfM6bGcmPWWUtr30PI+yEvF4XsBWZneoBfe9JSEC0yog==
X-Received: by 2002:a63:1013:: with SMTP id f19mr7259800pgl.38.1550265531823;
        Fri, 15 Feb 2019 13:18:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v13sm7776958pff.20.2019.02.15.13.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 13:18:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
In-Reply-To: <20190124202205.7940-3-ilina@codeaurora.org>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 2/8] irqdomain: add bus token DOMAIN_BUS_WAKEUP
Message-ID: <155026552985.115909.18373098620037043468@swboyd.mtv.corp.google.com>
References: <20190124202205.7940-1-ilina@codeaurora.org> <20190124202205.7940-3-ilina@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 15 Feb 2019 13:18:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-01-24 12:21:59)
> Add new bus token to describe domains that are wakeup capable.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  include/linux/irqdomain.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 35965f41d7be..05055bc992ab 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -82,6 +82,7 @@ enum irq_domain_bus_token {
>         DOMAIN_BUS_NEXUS,
>         DOMAIN_BUS_IPI,
>         DOMAIN_BUS_FSL_MC_MSI,
> +       DOMAIN_BUS_WAKEUP,
>  };
> =20

Marc, can you review this patch? It would be good to know if introducing
this token is acceptable, or if we need to come up with some other
approach here.
