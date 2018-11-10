Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E068A2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe0MLgmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E068A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeKJNXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:23:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45782 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeKJNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:23:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id p17-v6so1777690pfj.12;
        Fri, 09 Nov 2018 19:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sq/dS5tcLIn+XFiL9cuX2X/teydAN4YKwvXtO/9QKjA=;
        b=fe0MLgmnD60PRUPCdLReiwc4v8Rz4ianNthHDxS7dc3VM7tgYIbHvoHHCHH3T06dCa
         XDr7BTYDMb1oXjTYrKSP/w1Nu0u3+CF3Wyvrv7dEgd6q+LVT23RFDOQrrl38SN4Ki5Qd
         PxbUs356F0D+DGxUN1ix+ZpZp7SC4Ix0sF7orAtmS2m2eHhsp4VXHcTUM2MHIqiv4CJz
         p0nZmWM4m7p3RqJYiP+dDZB0CGTGs8ZDpTeVoCbF1EVJqjq6RA/DsC/ywqYcjmlHhX3M
         GLb4YYa95iQ6QLCAcKVpAbnFX44+ZrxSSejCbumO4jiL3vTMQA0QB8Rp5NaJ86rS9EzH
         sYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sq/dS5tcLIn+XFiL9cuX2X/teydAN4YKwvXtO/9QKjA=;
        b=TId79VBr7TSzSQc24nA52cyjFNhvZf6eXEzhQ5tDLXmY95j9GZZhGFbbVMAkF/A6xS
         w+XDnx0860Z0ug46mPysEowvta/bRo6m19e1EDOeQtw9eWhG6ylfxQ7yoTYu6xlhQBbB
         xFSDLAfKDV9e/V8iRsjFQzP3mkiq6h+q6JWjWPtpY0nB3rqCXk3UGJGJ2Nja2TgRJ8qa
         mu4OqLYNUpR7nVLYTuAuJHFxE6jtArE+/FTSzBYDnJKkYVlAvvT2JWj+2ovNkigjt9ya
         v3dFFy1625fR9BX/XRxG95vqEHwRjHQwFZx523L4ZviGTLLjWVUuX3fs+7OdG9aKDw9+
         n/NA==
X-Gm-Message-State: AGRZ1gJzGu46/+1mjO4W1r2SGfZAynuX239QpgTVIvbqqsI6lxCEBiFs
        Ru148m2ml0LfkdAYOoNajdw=
X-Google-Smtp-Source: AJdET5dw1SRtSdHyWDWpaBmijwPKvbdrM9xHLBA3CPSKfVu0LjQByLCUbpUpzno/tzbLy5fV0eKM6A==
X-Received: by 2002:a62:5904:: with SMTP id n4-v6mr11503864pfb.174.1541821187348;
        Fri, 09 Nov 2018 19:39:47 -0800 (PST)
Received: from localhost.localdomain ([45.76.192.69])
        by smtp.gmail.com with ESMTPSA id w2-v6sm10191359pfn.89.2018.11.09.19.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 19:39:46 -0800 (PST)
From:   He Yangxuan <yangxuan8282@gmail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, carlo@caione.org, khilman@baylibre.com,
        narmstrong@baylibre.com, He Yangxuan <yangxuan8282@gmail.com>
Subject: [PATCH v5 2/3] dt-bindings: Add vendor prefix for PHICOMM Co., Ltd.
Date:   Sat, 10 Nov 2018 11:39:03 +0800
Message-Id: <20181110033904.4207-3-yangxuan8282@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110033904.4207-1-yangxuan8282@gmail.com>
References: <20181110033904.4207-1-yangxuan8282@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHICOMM Co., Ltd. is a hardware provider headquartered in Shanghai, it's
product includes router and smart devices.

Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fc..8c413d8cc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -296,6 +296,7 @@ panasonic	Panasonic Corporation
 parade	Parade Technologies Inc.
 pericom	Pericom Technology Inc.
 pervasive	Pervasive Displays, Inc.
+phicomm PHICOMM Co., Ltd.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
-- 
2.11.0

