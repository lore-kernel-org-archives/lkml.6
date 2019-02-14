Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53615C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C2F21927
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGXgbkE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408076AbfBNSXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:23:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40256 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408055AbfBNSXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:23:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so3570057plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=FAWxPv94ddgd6BnLn4nm1oTRlMpVgNSJoFrPvkS3g5I=;
        b=KGXgbkE1qGUD9wMmvN7YKz5WXey9m3sl1LX1bT2j2Yh9IIvz1iA6QQnR8p1IW57KNr
         z1B1OR+cNHlwiHFz6DOpX7rWc6lResAxSW9c4BLsTL46ASNQ5RrvL2J/tEyoDc0pMk3o
         klXEaf6S4xIKkyETbuEdDiPJiaDAI4a0YTNV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=FAWxPv94ddgd6BnLn4nm1oTRlMpVgNSJoFrPvkS3g5I=;
        b=Bg1tLUnte474iVXXXAYQucvn6VLB3HqzrF94pGgcLPrevg3NvKDXHeoZozCQsF4MBd
         gnW5Dh7C+UkzKqFltInA8mj/5e3eDDCvRF19CGtlsEfUXW2/gAkGvHgm04/a16NMLSu2
         RijeK0BDZk/buG4DIVXzDIQ7lWvEqT0LSFeMvUmcDXTVwmMSrk+wTBIscJdSESEgSvAY
         VWpZeWyC/bMH3rPUKNRCxBMO28dKc4dghIwi8vViv+rKpZBWfs7RU2DEv8Ja4e3qEW0G
         mkIuLru6WlMsGwIz8KWypnue5zpL11vZbEvslg7L7YSEVe5z/dXG2N5DIn4q2VgwkjRK
         Tb/A==
X-Gm-Message-State: AHQUAuZ1V8K5/q0bXDeFjY++ekQcUZyYnN5S+xaNOT2yE/3/5gar1FuU
        gma705As/6ohiHXsMsfM9TOrgA==
X-Google-Smtp-Source: AHgI3IZeXXVtscwtX7Q5eQleR4x23Hih/A3s/BfWPA1ORxhbnAt8Ch5ai5eGtPiAMOXI0ljQ08MCvA==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6mr5535680pls.39.1550168631797;
        Thu, 14 Feb 2019 10:23:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q1sm5038302pfb.96.2019.02.14.10.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 10:23:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
In-Reply-To: <20190214181249.2749-2-dianders@chromium.org>
User-Agent: alot/0.8
Subject: Re: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
Message-ID: <155016863043.115909.10810905918164847994@swboyd.mtv.corp.google.com>
References: <20190214181249.2749-1-dianders@chromium.org> <20190214181249.2749-2-dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 14 Feb 2019 10:23:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-02-14 10:12:49)
> As of the patch ("PM / Domains: Mark "name" const in
> genpd_dev_pm_attach_by_name()") it's clear that the name in
> dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
> allows drivers to pass in a name that was declared "const" in a
> driver.
>=20
> Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_nam=
e()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

