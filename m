Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6237BC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D26C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="OOZPSPSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D26C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeJWSap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:30:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37480 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbeJWSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:30:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so1007535wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=g+t10cHmuM9MWFndnI6k5nB9kv/fzz/0OksJl35QveE=;
        b=OOZPSPSASxpKCviqMQOl+Z+yHXUCvzHO+rlCwg9TTTNe3BQGOu1rk39OzmWBdI/6ns
         f5NTQ6wLIQRYUr5aD2nxu8Hgv9JG5sqYwZMDjzqr5EoFOejaoBhTL1y1n7mYgq7WQZW5
         ECibVNVhfqLOnks2MeQOOQdObRxn7BR1eKemvbVLFfLnbsQikyZHlQRwEyFdTmrOg7P7
         YZLFfjhEWccwVqjDNUhoHOKsxEqdxBpu+QpW4ldkqO5S19DdGaSmfK7YwuDVnJUjJbL4
         SQB7+zIXHGI6DXQ6jipWEN8snaYwymRr+C7n7FjD5Iyf+BH6a9CtIrI9QGjGjJoGR3/t
         OqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=g+t10cHmuM9MWFndnI6k5nB9kv/fzz/0OksJl35QveE=;
        b=IqZwwxLQOXP59okLUKCbhyAj39Y1yW7BslQVJXPW9LzKXJrWu3ZGxJ/znp9HL8LJ0U
         K2ot/xrzLBmzdXjjFJKP0Vj73UyRmKX97IWoGO1PxMK4iZfv8ajc3sCvParXr4CBHk6T
         Sw61GASrkqRVYLTRizE5N/R9CdWWw2udtTxxoyjuoApqfVurHTYY6sqHAD44/rNAGqqR
         jdG68LElHjJdQfd3jsETj2OZ1e4zTqfUlB/Lt7xcGEHr1LcKKGXpECYR96jyvZ8PYAgl
         VxQSwP5I1CLfNSrWG32EiRAuRyPYT6b8rMugUF1vyfiq/xDFN5d1e8qczPr4yZd5kNTL
         q5AQ==
X-Gm-Message-State: AGRZ1gJgnhYukWPZhBinEwmJojBfeTNA6mL/dZ25xsinRADe5BhDiKtf
        5XFF7+B05nG7dVt9DZ67S8fc0A==
X-Google-Smtp-Source: AJdET5fAEFScllTLKzMwzONntdnIBXVIAhTQeuPWhriSwoFxv3o7vFWIICo4IIoHejlAa+XMsPZxzQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11-v6mr233865wrm.5.1540289263980;
        Tue, 23 Oct 2018 03:07:43 -0700 (PDT)
Received: from jaya.substantiel.local ([92.103.140.194])
        by smtp.gmail.com with ESMTPSA id i13-v6sm910930wrn.62.2018.10.23.03.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:07:43 -0700 (PDT)
From:   Anisse Astier <anisse@astier.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 2/3] mmc: sdhci-pci: add new machine with 1.8V dmi quirk
Date:   Tue, 23 Oct 2018 12:07:28 +0200
Message-Id: <20181023100729.28864-3-anisse@astier.eu>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181023100729.28864-1-anisse@astier.eu>
References: <20181023100729.28864-1-anisse@astier.eu>
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This machine also displays the same issue that is fixed by the quirk.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/mmc/host/sdhci-pci-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 396413f7c854..f2c1fb339d66 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -711,6 +711,12 @@ static const struct dmi_system_id board_no_1_8v[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "N75_77GU"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Ordissimo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Agathe3"),
+		},
+	},
 	{ }
 };
 
-- 
2.17.2

