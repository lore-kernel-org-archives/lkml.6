Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47C82080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550798842;
	bh=z2IAi+1Bu0T+zEWndJMftHNI5RUtoIFALL7GqnhmCrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tg0JLckg2H3lf8bTFDKCprmIHuoXb+oMhoDynGNa4X1/c3CN61nI5A+Wz0HKAzivY
	 5VXZ6b9OxWQpoZqXM8Hwc9cmzdgrDQuq3fzP5EEsk/rKVogOgpb88fMFb38BvvYytf
	 gKkSpPqJ1Q48REQzgC9Tq9HEPLtjWdobyKWH+dxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBVB1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfBVB1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:27:20 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3BFF207E0;
        Fri, 22 Feb 2019 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550798840;
        bh=z2IAi+1Bu0T+zEWndJMftHNI5RUtoIFALL7GqnhmCrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znTd3W44YfTVeYI5I6Qu4qx85RqvXCuvDDOcFoEIfscG7Lx3O1JO2tPLnzfTaTZuB
         8K+Z86QutL2fb8YKRD3L1h28xQhn0PCPZ5cxrMwNko4I8guA3eyYaylT+BPMaAulIy
         4nzfiomo3lsmtbI/l5Bs9taFTBLnnhC9mqEZc0ss=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH selftests 1/2] selftests/ftrace: Make a script checkbashisms clean
Date:   Fri, 22 Feb 2019 10:26:57 +0900
Message-Id: <155079881689.5157.10494170079333363559.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155079878723.5157.12433171255092403676.stgit@devbox>
References: <155079878723.5157.12433171255092403676.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make kprobe_ftrace.tc checkbashisms clean. Since
"grep function available_tracers" causes an error
on checkbashisms, fix it by explicitly escaping
with double-quotations.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_ftrace.tc          |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index 492426e95e09..7650a82db3f5 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -3,7 +3,7 @@
 # description: Kprobe dynamic event with function tracer
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
-grep function available_tracers || exit_unsupported # this is configurable
+grep "function" available_tracers || exit_unsupported # this is configurable
 
 # prepare
 echo nop > current_tracer

