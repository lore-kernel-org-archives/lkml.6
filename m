Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F53320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1XGFtc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F53320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeGSOGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:06:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38722 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbeGSOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:05:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so7456956ljc.5;
        Thu, 19 Jul 2018 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhBtfyk6EpvGULLmrb67ektbatVXeOakArBXKH6UOYo=;
        b=p1XGFtc9QJIOZbR0euzyexClOKel95qWYH0H9R5X5Do6Zmuy1OHC+cPxdmgs9T6z9T
         k5MP66+7CcAXkow65zwjEdizmhCBPMhEvEKPw4rzxxCV3GCIaNd+alN4d4jsMe/EekK0
         lFB/UNtASP043taUspo5hx9fRps1HEs1FfJKD+6oafqV+tnhFqtaPaK6vgKhJaNKN9wv
         JLuOyXj4GSGogVI2QC5SoL7Ik8tyo9a+cz+ii89Qrf/DRO6qjjwkLTUXzM0IErldS9iT
         bS3tLi3vkLhgm8Z2U/0Kl9sy3Vm7ZPDQnLyvwYiOJ1fAliQCxCtf2+5SAuVhX8iEnW2h
         Fd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhBtfyk6EpvGULLmrb67ektbatVXeOakArBXKH6UOYo=;
        b=q4IAknmXRL/GvZ7wyaKWFp4hRPYelneZlEH7j1CoxYd5ix/rhJN1fhZTvH4lARv+jh
         BJ5E987cEhXqkjP/FBA+90tcoBF+iQR23CEmOJuXsP7hKjQh1rjToMgaiYYzF5IH/znL
         bRvFWrTjh8oAqvRuj6Lxocx+/F+t9xFd877I0l1qusenUnOskAngLelTxyZ9PvqLF9NE
         DDMGoJlc8KxzC/rll0pKSPy0h5+JZhRvQsLdnzjW8z04VsN1yYcaFjLA8Y9xySC9jts7
         cxzCsMRoBvnFiu6WR0mGfGI67IxqLEW2dsNZr42DDVD7CmaCEK1Oh+Zds/nmcLCHIfZ8
         dqPw==
X-Gm-Message-State: AOUpUlGcPnJK/J0wGh9E7Ldd/GVj6t7S+3LI/8oELFvCsivtCzcpgE01
        SVzYGQP7IgURcj3cXEX3kQ4=
X-Google-Smtp-Source: AAOMgpejw9fp6ufe1zygZXUL0oD2TrbvGbp+cue9gOc9kXllhDsYgzRP47BSJ2mpnKrvB+KeBQOlDQ==
X-Received: by 2002:a19:a111:: with SMTP id k17-v6mr6351591lfe.131.1532006554321;
        Thu, 19 Jul 2018 06:22:34 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.91])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1109592ljc.67.2018.07.19.06.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:22:33 -0700 (PDT)
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
Subject: [PATCH v4 3/8] dt: bindings: Move tegra20-emc binding to memory-controllers directory
Date:   Thu, 19 Jul 2018 16:21:27 +0300
Message-Id: <20180719132132.16153-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719132132.16153-1-digetx@gmail.com>
References: <20180719132132.16153-1-digetx@gmail.com>
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

