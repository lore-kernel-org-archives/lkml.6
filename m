Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57612152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2R7NdvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57612152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeHXCbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:31:53 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:44496 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeHXCbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:31:52 -0400
Received: by mail-qt0-f201.google.com with SMTP id o18-v6so6119847qtm.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K8tJIsZDnwwISK2il+zDImo2torBdzAG5Pn1ud4CRAo=;
        b=f2R7NdvSXWugl/6TUcMP87qqCdGsRpOsCSW/sCRYTco818hjqpn8AFp9hOJ2w3DN9u
         GJ+zZyNjwvtU0OvBS7j/hKnnQGZ7V/Rp22vHVbRh3jp7xMzSZg6rPQjY4wvjubWUnbLN
         E8uMGOY6LV6FBfAB5Xaas8UQVmghqPd8DIevgB/w36vLnhCbcbmw3If8HinDSxE0t8eo
         0UEZL7wq136JGTPVTRIxl85Yq8KQ074iIeXULSnwUL0IX49oaC2/dzg1H/ilr7UgQrgh
         cx2+FkSy4uJt0LKmnmCZSXm1eMZ0QWR2OH5sH5XiGKE0a3ZFn3ZdE6QbUWy9opN3iv9f
         V8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K8tJIsZDnwwISK2il+zDImo2torBdzAG5Pn1ud4CRAo=;
        b=NedUbc7kUW8afN3Qn2/GBTj/HVc0xTw7Z060u9TfN4dgCLnkWT3taM5AWk8qemf3Lz
         jXg8eDPeFQUqoGpUn0R/2oBiBGSBoAE37U8ZlanpU8y5/PEML/kXwEbHyIw5oR3sRD7j
         1+Apsl31Gx1/TUgHrLdU0CHoBHiLl62ICHW6a8BUC0hl79KqOUpiUZhlv12z1KvsVAb9
         Qa1zvwqKG77/SiuIp/nt/d2BzYbQLr3k9hFSAKLL6GMufn4b7kU815Rqn2t7Dp0DGcG+
         VwM35qO8guB3XPhtcCdW7YJoutLgjyc/F0jussH1UfGY4JF/DGuheOrHVfK0pWomSdli
         ExmQ==
X-Gm-Message-State: AOUpUlHPnO7wv4xZgpvSyzdLQnthxCRotNb6qi2RE8l8pH141yW+1FsU
        5eP2Spx21D1Tmnsfb7IaXk/02ck4Ow==
X-Google-Smtp-Source: AA+uWPwxGio5KXS17DI+9tTcuXzGLgFEqn/mGGCLvglL3DZqu48sa8AM/gLlLfutlEQzi1K8ruByaYm167A=
X-Received: by 2002:ac8:29fd:: with SMTP id 58-v6mr33566240qtt.6.1535065200797;
 Thu, 23 Aug 2018 16:00:00 -0700 (PDT)
Date:   Thu, 23 Aug 2018 15:59:35 -0700
Message-Id: <20180823225935.27035-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH] perf: Force USER_DS when recording user stack data.
From:   Yabin Cui <yabinc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf can record user stack data in response to a synchronous request, such
as a tracepoint firing. If this happens under set_fs(KERNEL_DS), then we
end up reading user stack data using __copy_from_user_inatomic() under
set_fs(KERNEL_DS). I think this conflicts with the intention of using
set_fs(KERNEL_DS). And it is explicitly forbidden by hardware on ARM64
when both CONFIG_ARM64_UAO and CONFIG_ARM64_PAN are used.

So fix this by forcing USER_DS when recording user stack data.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2a62b96600ad..9bc047421e75 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5948,6 +5948,7 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 		unsigned long sp;
 		unsigned int rem;
 		u64 dyn_size;
+		mm_segment_t fs;
 
 		/*
 		 * We dump:
@@ -5965,7 +5966,10 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 
 		/* Data. */
 		sp = perf_user_stack_pointer(regs);
+		fs = get_fs();
+		set_fs(USER_DS);
 		rem = __output_copy_user(handle, (void *) sp, dump_size);
+		set_fs(fs);
 		dyn_size = dump_size - rem;
 
 		perf_output_skip(handle, rem);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

