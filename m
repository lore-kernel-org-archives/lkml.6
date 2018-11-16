Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4C20858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="NlPYdkgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA4C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbeKQE44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:56:56 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39379 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbeKQE4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:56:55 -0500
Received: by mail-yw1-f66.google.com with SMTP id v8-v6so10488116ywh.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otr9k4GoKwfQv9Joa8yyBiv7uFW72krl5ma+HCu/7M8=;
        b=NlPYdkgQsyEKnQHpl2iqUbpYaWp1ORNfGM94BpJb86TjnDhYLoQpOFFvLV8qxXET9T
         cMX6vHQr/1aVEwLFUYmW8XWGwdwPCkYlTHTmIy/kCPvUiEUClMUq4XIkAITtz8nP/0Kv
         8xFCzbdwcK5afnH3y1taa2nODU0N+UqdjGcvEiBVGU2LKjndi71LxHp3mWB9pzrMEJiM
         HIa/tYyc4CC2hOeNrYbk9EymXiUjQ+PA/mudF7OckAXxlf4DFkqFxe04QWvUfgGdt5/o
         /NtRpxyf4BDNq+pp0ZbAgQ6vQskkfhsXciIW7wwzPPJj4Hb7Gqa8KqykVM/csxrv5nNd
         WwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otr9k4GoKwfQv9Joa8yyBiv7uFW72krl5ma+HCu/7M8=;
        b=Lu9pWEKYWy6y50M9POHVsWtEDQ0DhLqfmNudKPlhO2wlu31fIGiGLq10/JFsae4uaT
         clUsJrpH0TPMxmhLfDTvRd2yctRzFmdyqa8jXvnDObT0EwtOeTswzGhJs3bQ0sctoSUm
         ZFQeSQBflQyZkgSPR2uVBgmmhH17uUsN1rI8uz104GbYmioZhDCaIxdowGXUP0+4WnNT
         TQQs1zcccMHm9FGf15NJVxc95mbxLGSxEbn20Mq5ZZcg5iS3c9wx4ZiLTi8n7LNcuffO
         60nsGw/ls1E/NG9lxrPGIwfZzYzMgl+/vHGWvK/mVJVrpSJtLkQLz9fhKtbwJokF84aV
         QasA==
X-Gm-Message-State: AGRZ1gLwLNn+BOFL7Ihnt/zW+HYBQHXRCdyEtvXGXP62dRhP32CQBnrY
        Xmy6lbOw9KdiuOg7cGnaVUT9Yg==
X-Google-Smtp-Source: AJdET5eoZ6I2IgDBDyboNA1LLiI6Ou6NzKjulvj7XEjv/VqAcIsAiFo6n56jjnZOyMDAMRkgiE6W5g==
X-Received: by 2002:a81:58c4:: with SMTP id m187mr9910762ywb.300.1542393803559;
        Fri, 16 Nov 2018 10:43:23 -0800 (PST)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id b144sm5359134ywa.33.2018.11.16.10.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 10:43:22 -0800 (PST)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Cc:     robdclark@gmail.com, jsanka@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/24] drm/msm: dpu: Remove dpu_power_handle
Date:   Fri, 16 Nov 2018 13:42:19 -0500
Message-Id: <20181116184238.170034-10-sean@poorly.run>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181116184238.170034-1-sean@poorly.run>
References: <20181116184238.170034-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Now that we don't have any event handlers, remove dpu_power_handle!

Changes in v2:
- None

Reviewed-by: Jeykumar Sankaran <jsanka@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/msm/Makefile                  |   1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  11 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |   3 -
 .../gpu/drm/msm/disp/dpu1/dpu_power_handle.c  | 136 ------------------
 .../gpu/drm/msm/disp/dpu1/dpu_power_handle.h  | 113 ---------------
 5 files changed, 264 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
 delete mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 19ab521d4c3a..7d02ef3655b5 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -72,7 +72,6 @@ msm-y := \
 	disp/dpu1/dpu_kms.o \
 	disp/dpu1/dpu_mdss.o \
 	disp/dpu1/dpu_plane.o \
-	disp/dpu1/dpu_power_handle.o \
 	disp/dpu1/dpu_rm.o \
 	disp/dpu1/dpu_vbif.o \
 	msm_atomic.o \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index af666d917a0b..9f7da56bb453 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1060,8 +1060,6 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
-	dpu_power_resource_init(pdev, &dpu_kms->phandle);
-
 	platform_set_drvdata(pdev, dpu_kms);
 
 	msm_kms_init(&dpu_kms->base, &kms_funcs);
@@ -1081,7 +1079,6 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
 	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
 	struct dss_module_power *mp = &dpu_kms->mp;
 
-	dpu_power_resource_deinit(pdev, &dpu_kms->phandle);
 	msm_dss_put_clk(mp->clk_config, mp->num_clk);
 	devm_kfree(&pdev->dev, mp->clk_config);
 	mp->num_clk = 0;
@@ -1120,10 +1117,6 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
 		return rc;
 	}
 
-	rc = dpu_power_resource_enable(&dpu_kms->phandle, false);
-	if (rc)
-		DPU_ERROR("resource disable failed: %d\n", rc);
-
 	rc = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
 	if (rc)
 		DPU_ERROR("clock disable failed rc:%d\n", rc);
@@ -1157,10 +1150,6 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
 	drm_for_each_crtc(crtc, ddev)
 		dpu_crtc_runtime_resume(crtc);
 
-	rc = dpu_power_resource_enable(&dpu_kms->phandle, true);
-	if (rc)
-		DPU_ERROR("resource enable failed: %d\n", rc);
-
 	return rc;
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 4e5acacb3065..59e18e2d3c59 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -31,7 +31,6 @@
 #include "dpu_hw_top.h"
 #include "dpu_io_util.h"
 #include "dpu_rm.h"
-#include "dpu_power_handle.h"
 #include "dpu_irq.h"
 #include "dpu_core_perf.h"
 
@@ -114,8 +113,6 @@ struct dpu_kms {
 	int core_rev;
 	struct dpu_mdss_cfg *catalog;
 
-	struct dpu_power_handle phandle;
-
 	/* directory entry for debugfs */
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_danger;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
deleted file mode 100644
index 8e64f0a52147..000000000000
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/* Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#define pr_fmt(fmt)	"[drm:%s:%d]: " fmt, __func__, __LINE__
-
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/string.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
-#include <linux/mutex.h>
-#include <linux/of_platform.h>
-
-#include "dpu_power_handle.h"
-#include "dpu_trace.h"
-
-static void dpu_power_event_trigger_locked(struct dpu_power_handle *phandle,
-		u32 event_type)
-{
-	struct dpu_power_event *event;
-
-	list_for_each_entry(event, &phandle->event_list, list) {
-		if (event->event_type & event_type)
-			event->cb_fnc(event_type, event->usr);
-	}
-}
-
-void dpu_power_resource_init(struct platform_device *pdev,
-	struct dpu_power_handle *phandle)
-{
-	phandle->dev = &pdev->dev;
-
-	INIT_LIST_HEAD(&phandle->event_list);
-
-	mutex_init(&phandle->phandle_lock);
-}
-
-void dpu_power_resource_deinit(struct platform_device *pdev,
-	struct dpu_power_handle *phandle)
-{
-	struct dpu_power_event *curr_event, *next_event;
-
-	if (!phandle || !pdev) {
-		pr_err("invalid input param\n");
-		return;
-	}
-
-	mutex_lock(&phandle->phandle_lock);
-	list_for_each_entry_safe(curr_event, next_event,
-			&phandle->event_list, list) {
-		pr_err("event:%d, client:%s still registered\n",
-				curr_event->event_type,
-				curr_event->client_name);
-		curr_event->active = false;
-		list_del(&curr_event->list);
-	}
-	mutex_unlock(&phandle->phandle_lock);
-}
-
-int dpu_power_resource_enable(struct dpu_power_handle *phandle, bool enable)
-{
-	u32 event_type;
-
-	if (!phandle) {
-		pr_err("invalid input argument\n");
-		return -EINVAL;
-	}
-
-	mutex_lock(&phandle->phandle_lock);
-
-	event_type = enable ? DPU_POWER_EVENT_ENABLE : DPU_POWER_EVENT_DISABLE;
-
-	dpu_power_event_trigger_locked(phandle,	event_type);
-
-	mutex_unlock(&phandle->phandle_lock);
-	return 0;
-}
-
-struct dpu_power_event *dpu_power_handle_register_event(
-		struct dpu_power_handle *phandle,
-		u32 event_type, void (*cb_fnc)(u32 event_type, void *usr),
-		void *usr, char *client_name)
-{
-	struct dpu_power_event *event;
-
-	if (!phandle) {
-		pr_err("invalid power handle\n");
-		return ERR_PTR(-EINVAL);
-	} else if (!cb_fnc || !event_type) {
-		pr_err("no callback fnc or event type\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	event = kzalloc(sizeof(struct dpu_power_event), GFP_KERNEL);
-	if (!event)
-		return ERR_PTR(-ENOMEM);
-
-	event->event_type = event_type;
-	event->cb_fnc = cb_fnc;
-	event->usr = usr;
-	strlcpy(event->client_name, client_name, MAX_CLIENT_NAME_LEN);
-	event->active = true;
-
-	mutex_lock(&phandle->phandle_lock);
-	list_add(&event->list, &phandle->event_list);
-	mutex_unlock(&phandle->phandle_lock);
-
-	return event;
-}
-
-void dpu_power_handle_unregister_event(
-		struct dpu_power_handle *phandle,
-		struct dpu_power_event *event)
-{
-	if (!phandle || !event) {
-		pr_err("invalid phandle or event\n");
-	} else if (!event->active) {
-		pr_err("power handle deinit already done\n");
-		kfree(event);
-	} else {
-		mutex_lock(&phandle->phandle_lock);
-		list_del_init(&event->list);
-		mutex_unlock(&phandle->phandle_lock);
-		kfree(event);
-	}
-}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h
deleted file mode 100644
index 7536624c8b20..000000000000
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h
+++ /dev/null
@@ -1,113 +0,0 @@
-/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef _DPU_POWER_HANDLE_H_
-#define _DPU_POWER_HANDLE_H_
-
-#define MAX_CLIENT_NAME_LEN 128
-
-#define DPU_POWER_HANDLE_ENABLE_BUS_AB_QUOTA	0
-#define DPU_POWER_HANDLE_DISABLE_BUS_AB_QUOTA	0
-#define DPU_POWER_HANDLE_ENABLE_BUS_IB_QUOTA	1600000000
-#define DPU_POWER_HANDLE_DISABLE_BUS_IB_QUOTA	0
-
-#include "dpu_io_util.h"
-
-/* events will be triggered on power handler enable/disable */
-#define DPU_POWER_EVENT_DISABLE	BIT(0)
-#define DPU_POWER_EVENT_ENABLE	BIT(1)
-
-/*
- * struct dpu_power_event - local event registration structure
- * @client_name: name of the client registering
- * @cb_fnc: pointer to desired callback function
- * @usr: user pointer to pass to callback event trigger
- * @event: refer to DPU_POWER_HANDLE_EVENT_*
- * @list: list to attach event master list
- * @active: indicates the state of dpu power handle
- */
-struct dpu_power_event {
-	char client_name[MAX_CLIENT_NAME_LEN];
-	void (*cb_fnc)(u32 event_type, void *usr);
-	void *usr;
-	u32 event_type;
-	struct list_head list;
-	bool active;
-};
-
-/**
- * struct dpu_power_handle: power handle main struct
- * @phandle_lock: lock to synchronize the enable/disable
- * @dev: pointer to device structure
- * @usecase_ndx: current usecase index
- * @event_list: current power handle event list
- */
-struct dpu_power_handle {
-	struct mutex phandle_lock;
-	struct device *dev;
-	u32 current_usecase_ndx;
-	struct list_head event_list;
-};
-
-/**
- * dpu_power_resource_init() - initializes the dpu power handle
- * @pdev:   platform device to search the power resources
- * @pdata:  power handle to store the power resources
- */
-void dpu_power_resource_init(struct platform_device *pdev,
-	struct dpu_power_handle *pdata);
-
-/**
- * dpu_power_resource_deinit() - release the dpu power handle
- * @pdev:   platform device for power resources
- * @pdata:  power handle containing the resources
- *
- * Return: error code.
- */
-void dpu_power_resource_deinit(struct platform_device *pdev,
-	struct dpu_power_handle *pdata);
-
-/**
- * dpu_power_resource_enable() - enable/disable the power resources
- * @pdata:  power handle containing the resources
- * @enable: boolean request for enable/disable
- *
- * Return: error code.
- */
-int dpu_power_resource_enable(struct dpu_power_handle *pdata, bool enable);
-
-/**
- * dpu_power_handle_register_event - register a callback function for an event.
- *	Clients can register for multiple events with a single register.
- *	Any block with access to phandle can register for the event
- *	notification.
- * @phandle:	power handle containing the resources
- * @event_type:	event type to register; refer DPU_POWER_HANDLE_EVENT_*
- * @cb_fnc:	pointer to desired callback function
- * @usr:	user pointer to pass to callback on event trigger
- *
- * Return:	event pointer if success, or error code otherwise
- */
-struct dpu_power_event *dpu_power_handle_register_event(
-		struct dpu_power_handle *phandle,
-		u32 event_type, void (*cb_fnc)(u32 event_type, void *usr),
-		void *usr, char *client_name);
-/**
- * dpu_power_handle_unregister_event - unregister callback for event(s)
- * @phandle:	power handle containing the resources
- * @event:	event pointer returned after power handle register
- */
-void dpu_power_handle_unregister_event(struct dpu_power_handle *phandle,
-		struct dpu_power_event *event);
-
-#endif /* _DPU_POWER_HANDLE_H_ */
-- 
Sean Paul, Software Engineer, Google / Chromium OS

