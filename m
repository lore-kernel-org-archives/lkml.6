Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90329C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3627C208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="05xK2JAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3627C208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeJPAOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:14:37 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35291 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:14:36 -0400
Received: by mail-wr1-f44.google.com with SMTP id w5-v6so22081220wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ms7gTuetz9nHHqoPhWmBPP69sKWlQEcSRCvL/hAhLCo=;
        b=05xK2JARB3jucua7CZ4WrEDtSqWHLBpIW8ffpx0MPZlB5poe4gfYeifetpdaxMXrFZ
         hXoHZEhxjU9KtTuW7x7qFrpP7/pFB6j5M9HyAaimvXBUYBivDwu+rpbb/46jdmllQD5N
         OcsMTJ4yvTdXauYY5nNB6RQmQy7EeMhbmIvPfWnibioI6spU2lWc79xgZBsMYiHIGUlq
         yrJZ50pD2O4ydBqUC8zzetmTPTpax+riYL29kneFW5U0rrRBEeIEzPpK6Hu3zfL0rQbe
         XNmOLViiQtduRcKvb9UDkhuk4efvrHOYSysBJpnuZ9cOndAXgfCVEn4RV/CNpV8lWXtg
         jUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ms7gTuetz9nHHqoPhWmBPP69sKWlQEcSRCvL/hAhLCo=;
        b=tYjm10f1JmpK1Jh4BADJ2nJ1vW+gS14XZ8ZRFqmvhAkWLcqLKy3Gl1Fcr8DjsrWJjN
         PtikTnqRZRlYQYxCfpMRdhU+bZ8qz4Uji3mA++GXu4L7PXeAvgvaa41djGbS+Nb1tawU
         ZShmpqTm33/2DEkCIHGBkdXXMJkNKuQdOgJWp1x40ZDCKiszGv/w4qwFs4HOWSItzXO8
         cXzsjYdNtyiBqpomkZm/Wjrosh6WJ/4q78noQfXQmR6n6N3l8MiZ9fo4GfjjAVlz93/U
         WOSLA7Q9igyfEJ+Tjc8GbfGpyWLaFQ23Nt+ONENTLpDCdbWkUqUwB5nxtJPWjLjI3jxo
         hTzw==
X-Gm-Message-State: ABuFfoh14anaPGNVucPOJCQgJ0Kpu2FjLvRvElYHQNLpLURgiT5hxUjm
        wWs+3GXnVttqK01zy4Z5QGfNog==
X-Google-Smtp-Source: ACcGV60I87mPSPTdDrLb5hlCM8AHWnt5mNkFCn5YB0aPPNuaQkQBoph8JtM6ZT+Xf0SnFD0PuJL2Qw==
X-Received: by 2002:adf:9e09:: with SMTP id u9-v6mr14706188wre.51.1539620919184;
        Mon, 15 Oct 2018 09:28:39 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c8-v6sm14045926wrb.6.2018.10.15.09.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:28:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] arm64: dts: meson: reserved memory updates
Date:   Mon, 15 Oct 2018 18:28:31 +0200
Message-Id: <20181015162833.7544-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patcheset provide updates regarding reserved memory on
Amlogic platforms.

Jerome Brunet (2):
  arm64: dts: meson: fix reserve memory regions
  arm64: dts: meson-axg: drop FW reserved memory

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 21 +++--------------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
 2 files changed, 12 insertions(+), 36 deletions(-)

-- 
2.17.2

