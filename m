Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25902063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqPwElC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfBZTg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33849 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so6729416plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZobjpzmwB69MRQCBwHsa8FPkgaO9Chk6a+x8M+nacU=;
        b=GqPwElC6Lp6FWs2TgNDnepnuXA2eRG75Xegb0lpyt+Fai8fcQQZ7pjNMomjDiIifT1
         bUnVSbv6kP4W8GP1SGQpLSuwpuM9RgmSjRUtlw6l5BNi/2HdoVhSfk4R/frrT6QupgbI
         J/BjhYPKTKJCitXrjof8kYC2saL8lG+kFL437ey1Ro1GiF4XNYAX+lPyD7fF9WkUYMCG
         ykSdo8vnSPlqZL/xRO0GJl0vppT3t/PphSJADLFv0jW98Q2hR71aNQMS23lLTGsdgbIz
         fiIxQgbbG12/HkLdk+vAxsGFUdQmZ/ka1hoP4pCwRFXLuufKsxFVyc2IAvjAHtJar0r8
         ef8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZobjpzmwB69MRQCBwHsa8FPkgaO9Chk6a+x8M+nacU=;
        b=gBBzySOK7iFkh9mHFPA4SOcikrrZmeUxSDVgE+QJouFdOAB4KKHocj2fNvDaeEnv9h
         4AF1Nqu/zRpKVJK798P68Ubak33nICxS/ULRoaNrBzqaIetZycMiYw+2Wq7mrDv/lnYF
         gWaewFJ4nSrYLa2z8jM+pR6b2+VnBm7hXtzF9N/NV7ixY+/62BHljtRoImCL6qyitAnP
         kSCKtCiB+QlqJICImlQQ3cZxvGwQ105JYJOs5pijkEXeE66Se6HWJq5B7Xmyx8AwobVV
         N40mP0vW8Yg2Sl8VpM2MYS3ZRam7fGn1//dFBOoNGmfAzxb4blP8pPQEjxjfnbUcynYW
         tpQQ==
X-Gm-Message-State: AHQUAuaGZa0Zsu4/0xDlfPgSYFlqwETT6LNfyMQttKgO3Z6Z/kUg4db1
        Ob9uQOgpo/9ztNP7aqcUHF4=
X-Google-Smtp-Source: AHgI3IYh5x6pUK5H7y7kg0wlsg+d4k2AYG8T71616pGQIoApw8doiibBqwMV1TVI+w8LsRULbEOwnw==
X-Received: by 2002:a17:902:6a2:: with SMTP id 31mr15092688plh.129.1551209786124;
        Tue, 26 Feb 2019 11:36:26 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:25 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] tc358767 driver improvements
Date:   Tue, 26 Feb 2019 11:36:00 -0800
Message-Id: <20190226193609.9862-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains various improvements (at least in my mind) that I
made to tc358767 while working with the code of the driver. Hopefuly
each patch is self explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (9):
  drm/bridge: tc358767: Simplify tc_poll_timeout()
  drm/bridge: tc358767: Simplify tc_stream_clock_calc()
  drm/bridge: tc358767: Simplify tc_set_video_mode()
  drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
  drm/bridge: tc358767: Simplify polling in tc_link_training()
  drm/bridge: tc358767: Simplify error check in tc_aux_linx_setup()
  drm/bridge: tc358767: Introduce tc_set_syspllparam()
  drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
  drm/bridge: tc358767: Drop tc_read() macro

 drivers/gpu/drm/bridge/tc358767.c | 283 ++++++++++++++----------------
 1 file changed, 129 insertions(+), 154 deletions(-)

-- 
2.20.1

