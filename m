Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E052420989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b="BxSpZ/2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E052420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kresin.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeKZVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:19:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46068 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:19:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so18258026wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7sW7IaUZ6EGXx0NcQjT3M8wEY0OafP/B4sKeDi8lVrs=;
        b=BxSpZ/2xXdDbmKuDM8Pk5NVO//G47rpSTmKnaIf80M/uYGzRMjnRSxkKp+qsl7uwnq
         g3zb9G/PPZi3H/nioOtnP6b4msE66RzP/js7uQSTYSIN5Mp1oWzw9+Z70XCf5AB3Bci8
         7buCzqT7JhVgf7gdQMxG15ZhRMdhD5mujOkn9AE8NYcKxOvrtITKnZ+azY7Vh9+YKAK8
         tjcmBe9b1OmsDO5jL5vrypE1U+51t+dL2d8Nsasj2n+KWOijArduvOgrs420rPiG/Tpl
         spLx0NYOzGLnOUdV8g4C/7FWjHbVmWlhv5X3oYR5uzcdZQK2W9uImQ9pFRtl3DS+mwrv
         hZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7sW7IaUZ6EGXx0NcQjT3M8wEY0OafP/B4sKeDi8lVrs=;
        b=UV1rAP1DciDvq/fH5aZJlyPvh7QWJ42SsvMuKBPjaoby7IklaU8N+8W5nmRYt6oKSU
         Cb2k0PWhb5ChCMWsf3rged3pb1E7XwXqkjI4QktmEMDg38vODBVUJQBsk+sa6OcpSqTc
         sy7GPUkF3DYMphz4E/mm2LqncVb6wOz6WCTdzff6Ec4YnjjRzsuetft3nJvoQT2YBlYV
         Gm6KOFd4rnXSRy0VOFMf+sKQSmPq23ri4BwuAeR282lSm1RxhSsYVGiWpNs05RAadCv/
         OCjHOesmVjnsuWvGzvxaAzRSRJHoZV3oR7QOXb9pU1I5YGaJQYRJPFhT5THxuBWGzJ1t
         pyAA==
X-Gm-Message-State: AA+aEWYz+bQHXbrMcchhrmAglMVujpDC00Wak57AkRAO+p30GZP9rfij
        qjkYcziweWlK+3SFXEKgxyKyNA==
X-Google-Smtp-Source: AFSGD/WSSi45/g4+5LjWAfgBnzc1kDiXZ1/IPjzlnIJHR4YrrOH3lbTgl+wiQlo+uFnHSlzsxremSA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr22234814wrm.328.1543227947846;
        Mon, 26 Nov 2018 02:25:47 -0800 (PST)
Received: from desktop.wvd.kresin.me (p4FED3A99.dip0.t-ipconnect.de. [79.237.58.153])
        by smtp.gmail.com with ESMTPSA id c3-v6sm366907wmb.46.2018.11.26.02.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 02:25:47 -0800 (PST)
From:   Mathias Kresin <dev@kresin.me>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: ralink: Fix mt7620 nd_sd pinmux
Date:   Mon, 26 Nov 2018 11:25:40 +0100
Message-Id: <20181126102540.5304-1-dev@kresin.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the nd_sd group is set to the sd-card function, Pins 45 + 46 are
configured as GPIOs. If they are blocked by the sd function, they can't
be used as GPIOs.

Signed-off-by: Mathias Kresin <dev@kresin.me>
Reported-by: Kristian Evensen <kristian.evensen@gmail.com>
Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux
data")
Cc: stable@vger.kernel.org # v3.18+
---
 arch/mips/ralink/mt7620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 41b71c4352c2..c1ce6f43642b 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -84,7 +84,7 @@ static struct rt2880_pmx_func pcie_rst_grp[] = {
 };
 static struct rt2880_pmx_func nd_sd_grp[] = {
 	FUNC("nand", MT7620_GPIO_MODE_NAND, 45, 15),
-	FUNC("sd", MT7620_GPIO_MODE_SD, 45, 15)
+	FUNC("sd", MT7620_GPIO_MODE_SD, 47, 13)
 };
 
 static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
-- 
2.17.1

