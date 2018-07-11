Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA36C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37D120C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="a2AqncCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37D120C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeGKVGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:06:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35058 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbeGKVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:06:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so18069459pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5w4nLPEuwrKCz5EFO/Uj4lhd6c7bn4BL+FGxKombQeE=;
        b=a2AqncCNRW/thst/ozp/a3WArKo3XjeANBS3YY2TJ5cQwCnmmrzd9U1z8gEvf1mNd+
         1oiybqn5G5+0nsBHZDXmYuirZ/zukiIL63aoDVHpqYUhSyxRYh6mz3V+bcbhAUWeAEFK
         J3Upk7vLeyw6t4im40JAVt2cOdN+z0jDEjg3aaPV3z+unomrLiAGzAnD2gsJIw/ZqgJ7
         3AnZFpwn3VZZg44tvrqsu9zC810+reHyZ81F6P1ttHow+PwcdF90csoDt78GtVOVDFK+
         cN1/+9U2JQJW8V/fT/U/rKeo6R4oH7XOBJWdbZdkBN7SbCHx47tKApwIoVqd1eSA6zPx
         2QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5w4nLPEuwrKCz5EFO/Uj4lhd6c7bn4BL+FGxKombQeE=;
        b=ngCEuY9WtpzO1VCALQsnC3ubGNvL0XZgMu4OdPrV39NfXcmzJW6SLm1tCl0V+zwBB8
         tvop+tFSAfzf6QsTlTW7yKQv5JOCnHMmtS7Aur7acbpowc+Yx6+if/tBhA0hsMy2/yIa
         tPNXA6jFeUgJ0XDehs2MJYJNSLsvDrfUn27DjzCVz5NX9k13jAx/+fdPLaADng6RUfQb
         3essfU/55OiZB6RZdCWRhRg21MpkkDvOsAzr+ACg+NfH+mvSZ0oFs4ydUZ0SpEOqRs4i
         Hd4dp2GVIG2mgLJ7+91Xo9+UDg4c0pXwMe4F80mDL55gLvBrlLz8uU/Qx/Z3gxCUa83o
         vsQg==
X-Gm-Message-State: AOUpUlHeRZdjK3V6jMHhsXv+WTUQvHk7sr/MldNZMB1ODcP8b1v+yAWF
        CGocqbdtuDAD/30S6gUPyHes/VxW
X-Google-Smtp-Source: AAOMgpcX4gU/1u8QpIGAcq3kidYahd26UA/anVSPVfqp/OE8t9kYJP5J0V/z9K/zuabNd3/I81stJQ==
X-Received: by 2002:a62:2605:: with SMTP id m5-v6mr180994pfm.223.1531342798357;
        Wed, 11 Jul 2018 13:59:58 -0700 (PDT)
Received: from localhost.localdomain (173-13-129-225-sfba.hfc.comcastbusiness.net. [173.13.129.225])
        by smtp.gmail.com with ESMTPSA id j2-v6sm22867564pff.35.2018.07.11.13.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 13:59:56 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/2] iommu: add sysfs attribyte for domain type
Date:   Wed, 11 Jul 2018 13:59:36 -0700
Message-Id: <20180711205936.18614-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711205936.18614-1-olof@lixom.net>
References: <20180711205936.18614-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we could print it at setup time, this is an easier way to match
each device to their default IOMMU allocation type.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/iommu/iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab8fc54467e0..53164107620c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -298,11 +298,39 @@ static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
 	return (str - buf);
 }
 
+static ssize_t iommu_group_show_type(struct iommu_group *group,
+				     char *buf)
+{
+	char *type = "unknown\n";
+
+	if (group->default_domain) {
+		switch (group->default_domain->type) {
+		case IOMMU_DOMAIN_BLOCKED:
+			type = "blocked\n";
+			break;
+		case IOMMU_DOMAIN_IDENTITY:
+			type = "identity\n";
+			break;
+		case IOMMU_DOMAIN_UNMANAGED:
+			type = "unmanaged\n";
+			break;
+		case IOMMU_DOMAIN_DMA:
+			type = "DMA";
+			break;
+		}
+	}
+	strcpy(buf, type);
+
+	return strlen(type);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
 			iommu_group_show_resv_regions, NULL);
 
+static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -384,6 +412,10 @@ struct iommu_group *iommu_group_alloc(void)
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = iommu_group_create_file(group, &iommu_group_attr_type);
+	if (ret)
+		return ERR_PTR(ret);
+
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
-- 
2.11.0

