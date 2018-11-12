Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D27C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9831224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1RIXgb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9831224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbeKMI7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:59:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeKMI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:59:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so4714580pgv.10;
        Mon, 12 Nov 2018 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4w/uS5CdZfUu32Qk39NtHIWDaBjSkhBcPb+FbjjLeZ4=;
        b=s1RIXgb3b+vXc5c89w24eOfcjmq9stBNrOwsuwcbhG9TyvKyMIw0z5/w5SCfK4ZFxR
         YDhm1UYvp7mmOJ+5vmN2WDG+abzd+uo2KIuR84P8HT92DH/jFnwA4ngNNtUC8cK24umN
         cR8Pie8hNyZOIQKHYDUvZP3Bc9drjlXrxw4Ev0YJkGZrvJdx6PvERxFYJmo6w7/r/bbj
         NexQouHzH9t3y2zfNs0UgMl8V6+O3lxko6nbpqJtSxor9uqSsncKIEjByKD7JjDtto6w
         +xj0+7cyIzPxIQvsxzh0pzAClsudMgWWBplzdhCaf/XaAtWON7+JKfWZw1J2Im77UCut
         Bw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4w/uS5CdZfUu32Qk39NtHIWDaBjSkhBcPb+FbjjLeZ4=;
        b=lfnbVAijvW+dSKES5VjhVktkAMOPtS3cX6FcOelnPSJL39ThlabzWidcWB+So9tafn
         h10dwbJait3DYRmJJZLc4Dmh5mj6UT+/hd6svLMjrUsSe1+/I+CqTnpa2lPxNDNSaUO0
         W5Rg9cTAct0lcIcSTNk+hGQkjBu691vNVW9vSFZ9sf63y3e+dPDfAtti0CKVU28Lb9YQ
         D2gHF6suD8RbEujeX9dx2OHSCdYyLn+jh0BRUDYLB56fNAOqnGyP4ie97ITC4QGdAebg
         QvNYWONXzC6VXRcFhwyV4fL1z9foxH+haBy8GflQt+a5rkCdPSktKnkgqoXkgYcqRWAJ
         xmtA==
X-Gm-Message-State: AGRZ1gJ/On0IVSKodI/5Umu+3corM1aYxbQ0Cy7rAky/x70030tzqvye
        ZPDFc9XgAmCHEF3LxzNmILk=
X-Google-Smtp-Source: AJdET5eIQ+CswnTHKudTBgdQ54DEBMprvHGb7xIYPul2AS52F+5lUZ+TX/ZzzwzrlJ1/3jxC3EjBAw==
X-Received: by 2002:a63:e055:: with SMTP id n21mr2527787pgj.397.1542063865619;
        Mon, 12 Nov 2018 15:04:25 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:c2f7])
        by smtp.gmail.com with ESMTPSA id f64sm7192327pfh.0.2018.11.12.15.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:04:25 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] cgroup: document cgroup v2 freezer interface
Date:   Mon, 12 Nov 2018 15:04:16 -0800
Message-Id: <20181112230422.5911-2-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112230422.5911-1-guro@fb.com>
References: <20181112230422.5911-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup v2 freezer interface in the cgroup v2 admin guide.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
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

