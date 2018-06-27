Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90833C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4695C23C88
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb/FnDQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4695C23C88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966173AbeF0ROl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:14:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43528 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966014AbeF0RMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id m12-v6so1552072lfc.10;
        Wed, 27 Jun 2018 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZ+D5Sc+yJuzFf75xVhwp5dGypKWh4VeY4IuDiPsg3A=;
        b=Lb/FnDQFAQSC4dk8O2TPrePDEynoHuD1VXi414YPPKNGpfOlGvJdQaQOBce5jryYfU
         JUgN0bWQFNRlfzkUly/L362LkTY2UXb+OoRebFR60mtAbv1ywDoIfuCHmHW2iEMlYyFH
         7XJk8uauADYIs0v5HrPPq5O+aRBjDg/p3xW113zUbXWJtO0W5XkwrjkA5wvJXQHrpcmW
         gjs7VEtUqFrSORzfXbAo59hwZyvkNo0Owj0TITvc71y9HIewULHYk18H1PKpidKwWG2T
         Zctj2Cy9WbknW5eXrhs7Idh3DjvY4h3rtFqMANAMwExH4LjomaAayubbyKKKxn6N1r9S
         LZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZ+D5Sc+yJuzFf75xVhwp5dGypKWh4VeY4IuDiPsg3A=;
        b=qhMHrVBTG+tsUVJpPWcIQEczAlrOd3B5KkcEgpgk8mpayO8CCNEMIa5O+ir/vIkWFk
         0EfpBv8IXDtrz//PKrzt7QXCgid8v53jkFsliynxKu/H48CxNE/77ss0650Op0qmHGDc
         JhAby6rg3Anzd4cHMcF2oj1chh6QjMKEEyGTE1HETJUw34TvzDc4JGEWN4mnMpc1w5a/
         u3D2Uu6GHis2uSN843x2afZcPnWivfoPdajBYjBCvB1o9HLCCCIJSsda/REZg5IwJMxt
         oWs5y4a600iiRwU6L5egIGZK5gL7jrp78yfzlF4KOHcJh+tRzboYNtCIbsMFBBDd51Ng
         2BCw==
X-Gm-Message-State: APt69E3TfXMcGJo5aT+lZH/R12bBzf5KKtHs/crMWMUsAsOGE01zwmE7
        pij4iXw0Rv85owpciUSchUA=
X-Google-Smtp-Source: AAOMgpeH3eRg321IDycIfJtuDO/QbJmN/QksMsOYj060jK5i6KZMfcJuQMtjC0zMXCkcr9R8wOSaWw==
X-Received: by 2002:a19:c301:: with SMTP id t1-v6mr4071716lff.45.1530119565659;
        Wed, 27 Jun 2018 10:12:45 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:45 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 06/10] dt-bindings: samsung: Document bindings for Samsung aries boards
Date:   Wed, 27 Jun 2018 19:12:20 +0200
Message-Id: <1530119544-30023-7-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for Samsung Galaxy S (i9000) phone.
Also add binding for whole Samsung Aries devices family (based on S5PV210).

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
--

Changes from v1:
  - Added missing commit msg.
--
---
 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 175f669d9bb6..3fa287a86300 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -2,6 +2,8 @@
 
 Required root node properties:
     - compatible = should be one or more of the following.
+	- "samsung,aries"	- for S5PV210-based Samsung Aries board.
+	- "samsung,galaxys"	- for S5PV210-based Samsung Galaxy S (i9000)  board.
 	- "samsung,artik5"	- for Exynos3250-based Samsung ARTIK5 module.
 	- "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
 	- "samsung,monk"	- for Exynos3250-based Samsung Simband board.
-- 
2.7.4

