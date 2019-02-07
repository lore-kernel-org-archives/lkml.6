Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B507C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E3E20811
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BFNfuLOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGDX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:23:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38206 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGDXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:23:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so4135572plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wgMLZtwbxS9Z4PMvknmxQ2RRO/mBgmvoLu3T0GddWLs=;
        b=BFNfuLOPpEVH0BDElhJ2FAyxVIWfcgPnbEtcK7Oomy7/5m0TiqFnBIU0mfaVIDjLi6
         SSqVW9ycop/cD8I0KsRZnRYuNZvnN4st5HheWG92DRCttgmmFR18OrVj6F1wtl/Hi247
         n9hAH5KNcaXZeaYuvyWammk3sBh7VoHy+2SnhX6sc4HCXASXeaIdNJx8wLznnuwzmuUH
         d8+/xuPBk1rDDF67aSwkzM9hiG4Kk7hrAdnbMDL6cYRe6B0KZt+hBM5o74YuBiMBup0c
         bqxWkMU9CKyrSWgMomYtUeaPlHaQ4zoF3N+6hNEXmnsg27Gl1y518ZNu0bbe+yAMhwPv
         N9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wgMLZtwbxS9Z4PMvknmxQ2RRO/mBgmvoLu3T0GddWLs=;
        b=DGWdhRWOL9Zbotu6Qen4I2htJlbBK0fmIwOE8keoy6ZUXYp7lZxKZuBXI5zku0l0Ey
         DP8Do2i8sQEKTITRMB+68K5aImslauJ+xyuWkkfXPfHJ1OpoG5ZFZX+A0z8egrJLfIpa
         DyrPQg3udJ3P0mIk4FwGqu8phLRYHXQSY8khY8qbSiCHqUFqrVki/yqBnQDkbbWM5m+y
         Qr7aRK3M2JRttg+vozBsQ6RWNN3ThudOZWnYm+FSJ1qxJFa8WREmwjQlvU1LrhsYhViL
         xSqN5JVH8LJqfZTtNfRFV/Ne78erutKcuqWZ57nabFjgMtzeNmUxOzfPtXF290inm32B
         dCXA==
X-Gm-Message-State: AHQUAualKwXP4a9s+knXzbEiZ+wBlvu2llOocqcs3jWNl/G4mgAMdSWO
        90sNGfDJR0nAfxmoG8rNOwA/XA==
X-Google-Smtp-Source: AHgI3IbSz0/OUlXHq1X8d1l7V6vht4CARVIl0WrRPaAxws7Kyb00C5LYas8twBs6xF7WOObcMFlvZg==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr13857459plc.225.1549509834989;
        Wed, 06 Feb 2019 19:23:54 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id i72sm11363785pfe.181.2019.02.06.19.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 19:23:54 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH v2] arm64: dts: meson: fix g12a buses
In-Reply-To: <20190201133732.32169-1-jbrunet@baylibre.com>
References: <20190201133732.32169-1-jbrunet@baylibre.com>
Date:   Wed, 06 Feb 2019 19:23:31 -0800
Message-ID: <7h5ztwi8ng.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Fix apb, cbus, hiu and periph regions which are not aligned
> with the documentation and the information provided by Amlogic
>
> Fixes: 9c8c52f7cb4f ("arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support")
> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.1 (branch: v5.1/dt64)

Kevin
