Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF74C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A11206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jb8tmixT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfBLLZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:25:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44642 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfBLLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:25:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so1145149plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Rkz1AmMpKZd1fV18RILezy4fqM6DWDhnKRct6ucDF8=;
        b=jb8tmixTe8vNIL0kFX68s8W7CQ32XaRvscPfqyFo0sP+lASF0aiI+WJqVLrfn/Isps
         c7MgUj7qIWkbJQ1YWzW+81uqBYqlRZ9x+8T4AbqXr5Ry819P6/j1SkqAA/TmcxolvjgD
         EXSs9LS4BzPRD/fEoYy4lYWEXnyqS5dsaioL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Rkz1AmMpKZd1fV18RILezy4fqM6DWDhnKRct6ucDF8=;
        b=q5ZVgo0Fpq4tnYd4WVDJGWRR5Jqp/snpOkiO94d/nLT4CfFPGLRXYqFObpFCBgwkU9
         3mXD0U7JSOAI2WYtOp6yiOrpYn+Bkrn+dlHsXJ9LwOX344V7BWoj4e4jRjkC1jABalI0
         2+NbT7uidQFWpkE4w6VTwHMluVKaWqZ/ipztl8TWjd8pSXsSgCFXfJZtSErG58RLUGgP
         1eabhAB+uoehoP4glbAaOOOauHgaTOmMIvqlmMd/Ebyr5l53g0sWzB/Wb60I+mOymExx
         pje16BRh1v05BQbHd/h++WYCJI/JxoUBDSPKd8MzZPMbI/prnSjGZX9gsnBnLc48MkGG
         A9Yw==
X-Gm-Message-State: AHQUAuaSLFm6z+G4Qha+IbjPWJ/2JQk7DTcKDZesSGdlgkpqzENCjmoT
        WgKC7v0AY3GyPjwAfIaH/69Hhg==
X-Google-Smtp-Source: AHgI3Iae63XfS6haCAMBSISZHqmTtoPiV6gNNuJFxw9sBjKPkdaMfhC/sOLcGN0yZ9gzlZsX5irZDg==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr3540022plb.241.1549970701206;
        Tue, 12 Feb 2019 03:25:01 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id q28sm22399460pgl.35.2019.02.12.03.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:25:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 3/4] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date:   Tue, 12 Feb 2019 16:54:38 +0530
Message-Id: <20190212112439.2025-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190212112439.2025-1-jagan@amarulasolutions.com>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures, it support chipdata which is similar to
existing GT1151 and require AVDD28 supply for some boards.

Document the compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index c4622c983e08..59c89276e6bb 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
-- 
2.18.0.321.gffc6fa0e3

