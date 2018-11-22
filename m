Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C876FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8950820684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH7zXICC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8950820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbeKWDWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:22:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39076 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeKWDWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:22:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so3191981pld.6;
        Thu, 22 Nov 2018 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kn70APoGKgmr2pFoLw/4Br9NJUzDnGR7gLeEtbHaKD4=;
        b=eH7zXICCcR3pclgzT0G9wMDVL/wAPUWBuppb+yb0/fI4tNUPHODdojmixlqDPg7rhn
         HTfOtcRenPmUfX+kBNBPqFErEXvUVcBlWp3eGlrEi1ci9L6XI2YOqRg9XrVh1mHbqN48
         bJl9j/5MkvaaOmrGTYKg2au5Q+yUagWKoi+D+p3fpib5LqRSYVKZ5lpusRda/fMNTDXD
         opANI3AcBvBHKj/jl1Up8CkKtlvmak/yvSCTQS/I+8PeIf1shXY+OLMnCNkfAnLRa/TY
         rnF/GwbSu9GPP6JCWfinWvYGpb4R7+ILhnh0S7SvR+3hj98Y1WgBv5xO+N+EjGmttIx7
         bAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kn70APoGKgmr2pFoLw/4Br9NJUzDnGR7gLeEtbHaKD4=;
        b=FywBA8BRj1hGm7ygbffSPSU6Kptovq5GccaM8zNcqBmh9A0jyRHj8eyZgg3++03a0e
         Scg6tRnDlcDb4/LCwDUqOHPmTMuMv+CYciLiev1ePlr0XKodqn3lrviYHdgdBLFt7Fvo
         etU2hnOwkQX93wldXTYZpwDR5HuFh08hqi8eUdt5mqVMBgpSf5DgMRD//1Wp731Q3+aX
         KEZRat33NgTE2jKI3NC0X0ixA5objo59QvmzLya8ytqbLgHSHirYWHJBR+p5Wg2i/bho
         EBEVWtmJXaR66fZX1VYaWjV7N7pomf7RZKCqTe9rXTn0DhtWmJsj2XHNHusqDnSW4BnY
         WrmA==
X-Gm-Message-State: AA+aEWY/KIYzYA14Vz34Vb5ruC5oLQYyoWgoXh3lOXBlUYPw7VgVcObg
        325kBMAzyr2dN2YXFPy4uQGpvnYqkCs=
X-Google-Smtp-Source: AFSGD/VczWXamzU8WnF5x/TYzizfJ3BWGyQ6rN3yKIAK0dOb3O8qSkh51y56Fnnm8/jVf3WsqRJkQg==
X-Received: by 2002:a17:902:6185:: with SMTP id u5mr11944390plj.194.1542904936737;
        Thu, 22 Nov 2018 08:42:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f32sm53289900pgf.80.2018.11.22.08.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 08:42:16 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc/tegra: optimize soc_is_tegra()
Date:   Thu, 22 Nov 2018 11:42:13 -0500
Message-Id: <20181122164213.26101-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for() to rewrite the code.In addition,match->compatible[0]
is equal to *match->compatible,change it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 54627ca957e8..521a201d9fff 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -24,11 +24,9 @@ bool soc_is_tegra(void)
 {
 	const struct of_device_id *match = tegra_machine_match;
 
-	while (match->compatible[0]) {
+	for (; *match->compatible; match++) {
 		if (of_machine_is_compatible(match->compatible))
 			return true;
-
-		match++;
 	}
 
 	return false;
-- 
2.17.0

