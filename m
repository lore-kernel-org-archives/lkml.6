Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDBA20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeLS648n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDBA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeLAK7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:59:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35378 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLAK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:59:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so3551952pfi.2;
        Fri, 30 Nov 2018 15:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNiXMipqkuH/anRcfopn8XxqISAUbvZjEb9Ku6rCx0A=;
        b=ZeLS648n7PDoTv4CN/31oK5h1LPX+aZPSGwD9mC96VTyLO2yq9pyNveFAVz14beil1
         fueDRtMVCVuoSImhu35O/Muj29FSM4uHGe6ByeUwTadsPjG+xUpcc9k+iBwOwrYc0LIB
         Ra0Z7SfUi34PS5Wqjnm7euwgQUmKefATVZ4IFg1W7Tj9GNasW6bPxue/9HhHqanhyayG
         1j7fu5ew3wBQqJR3S/rhhYGe3kV96H1FbsjZfslZJlnyHJxgcZPVifqdED3ipFAAotEC
         l3DD+7W/Nds21wS409N02ShTyTXDE7OZQl3LHefE6gwFF3buYc3tDRY30bQYqkDSNfDu
         mL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNiXMipqkuH/anRcfopn8XxqISAUbvZjEb9Ku6rCx0A=;
        b=SNUbjOKygs9CBEncHaZ2x6oaB0J/SKJRjEZGhoehGOlqFntuo5B7AmmtchGnk+Lsrc
         5BRiYoEKZgV175fsxx8U9dtYSbiWzy22adS52Ocj9mAqKKNAKzi8iXAZOBX4EPqI/WM+
         3AsKq3j1sdeR02H1Vx8RviP9pVpqV4XBpw23I+1dxGIXaZG//EIjU2ErfRLzACQFu+bZ
         SGvgrgwuvCFVnLWI73uXFLuYXXA7MiWNVzy0oFlZjAhRRvzYOzJTn6ar62fB6sXnjiv0
         5IxnT6OsBo2MQ37YUF+lduDOAe7glQa6vtaJs6G4/qvp6dBhFKFlVDl0hBc6WzI6/lhG
         iQrw==
X-Gm-Message-State: AA+aEWa83vkfdmja4MicO1QB38wzgTvS6wWuX47Rom/qzYFttfmYdgCV
        qqJkLE3w3d98Tq8qr69/NjQ=
X-Google-Smtp-Source: AFSGD/Uao93VpeU2UC6j7McPDUL7Q+wgyWxSM6km6K05n04Avr47CtTur5Jwvev6ykuon13HO992cg==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr6523559pgh.164.1543621682181;
        Fri, 30 Nov 2018 15:48:02 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:2b61])
        by smtp.gmail.com with ESMTPSA id e188sm9556742pfg.130.2018.11.30.15.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:48:01 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 7/7] cgroup: document cgroup v2 freezer interface
Date:   Fri, 30 Nov 2018 15:47:45 -0800
Message-Id: <20181130234745.6756-8-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130234745.6756-1-guro@fb.com>
References: <20181130234745.6756-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup v2 freezer interface in the cgroup v2 admin guide.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 07e06136a550..f8335e26b362 100644
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
2.17.2

