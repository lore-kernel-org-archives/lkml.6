Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D4DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EEF2190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOdAZ4ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfBLSsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:48:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40698 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbfBLSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:48:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so1711978plb.7;
        Tue, 12 Feb 2019 10:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hgV92wDT2ZmcOau/wgDvn2O7fusGY5Cr61uoT+/hFU=;
        b=XOdAZ4ejroaV8XQrbRNs0Bo9BtzFbOVrVwqyUebTzCyOdhZf4ZBNLWi30bbeHVYcKK
         XI8XOTU81zGsFSZoukFtA6eQJva7mkLs7zpqhnZiI1C8fU0VGHPovaLeZjRP95HMAHZb
         HW/XRcRxjERl+cDMu5KzyXlqCVLTAywtdN7l3r84bRmbYAFDuBK6DIu3+jysI3ra1xs1
         V2HdoIczc8kmGA+/SddU6DWhrnEWr5D3rNfX4osYhjNQf71L20ZrdOf7nAu4bZ/oaqeB
         AF6PWWWnTbNFU1lWR5gAgEIc7c4M6uluA6avxYsUc0D82sUV5bwa86kSeUkHoFHPepE7
         Aqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hgV92wDT2ZmcOau/wgDvn2O7fusGY5Cr61uoT+/hFU=;
        b=YED5Sqexfr533wQL13mubPJFM1NGCYdrJC1Byms0csReIPeqi2DGPrdrk9EbDs7j+u
         Tm2WmTLk9YUUnT6UE28tBZcJ1lwSrIyZkTe0bS970Zlm67z9q/10rLxvO9JOm8DB8g7R
         CHrv+94IG+KH6nBJsgFmD9cEAh348R0iUZfYafIMWxyO+T03kWtIOJn7yHCc2oOHFv8k
         0okUrZmGqc0Hk6L+KvwycVZDy6eLKQvFsS/EWFCVS4j2YDawXnZsLr5EMl/cl+7cGClI
         QcYYzRNdofyGOr2gXF64adJ20pfh9JDYbPo4eVl8MQpj1YfOCNxUmpJwlfwOXB/XHC3H
         52TA==
X-Gm-Message-State: AHQUAuZydxFixjL04adI+aKWVyClIqZRosCs2m5XLG8lJ1Vaalktgfe1
        qD14Tqn95hS3m+xJdP6kFomBWI4310Q=
X-Google-Smtp-Source: AHgI3IYeuDp1vcysP0tH2EoKM0pCJ0lPuK4U1AEQ5YqQ5NsmTeDVAQ3HWrp6An3Et9Z/srpcijixhw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr5245192pla.144.1549997305108;
        Tue, 12 Feb 2019 10:48:25 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id f67sm25480102pfc.141.2019.02.12.10.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:48:24 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org
Subject: [PATCH v7 7/7] cgroup: document cgroup v2 freezer interface
Date:   Tue, 12 Feb 2019 10:48:07 -0800
Message-Id: <20190212184807.20304-8-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212184807.20304-1-guro@fb.com>
References: <20190212184807.20304-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup v2 freezer interface in the cgroup v2 admin guide.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 61f8bbb0a1b2..78f078ddbe9c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -864,6 +864,8 @@ All cgroup core files are prefixed with "cgroup."
 	  populated
 		1 if the cgroup or its descendants contains any live
 		processes; otherwise, 0.
+	  frozen
+		1 if the cgroup is frozen; otherwise, 0.
 
   cgroup.max.descendants
 	A read-write single value files.  The default is "max".
@@ -897,6 +899,31 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+  cgroup.freeze
+	A read-write single value file which exists on non-root cgroups.
+	Allowed values are "0" and "1". The default is "0".
+
+	Writing "1" to the file causes freezing of the cgroup and all
+	descendant cgroups. This means that all belonging processes will
+	be stopped and will not run until the cgroup will be explicitly
+	unfrozen. Freezing of the cgroup may take some time; when this action
+	is completed, the "frozen" value in the cgroup.events control file
+	will be updated to "1" and the corresponding notification will be
+	issued.
+
+	A cgroup can be frozen either by its own settings, or by settings
+	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
+	cgroup will remain frozen.
+
+	Processes in the frozen cgroup can be killed by a fatal signal.
+	They also can enter and leave a frozen cgroup: either by an explicit
+	move by a user, or if freezing of the cgroup races with fork().
+	If a process is moved to a frozen cgroup, it stops. If a process is
+	moved out of a frozen cgroup, it becomes running.
+
+	Frozen status of a cgroup doesn't affect any cgroup tree operations:
+	it's possible to delete a frozen (and empty) cgroup, as well as
+	create new sub-cgroups.
 
 Controllers
 ===========
-- 
2.20.1

