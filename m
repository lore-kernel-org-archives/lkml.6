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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6518C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7570222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQpG3etk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfBLSsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:48:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45761 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfBLSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:48:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so1701318pls.12;
        Tue, 12 Feb 2019 10:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=LQpG3etk7MTKXkfQSPMgt1GsnnOOJYCT94TODTqM2M4NDx7aIxlM1gAMAGiH2LBzkK
         NsRzL1/yNTTUICGEVjV5WPrLB+lyt/3CIefoAEWj5uyYfaYJ0ifBO/3LHtyzQtZGj4OJ
         gkjtVGi1ypGgB81f/5pHoPT5OFe77VWTI2QSlF0ZMCXvXMmHq36ciHy7f0Yh+e0tveoe
         XDPch2lyiJKH5xe/oQcdyVzCxF5/izdKBGpK+blGJmNJNgp8kOWczhtjfnc/Xnb/7l0q
         8MtaUhoRHjMPgW8tfeTeulUr68IHzq0NoJ496q8NQk/IDPxLha0Y2VDeACSRbftDPECt
         vCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=BufwefrxlPgNroho/BFCuE6qzhQXCWikjHDzzfhLKfSN2R4MuCr8E8Gau19NngIZzg
         GJixwg0Y7xftBAUKy8jmnse3Kwc7TzlnopSoeSnheGeOHf2yGTtBJ3iqDFETShkDEP8x
         dyaPXYDv/4MzryTez24yovp1KOOAdNdd2l+YPEJPCf60Qn1vkUX9ktWyGYcwL1A5/+w2
         48xKrREfBWdFxNARwmDw4+PkSOR3u2Zek5+hbe/P3NgoIU+rg3QzUkHfJrfpKz6XDT4M
         sVgICXl+XS6rnCRq6PmEmFzCmuyk6gn04Hk8NHFVWp6P88ChIR0tkABo575a4n8jYU7F
         i4wg==
X-Gm-Message-State: AHQUAuaui0r4rRN+qpNQFVbolC+P5X7ICq2YfXUCUoSjw2jlhRnnSTES
        swPkOh+F1p+TDhA+2Oi3V/8=
X-Google-Smtp-Source: AHgI3IZxkt6SYUcEuE4t9K530eIUitBSZkQRxyk2p9QQ2vbSllLsI6oRn4HG60y7V1ipU1VTYDetpQ==
X-Received: by 2002:a17:902:241:: with SMTP id 59mr5328309plc.72.1549997302410;
        Tue, 12 Feb 2019 10:48:22 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id f67sm25480102pfc.141.2019.02.12.10.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:48:21 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v7 5/7] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Tue, 12 Feb 2019 10:48:05 -0800
Message-Id: <20190212184807.20304-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212184807.20304-1-guro@fb.com>
References: <20190212184807.20304-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-kselftest@vger.kernel.org
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
2.20.1

