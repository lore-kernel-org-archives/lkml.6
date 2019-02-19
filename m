Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D55C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CFD2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7absAyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfBSWDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:03:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35863 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbfBSWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:03:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so10770238pgr.3;
        Tue, 19 Feb 2019 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hgV92wDT2ZmcOau/wgDvn2O7fusGY5Cr61uoT+/hFU=;
        b=C7absAylMscTk4Wjtt7Y4IbaIyGuHygs0J94JlBR7eQX7eVs9S1ayeofPfpDjrKJK3
         45a6P1EgyNgQxDbGU3ZpHrTyGYFZGCwNf1VOe5gmznWb/4Ppz8HIZVfVr0LrGIb2jdiv
         gk3Pi9USbefmrKl9z/DrgtP7XLh8bXvhK3UW+go7HEhNnFi5nu6iuDAbx/5TDPLCEWNg
         1lRvkfVrk2zFBfm+jkImsL1WcU1/6D902qxA0m3JFvt5ZKNOLeAdfKIKeSOhxM0Jn396
         kV3J+FObFkdo957p4OSioHkZP5N9iCkpp9JghZ3qdrcmn56lkILFWxMSDu08rSTAmMac
         h4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hgV92wDT2ZmcOau/wgDvn2O7fusGY5Cr61uoT+/hFU=;
        b=JX5C7CR33wJLmGnQCKuxJtQd7dSNfzKAE787m0YXs932gtkC+aU20dLdAheU2c17Ec
         f11DRS0eXSkUTNsPF0BNKYncwR0GYsg7cCy/8It+E3laPQ4Trebq2M33KHKwR555EQlO
         CpyXzZQ4MNRiFoTF+Wtg99PrXTSUEsYYZv8tTb6uyymxqOeVeTHyIY1LZSRhgebFu+19
         3qLv1jcf2htxrZvUNtEWaVxGxd5OkjDQkmk1Cq2roqJbWjJAmpS0HoQdqoa2Ea1LlY55
         u2e7mPhVxYKnwy+4uyLQdhGWCiTEdv3+U+N31T8L2ObU4u1BIn+YH1ZkypKc6GaeUAM9
         3gGA==
X-Gm-Message-State: AHQUAuY1sTeVz+Ke07d9VyrH5dvrVZyWTJKdBD15sRVY3h9KOdc2P+ia
        t9OrhReW9B6baK80MnqwAqaN5TjgcYc=
X-Google-Smtp-Source: AHgI3IZK/aAcXXln+ubV5L0uRdVx43Y7pNJRTzMywNs93NFIfXPSMEzZJJEQyGJ20s7zIg8M95jiCg==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr26126163pgk.147.1550613789961;
        Tue, 19 Feb 2019 14:03:09 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:161b])
        by smtp.gmail.com with ESMTPSA id e6sm33539779pfe.59.2019.02.19.14.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:03:09 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org
Subject: [PATCH v8 7/7] cgroup: document cgroup v2 freezer interface
Date:   Tue, 19 Feb 2019 14:02:52 -0800
Message-Id: <20190219220252.4906-8-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219220252.4906-1-guro@fb.com>
References: <20190219220252.4906-1-guro@fb.com>
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

