Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3799C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763E92073F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4nu8Cja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeLaS4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:56:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43720 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeLaS4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:56:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so13456580pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
        b=W4nu8Cja0NZNaGlpKmet2nCOvwvs+V9OUNGUYT6vL9a96lzBBU9hwnGPa0/QO6/N7V
         JhnRIZ2Sg7oWgg1VAsSmMkS4UaCg6Z7d4gF27U5+ay789PISSTjkhjJfKFfUikh1VwoZ
         nJ0EUPTrJLFWHggWgz//MNCkty/ZLuQs8xg1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmFI5a8lPjCMuBHux9Ylzns+RwprhO23lrIeWOAs4Cw=;
        b=PgkMSja1daTUg9GXhXDHwerIqDysj8j+lBWuMJAfvSNQWmEC5ZTehWPl06erudQZPM
         kjLs/OxHCplOzFYfeD012+GHcy/FYpWDwfYktJBUITxAEWQYIbmsAviY7TC92Fi2kWsP
         4zs301TNwusFwKCZEL1/QmKZAX3+NegvhSHx7ZT/h0efL3THeAe9mSFO9YxLumfeD/im
         Wfwrvdr5f1yU/rul4MpqejuSsvpdsuafAq07+3yYD+0lJA7VKcxl9Bd85IB/4nYtaW93
         RHskACeOtMukyd4U3pmSnbpXL+616yhLX0+u8yM4k/JDOto5i1eX1HdeaG08dhgUoJtx
         +k9Q==
X-Gm-Message-State: AA+aEWY0/v3F5fUepnJR/HK/LKKCIagK4q0iAoFc4ysx5TNhxI7NVoua
        FmHxI1o661/ksy/rzlAZdeAu
X-Google-Smtp-Source: AFSGD/W4CZPMYeZnQs2N+vGT5R6DNgkdzBwfT/FBzlWKkgdtK7qR7JuylOG3A7ZrE5mQVJiX4iHgEg==
X-Received: by 2002:a62:d0c1:: with SMTP id p184mr38627489pfg.245.1546282576851;
        Mon, 31 Dec 2018 10:56:16 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
        by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 10:56:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for Actions Semi
Date:   Tue,  1 Jan 2019 00:25:17 +0530
Message-Id: <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the linux-actions mailing list for Actions Semi SoC architecture.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d37f8a4743c..f30e25c8e4a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 N:	owl
 F:	arch/arm/mach-actions/
-- 
2.17.1

