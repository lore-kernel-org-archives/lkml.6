Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F90C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD74213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzTluJeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD74213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJELLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46242 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeJELLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so4408157pfb.13;
        Thu, 04 Oct 2018 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CpxCZytTE2DMCbEh/CJMp/oXOlBJtuApwHXbU+m9rIM=;
        b=bzTluJeC/Tmbyz4ERw1iVHsYT8vdIdsZoU6Lpdmg0uJmxQ+mzOXuMhZj8PKrSpRMuA
         qGlt7DeoV6k4xW2CfE9DkiMVKseaAx2Oy0lnwLetYxnpxxqjuWazNovCZn3Wrp/3nC64
         H4sYwh66s9070KUJMi2Iaun6XsvhtWE1WHXXNWLyu5MgDkmWb4g8sUYr70qZrQEhBGFd
         yqAS3M7p1fERdirBM4Ct0LIARet26yKDMxhrJjNUXVVSIRofQOffseBiweV3X9JH5jKJ
         xeUlLMWLzb6h0o1DZb/+mXGwVQDQmb5OY2XJ18H8O+R/N5qQT9sTLl/cmc2MQ5u5eKp3
         OY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CpxCZytTE2DMCbEh/CJMp/oXOlBJtuApwHXbU+m9rIM=;
        b=KZCr9eZSckHNe+EcRAE1AQS1dIeTiw5Zx80gOVsfQHmbh8DRG9guMua7omkXB3ZUrI
         r5HUaM0Cd6G42nn1aTWxNV9UHyw2DJdcB8XmXORRnc7SsTBauM9rNKXP7MhBX6X4kO2y
         fY/UuLCdjuNNjvBWTV/tThYs2p0GMSnrnryjBDxPD7drIBxHrg0q3EOzIyuK7a8yhoKS
         YKLO7rkxV7IsVBt2NzGB1+gFSZ64Ac5EPRxxWNvoV4QQ3YyiKHYIS5rHqyoTD3zG/Lbn
         et3sWq03kT/VQLPHULVx2Z7FoyDO2rCtOKxrwTgEoVGBIyYbKB0eZJgPE8l1OETb8S/g
         KeDQ==
X-Gm-Message-State: ABuFfoi8Yy24xYYnN+rvysIlxNe9PF5MeqxzLsYS+O/h1lNr3bdysgwf
        mC8fHLVtrFIbCodIqn5/FAY=
X-Google-Smtp-Source: ACcGV60XDvqIPx+3U41poUeNqK5p8QfF/qqKJ7ruL10hXJmIq3qiAHQ1HUQ+5E6K57ZDMhbs4aCsww==
X-Received: by 2002:a63:2483:: with SMTP id k125-v6mr8451738pgk.287.1538712864682;
        Thu, 04 Oct 2018 21:14:24 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:24 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 10/16] of: overlay: make all pr_debug() and pr_err() messages unique
Date:   Thu,  4 Oct 2018 21:12:41 -0700
Message-Id: <1538712767-30394-11-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Make overlay.c debug and error messages unique so that they can be
unambiguously found by grep.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index e6fb3ffe9d93..f89383331b88 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -513,7 +513,7 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	for_each_property_of_node(overlay_symbols_node, prop) {
 		ret = add_changeset_property(ovcs, target, prop, 1);
 		if (ret) {
-			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
+			pr_debug("Failed to apply symbols prop @%pOF/%s, err=%d\n",
 				 target->np, prop->name, ret);
 			return ret;
 		}
@@ -557,7 +557,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_next_level(ovcs, &target,
 						 fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -570,7 +571,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		ret = build_changeset_symbols_node(ovcs, &target,
 						   fragment->overlay);
 		if (ret) {
-			pr_debug("apply failed '%pOF'\n", fragment->target);
+			pr_debug("symbols fragment apply failed '%pOF'\n",
+				 fragment->target);
 			return ret;
 		}
 	}
@@ -879,7 +881,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay apply changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
@@ -1138,7 +1140,7 @@ int of_overlay_remove(int *ovcs_id)
 
 	ret = __of_changeset_revert_notify(&ovcs->cset);
 	if (ret)
-		pr_err("overlay changeset entry notify error %d\n", ret);
+		pr_err("overlay remove changeset entry notify error %d\n", ret);
 	/* notify failure is not fatal, continue */
 
 	*ovcs_id = 0;
-- 
Frank Rowand <frank.rowand@sony.com>

