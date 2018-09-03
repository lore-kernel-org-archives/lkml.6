Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C10C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1C420861
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZQ6Fj3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1C420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeICFKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:10:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46124 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:10:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so110251ply.13;
        Sun, 02 Sep 2018 17:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqNEZCF3NFy3Jzxsnv6juVWEGf6EoQqZyW/gnVxyV+M=;
        b=nZQ6Fj3YkpjhrG+K+fDsDVinPrzX48NDfx7hCJNHveoRnUUX2Dl97U9nWbe5pFEO2Y
         DDjK6MsdoN5exy2lz1qchFT3hiS8HzLO4WycB+I6eNNARhX2aLXJ5x+UtDSk44C4jR6e
         ja9xRrTWgTfovwLvvd9XH/4+o6dMLteoN3JZPLFyfnZgwR2QvWYZlCPMnukV/ODO0+5V
         4vKNCGycErrIwPAs7Ijzpyqa08m17DYKh6o+gHNRo5WRh6JHeriDHUfOoRReeiNahuDh
         vfs3ZTPLPUcF4mGYCCG8Ni6kGmTXrHtNW6BKyS/wkHvNa7b2aVmwxp53H/crlo2rb/oo
         jJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PqNEZCF3NFy3Jzxsnv6juVWEGf6EoQqZyW/gnVxyV+M=;
        b=JYftu6s2e065P5f4URi6ReGNKMvC7UlGsHzIhh85XWIRAKHwVqlP9mJxzfR24+SEW6
         Z9NqKVWYQP+ZyBfxrisqbpY2Rqx7z5n3kL9syIIs2mDwIHhfpTENYUW5EP4nM35c70Ge
         aNahxJk7fMLjLX9y+RfHXtmykrUDROFZHaHiQEcljERiPh9nUf7p1pMWiVKTUDsi3dur
         YLuOn6UpYpLlaJ5k1UHFIyhHjJwPwODuXFgP7poGFpA/mqEmk+zX/PHoKtUekmWWsd0R
         O+4d+gwaqsuCaksSEiwuBff4fgzS6vY370OHD7Atx1MiJtZc8DzfesYx/LdW9tgwF2mm
         c+QA==
X-Gm-Message-State: APzg51A6QK2WxwH0fvnj14vDwmFX7Ci8HbVgKypCdWxuxKxIQKp6ThQ6
        INJY2xVlbvFwHvY8+BmHTfk=
X-Google-Smtp-Source: ANB0VdbR8+ime6YzcNp/WX8x8dusjqplYqeTH/woZbX5KMbL0sk4tL3z2wpiCtAVAPzNHXykclcPDg==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr25383105plo.148.1535935946150;
        Sun, 02 Sep 2018 17:52:26 -0700 (PDT)
Received: from localhost.localdomain ([203.160.89.93])
        by smtp.gmail.com with ESMTPSA id w81-v6sm31487064pfk.92.2018.09.02.17.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 17:52:25 -0700 (PDT)
From:   Kenneth Lee <nek.in.cn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc:     linuxarm@huawei.com
Subject: [PATCH 2/7] iommu: Add share domain interface in iommu for sdmdev
Date:   Mon,  3 Sep 2018 08:51:59 +0800
Message-Id: <20180903005204.26041-3-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903005204.26041-1-nek.in.cn@gmail.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

This patch add sharing interface for a iommu_group. The new interface:

	iommu_group_share_domain()
	iommu_group_unshare_domain()

can be used by some virtual iommu_group (such as iommu_group of sdmdev)
to share their parent's iommu_group.

When the domain of a group is shared, it cannot be changed before
being unshared. By this way, all domain users can assume the shared
IOMMU have the same configuration.  In the future, notification can be
added if update is required.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
---
 drivers/iommu/iommu.c | 29 ++++++++++++++++++++++++++++-
 include/linux/iommu.h | 15 +++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..8e567e1037dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -58,6 +58,9 @@ struct iommu_group {
 	int id;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
+	atomic_t domain_shared_ref; /* Number of user of current domain.
+				     * The domain cannot be modified if ref > 0
+				     */
 };
 
 struct group_device {
@@ -385,6 +388,7 @@ struct iommu_group *iommu_group_alloc(void)
 		return ERR_PTR(ret);
 	}
 	group->id = ret;
+	atomic_set(&group->domain_shared_ref, 0);
 
 	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
 				   NULL, "%d", group->id);
@@ -518,6 +522,26 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
 }
 EXPORT_SYMBOL_GPL(iommu_group_set_name);
 
+struct iommu_domain *iommu_group_share_domain(struct iommu_group *group)
+{
+	/* the domain can be shared only when the default domain is used */
+	/* todo: more shareable check */
+	if (group->domain != group->default_domain)
+		return ERR_PTR(-EINVAL);
+
+	atomic_inc(&group->domain_shared_ref);
+	return group->domain;
+}
+EXPORT_SYMBOL_GPL(iommu_group_share_domain);
+
+struct iommu_domain *iommu_group_unshare_domain(struct iommu_group *group)
+{
+	atomic_dec(&group->domain_shared_ref);
+	WARN_ON(atomic_read(&group->domain_shared_ref) < 0);
+	return group->domain;
+}
+EXPORT_SYMBOL_GPL(iommu_group_unshare_domain);
+
 static int iommu_group_create_direct_mappings(struct iommu_group *group,
 					      struct device *dev)
 {
@@ -1437,7 +1461,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if ((group->default_domain && group->domain != group->default_domain) ||
+	     atomic_read(&group->domain_shared_ref) > 0)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -1474,6 +1499,8 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
+	WARN_ON(atomic_read(&group->domain_shared_ref) > 0);
+
 	if (!group->default_domain) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..013ac400b643 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -344,6 +344,9 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern struct iommu_domain *iommu_group_share_domain(struct iommu_group *group);
+extern struct iommu_domain *iommu_group_unshare_domain(
+		struct iommu_group *group);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
@@ -616,6 +619,18 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline struct iommu_domain *iommu_group_share_domain(
+		struct iommu_group *group)
+{
+	return NULL;
+}
+
+static inline struct iommu_domain *iommu_group_unshare_domain(
+		struct iommu_group *group)
+{
+	return NULL;
+}
+
 static inline int  iommu_device_register(struct iommu_device *iommu)
 {
 	return -ENODEV;
-- 
2.17.1

