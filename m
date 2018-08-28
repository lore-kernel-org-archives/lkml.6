Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19665C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69A1208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMR09u19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A1208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH1JDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:03:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44628 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1JDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:03:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so180497pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zM9jMMiIpO+tw+pHUNS7ovGl/M7/awbAeQj1W9dMgeo=;
        b=QMR09u19Tlp3AonXDDQ07DM1AMg53jAiqXiY5LZfuaevUCMKsJUCBWLyxnPNehKVfn
         STyiA5dsXvP91vNhYGw5OuqEy+CMj1ZMW7ahtkM2vF6xrZBOU+2k1VIqnG5fgUh/AmVk
         waeo2xItZ4NH2ohwxCbs3lUa750K7SGXPsufs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zM9jMMiIpO+tw+pHUNS7ovGl/M7/awbAeQj1W9dMgeo=;
        b=unbl+Cs1v0QAvAPSxze9GCiyZ5KgVpKmbtZnj/c875a2Wruzk95bYi9BtZ59kacAWb
         vK3WN1VakzGaM+6mFBYO60J5CbnghutOl3vmIjOvo3o+L1qReCow7HHnlcBtQH0WngpK
         YrC1gGc+0iF8plDkOlHQMNXDUsIZ/602/p43tZGR7ONuEJ+oSLuuWdOwsEMYzREO0SYu
         K0h+9vP+Vzj4PP/DUzA7GYGZ+RRQ2RQFZNmzXCYNiIhMr6GedgUOEng4QD0q7KhTu7Bz
         oGiuGuTQPVMKH9+3uzeFIOXiGJH+WTgJUVHVROgOOieM2mCHYiVxMdbc3rGCH05Onop2
         Jppg==
X-Gm-Message-State: APzg51CSJaX1dO3QJxTKsCcw216bugOhCkZn+yQxlzUmNfivo+Z8j330
        gHKIHNrtJKrb45JxJuvd0kSh6Q==
X-Google-Smtp-Source: ANB0VdYbdPAb+AmfPLhbuvu8Vy6WXL26EqmCI8GjMDnZZO9OGLATcdLCJ7yGzGhOHWvqR8lDI6243g==
X-Received: by 2002:a65:448c:: with SMTP id l12-v6mr15250768pgq.277.1535433186701;
        Mon, 27 Aug 2018 22:13:06 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t86-v6sm109430pfe.109.2018.08.27.22.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:13:06 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm QRTR
Date:   Mon, 27 Aug 2018 22:14:43 -0700
Message-Id: <20180828051443.22777-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QRTR packet family is used for a wide range of communication between
services in Qualcomm platforms. Examples of services using this
transport for communication are remoteproc management, modem control,
positioning, power management and WiFi.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..c508462d4c49 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -149,6 +149,9 @@ CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
+CONFIG_QRTR=m
+CONFIG_QRTR_SMD=m
+CONFIG_QRTR_TUN=m
 CONFIG_BPF_JIT=y
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
-- 
2.18.0

