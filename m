Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F72C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EFD208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 15:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knmXYajs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EFD208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbeFQO7x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:59:53 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43562 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933362AbeFQO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:59:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id x13-v6so5545574lff.10;
        Sun, 17 Jun 2018 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrApQpP0WvafpCiewDuuf1a+KJDyfHguFBeMD1BeR+0=;
        b=knmXYajs4hMok3DN7KUr1o1qEgpeRdk45qP68tYXon1DPoPPPrnIzEeXBbgJ8CqecY
         7IA1t5+zm6iUNYQWLHClTdQ7grTyRgG8iK4dNMpRybNSNKCkjsPS/Wwa2coTGQE+TORs
         owkf5gGolAzrpNyC57pFrLIiy3jkNuSStGfmH0zLfhb1e6wLyTHjqMKD67nOpAeoTJBb
         hm/G2tfhdjT6LOHi5o5FbwPU84v6ymVJYRJ4HuDN3CJwMg3wBYtxRb+kaDeI2Ese5Pfr
         dm9cO0ie93seNsjUGBrV5Mz2PEViri+PeiMEIa014b0TiBvi5M7o+yAEsegswWXOH1s7
         zGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XrApQpP0WvafpCiewDuuf1a+KJDyfHguFBeMD1BeR+0=;
        b=Lc001K15I/6K1bSzVG9k1542uPHOB9XXAHDmNvgpj04cSJAoIUoHSZ8eMptsHrVnbp
         4+d6WtflqL6/YXDHmkcR8MswRh/OGfJkfwHGDahokLSaYR4nC05jZJqwhK0+xbXpVIe4
         rvs+MxBod/lXH6aZ7eXreg6T7kK4STibsb8mh87l21G6AqPx84m1BzcdQ/ROcP1/2WDZ
         Uk4hrwl1IhE3iOz8iU5NYqsA8EdYua+jKNJtlsCijhYMmE/INPm7ncgtF2O74kcThvN4
         F8rHjk8aHUd7UY0vRdvPBCmxtX3pVoh2sw63DzXvvIndmKw+hS9lPAgRal2wi8/sBYmR
         9TMQ==
X-Gm-Message-State: APt69E3oWQtADvAcyOXLsBukIuyooQ+sf08cZanEYI3uI5JZIiGNtHXj
        QCUP6VRza4mudAliurk+ztc=
X-Google-Smtp-Source: ADUXVKLjjV/sQCwxCwGuY6v5q7/+YiwXcwGxPH7NivWH9SsWmPqAI6tOjEAJZgU8rZ+eax2hDwbVWA==
X-Received: by 2002:a19:184e:: with SMTP id o75-v6mr4704945lfi.118.1529247580254;
        Sun, 17 Jun 2018 07:59:40 -0700 (PDT)
Received: from localhost.localdomain ([109.252.55.139])
        by smtp.gmail.com with ESMTPSA id r21-v6sm2296173lja.92.2018.06.17.07.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 07:59:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] dt: bindings: tegra20-emc: Document clock property
Date:   Sun, 17 Jun 2018 17:55:33 +0300
Message-Id: <20180617145539.4758-3-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617145539.4758-1-digetx@gmail.com>
References: <20180617145539.4758-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embedded memory controller has a corresponding clock, document the clock
property.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
index a6fe401d0d48..add95367640b 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
@@ -11,6 +11,7 @@ Properties:
   set of tables can be present and said tables will be used
   irrespective of ram-code configuration.
 - interrupts : Should contain EMC General interrupt.
+- clocks : Should contain EMC clock.
 
 Child device nodes describe the memory settings for different configurations and clock rates.
 
@@ -22,6 +23,7 @@ Example:
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f4000 0x200>;
 		interrupts = <0 78 0x04>;
+		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 	}
 
 
-- 
2.17.1

