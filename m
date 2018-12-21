Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEB72190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545378920;
	bh=QI9QzemGCZuiQ0yVS6Op/Kfzd4d/q4rBU/EK3EOMQjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azTN/tBmHSDNsNEHhqrvj+5CWUDZDCrlEEyFkS1uOfREftg/8KFdV4dURCW3fhHZP
	 dy5QGf/NnqZ5oHOYJgl7CbNCLRTjT9Hw0MaRlWpcLW6JYD67GuI3+GFcmuWiDN/HLu
	 /tq6lDchjABOxarnLKk4JupRO/MlZu4Ztc4QADA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbeLUHzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730539AbeLUHzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:55:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01CE21908;
        Fri, 21 Dec 2018 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545378917;
        bh=QI9QzemGCZuiQ0yVS6Op/Kfzd4d/q4rBU/EK3EOMQjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qn/Mg2xavPOz+q9SCQ3FBCg68z91B8mMdDSzSgBnBiHSQQLe1acLE8IehDw51nYqQ
         z/3dmuSNMgYNqL1m0zOxQ2jzzM5m17f7bLHi57TtNzQRUsZ5UQUNYzBHwQyhHvJ7L5
         Y/piUFPK3wgXqPVERdyaVa1vmD0jAgjFW7YuNcVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 10/10] driver core: remove BUS_ATTR()
Date:   Fri, 21 Dec 2018 08:54:42 +0100
Message-Id: <20181221075442.17109-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221075442.17109-1-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are now no in-kernel users of BUS_ATTR() so drop it from device.h

Everyone should use BUS_ATTR_RO/RW/WO() from now on.

Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..1e8ae731fb97 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -49,8 +49,6 @@ struct bus_attribute {
 	ssize_t (*store)(struct bus_type *bus, const char *buf, size_t count);
 };
 
-#define BUS_ATTR(_name, _mode, _show, _store)	\
-	struct bus_attribute bus_attr_##_name = __ATTR(_name, _mode, _show, _store)
 #define BUS_ATTR_RW(_name) \
 	struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
 #define BUS_ATTR_RO(_name) \
-- 
2.20.1

