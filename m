Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE915C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FE3214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBXbW8L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfAJA3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:29:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35436 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfAJA3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:29:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so4457394pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
         :from:user-agent:references:message-id:date;
        bh=rsEGMz8QdrVpRtN7S/g6VkwnFcLYBhawxwRr9F8P3No=;
        b=jBXbW8L63zHBTwq0FnK69WR81No0ZS+LeuDUReHwfFoo3BAuq/yShzAJXSpNPlfroV
         uAotuMBnPiPZ6qihin+GlD7a9xNEewVX2DuCy9VsQMZdxpIj11GGEInnedGMlZb8xndc
         wrt0kVnwucba5JavjRb1UgbAxMNXirQ3w3+Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:in-reply-to:from:user-agent:references:message-id:date;
        bh=rsEGMz8QdrVpRtN7S/g6VkwnFcLYBhawxwRr9F8P3No=;
        b=cM5172hHzXXQ8Vbb7f/Y2oWf1wgsI3DMCj/c1LLu97FYVZdlr3GYsQ76bucpStiJJs
         4hWZuEsFDkdHW+nzWzM/JE6aM53LXqTHTcJidfZwcBv+sunYFBNnynQ9NP8USc2Jdc8O
         X/1MwQLNlUGod8J/uCtVbOgHUUAou3ESylcuHtxqCp8F4S9Ofop9vlS8WiqErscD7RMl
         uF99A/wdM1YJd+JM17ntd3TqL8EHHR8nQqhzVwSP9R7gP9pw+Pdyi2mPJ1sdNEFCeRAn
         hilU9DZTq5YSaeDXipFXeOLSXJhwifE377JC/yCX8b4aX9d9wB4D3v7gNF6OKceJZCSm
         Ck/A==
X-Gm-Message-State: AJcUukfp2/ygw679/YIii/r3xhy5yTWCr6nDPP1MBe9bmRdKkgzEg8/Y
        lp6uxL/IB7HYRDD5lkNSL6FWag==
X-Google-Smtp-Source: ALg8bN5PmO0rZ0+7Ks1TZnZJX9RGa7bmnQ2oxR9p8UZbRthRJzWuTfjx41UU61TBXrQ7zmimR51M0A==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr5207559pgl.173.1547080184806;
        Wed, 09 Jan 2019 16:29:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 24sm309686177pfl.32.2019.01.09.16.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:29:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to 95 degrees
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <cover.1547078153.git.amit.kucheria@linaro.org> <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
Message-ID: <154708018331.15366.11574628155253134835@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 16:29:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-09 16:00:55)
> 75 degrees is too aggressive for throttling the CPU. After speaking to
> Qualcomm engineers, increase it to 95 degrees.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------

Is the plan that these are some defaults that would be adjusted by board
variants? Just curious why we have anything in here and don't punt it
all to each board dts file.

