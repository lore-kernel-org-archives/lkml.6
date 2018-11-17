Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791D7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AA2208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5fAvgNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AA2208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbeKQKxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:53:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33033 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbeKQKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:53:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so12161839pfk.0;
        Fri, 16 Nov 2018 16:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oiVWgL/WHUTd0gentorRc6DDTrlDET1vasHz44Fkvas=;
        b=m5fAvgNT0ALbznjtvQDpaZKTEG8H7cKwcf7NZSMkS7GDc3wwPXOT9aJhJG1yuOphcy
         Ype74/TsezjxgQ+Lyae2iX6zHipWQGMFHQfw0cpdoj9sM8zO2WQnWbksMaOHqPLv6QLQ
         Iq74qlz3SF/U31I6Oubkse6RKmaXQ+PzYgo2OcAwJouAEZCTj9imtUWLkLPkPw0FoL5H
         ADjavVl+7kUX5V9BfBQcTWjfiMqekvMYKJ3iCIW30WDAWdD4VbNKf0oLbnVyHmMq9qvZ
         bqDqJzB0n7yLtOWq7hGxoVwDpXban2gdBcN2eWeF+MyHgw7J7MIVPE4diChQIztmI7vB
         l3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oiVWgL/WHUTd0gentorRc6DDTrlDET1vasHz44Fkvas=;
        b=Td8DKBPAMTzTS4RDfe8XTtCAUYW5dxnf3sBkVb/DvuM5aiDDMPnlcASJdoBET8uggx
         HcFD8wvo043MTt9Fv75ZB0N++vCG8YS5rOtjX67lFCKuojZ+YP4MDpPRSatx1MsiDW0W
         A+ukp6koLC6Qv6OKHr0abbg+yYOXBMzytdrat5TUNLJtKNarc418bKVoF/5s/wKKEc+j
         dysBJ+vqedacmR9VQmhbcGkLKD4bNkVVTQGJFzQx976tw+CaR2HjMZsnxWUT/CUJW8Eg
         /aYFsiQnoqGRlA5bu9dKOCeBH3U/l32HZm1yY+aWdCG5ngRbAl4F2g2hTNjZNmJjULgn
         7oew==
X-Gm-Message-State: AGRZ1gKrNj81KI2VFtJIQzK42axPDDjBgoXlWm75MwZebBIwLBQi23S5
        uNlBSTjrL7vULFnHupPaFGBz9OMhbSQ=
X-Google-Smtp-Source: AJdET5cpAPXq4Y70fKGau612iG6NLr9GvNy2E1VVqkJUYvP8zYw37YuUkrD67+HHH7LqTfjQ9q1Q6g==
X-Received: by 2002:a62:fb14:: with SMTP id x20-v6mr13281173pfm.71.1542415120194;
        Fri, 16 Nov 2018 16:38:40 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:2b73])
        by smtp.gmail.com with ESMTPSA id f6sm1981177pfg.188.2018.11.16.16.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 16:38:39 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/7] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Fri, 16 Nov 2018 16:38:28 -0800
Message-Id: <20181117003830.15344-6-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181117003830.15344-1-guro@fb.com>
References: <20181117003830.15344-1-guro@fb.com>
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
2.17.2

