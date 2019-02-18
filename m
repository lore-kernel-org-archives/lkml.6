Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB71C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jfdoqrlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfBRIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:52:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42926 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfBRIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:52:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so3737919edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm/bJIx/uRsVjpVSSqXPJfAsT7u+Yco2/xHd2+oE910=;
        b=jfdoqrlvpd/cD8um/uOFOs1Sr+YtCRHF2bYyMMyP1mBji+yrclrWIs3a/JoRKzwyio
         CIwtUzcYIWM0xqmYU4bl+PLhNzKY/RAJ9K8WABbLqcgyXVVW3Hp/IaGOksOi5i8ChREN
         LrhwfkCeNDya9ZfrYDejm7P47CJr5gikhwX3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm/bJIx/uRsVjpVSSqXPJfAsT7u+Yco2/xHd2+oE910=;
        b=GBDFH40IHdjLfIBj2cL0o3JwLArXCXSFg7g0uwgZ+2aaIzIHZbhT+Uee2DoVL2q7Rt
         F0dutM860aAiUOaFbDLgsT2LhMHJXyLL/cCH2y06vTQC9bNCx1mL/yqH+fWDD9qJyKhB
         xcyG9yyKVIelzJYq5yKd+xrMgLNyODOLwf6TixLGb7yq3ZXP3eJCu+SXv9odF3obeYdn
         18aviprtJuvrFVOIpuDs/E4n7J/eeLE47R++OW87b642Qn0a9eu9dfRp97lsgvHYehuz
         u5DXGXHsJzj52GKOacNJSwBNQR6teIMKa2Q2R068ABivPUkeNpd1/UVEaE3CG4H/Rv6m
         y06w==
X-Gm-Message-State: AHQUAuZ9+cLlCJSrweuWRqWTrchunKPIAb9Fq1snR8Zft//KjCgY0x70
        J0386Gqj62zS2LPvlNkE51qwdUZBQTXZrQ==
X-Google-Smtp-Source: AHgI3Ib0ZWCsJJt5IkLB7PS4n9y4b3XIKAouGrPg1KToD5Da+zn6fzs79JtxOn/EuSuyVo4Mhv65UA==
X-Received: by 2002:a17:906:52d5:: with SMTP id w21mr15678439ejn.172.1550479968233;
        Mon, 18 Feb 2019 00:52:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k17sm3805306edr.59.2019.02.18.00.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 00:52:47 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>
Subject: [PATCH] drivers/component: kerneldoc polish
Date:   Mon, 18 Feb 2019 09:52:42 +0100
Message-Id: <20190218085242.18845-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Polish the kerneldoc a bit with suggestions from Randy.

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Ramalingam C <ramalingam.c@intel.com>
--
Greg, I don't need this in any of the topic branches, best if you
pick this one up into your -next tree directly.

Cheers, Daniel
---
 drivers/base/component.c  | 14 +++++++-------
 include/linux/component.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 7dbc41cccd58..6954e448f46b 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -27,7 +27,7 @@
  * helper fills the niche of aggregate drivers for specific hardware, where
  * further standardization into a subsystem would not be practical. The common
  * example is when a logical device (e.g. a DRM display driver) is spread around
- * the SoC on various component (scanout engines, blending blocks, transcoders
+ * the SoC on various components (scanout engines, blending blocks, transcoders
  * for various outputs and so on).
  *
  * The component helper also doesn't solve runtime dependencies, e.g. for system
@@ -378,7 +378,7 @@ static void __component_match_add(struct device *master,
 }
 
 /**
- * component_match_add_release - add a component match with release callback
+ * component_match_add_release - add a component match entry with release callback
  * @master: device with the aggregate driver
  * @matchptr: pointer to the list of component matches
  * @release: release function for @compare_data
@@ -408,7 +408,7 @@ void component_match_add_release(struct device *master,
 EXPORT_SYMBOL(component_match_add_release);
 
 /**
- * component_match_add_typed - add a compent match for a typed component
+ * component_match_add_typed - add a compent match entry for a typed component
  * @master: device with the aggregate driver
  * @matchptr: pointer to the list of component matches
  * @compare_typed: compare function to match against all typed components
@@ -537,11 +537,11 @@ static void component_unbind(struct component *component,
 }
 
 /**
- * component_unbind_all - unbind all component to an aggregate driver
+ * component_unbind_all - unbind all components of an aggregate driver
  * @master_dev: device with the aggregate driver
  * @data: opaque pointer, passed to all components
  *
- * Unbinds all components to the aggregate @dev by passing @data to their
+ * Unbinds all components of the aggregate @dev by passing @data to their
  * &component_ops.unbind functions. Should be called from
  * &component_master_ops.unbind.
  */
@@ -619,11 +619,11 @@ static int component_bind(struct component *component, struct master *master,
 }
 
 /**
- * component_bind_all - bind all component to an aggregate driver
+ * component_bind_all - bind all components of an aggregate driver
  * @master_dev: device with the aggregate driver
  * @data: opaque pointer, passed to all components
  *
- * Binds all components to the aggregate @dev by passing @data to their
+ * Binds all components of the aggregate @dev by passing @data to their
  * &component_ops.bind functions. Should be called from
  * &component_master_ops.bind.
  */
diff --git a/include/linux/component.h b/include/linux/component.h
index 30bcc7e590eb..8628d4d0aff1 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -98,7 +98,7 @@ void component_match_add_typed(struct device *master,
 	int (*compare_typed)(struct device *, int, void *), void *compare_data);
 
 /**
- * component_match_add - add a compent match
+ * component_match_add - add a compent match entry
  * @master: device with the aggregate driver
  * @matchptr: pointer to the list of component matches
  * @compare: compare function to match against all components
-- 
2.20.1

