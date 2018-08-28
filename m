Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C68C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85921208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85921208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeH1FmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40989 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1FmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so1737797oiw.8;
        Mon, 27 Aug 2018 18:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wMsoSHrTnqmMHU/afUmBcsyqhLYPvT/ds3GpNPgxRo0=;
        b=YQg2dxZ7/98O57fNg8A7GPSEmsyVjzAowqZ4ue2hS/btw+yheHcC11vY1zv/9QOQlo
         22mtzsZmspF1AhVjpdXGpA1dktl3LWzimZ4rPIg0cIcMHqkAh6rHKjicnLOkLVevpenv
         c/Nz1YxbSrL/KvXE2Ab8w4Hrin+zOStgf/fxRqgnHEOz9KZzTXyShmAD9iiLKEECjFuI
         fG0saIrjE2P/1HtLn6rRu9zzYq/VSSRj9ktNMfJ5FNIBZzaokxkVAo/KcPprFWdZryZ4
         zUFrt9twP9mP8pDTPRLfgHdemhRrouZeF0vd/mjfGaVfaQjOqJwWmarEMR8Nx65f5hG2
         ZHyg==
X-Gm-Message-State: APzg51BQJOFlIrzTAUESq1xiBVEu+WW/gfsgXJUXLLTFH3D8/KkiCsGV
        r3SXSUKJGHbDKcfinNPwj98ZqZI=
X-Google-Smtp-Source: ANB0VdZ1p6mbvjHeaDbr8ExmhxZaMMLb9B8Yb+7R0BUNsh2JI7i2gpk60YbHCkXUS3u1tchYa7sgpw==
X-Received: by 2002:aca:ea57:: with SMTP id i84-v6mr981770oih.266.1535421175215;
        Mon, 27 Aug 2018 18:52:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:52:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] ARM: shmobile: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:03 -0500
Message-Id: <20180828015252.28511-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index e348bcfe389d..9dd6cadcd900 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -189,7 +189,7 @@ static void __init add_special_pd(struct device_node *np, enum pd_types type)
 		return;
 	}
 
-	pr_debug("Special PM domain %s type %d for %pOF\n", pd->name, type, np);
+	pr_debug("Special PM domain %pOFn type %d for %pOF\n", pd, type, np);
 
 	special_pds[num_special_pds].pd = pd;
 	special_pds[num_special_pds].type = type;
-- 
2.17.1

