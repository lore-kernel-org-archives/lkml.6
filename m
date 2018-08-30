Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99619C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C93E2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKKsv+YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C93E2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeH3W7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:59:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41802 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeH3W7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:59:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so8127888ljy.8;
        Thu, 30 Aug 2018 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=chM7oFjXuLu7qkEIeVRWJWZtMSPZUe6iRe88eElFN20=;
        b=MKKsv+YY/yvVefhngbnLbqhAktIpUiHI5HdeBOU5uMeJT0hQRnKIO308pa6qlT52/f
         1u2+O3dRQmrr6PbFj17z1V6DN0VUFXjlaV6jIn7r+hGIOVD+IoiD/QsmKSDBJlYtJxFe
         4FdHVQy8q1q6rp1oYaoqj9Su2z1dMFLBk4P3LRRCRRpUbHlzvNFV6CkEquDNZ0U3jaN9
         8/lBV3AQtlmfeQp6BhwgTwBkugaTOurjqqqxmgL6jyRoZzOKPsjUVUf08IXDRdXNGeCX
         d6pAqKc8ZjQK6Yb8YPvsh3wtkQONxMlAdgr+GVOGEwhZng6mGgQsc2m/I9r/HHXHUYib
         ZPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=chM7oFjXuLu7qkEIeVRWJWZtMSPZUe6iRe88eElFN20=;
        b=Fvgry73xvUEf3hMqyYFPLC34YuF6H/nWbpQeRPOHMHjq+HTVs46tgmWDFQsi72s4Y8
         jgI2hr0Dj61gQRCotbu3IpotGbn3cADZuV/l3P2jGdtJJWOuKl98oSuWRcFJeHSlDaRd
         R4TffuemXpwSlPxiIHU4zyRs33BKXEFmEtGkArn3c6uFUxXhbMu6VB13rGeHYF+xF20l
         ARTUR0o7riAE3Sb5iYPdON4zl0rCoHrEKVV63c6x7RclYrge6rshsXJg3xjzW8pK+uTA
         YweLYHWX+ieDlJANIgK5tAqxc0Vt9cXrRwB8pfLKnAblRzX/UZKhwhmGinFbsbd8Zb9Y
         +47g==
X-Gm-Message-State: APzg51Ahz3Ncvmo7MPr2bNa4YigZvxHK7tmxjUhr4SgbipzatnK0jUG5
        llpuZwHcAVVH4c9VO8mmNH0=
X-Google-Smtp-Source: ANB0VdaWMM0ROZQbUPI0JugGl0jw1PQx+d8QYJeeo18e0NVzPWzG8KVNr+sGWd50An+vT4YDprT1Qw==
X-Received: by 2002:a2e:2e02:: with SMTP id u2-v6mr8508792lju.77.1535655334868;
        Thu, 30 Aug 2018 11:55:34 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1373087ljd.61.2018.08.30.11.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:55:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on Tegra30
Date:   Thu, 30 Aug 2018 21:54:02 +0300
Message-Id: <20180830185404.7224-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830185404.7224-1-digetx@gmail.com>
References: <20180830185404.7224-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRAM refresh-interval is getting erroneously set to "1" on exiting
from memory self-refreshing mode. The clobbered interval causes the
"refresh request overflow timeout" error raised by the External Memory
Controller on exiting from LP1 on Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 801fe58978ae..99ac9c6dcf7c 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -29,7 +29,6 @@
 #define EMC_CFG				0xc
 #define EMC_ADR_CFG			0x10
 #define EMC_TIMING_CONTROL		0x28
-#define EMC_REFRESH			0x70
 #define EMC_NOP				0xdc
 #define EMC_SELF_REF			0xe0
 #define EMC_MRW				0xe8
@@ -459,7 +458,6 @@ emc_wait_auto_cal_onetime:
 	cmp	r10, #TEGRA30
 	streq	r1, [r0, #EMC_NOP]
 	streq	r1, [r0, #EMC_NOP]
-	streq	r1, [r0, #EMC_REFRESH]
 
 	emc_device_mask r1, r0
 
-- 
2.18.0

