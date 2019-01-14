Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFB1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E65620657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jH+vd13d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfANXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:54:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfANXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:54:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so345418pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=GcFO5WS/zvkcBB576EkMI7jM3FKeOXl/Fj/3UzX4K6Q=;
        b=jH+vd13dpHloO9LkEydTYN6zRhCDNnCNUo/N6iPTeDJddhuoaZ0ufzoh3B0glavZ9j
         V//2n+gx1Bo93DKaphftGSkEazZqvOGcfdt/F5HYIFXUlRzf1Fi/MLLQR+FH2GZAwAzZ
         azrba4FEsZ09rZiBhIJmRaPRStw//RPqDXIxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=GcFO5WS/zvkcBB576EkMI7jM3FKeOXl/Fj/3UzX4K6Q=;
        b=HNi0MYW+/XPMeKNJG3HWq+SUUmgXha0Dv74D7fNxVUVlChh8fMSoouT+p6U19aGji2
         oQ+AUemhuF2KoC/S4HSnSu5P+/U+iPXS9UaKqRjOWDTtELILlojHPLaE1gAJbtY+A0rK
         PYUOhLhPNREMjAgtHTpNe+6OA2z7+ehf4g4ehxLgsrLiEhTkcbLM+3tQek5Pbf2wI9Dl
         bmBH0V4clq2xfe6+/CRPOrYjuMnQtDd6ouP3kSiKzm7LZTdvxx3NHS/jiaRy2fnrhKCJ
         TbMY+R6N6lh95DVBhRNaee6S8iL3mG1RroYjT+OUC096/zPb8z1/joUft2/jNm/s9JWk
         SBfw==
X-Gm-Message-State: AJcUukd7TGbY7O+lKAGvOSJX6h0D2roEo4IG9IYDb87M9MXbyHETA+AV
        lojS0sp5YfCE2YM1J9sK9y8n+Q==
X-Google-Smtp-Source: ALg8bN6mdZ+53PCrRlQcRxPwlw75nBQ0qHLbJIdM/n70Z3H+sVjNGxzeLnPgE1Wq9AbtKWwkhQ8jIQ==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr1075417pgb.26.1547510085884;
        Mon, 14 Jan 2019 15:54:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x3sm1932587pgt.45.2019.01.14.15.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 15:54:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/9] drivers: cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
User-Agent: alot/0.8
In-Reply-To: <bbc4cccbe2931de5f7e07b70a4873624424ac930.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <bbc4cccbe2931de5f7e07b70a4873624424ac930.1547458732.git.amit.kucheria@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Message-ID: <154751008451.169631.1287877735076391741@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Mon, 14 Jan 2019 15:54:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:05)
> Several cpufreq drivers register themselves as thermal cooling devices.
> Adding a pointer to struct cpufreq_policy removes the need for them to
> store this pointer in a private data structure.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

