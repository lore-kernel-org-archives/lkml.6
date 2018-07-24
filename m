Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE95ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D789D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnr4qui8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D789D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeGXRui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:50:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35659 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbeGXRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:50:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so3289602pgv.2;
        Tue, 24 Jul 2018 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhBtfyk6EpvGULLmrb67ektbatVXeOakArBXKH6UOYo=;
        b=Mnr4qui8T1KxSW8AKioa99ShJWNt0VIw9UqzWbZx0Ad1ZYTxEDfPZUh7i3IiiR4CXU
         gEQ19TKoVGIBI7ZeQsf8+eiU5xxn6C0dBlOMqJdndQ5eQexU3N3Eg2EOFqyKoUxAhbvi
         gxa6NdMTm7SB0S14Rne9bwrbFDTHxPWSFoTzP4Yx7O+E7N3qYzgKkYzk1gg6qeb43o7z
         ryoFgqqvAzC+G06Dopdmmb7eY4kME9iyEj4xjkcqRb45z+cPFvsNKNzY4Y46kaUW4wLK
         4i/Ke6dTBjz1xqXd0bNLSDxbksJlPOQIkt/HWbdSP/CyvhVeAWMzmkUDyv04EFfBjS5h
         zwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhBtfyk6EpvGULLmrb67ektbatVXeOakArBXKH6UOYo=;
        b=BzgVW8/WfPZW729hEHJ1u6X0gJ53uQ95I57HVl7vvNvqijbJWKXFmLh/TSUp/a3ItK
         kNLnxF+Ro6btO0q3ZLQ9Xb/0oWK0x3JRVYbKD8PXkzsDysXUOgo1zTMDw3Kv7HT259c4
         uoKxkgW2pjmlDnUNjXiC13C+j7pHHc3ShvRjKzsh3LL5t5APbKwxgX6SeflGZUpDZwEP
         E66FzVE/0Nq1ZfoyBMcoaGAh5E2YFSsyxHMFQ4E3Af9qjAvNLDMUavUltZau0nGLYhbm
         UBkKF98eV93jPT7q7TYWexK/Bi5VCrY4tI3q+9yjrspvjVyBJMtOdl67jrH1LpdeYRYj
         cKMQ==
X-Gm-Message-State: AOUpUlGLrdKe3BBvyYcxW4ZWljkvcOxcOVqJm1K+AaA69tu/EvNR/6Za
        YvDWlIehD4b3b5PlRhUuZaE=
X-Google-Smtp-Source: AAOMgpdKl2emy59XBbr6arJw19eh6+l8Bp/xKw3nRuy6xXFTLM16OxqjVnzukVakftL6jI5XIN70KA==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr16797195pgo.378.1532450598724;
        Tue, 24 Jul 2018 09:43:18 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j1-v6sm39410536pfk.125.2018.07.24.09.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:43:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] dt: bindings: Move tegra20-emc binding to memory-controllers directory
Date:   Tue, 24 Jul 2018 19:42:16 +0300
Message-Id: <20180724164221.3307-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724164221.3307-1-digetx@gmail.com>
References: <20180724164221.3307-1-digetx@gmail.com>
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
2.18.0

