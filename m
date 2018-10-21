Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80FECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0793320838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSh5zPk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0793320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeJVCrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so13008776pfe.1;
        Sun, 21 Oct 2018 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Q3FXmWXbh9XFqApAZQyqrxqWr281d5SwSAZZmUR3n4=;
        b=aSh5zPk6tUpaXXm97AcOskbUJmTUp2HQ2zvl+rCEhCZv9eD90O9/07+cHaBZX+gTji
         I8Gwe+6athOTzHyG8nvfbJSCBomDgVua/HNCmVvy7M7W/SogmGyaivoAI3rIeUrDW2mQ
         QB/jrmmJuQ69ESsu7KD2m0UTtsDczycw1Xbs5arvYacxqvYWqdgQX3gKGetTW8J88mv6
         KyOtbLtUhZKr+5UiWlG/2BJRSZgfyNRSyRGDZgytncOl9fefpjUjfuJBzWDJOHTj/OkU
         gcQgZR+hSDBrBhU68EowZcdQC7CfPdruEZYUuIJ90nitiKdIvkZpNIPhUXjLEEJGiqc9
         MMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Q3FXmWXbh9XFqApAZQyqrxqWr281d5SwSAZZmUR3n4=;
        b=RklZcn/g3D7kgEbHMhMI1Mpe8X9zIX0uToB1gkaphzl31DwoGmgCapuIkk5KXL+Kh/
         JvDUev6FC7trwVpkDfKWgpG870yE/5248woZHSptuoBsoYeGVyYFThzQcYZwii5iydDO
         YwckiLqdwv8EfhevHnfinVhiDRI7yGnJPmnm4REFDhkmndmGzVIxjet3N6zUTw3x3xuE
         FJM9GdQpnv6ZRtHwV7HlZ2ri3PS3W8f7EPzeqFyvxSgp3MfxJzpS7oRNjL9zJkTRESO7
         Ka5OXUUJPU4AqsigGLO+v9llmkBOqhukBwqxXEQ5XxDPcvfE1A6TykwAv5K7+3rdqCB8
         oWkw==
X-Gm-Message-State: ABuFfoidcp20FiFTA3TPZzkRuIfbkNQuTJJ3ij0HzTQ+nzGz1LW3Zd+T
        rUmrR6yG55vTmz0CQHmaDlI=
X-Google-Smtp-Source: ACcGV62cM7SqwfbdiLkmnMHRGKMSIWC2XPGv7yGTwOoKBrUD8vgcVlRZ5g0Yh6BQJgzaV/vr5lTa5w==
X-Received: by 2002:a65:4783:: with SMTP id e3-v6mr39399331pgs.12.1540146715700;
        Sun, 21 Oct 2018 11:31:55 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:31:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] dt: bindings: Move tegra20-emc binding to memory-controllers directory
Date:   Sun, 21 Oct 2018 21:30:47 +0300
Message-Id: <20181021183052.32023-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tegra20-emc binding to the memory-controllers directory for
consistency with the other Tegra memory bindings.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt      | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt
rename to Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.txt
-- 
2.19.0

