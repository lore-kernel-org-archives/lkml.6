Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83039C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8D218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGyw5vY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfB0HRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:17:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44770 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfB0HRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:17:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so7545297pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 23:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gO8p6NHNcp0awhzSuG0wNA0Be0KQfI7T7JRNXpwEaps=;
        b=LGyw5vY6kAair9WNvdnUpcUWMlkywltQ9wDsC1qXrycvHu3yu78oKnBc4L2mX5stTc
         XcuKiaXYCVLckSbYinl6EVHt+IwsgSufjNHsL20E40+81AncSaE+8uTSSMBaWmsvNJl+
         pfoUctxwEmTT2Vejg6LHlMoaxuBBI6zvb9WWQwaVGXPPWEVwLeW2DulkG5MvN/EmCGyf
         bWlP3+10f1UfRsyOmXjzni3TAgv3LOuUXRIFX6AniK0sxZC7hi4wNEPXbhXESGhDamd0
         UHw/el/5lr9j9t+a9WUotSJY7wHY1SvT3ivARELM00DALxyULunp0UfEHI7AAvKJZDdq
         hQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gO8p6NHNcp0awhzSuG0wNA0Be0KQfI7T7JRNXpwEaps=;
        b=kTyOlEVcXAyvbBnwquTjxe3lVqcb+WSIAigYXUXq3tFbHs8M4Q/1w8xBpMFO+TKgC0
         XxO9EgCvzc3IZXo/MPQCHdzddb+iSU+wRQl4522toMh082SJsZz8yWc+xvW9s1367kRL
         8xgh4UmILsYKVizIOYlTUJgXiovVLXNk0qg/gGAhmo9de+H+6dugnnfb4JBMVvj6QIh0
         0yCm0JEjOary6Naleavvr9b1Kr4X2Gy0CjYAmNQ9EN88KUUup0auQ3/CQayIUeJKTOjV
         33+X+I4DSbqVnKgN8YJHtrjiobMBrauI7gsh56XAcnbJYNWCZDPVMugW/6WXzHTgmcmM
         k3mA==
X-Gm-Message-State: AHQUAuZx9jjcNCPXLdnBbRE2g8SHehQm7c0hMtNNnx54tXBo2Utmv16C
        OjanDhKAK2Tbs95FocpPUyTz/Qpweao=
X-Google-Smtp-Source: AHgI3Iaxs8akkV/YlRYgue+flJDoLpytUMeHc9NZMTla1ZofB6kRyiwywET3BjObBXkNZhxJHOsz8A==
X-Received: by 2002:a63:2a82:: with SMTP id q124mr1599728pgq.402.1551251838632;
        Tue, 26 Feb 2019 23:17:18 -0800 (PST)
Received: from test-System-Product-Name.sunix.com.tw (114-36-235-188.dynamic-ip.hinet.net. [114.36.235.188])
        by smtp.gmail.com with ESMTPSA id v9sm24245630pfg.144.2019.02.26.23.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 23:17:17 -0800 (PST)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH 1/5] Add support SUNIX Multi-I/O board
Date:   Wed, 27 Feb 2019 15:17:02 +0800
Message-Id: <20190227071702.4103-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig and Makefile entry.

---
 Kconfig  | 2 ++
 Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Kconfig b/Kconfig
index 4f9f9905..645dcc85 100644
--- a/Kconfig
+++ b/Kconfig
@@ -228,4 +228,6 @@ source "drivers/siox/Kconfig"
 
 source "drivers/slimbus/Kconfig"
 
+source "drivers/char/snx/Kconfig"
+
 endmenu
diff --git a/Makefile b/Makefile
index e1ce029d..c9393c75 100644
--- a/Makefile
+++ b/Makefile
@@ -186,3 +186,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
 obj-$(CONFIG_GNSS)		+= gnss/
+obj-$(CONFIG_SNX)		+= snx/
-- 
2.17.1

