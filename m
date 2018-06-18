Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2633C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7859220852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgF9nKEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7859220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934595AbeFRONT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:13:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40402 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeFRONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id t12-v6so9101948plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IEgwgEQof0yD7MJNlHDTvloee/uaBX8orQ7UFMT0mjs=;
        b=NgF9nKEibdFNEd+SL/G4MXRM9EC/VgE/QSX5Ppj5pH/l6cfx0uZFy8OVOqaTepqfGw
         EzfKDjy9yzO/Ei27JsPo0ZGOUU7pjBdqh0w5yq1qmcYK71wcgSkozpPjT12eQmneiVwW
         8Cn+5HbA+D8eoO4ek4IyZYdiwe96Dsr0dg0Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IEgwgEQof0yD7MJNlHDTvloee/uaBX8orQ7UFMT0mjs=;
        b=oGt9/PCDLoUYWGsYD5DzqSuF1RAZbocmcBUHbYyXUgRU9y4aDYapbZ8QEXvGdDChWO
         FGgxATrZj2hktLPbo0x9qo6jApWM6VCOeerV7CpnsvyFIbmOGuTQa6Yap19U3V6XUWor
         cLpEGrs9x2XcDHirn1K36mNuvNN4Jwhhwb+mDE1j8qRpVlXMdvxexQ2IlHP36L9EsBh9
         5CeRr4JTurxxZjefLD5TsVvZgTNKGenemiGjxTb0aYxCi9N8rPjii4briLvVKvnByJwv
         63Xx6g7M+WPqX0zS11DCkJalKCb/b016V7DgZiNMGI4/qjGp+s0/9VyuT49uSslMrlo2
         PEvQ==
X-Gm-Message-State: APt69E2YtdWlAzwctUweBZpJpFFy5uWXkfHxzaKT5CPSjL2qptW1009W
        GLt5EmAoHZ9CdJ/ttMQoF9uGNt3FC38=
X-Google-Smtp-Source: ADUXVKJ/06mC2uuS0nnykJCLL0W5pWKIlzogG9bsrkkUB9dqi47UPUXRP0p6747mTvk2QeXbSb46vQ==
X-Received: by 2002:a17:902:70ca:: with SMTP id l10-v6mr1352203plt.174.1529331197037;
        Mon, 18 Jun 2018 07:13:17 -0700 (PDT)
Received: from localhost.localdomain ([27.59.118.133])
        by smtp.gmail.com with ESMTPSA id t17-v6sm25813339pfj.75.2018.06.18.07.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 07:13:16 -0700 (PDT)
From:   Vinod Koul <vinod.koul@linaro.org>
X-Google-Original-From: Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/3]: hwrng: Add support for qcpm v2 hwrng
Date:   Mon, 18 Jun 2018 19:42:56 +0530
Message-Id: <20180618141259.23141-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for newer version of hwrng as found in
Qualcomm SoCs. To do that refactor the msm hwrng driver and add
support for v2 ops

Vinod Koul (3):
  hwrng: msm - Move hwrng to a table
  dt-bindings: rng: Add new compatible qcom,prng-v2
  hwrng: msm - Add support for prng v2

 .../devicetree/bindings/rng/qcom,prng.txt          |  3 +-
 drivers/char/hw_random/msm-rng.c                   | 36 +++++++++++++++-------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.14.4

