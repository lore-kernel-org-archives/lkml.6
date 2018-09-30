Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B686CC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64155208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjD/CE8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64155208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJABMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:12:12 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:34490 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJABMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:12:12 -0400
Received: by mail-yb1-f171.google.com with SMTP id 184-v6so4744139ybg.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GbfsERuPsZIWYZ0T58jt2vm7fOpwyIoxNzVNx9PrCLk=;
        b=ZjD/CE8EqqksZ8Es9w5kCOFKyJacX6hbZ74YyUwZgoG8JevUDe15WWoG2weZB/wcvs
         IGMXbLUK4Jb0r0tufNT8I2PEGJ+cd8nVS+9f5/kP5yWAfTrdk9USEJ9ossFOc+l1NwbW
         aqO5iwOwJEDVH5y1nDpUEJzwZjCywSjRZ5IRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GbfsERuPsZIWYZ0T58jt2vm7fOpwyIoxNzVNx9PrCLk=;
        b=hG3Vua1GuOCm/hitH4jZMLqsDSY2dreDkCWcWQ0mo8B0Qy3iFTPfkbB+DMKc9LmQyX
         N/wkEr19yZqgpmVtDh5TA0E0pkP/RLFhtO34DBSXBd+euqek08/2J6VH672q4u99M2HV
         vw+P/K0EykF+RkYx6XHpo/15fzezXekh7Ejf5bMc6ncBS2RlcUasAZlRrFxcl+b0kx27
         Tw4CKU+i6sUut4RPfXeftApoPElD/F+ueZ8CYEnEtyAsn4Qr4WZ9MbI56dzVBhW9NkgC
         B5XTXkdyv6o7M8skC3De6N2TxxTRSL+jZdp2MPCoE24Q+pgrK46lPICf6AboRnAlyKLL
         kfnA==
X-Gm-Message-State: ABuFfogwFbW3SC8bAI+AbxgvLyw8iLVkKkr8zzQv4wWvunNFjB5LWE4s
        0I+AktU2EgvAtypLUMLObvGzcL+QbyE=
X-Google-Smtp-Source: ACcGV61obQYMS0lgbsbUxxXQfvjxiscX6fmn/DUQlPkmWJv6353/NuBi29Pn//TE+Udn/AHD2o2r9A==
X-Received: by 2002:a25:3356:: with SMTP id z83-v6mr4136084ybz.218.1538332684669;
        Sun, 30 Sep 2018 11:38:04 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id g131-v6sm4629316ywh.70.2018.09.30.11.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 11:38:03 -0700 (PDT)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.20
Date:   Sun, 30 Sep 2018 13:37:58 -0500
Message-Id: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.20

for you to fetch changes up to 1bdf91fd2ae8226f34ed3a760199946c7dfe746d:

  arm64: defconfig: Enable Qualcomm QRTR (2018-09-13 14:38:06 -0500)

----------------------------------------------------------------
Qualcomm ARM64 Based defconfig Updates for v4.20

* Enable Qualcomm QRTR driver

----------------------------------------------------------------
Bjorn Andersson (1):
      arm64: defconfig: Enable Qualcomm QRTR

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)
