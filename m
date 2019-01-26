Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3294BC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AB8218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddU2K9+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfAZELd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:11:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45501 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfAZELd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:11:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so4995196pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3VdLJWQGXPQM/DsCFiVj823D2T7QeCVu5p3fFIf6EM=;
        b=ddU2K9+EAjuJpdGPbPHcURlafW6BUQGU+lSJ6LZlQcs4NglK/YxpRSrB0Ug8AAIleK
         UcFUUil1uUcKSavzt5fDviPgbutIxhKDUK6CYxKkwSUgAtuLm/gM3syYtrAOcMDJ/ljR
         Iyfwj9N+084PfKtwhdo7ROFdqC2UuXPHhpHWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y3VdLJWQGXPQM/DsCFiVj823D2T7QeCVu5p3fFIf6EM=;
        b=Q4doq3ivs6qwSrNLRZ2M8t2EEPuLsR2fVf8PJw7cbktef2LgG+JKhyoE7qsBS08Ema
         A02eM+98xD/ps3lWSQ/S0hQnejj97pPk+uWNI4wr4+6ulD3HRVEvL9cUg5ne97xEvmRw
         uBGePyABlQdF4Nb6qwtcTa8yJFY0GFgKqCQUEWdxQfiXo7wsyY1vR0/JNheDM2Ns3qH/
         adGL+6kKKWo3I6IIHqoF/WyLX4JUF7TwcUvbxDdA2vWjUK6QcMBd3n6NFtdNzf0U4b/4
         US/IOU5OCcbk7Ex4Hay7IxzajLnHmKoUofEMwDkSWYDJuze3CyNMqNu28n1gp984WuM+
         MoHA==
X-Gm-Message-State: AJcUukfhxVC6uhJQQQg5V3NN+1Vm/KYVPykQad3zjElIJ234D58NuHuA
        x4b/8Zny+acc7bo/iqpfWjCGOUXzIQ==
X-Google-Smtp-Source: ALg8bN4F/IqHArp9RBXNNmWzVsOJVthhC86A/n5rHKctOsqxs/3TkVQ1hx4NXmSmfdY5/gozsz0RvQ==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr13519991pfe.152.1548475892228;
        Fri, 25 Jan 2019 20:11:32 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:e69d:b1bd:9891:c622:302d])
        by smtp.gmail.com with ESMTPSA id h129sm75099676pfb.110.2019.01.25.20.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:11:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] MAINTAINERS: Add entry for Bitmain SoC platform
Date:   Sat, 26 Jan 2019 09:40:41 +0530
Message-Id: <20190126041041.13173-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Bitmain SoC platform with myself as the
Maintainer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..da85ffe5e3f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1372,6 +1372,13 @@ F:	arch/arm/mach-aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 N:	aspeed
 
+ARM/BITMAIN ARCHITECTURE
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/bitmain/
+F:	Documentation/devicetree/bindings/arm/bitmain.yaml
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1

