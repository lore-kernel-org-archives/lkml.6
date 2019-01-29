Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A558C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0023D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfA2GrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:47:15 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35222 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbfA2GrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:47:14 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0T6lDj0011907
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:47:14 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0T6l8gt029050
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:47:13 -0500
Received: by mail-qt1-f197.google.com with SMTP id u32so23801082qte.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 22:47:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=WZ49e+wOO/wtFvBaOgf7zukaRUZflpYPsjy82W11Klw=;
        b=XMpuwiYDjdiesjl6so7WxiQr98lVw72UrTaQLZ9EQ2K0tnYVXtopNe+9V1fu9kLlCP
         FeG1PLWSBHoW5uSZoeQhOaIulx64nqRgiER88PZZ8BsC0CyhNuRwiPuI+yg+gB6y/GnP
         EnWOP6ocRp/0y7u8tp7xXQv32XpltOHBJ1X0v1EsnplrPNfDoilpXj3xlT02YIPNrrFg
         42CrwBfxTZebPXQ8nIF3S38GsU8enoHBEVAisGRA8o+G5UJVOBRDCMpHaT8bgsPuV6tP
         pJnEHxRCxMl4ZZha+lOOd2Py3esdIY8ZDQ8DFRmpwlOoSvDuDObLUL+0P31HkHu4II5J
         iDbA==
X-Gm-Message-State: AJcUuke5gRbiqEiLd8VQoQaaO9KQ0ykBTC/w58o+J99+5IYWJK/1VrSG
        F7x1LHFnl0mNNyupoTm0wHGUz08m+SeOsIAI1t+tA5q0ZkXkETrkGOLZuXqcXkKc4GLIOd4xUEU
        SIYM+kvBz55XeRx1mONQ2NSfSWvxPKWK/NLA=
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr25044104qti.336.1548744428640;
        Mon, 28 Jan 2019 22:47:08 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5uTqvDGtpsIQDBn0Cf36InlGDtjH/7RpMcRpyptlvlnus0MpL2+c/cJILEkZM9o6L60Nm6FQ==
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr25044098qti.336.1548744428478;
        Mon, 28 Jan 2019 22:47:08 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id c11sm67954413qtn.95.2019.01.28.22.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 22:47:07 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/bpf/cgroup.c - clean up kerneldoc warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 29 Jan 2019 01:47:06 -0500
Message-ID: <10746.1548744426@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with W=1 reveals some bitrot 

  CC      kernel/bpf/cgroup.o
kernel/bpf/cgroup.c:238: warning: Function parameter or member 'flags' not described in '__cgroup_bpf_attach'
kernel/bpf/cgroup.c:367: warning: Function parameter or member 'unused_flags' not described in '__cgroup_bpf_detach'

Add a kerneldoc line for 'flags'.

Fixing the warning for 'unused_flags' is best approached by
removing the unused parameter on the function call.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 588dd5f0bd85..695b2a880d9a 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -78,7 +78,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp);
 int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 			enum bpf_attach_type type, u32 flags);
 int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
-			enum bpf_attach_type type, u32 flags);
+			enum bpf_attach_type type);
 int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		       union bpf_attr __user *uattr);
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ab612fe9862f..d78cfec5807d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -230,6 +230,7 @@ static int update_effective_progs(struct cgroup *cgrp,
  * @cgrp: The cgroup which descendants to traverse
  * @prog: A program to attach
  * @type: Type of attach operation
+ * @flags: Option flags
  *
  * Must be called with cgroup_mutex held.
  */
@@ -363,7 +364,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
  * Must be called with cgroup_mutex held.
  */
 int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
-			enum bpf_attach_type type, u32 unused_flags)
+			enum bpf_attach_type type)
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	enum bpf_cgroup_storage_type stype;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6d03a27918f4..9802ab424397 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6059,7 +6059,7 @@ int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 	int ret;
 
 	mutex_lock(&cgroup_mutex);
-	ret = __cgroup_bpf_detach(cgrp, prog, type, flags);
+	ret = __cgroup_bpf_detach(cgrp, prog, type);
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }

