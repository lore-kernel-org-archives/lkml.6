Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE420817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9W+9a9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CE420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKIFxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:53:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42981 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeKIFxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:53:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so5120413qka.9;
        Thu, 08 Nov 2018 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DzcE5bixymM64ursY5BeupFFYZWpXSHlxEvgaLA1wns=;
        b=G9W+9a9Owr0udn9+avJL0Cm5EE2JVW/Y6IAVePlgAQzQaJSetWPvajRzsuemZwsSLn
         NieBizmjVwCJaDYHQcO1iFS1oH4vq4EhggaeGy/EC8G8PUziMlSuCRfjb6ud2pT3C/eD
         Y4f5O0VcC62DRnyBT48R6hueokdmbs4TfzQA9PAs2MEo1TabjDzEeKApDqnEVmzyaWiv
         hQ2ewi/imNIVRf7DBrOn0cPhzGDcFDqJMPA2/tR/aj9t37UOa638LoDnpiEuoO9LGn0N
         leHI7hB1TL7J3DYcuRJwr/NkY/4Va7WCBuDRmcOk4SCJiowXWBhhXzynsqmRQzSSzR0c
         Oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DzcE5bixymM64ursY5BeupFFYZWpXSHlxEvgaLA1wns=;
        b=r+bzYaysHoV04+LC5jbjRuoWQNhqHONa6laVgr0McAFDvELnuMyt96HTQJbYJzbx9i
         s2/i4YGm1ZS7FuBXoXQzRLjHLC07uv0fv8jaIGhCmuMlBXiT85W7FtUVL5h7TsPk/oaC
         +0GdnwFE9QSH1GxgTKnHR9b5glr3xx4CxPW7CQ1l8abpfmuw3w5ZnG6pmBBaNVbxecPQ
         wkGiJSdcgxR4j18G4fnXJXI7Xq7G7JHxz8xopi6YrFprK2Z6Ar5aXQesuhgsFhTCd3H2
         CeNnr1k8cZKcpIQ7c+4Bz+z9la3NFrawuQMi/OWy3hKfxqGoL9w9a6G9s1oQo+oFjWKU
         8XLQ==
X-Gm-Message-State: AGRZ1gKEwee95Bz8UFUR3ORhNe+HZMp6Z1NLsTNzlINYEAsd6RaEoyJJ
        +I6ebTjM5/3U49TTCZ59TWxBZhai4fA=
X-Google-Smtp-Source: AJdET5ctvsBVQHvyRFfMRBfrmmlIMx/c/B+lsB72MqHiJgmGrI0znxV+fWkfD4W868uUhNVGdSMYdg==
X-Received: by 2002:a37:73c4:: with SMTP id o187mr5890623qkc.157.1541708173901;
        Thu, 08 Nov 2018 12:16:13 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c091:200::4:4cb1])
        by smtp.gmail.com with ESMTPSA id k38sm3399381qkh.72.2018.11.08.12.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 12:16:13 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Thu,  8 Nov 2018 15:15:59 -0500
Message-Id: <20181108201600.9129-5-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181108201600.9129-1-guro@fb.com>
References: <20181108201600.9129-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cgroup destruction races with an exit() of a belonging
process(es), cg_kill_all() may fail. It's not a good reason to make
cg_destroy() fail and leave the cgroup in place, potentially causing
next test runs to fail.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 14c9fe284806..eba06f94433b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -227,9 +227,7 @@ int cg_destroy(const char *cgroup)
 retry:
 	ret = rmdir(cgroup);
 	if (ret && errno == EBUSY) {
-		ret = cg_killall(cgroup);
-		if (ret)
-			return ret;
+		cg_killall(cgroup);
 		usleep(100);
 		goto retry;
 	}
-- 
2.17.2

