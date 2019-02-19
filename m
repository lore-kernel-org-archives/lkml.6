Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FEFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2976B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547679;
	bh=A1wKWlsrID4+jbrFsIV/UfCQTNQbB1z97uj2BLI1fcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=Xuw6onozz2VEcIG3Fj6S9aviTCU6dxayZECRmN1AgCHggVs0Wrrbvx+Hd0rn8Uze0
	 1H34vbqR2BSoSPDGjVJ8e6IgKR3j0QW0c+jRqI3gSId9XiN3EN0OD+o9LlBjtWN6Tl
	 nDaVu8pa3ofNMRqmmYLs8S05xynTRk/wS9HYyu4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBSDlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:41:17 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45076 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBSDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so11579883qtg.12;
        Mon, 18 Feb 2019 19:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=mixtgFOHJ8rVnEdEHA1KmScKmbK09f7UjWOhOlQYjQ4=;
        b=u+9RKvrLS1qfQSFA04RRDPpK2KO03Ck+9Iwzl4Q+TQozBtQHsujCUjlC3hli+BwGQX
         mXr2BnVD+6ERoWMluVODzPf+e+E0XDWMymqIDmLIRpRO6wWF8Imi3OBBfE2a8ne1JnLn
         9r3FN1n8R57/lO0FGuxT3BnWu/q2v06I/1cVzyeM3WY6h/t6oVtcjNVJz+0UT2nBaDno
         SMq6RkwbzuJAeh+np5LR0MuKP7tyk3nSDnab19v5Z6wczZXWX+n2nuVSGdKOYXoG81xw
         YbjXZZoeJ1koDj4nwLSbKUYSj4iFmThpkugSmNLbICrZL6cx1l7fnazHw/7DuFQNyC8t
         78Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=mixtgFOHJ8rVnEdEHA1KmScKmbK09f7UjWOhOlQYjQ4=;
        b=C/2c9UFvj12V/Cr8kNibrhXECIq0HiSdPptWHJx6bhGJ23sjpvMorln4GNFJEKQSPE
         cYSA+6chPeK+oWDupgQ9tKVAVQ258TU/0c01MaqeQ13SgkJbvyDBCp/XpC1dokC8s73Y
         st5f+vzq9c+x3MkoGtQzaY/AFFjmn4ELvjC3hg51+4xluX/RpcecfQC+gwjvH9Y2spoB
         Igh3zZUGsxnoPauspeRoymDBalDi/2Dl/MDIESv7ZNd2kkhbT9l59XprKm+r+HxqG5+T
         iDK2T+d8yFvun2DTV2H2Urv6eqsCMQAcCdNh/ZGAa8wFK8N+Z1ZvTG55lJOdDUQ+Sjyh
         GNCQ==
X-Gm-Message-State: AHQUAuZaNfvbiS0NvSY9X2IHrzkPQQQ7btG1X6R4XxhyetjxUkKR9AGp
        nRNBu9k0N61QxAj9IiBsfvbpErid
X-Google-Smtp-Source: AHgI3IapO2q1+ptdRtqq9LGBMlzTMhS/3pH+v6tDYIBpLk4yImUKbukZhVauSVYxf52ItTfLMbtHgw==
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr21430413qti.336.1550547623751;
        Mon, 18 Feb 2019 19:40:23 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:23 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 02/11] topolgy: simplify cputopology.txt formatting and wording
Date:   Mon, 18 Feb 2019 22:40:04 -0500
Message-Id: <e13cb72d48bdaed80b681abf89bc77d58931db51.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

No semantic changes.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/cputopology.txt | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index c6e7e9196a8b..2698da7e4f49 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -3,76 +3,76 @@ How CPU topology info is exported via sysfs
 ===========================================
 
 Export CPU topology info via sysfs. Items (attributes) are similar
-to /proc/cpuinfo output of some architectures:
+to /proc/cpuinfo output of some architectures.  They reside in
+/sys/devices/system/cpu/cpuX/topology/:
 
-1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
+physical_package_id:
 
 	physical package id of cpuX. Typically corresponds to a physical
 	socket number, but the actual value is architecture and platform
 	dependent.
 
-2) /sys/devices/system/cpu/cpuX/topology/core_id:
+core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).  The actual value is
 	architecture and platform dependent.
 
-3) /sys/devices/system/cpu/cpuX/topology/book_id:
+book_id:
 
 	the book ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-4) /sys/devices/system/cpu/cpuX/topology/drawer_id:
+drawer_id:
 
 	the drawer ID of cpuX. Typically it is the hardware platform's
 	identifier (rather than the kernel's).	The actual value is
 	architecture and platform dependent.
 
-5) /sys/devices/system/cpu/cpuX/topology/thread_siblings:
+thread_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	core as cpuX.
 
-6) /sys/devices/system/cpu/cpuX/topology/thread_siblings_list:
+thread_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-7) /sys/devices/system/cpu/cpuX/topology/core_siblings:
+core_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	physical_package_id.
 
-8) /sys/devices/system/cpu/cpuX/topology/core_siblings_list:
+core_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	physical_package_id.
 
-9) /sys/devices/system/cpu/cpuX/topology/book_siblings:
+book_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	book_id.
 
-10) /sys/devices/system/cpu/cpuX/topology/book_siblings_list:
+book_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	book_id.
 
-11) /sys/devices/system/cpu/cpuX/topology/drawer_siblings:
+drawer_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
 	drawer_id.
 
-12) /sys/devices/system/cpu/cpuX/topology/drawer_siblings_list:
+drawer_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
 	drawer_id.
 
-To implement it in an architecture-neutral way, a new source file,
-drivers/base/topology.c, is to export the 6 to 12 attributes. The book
-and drawer related sysfs files will only be created if CONFIG_SCHED_BOOK
-and CONFIG_SCHED_DRAWER are selected.
+Architecture-neutral, drivers/base/topology.c, exports these attributes.
+However, the book and drawer related sysfs files will only be created if
+CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
 CONFIG_SCHED_BOOK and CONFIG_DRAWER are currently only used on s390, where
 they reflect the cpu and cache hierarchy.
-- 
2.18.0-rc0

