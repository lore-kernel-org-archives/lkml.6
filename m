Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA99C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E96120685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEylvC1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfAJUxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:53:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37050 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbfAJUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:53:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id y11so9308103lfj.4;
        Thu, 10 Jan 2019 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
        b=qEylvC1tIWWrajc6u8JkeM6spEmKlLzZhCxFWzYOs5PkStF7o5brriirrKqXYMPUMY
         RkKy/7hYSADhegHFVrKBOa/m97rTucc2ldHDy439dQUEoPfLhoVrfmB8dZYHK2bRmVFj
         Vz0xPpOdrKoXQwmhtZ79+R8U0qaV5GZMxSkAv8rt4NU0fYq9/GQ2ZjjUZ6eTbR2T9P9h
         XxCo91nbt05U9F7bHC6lPuc/XlJ5kmaza1JzkXph30K5UeBpbgatGdM4c5FwTZVYJMjP
         0ApEx5WvDWu7fxFGl8KexsRMWUGEFTNLxNN/bc2Lpx0BPlVFkAg5C03OWcIIK5K5Nkti
         /nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKLSuDSiUbomGh4I8Fz1drCWaMjb7DVbiuB6C0KO3NA=;
        b=RBmXRhIkXfkK+4YFdNjLQtANK+jvXwI+iUnzMTdBh/6HR2FwziYv8x2N/sYwML3Yx9
         492QWdcbFN3wm9ODYPvOK++QOxr0pp16LJVPYVVHoMquKb4F3+MAZEJEC03/usER6rts
         fuV1cq2xZ36/7rtvXSzgQlKMB0HNLvfUTRIaNJs3ph6S5bzI77hR6m9JC8YdbKvW7GKY
         HgA1EVSqToqNBZp9IfQ6pxs5AkCQiZKgnZhl+wy2x3yNQJ2d8c4qcPvG0YsEmK0HKj7P
         YUQgO5A3OagMgdsI568BqSzGvGu8nIvBrJr3AvBiPJjluOY6Y/3OJl1VH1IrqU51464T
         nq2g==
X-Gm-Message-State: AJcUukcy/CtpnzuRFr5BH/6XaAC7rLcLypNAD/vFTyHACswbxFgh6izn
        xtHC11SxBGhU1nR9vZM2ZGI=
X-Google-Smtp-Source: ALg8bN6ZHHz3k1uF66q/M+s39R9kCKkICx9Zi3c+pYrJ6cC8iJmhLtwjwql25urZvdAOxm4reiHdTg==
X-Received: by 2002:a19:10a4:: with SMTP id 36mr6698911lfq.60.1547153593330;
        Thu, 10 Jan 2019 12:53:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
        by smtp.googlemail.com with ESMTPSA id z7-v6sm15389690lji.42.2019.01.10.12.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:53:12 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
Date:   Thu, 10 Jan 2019 21:52:12 +0100
Message-Id: <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds dmc nodes, which are needed by s5pv210 cpufreq driver
to work.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index e9613418228d..2d55a3a6e79e 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -25,6 +25,8 @@
 
 	aliases {
 		csis0 = &csis0;
+		dmc0 = &dmc0;
+		dmc1 = &dmc1;
 		fimc0 = &fimc0;
 		fimc1 = &fimc1;
 		fimc2 = &fimc2;
@@ -521,6 +523,16 @@
 			status = "disabled";
 		};
 
+		dmc0: dmc@f0000000 {
+			compatible = "samsung,s5pv210-dmc";
+			reg = <0xf0000000 0x1000>;
+		};
+
+		dmc1: dmc@f1400000 {
+			compatible = "samsung,s5pv210-dmc";
+			reg = <0xf1400000 0x1000>;
+		};
+
 		g2d: g2d@fa000000 {
 			compatible = "samsung,s5pv210-g2d";
 			reg = <0xfa000000 0x1000>;
-- 
2.17.1

