Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10110C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C579D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl6AQp5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C579D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeLGUPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:15:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40903 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeLGUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:15:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so2437767pfo.7;
        Fri, 07 Dec 2018 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oiVWgL/WHUTd0gentorRc6DDTrlDET1vasHz44Fkvas=;
        b=Tl6AQp5NBS+Vty8MRgicYJ/jVsKR0CryNf5wkhgDTDviSmtB5Wz5KcTOni7EQWYiOH
         M7G/A/ahbj0zI4CX/oWxaTi3eJ6MDEIHpJoed0IEfumnekz0XOS5c/X94GXsjpeRxgu+
         l2CL4eRuaWgoJimP0SL5rSZ5XqAxlywguM+C8fB+TRPnFh7lzKNozNYlW0wRdQBzUa/a
         ao6SOAXWMayp5gxtmPSMC71qWuSZw4ETGeggMgxoH2KE8z3aAC0/mT4J9+OJA3FOHaru
         l5GNQdJ37yTs4EbHlaXxMHzY7kffSwszM0uq23KIDYpnEAM7yJecJW8OXtILW++JSxuo
         zwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oiVWgL/WHUTd0gentorRc6DDTrlDET1vasHz44Fkvas=;
        b=B1U9JjQEq6+sMMcLcb8vzVAT6YRoR810hN8Gw3T5Y+GICcwfjHv2waip1foTnzvrzy
         tuDjARzfxpWXE9OjZCv9nTQbbfuH2mPEAOi3uY2RRbzGbQwEfEyce4H1hbRzuFTeUuCv
         pyEZnh2G1LU2+oON2B5QVsimR/fEH7ytoxVr89y13gCrHZpK9YQHgZeMsBF+b3YDeU2H
         zSdwz631ZJc9apFcRpfToel9uQHWs3t24vPOF4rWbuRunooGhXEaX57fC+h3aowLvNfT
         gSy+5tm3LiWTjapdDPSI9lgbwVBinbOaXFlKDKKidCbDuXkek7KQ27QcUprzzoljwxwX
         tFfA==
X-Gm-Message-State: AA+aEWZEi8V1rpqZUATGfW8Q6b5Shxo8QZci5h23Pw4ouLbpFN4Z/01X
        jS9zr2EtRXhTNAxhd+Ap66w=
X-Google-Smtp-Source: AFSGD/W5GF7l5xue5w7Lkrut0LyE2fg5jVo/CiU87iJyb7jzaQvHLrVInJWKnL5WvqjQBRBvOaQdpA==
X-Received: by 2002:a63:26c1:: with SMTP id m184mr2951411pgm.367.1544213740629;
        Fri, 07 Dec 2018 12:15:40 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c090:200::6:d83b])
        by smtp.gmail.com with ESMTPSA id q75sm5870898pfa.38.2018.12.07.12.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:15:39 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 5/7] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Fri,  7 Dec 2018 12:15:29 -0800
Message-Id: <20181207201531.1665-6-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181207201531.1665-1-guro@fb.com>
References: <20181207201531.1665-1-guro@fb.com>
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

