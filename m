Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86807C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E68F21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hXdR3RmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAJA2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:28:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38307 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfAJA2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:28:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so4037701pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=8eBGWXckAb/SIpb7ck6qGfkx7wOiPVDSozVWyaBmSlg=;
        b=hXdR3RmEevrr14XpABoUDwtEkVMf/CezZImacygYi+n5IwUDq/Zb/p1PbhaW43GVRn
         6nZutfaLPiOuXyco9BQl7gE985yyDbDKz6PTX/oOPRk0oHXsj/rO7z+jztV7pG73yIJu
         g4fmzb2+QbRPV60ZeoBCGen3s/MsMjzCDRrsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=8eBGWXckAb/SIpb7ck6qGfkx7wOiPVDSozVWyaBmSlg=;
        b=OVLFWEY5UycP5Lsk29XubifwUslvtGTH1mWSAN4ypn0nkCVkGDJOhBuv3J6kKB559D
         5ejbKuP3c5RPvSiw5ffCyg7ES3Er+/4UrB9HP+j8IMhKEjUO+4bt3ptsITHTUl3IjCrz
         BpsTBqx7u3DftufGO8MZrOOZju7RyrNCme/Ih4OaB1rxEVDmI3rEoSYycRgbp3WW7TBc
         yLCIjVWCuuRHiJ5KxMGbnAuCc0ambn+Bv5hCDotBQONBYj4/zUnLkPfwsi+bN6Hluj6x
         mQVD4F+zkYay7BzExkX0pymAh9sy5skTNuz779D8Gh1A+Jcqk4duhdCBRVxRpESaBNKk
         asGA==
X-Gm-Message-State: AJcUukeA0pjoSpP5dGVSEJHM9PHRdzHfNDrLuICBq0bXtpA9un4B2XqU
        pQUQxjaa2Rchc65699HFTZdULQ==
X-Google-Smtp-Source: ALg8bN7zVfGKluboNNOvPv2WfOhP27kIopy4TTazy6qSiuuF6CchwF9VSlTRmdhxw4uHYZ5VOmNYXg==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr7471353pge.433.1547080100377;
        Wed, 09 Jan 2019 16:28:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f32sm89968438pgf.80.2019.01.09.16.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:28:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip points to cpufreq
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <cover.1547078153.git.amit.kucheria@linaro.org> <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
Message-ID: <154708009884.15366.3039982038291126570@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 16:28:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-09 16:00:56)
> Since the big and little cpus are in the same frequency domain, use all

Oh? I thought the big and little cpus were in different frequency
domains and voltage domains. Maybe that's what you're saying here but
I'm misunderstanding. So change the wording a bit to be more clear?

> of them for mitigation in the cooling-map. At the lower trip points we
> restrict ourselves to throttling only a few OPPs. At higher trip
> temperatures, allow ourselves to be throttled to any extent.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

