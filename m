Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15642083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z8DAlXzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15642083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeIZPUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:20:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36920 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeIZPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:20:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id e15-v6so1221923edr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=yan1QIGWmQTUSlbj9ueM/RgJDFg1wMf3qrAex4znMMs=;
        b=z8DAlXzBW3ERci/hqq+w1Bd/uAQuoJY8tJfB8Oj1kwc4BejJzJJiiLYolxzdS7dQwe
         NkqUi6NRL1qit2tHWAna1iu81n8sUvXAsySdnZNeH1Zs7YC7pLkkNhuwlJETyWNqGytk
         IAdLiI80I17hiIC66bpNDDkSZ4aDxTytv9OvjAUo59wyL2G1s7v7wb17WokohTA0qmvg
         wh2+dRzAp8O/8nymtXSos1xxruCVDRpkZo1K/tIvNbeieclMmqwqg7Zc6d5G5yWbN3ll
         NoDDs2VSg51hPBP3BSokAnynEmCUODqKXdVUWd485qEy9SL6jBv0h6CG/SmIwi+YYD7m
         CMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yan1QIGWmQTUSlbj9ueM/RgJDFg1wMf3qrAex4znMMs=;
        b=gtWGwKKdW8AqqE36JFh8le/c3vKMjGHgEaCrZiAYNvLMhjBfyRkBWjGnY5LYMDtkzj
         G4qahiv2k7R/yLJ7RiHjpjkqbgwUX5oHeOyA5hA2OT8UTz57zNwIUxcK3a/HLLHC4TEC
         3Loq56tr3gy8GwlA+ZENiQQrwxSnzbFjrir4DYGSy9kYO2ThKaP1FUUesbfsBEkRHrU3
         iSxzyOK7m5fc3DA4j6FfITSoUS59lDjLJpUu17KFwyY4ZbF2NpxMJSbI5JGvkS5RBLt7
         7s3w0vzrmXrNST2LPxsE35MEga2m/vA9X65OvF1j71IRxDCUz8bbks9Fdi26osMAksqn
         SbnA==
X-Gm-Message-State: ABuFfohU9jOcnEsQI6t6OT2AoA4uJV1wZeQurls09SI/C3JQRm+moTZE
        J5a8iy7NI05yvK/V35mUQTY/sA==
X-Google-Smtp-Source: ACcGV63ak2DfAbIY7Q3Amc7eih5k4Hl5L7bjzslaHIyOOZbj473Cu8Ls18iMXAYFXCYwtlXS7iUVAA==
X-Received: by 2002:a50:fd10:: with SMTP id i16-v6mr7792980eds.253.1537952900786;
        Wed, 26 Sep 2018 02:08:20 -0700 (PDT)
Received: from localhost ([194.187.249.52])
        by smtp.googlemail.com with ESMTPSA id i23-v6sm18218ejc.48.2018.09.26.02.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 02:08:19 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     <linux-amlogic@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] arm64: dts: meson-g12a: Introduce new DT files for Meson-G12A SoC
Organization: BayLibre
References: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Wed, 26 Sep 2018 11:08:18 +0200
In-Reply-To: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
        (Jianxin Pan's message of "Fri, 21 Sep 2018 16:34:39 +0800")
Message-ID: <7hzhw44oe5.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> This attempt will try to add new DT files to support Meson-G12A SoC.
>
> 1) first, Please notice that, in this patch series, the DT node about 16M reserved
> memory for hwrom is removed, since it's not needed by G12A SoC.
> 2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
> merged. In this version, it rely on bootloader to enable the pclk gate which 
> belong to AO clock domain. Please add clk_ignore_unused to bootargs.

Applied to v4.20/dt64, added Neils' Reviewed-by tag.

Kevin
