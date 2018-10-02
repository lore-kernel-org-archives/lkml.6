Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBECAC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F40D20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c09tINXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F40D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJCFGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:12 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:55913 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:11 -0400
Received: by mail-vs1-f73.google.com with SMTP id e15-v6so879066vso.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FlCLNN8Lnqzva0Yf+n+JPxdCDMpZIssIkm6tcmZBG0U=;
        b=c09tINXtYXDuiTkdLdxhSlWTd09evhsq/cSkkrDzrQCBjUl/Awhi6gvAh0SzRQhsZN
         YO1MyKMxMLapHNe/Ib1wOT5Hrm3JscEsVWrhOv1osEVgfAOmjxSSTohjm5y/zYwBe9L5
         F6RIBUfvUe1BqaXUK+zm/AfUHpa4BxRMDn4Dee42nKnj8h3edqtoyQmPWObpjM+j0NGt
         A5T6w3JWbmN6v22sbrbFqyQqm1dTYYz5cp+rELuVOYgtJhaZVAZ9GCXs5Y/Rs74jH/r6
         5U1Z+XStvKMKKMwLZh2A00qQr9HgnyOA71Hjmp7uItjzdZsmMkj8x6Jy/7D7P91xbp0H
         eqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FlCLNN8Lnqzva0Yf+n+JPxdCDMpZIssIkm6tcmZBG0U=;
        b=Z9OVAaWJOn2DjiUfJ9NFTDo3TR7yFbgMm12OYKWZ76XGsM5Q//uexeB9vNoq9SFmYm
         qKMGOrAg+yRBHhbQR8UgmhZH2eEi+TMysrwwUbEzjtAc2PquVUnFQBM3VQnTdSKdjTrH
         y121SGJ5kT+C7cE1LsWY4T0SECbhkhNjdozNApZx9uYXzFvn24s1bw/eHIvejGUi5iIz
         DFL97fHTK5Y/riSka7tRXGDSZL28u5PVmjwDTfYvL96AjbNdV0GB+Q8rdACHLmjaQR3i
         X/dNVSNfuXn6Tt0ChcoKzNBpkX/FubstKIOWvisGQHD3ZgRxRHLby2ambMoMszuKyFcm
         aZYQ==
X-Gm-Message-State: ABuFfog1x4v/CNsidwI/yoXcl6nHN900pSyl5zQXc1Fl1tUVwJIgt4cr
        v3GM7NUub+76hr7+4iHKa/w7EIAg
X-Google-Smtp-Source: ACcGV60NaYYigha8FCXWHRgLzHkvE8OGegHrFxJqwOpuTEdvJ+YX00qUpF3vk+LroQrzrmj3mjdXTdF/
X-Received: by 2002:a67:7b91:: with SMTP id w139-v6mr17171816vsc.45.1538518837153;
 Tue, 02 Oct 2018 15:20:37 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:57 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-9-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 09/15] platform: goldfish: pipe: Move goldfish_pipe to goldfish_pipe_v2
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This is the v2 driver. v1 will be added later.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/Makefile                              | 2 +-
 .../platform/goldfish/{goldfish_pipe.c => goldfish_pipe_v2.c}   | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/platform/goldfish/{goldfish_pipe.c => goldfish_pipe_v2.c} (100%)

diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index e0c202df9674..81f899a987a2 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,4 +1,4 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe.o
+obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe_v2.o
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
similarity index 100%
rename from drivers/platform/goldfish/goldfish_pipe.c
rename to drivers/platform/goldfish/goldfish_pipe_v2.c
-- 
2.19.0.605.g01d371f741-goog

