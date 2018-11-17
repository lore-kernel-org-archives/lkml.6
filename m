Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2BC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B72208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEbzETZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B72208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeKQKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:53:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41930 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbeKQKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:53:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so11290457pgh.8;
        Fri, 16 Nov 2018 16:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37Hf1x10NLuEt+wNwFB65vwUj5lPVMCSL7uBe89akZ4=;
        b=GEbzETZBCS/sOrvlWPM6Nhp9oQNy1y0bCkc1luh6bqDnYXjnaj8b118TW3aPXUNeJG
         ZsW1NtPfg2zP6VTm5m5uC0QoS6I9O4H53mzKOTFCfPqJZ9q5+FEbtZrlwTGl5c1jHy98
         mHQLxa5dl6Ag6j8kN0WsWmgNieYXFIzo7l9L3Xkkd0vc6bjj+YO5wMQGJ/ezU1FB1jBy
         Db9vvWfG4usAL/toFiuYFDe05h2fved91XnUuFJ6lpXbQZzPKl97JRdHHrMu6G/R2dRe
         j4EPl90x48QzEBlYfHwwMQZ7UxOUHOJBWlT/WLZoVTbPOMtkEVvIK2/+mYacf/akZ1BK
         es0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37Hf1x10NLuEt+wNwFB65vwUj5lPVMCSL7uBe89akZ4=;
        b=c37DRp4cuaQwkXN62fgwYftezv/FoBNa5j3sdwmbCe/Vx2/6T+9WArKcRrjCkMmGdX
         HW1YlmzNcNzNjCZtZJoaeUDtQtMkKCPTLq6MNEn+L3Xr9z3SQABRPfXKhH5bPmKC2y8A
         psxg0WViZv8I19wSCzmLGe1tSUbOP7vB4lfJvA1D95ZB1qtRe84+i126dn0AZfBz4KVJ
         anHfSyZcvS/3AR9GEt2p89MQ19UHjoX8T65E74ntoyIKufZf5bgb4H9Jr1WaC8dkVT85
         cgiyWuKWIcwq9wnVpGup0rrolthoAJ9TBAyVFzgMffYpZwQpXxn53VQ7NVp1+5W62qZD
         HSrw==
X-Gm-Message-State: AGRZ1gIEszckJAAwBrJ3Ph4XFiLWftdRJxW09QVS970O5FMBQtjyu+Jm
        uUw0H8pY39dD8KSXIWm0k7c=
X-Google-Smtp-Source: AJdET5foZ1EdCnJVKnTJ+21mnUmc4KBL5JwTsB9iGqaKplhLcqSfxVR86td4eL0idX0hy+iesrgeAw==
X-Received: by 2002:a62:ea10:: with SMTP id t16-v6mr13992921pfh.228.1542415122415;
        Fri, 16 Nov 2018 16:38:42 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:2b73])
        by smtp.gmail.com with ESMTPSA id f6sm1981177pfg.188.2018.11.16.16.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 16:38:41 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, linux-doc@vger.kernel.org
Subject: [PATCH v3 7/7] cgroup: document cgroup v2 freezer interface
Date:   Fri, 16 Nov 2018 16:38:30 -0800
Message-Id: <20181117003830.15344-8-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181117003830.15344-1-guro@fb.com>
References: <20181117003830.15344-1-guro@fb.com>
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
 Documentation/admin-guide/cgroup-v2.rst | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 184193bcb262..a065c0bed88c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -862,6 +862,8 @@ All cgroup core files are prefixed with "cgroup."
 	  populated
 		1 if the cgroup or its descendants contains any live
 		processes; otherwise, 0.
+	  frozen
+		1 if the cgroup is frozen; otherwise, 0.
 
   cgroup.max.descendants
 	A read-write single value files.  The default is "max".
@@ -895,6 +897,30 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+  cgroup.freeze
+	A read-write single value file which exists on non-root cgroups.
+	Allowed values are "0" and "1". The default is "0".
+
+	Writing "1" to the file causes freezing of the cgroup and all
+	descendant cgroups. This means that all belonging processes will
+	be stopped and will not run until the cgroup will be explicitly
+	unfrozen. Freezing of the cgroup may take some time; when the process
+	is complete, the "frozen" value in the cgroup.events control file
+	will be updated and the corresponding notification will be issued.
+
+	Cgroup can be frozen either by its own settings, either by settings
+	of any ancestor cgroups. If any of ancestor cgroups is frozen, the
+	cgroup will remain frozen.
+
+	Processes in the frozen cgroup can be killed by a fatal signal.
+	They also can enter and leave a frozen cgroup: either by an explicit
+	move by a user, either if freezing of the cgroup races with fork().
+	If a cgroup is moved to a frozen cgroup, it stops. If a process is
+	moving out of a frozen cgroup, it becomes running.
+
+	Frozen status of a cgroup doesn't affect any cgroup tree operations:
+	it's possible to delete a frozen (and empty) cgroup, as well as
+	create new sub-cgroups.
 
 Controllers
 ===========
-- 
2.17.2

