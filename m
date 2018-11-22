Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38438C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069CB20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069CB20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392401AbeKVRqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:46:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44677 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeKVRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:46:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM78JWO3691402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:08:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM78JL33691399;
        Wed, 21 Nov 2018 23:08:19 -0800
Date:   Wed, 21 Nov 2018 23:08:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Milian Wolff <tipbot@zytor.com>
Message-ID: <tip-b07d16f7e9e4cf2562f61b5f68a4b0831fe5ef14@git.kernel.org>
Cc:     milian.wolff@kdab.com, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: jolsa@kernel.org, milian.wolff@kdab.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20181107093705.16346-1-milian.wolff@kdab.com>
References: <20181107093705.16346-1-milian.wolff@kdab.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Add newline after uregs output
Git-Commit-ID: b07d16f7e9e4cf2562f61b5f68a4b0831fe5ef14
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b07d16f7e9e4cf2562f61b5f68a4b0831fe5ef14
Gitweb:     https://git.kernel.org/tip/b07d16f7e9e4cf2562f61b5f68a4b0831fe5ef14
Author:     Milian Wolff <milian.wolff@kdab.com>
AuthorDate: Wed, 7 Nov 2018 10:37:05 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf script: Add newline after uregs output

This change makes it much easier to easily distinguish between
consecutive samples by keeping the empty line between them, like we see
when we do not enable uregs output.

Before:

  cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
              7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...
  cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
              7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...

After:

  cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
              7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...

  cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
              7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
              ...
   ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181107093705.16346-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b5bc85bd0bbe..daf73832743e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -603,6 +603,8 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 
+	fprintf(fp, "\n");
+
 	return printed;
 }
 
