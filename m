Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FDAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C94208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaBgnlL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C94208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbeHAMJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:09:09 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38795 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387528AbeHAMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:09:08 -0400
Received: by mail-qt0-f194.google.com with SMTP id y19-v6so19249550qto.5;
        Wed, 01 Aug 2018 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWIq5icRCbDxGht9xmQ01P5jvmLkE08F35LVVt7ALwc=;
        b=kaBgnlL5JfMglGejfXzVsdfNd5eh41QX4U8wI6PPauYfESoPOyF3CtT6Sr5zimBzAo
         vsiuzw33+3xhV8/NWrzmODWA8dwDPxjrGikYfhKJRGWR/LtsZsFqZrQuKi3VWtoMScD3
         I9qb2jxYxFCvf3qKEJlA/YCJVy4ZG0QHbifuIggFh7K0Kg8HWZ3ZkfHuykEdtqSiIkW0
         znrMJwjgNVbQaKGglmu6Y3LayfkP44eqarEIA4RPRQBRwK37HA390vcT+kB7/yPZIzrR
         sGR+qcaamvizbjJEqjmuU+jqaZYhxdWlUy7CP44HfFhgCUvFKvLWk6UkxjruBbKbPPUr
         /oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cWIq5icRCbDxGht9xmQ01P5jvmLkE08F35LVVt7ALwc=;
        b=RYdXUTs2jllZFqiYi1RUk0o644A1J5XqqNhiQSRcAkEX43lGoos4JTeH9gcfuwXQuj
         j7XfapGIdG7vytZTTK7GDx9K5WxZxi0k3HhUCput5X2SvQ4HubMoB7/j/8u3A4sHBhJM
         UtXf9bcy7ZzPcTmMtogMNX3UC4P6txe7IF/vk0NMDJJDecR+yogt1B6M+MJlrC1VxNHD
         uKzxXgX8l26NHHcfj56I9EzxQKCYTDOWGFrOk8ZHHjp7ohiAtfSjammiidsn1iv2VznM
         9fBUWDkMlapDvp+0NZCho0mFb9B9G1wg1c0E3eWaD1bfMffWbd9eyUNWqjzfykNAZ6dP
         m4GQ==
X-Gm-Message-State: AOUpUlFTh1Pd6FkcEA0dQTzgA8ST5mIH9mjTXiBV+QYALnCplzpZkL1q
        ecxuoTJxZB2tBn3sxmiEIvU=
X-Google-Smtp-Source: AAOMgpcBJcdjp0oqonN+uHzRpA/J4w6PpcR9zK56IPEIP6VVsim38TyhhqxQFmqYwAH0XyfoUoiZtQ==
X-Received: by 2002:ac8:43da:: with SMTP id w26-v6mr16382599qtn.137.1533119042468;
        Wed, 01 Aug 2018 03:24:02 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.144])
        by smtp.gmail.com with ESMTPSA id s19-v6sm11176890qtj.61.2018.08.01.03.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 03:24:02 -0700 (PDT)
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
Subject: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for spimdev
Date:   Wed,  1 Aug 2018 18:22:16 +0800
Message-Id: <20180801102221.5308-3-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801102221.5308-1-nek.in.cn@gmail.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

This patch add sharing interface for a iommu_group. The new interface:

	iommu_group_share_domain()
	iommu_group_unshare_domain()

can be used by some virtual iommu_group (such as iommu_group for spimdev)
to share their parent's iommu_group.

When the domain of the group is shared, it cannot be changed before
unshared.  In the future, notification can be added if update is required.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
---
 drivers/iommu/iommu.c | 28 +++++++++++++++++++++++++++-
 include/linux/iommu.h |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b37563db7e..a832aafe660d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -54,6 +54,9 @@ struct iommu_group {
 	int id;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
+	atomic_t domain_shared_ref; /* Number of user of current domain.
+				     * The domain cannot be modified if ref > 0
+				     */
 };
 
 struct group_device {
@@ -353,6 +356,7 @@ struct iommu_group *iommu_group_alloc(void)
 		return ERR_PTR(ret);
 	}
 	group->id = ret;
+	atomic_set(&group->domain_shared_ref, 0);
 
 	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
 				   NULL, "%d", group->id);
@@ -482,6 +486,25 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
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
+void iommu_group_unshare_domain(struct iommu_group *group)
+{
+	atomic_dec(&group->domain_shared_ref);
+	WARN_ON(atomic_read(&group->domain_shared_ref) < 0);
+}
+EXPORT_SYMBOL_GPL(iommu_group_unshare_domain);
+
 static int iommu_group_create_direct_mappings(struct iommu_group *group,
 					      struct device *dev)
 {
@@ -1401,7 +1424,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if ((group->default_domain && group->domain != group->default_domain) ||
+	     atomic_read(&group->domain_shared_ref) > 0)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -1438,6 +1462,8 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
+	WARN_ON(atomic_read(&group->domain_shared_ref) > 0);
+
 	if (!group->default_domain) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..278d60e3ec39 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -349,6 +349,8 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
+extern struct iommu_domain *iommu_group_share_domain(struct iommu_group *group);
+extern void iommu_group_unshare_domain(struct iommu_group *group);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-- 
2.17.1

