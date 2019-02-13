Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37B1222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0rEWe/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391424AbfBMJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:56:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388936AbfBMJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:56:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so1775160wrw.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b7LgYP7807Tnr35awa/NURSdyjs5dTiNK4eNh7zXXq4=;
        b=z0rEWe/SC1ZIQotZJSjlDQmDv0V3/veFo9AbD8eMUFn7814rurn50b3i8NIEWkqzDH
         Ah5wb2f3GoNFvc/CGfYV9Ky6mUI85N/w7VoYtQsbJWlKO8AWBB0gbCbqiRR7fbtaQfIu
         voFCTOM7Rc45DZg/Y66KGPKvInf7gUEHNgIe9AYEtL3DrPuaBEZS4B5MRLdKtkZett9K
         vu/b49IeedXC8latHhxf5RkaJ0BVeEuO1QD53hX9gUDBckdwwLeQSsBonB9dF4TwkCNX
         YQ93Kf02hwq0XDo0VYi/r+FQFi5Kpi/GfCaJU3K1LWgcCoZT+iA24mfdihaVwPnk/omc
         kC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b7LgYP7807Tnr35awa/NURSdyjs5dTiNK4eNh7zXXq4=;
        b=Jia3m7fsfh3bSc6dLOejp12q2rn+CqcZLyq/xN+sDis1VgwiHmJEcbDmYbmrwp/h5s
         7l1pcgEwZr5ZKBDPB5nczajhz8rMHrqjY8bB3OfqgSDM1sTo0/SdSFgwW8hmZPPGnODX
         PVYjGqBfvvvVN+SmkGXYqrOzCtG1UuW3m8cWcVk0+yzMUpuABDCTejxSljis6gamTrVw
         Gd14WY9t06deXO6sIDAj2W4A+/wDzJL4IMzLBsOhkQ8TiYPXzRE5xYt/lZd9mXB3uTLq
         cRrxY+XQRKwRVWePFTn+Ad6XZ4nPV93OH+ERqV88f3f10AW/jRgSzxdU/L6oOsGAJ+1O
         /agA==
X-Gm-Message-State: AHQUAuYQ45cmaPfhdjTT9eUQnEBrNeXs4+M0p+Ey6oaXkZ6mD9Gi7dbz
        ZTSRgncgpsn/taqJwYuNlVQG2ckEOoM=
X-Google-Smtp-Source: AHgI3IZIkLpfc7Bzf8F/fil6wEK4jaYLb+K903quiEEfuCcp3HWcuwpiYbkZm9R1NrAAZTo9+Yw9rA==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr6377212wro.300.1550051776939;
        Wed, 13 Feb 2019 01:56:16 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1008:7bdd:48fa:e18e:8893:ae85])
        by smtp.gmail.com with ESMTPSA id 2sm41244909wrj.27.2019.02.13.01.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 01:56:16 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     linux@armlinux.org.uk, arnd@arndb.de, alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH 0/2] ARM errata 814220
Date:   Wed, 13 Feb 2019 10:56:11 +0100
Message-Id: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ARM errata 814220 for Cortex A7.

This patch has been wroten by Jason Liu years ago but never send upstream.
I have tried to contact the author on multiple email addresses but I haven't
found any valid one...
I have keep Jason's sign-off and just rebase the patch on to v5-rc6.

Benjamin Gaignard (2):
  ARM: errata 814220-B-Cache maintenance by set/way operations can
    execute out of order.
  ARM: stm32: select ARM errata 814220

 arch/arm/Kconfig            | 10 ++++++++++
 arch/arm/mach-stm32/Kconfig |  1 +
 arch/arm/mm/cache-v7.S      |  3 +++
 3 files changed, 14 insertions(+)

-- 
2.15.0

