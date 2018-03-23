Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802246-2-17315460199884288567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802246; b=tZ8EowYUAFWTlL8bcOTj+PT4Hbiy+995Vh7hIf5kJfuwAPt
    1YasvFQC4p8il71rq13oaFrHEf2FCDyO6+mO12rxwxXEYr1j/724+1CP5q+ovLL6
    T8+ENLs+i/SlNPBVW9dg2ZHZInzoW20epWZutRweIf4xhKsW4BVtARjeKK7MutJp
    TUiX8hbejYWWAzGk1jymZaC/8LGe/HdiMmUexZESWV2QqTi6lQZUvKlzkAaSoGf5
    pig/2lNjwgXJzcJkQvvh427sEWyMpF+jVkq7iSccx4FyOWBZLHnZuEZPr8/U/lgs
    xeDLdSO55RohcHv+l5zlkjSurDyqktNxtEcd5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802246; bh=Ji9IapHMJPVnSaRvhrUDyfggDt
    rlq3GCUVz5Te/QCyI=; b=Wvr87prZogP1rPtyCM8zEHfUn02JbVTKmNX0B51KW7
    0oIJHGkzrpbjK/z0/oftS+01PpRSzCWLEN7QS7k9OGAB6LpfOrXs3jyCgiMwi6JK
    OnryXu0L1Fch7yvHwXBNZwYP3YAT5QrMUz4LRZSZpmLhDNmaUC9rNeiLqZxvHu4z
    FK5XppRUA82M7Xa1l2YjiwrS1Oy7r+35465XAeL8lHRMGWoU3uIk8P53nnLi7TGj
    SnSThg1N+n+E3vyQpp647j3Pg/TW+zgzz+KBlM0PyIbAN5jnRHLYAN35lpaIgGHR
    p7ofY7Lxdi+mlMzsR15b5qEX/uwB1gzrp+KtuPGAWMBQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755791AbeCWKOe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbeCWKOc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 25/97] iommu/omap: Register driver before setting IOMMU ops
Date: Fri, 23 Mar 2018 10:54:12 +0100
Message-Id: <20180323094159.033214117@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Anna <s-anna@ti.com>


[ Upstream commit abaa7e5b054aae567861628b74dbc7fbf8ed79e8 ]

Move the registration of the OMAP IOMMU platform driver before
setting the IOMMU callbacks on the platform bus. This causes
the IOMMU devices to be probed first before the .add_device()
callback is invoked for all registered devices, and allows
the iommu_group support to be added to the OMAP IOMMU driver.

While at this, also check for the return status from bus_set_iommu.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/omap-iommu.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1295,6 +1295,7 @@ static int __init omap_iommu_init(void)
 	const unsigned long flags = SLAB_HWCACHE_ALIGN;
 	size_t align = 1 << 10; /* L2 pagetable alignement */
 	struct device_node *np;
+	int ret;
 
 	np = of_find_matching_node(NULL, omap_iommu_of_match);
 	if (!np)
@@ -1308,11 +1309,25 @@ static int __init omap_iommu_init(void)
 		return -ENOMEM;
 	iopte_cachep = p;
 
-	bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
-
 	omap_iommu_debugfs_init();
 
-	return platform_driver_register(&omap_iommu_driver);
+	ret = platform_driver_register(&omap_iommu_driver);
+	if (ret) {
+		pr_err("%s: failed to register driver\n", __func__);
+		goto fail_driver;
+	}
+
+	ret = bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
+	if (ret)
+		goto fail_bus;
+
+	return 0;
+
+fail_bus:
+	platform_driver_unregister(&omap_iommu_driver);
+fail_driver:
+	kmem_cache_destroy(iopte_cachep);
+	return ret;
 }
 subsys_initcall(omap_iommu_init);
 /* must be ready before omap3isp is probed */
