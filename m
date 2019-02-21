Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C85FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEC720880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWAObh/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfBUIoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:44:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44296 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:44:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id q128so23217844ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X1MR8AIWsbNV2CcMMAD/646Fti2Myq2Tmqq34opOOuM=;
        b=MWAObh/Dvjbx2/u9wwuhuPlBNktImMkZTbQCxhlZC5jTjXSUgb5WfQ/m882bfHese3
         NoSBymAnEybCphLht3iUOjJ8KPq5WhBziF8l1+hBtClQSpwotqvi1c6lBwKhmWcAgEuP
         aOP//T66Q2uF0c4+pRjf+ilAfKov7EeasYoPZAMiVEh+gL5kPZPnF06pZ/NeidTNKb5C
         NBcRy0Mf3j7ZM82ITklVa+KBuSIg0O1+xxF3A6bbIQLufZ+tlzJkTXg/uGC7RSUab2lU
         mIbyd3llwgQ3mAXU8f9j2RmbeX4RFTI+ONL5YdBDqaxBG86NNu44kcN+ktTTiJ2r6trP
         U+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X1MR8AIWsbNV2CcMMAD/646Fti2Myq2Tmqq34opOOuM=;
        b=tiW8g7rXe+ifmhFphimNNEVA6eb+A/VEsb4cVcyWqzGlcK0E2hDkZuY3tHlO1qXJxS
         DxkGYzA/tzP8gnwkBdNMC83JMnqsFPa/3egjgGjpQBbaOyOOIgUQURWAVKOhWyWKGOd5
         eNshRvZtLb929vW1svQ57fZiRLHmyPIJf2zvABUdz8rNzVL7nkpLty5i3xu9wRetZu9P
         wUbjyw3Ozu8BbQ/apmWmOvCka/SA88IP9jLnGGRxJLaIFyZcw6fYpSeZ+VnFdRQKorem
         a2ar+9wvFAPdIRneEPckjRsxV95AxzUSdTVEQdwt/82+Ym3JdmpQ0tKfjx2Y9+2RW+RX
         zVlQ==
X-Gm-Message-State: AHQUAuakRnytmn0z1z2ylnCL1IBHagBAQ8pwGm8Wvqi5mk3JqEOsJwOQ
        HwQ8Oz0Nvs0aexWLxeq6InKHj44NGeI=
X-Google-Smtp-Source: AHgI3IYEELJG6+pkm9q9chybNBmA1NZmBMK6lR2JLAD+iy9b1TAazSwpst5sU6Q2F/lZSAcB8oHafw==
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr14482869ljg.148.1550738669973;
        Thu, 21 Feb 2019 00:44:29 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id x62sm2826866lfd.51.2019.02.21.00.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 00:44:29 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] bpf: test_bpf: turn of preemption in function __run_once
Date:   Thu, 21 Feb 2019 09:44:25 +0100
Message-Id: <20190221084425.9574-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running test seccomp_bpf the following splat occurs:

[ RUN      ] global.secseccomp_bpf.c:2136:global.detect_seccomp_filter_flags:Expected 22 (22) == (*__errno_location ()) (14)
seccomp_bpf.c:2138:global.detect_seccomp_filter_flags:Failed to detect that an unknown
  filter flag (0x8) is unsupported! Does a new flag need to be added to this test?
[ 2155.677841] BUG: assuming atomic context at kernel/seccomp.c:271
[ 2155.689351] in_atomic(): 0, irqs_disabled(): 0, pid: 28540, name: seccomp_bpf
[ 2155.696597] INFO: lockdep is turned off.
[ 2155.700605] CPU: 5 PID: 28540 Comm: seccomp_bpf Tainted: G        W         5.0.0-rc7-next-20190220 #1
[ 2155.709972] Hardware name: HiKey Development Board (DT)
[ 2155.715232] Call trace:
[ 2155.717710]  dump_backtrace+0x0/0x160
[ 2155.721399]  show_stack+0x24/0x30
[ 2155.724742]  dump_stack+0xc8/0x114
[ 2155.728172]  __cant_sleep+0xf0/0x108
[ 2155.731777]  __seccomp_filter+0x8c/0x5c8
[ 2155.735727]  __secure_computing+0x4c/0xe8
[ 2155.739767]  syscall_trace_enter+0xf8/0x2b8
[ 2155.743982]  el0_svc_common+0xf0/0x130
[ 2155.747758]  el0_svc_handler+0x38/0x78
[ 2155.751534]  el0_svc+0x8/0xc

Rework so that preemption is disabled when we loop over function
'BPF_PROG_RUN(...)'.
Commit 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
highlighted the issue.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/test_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index f3e570722a7e..0845f635f404 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6668,12 +6668,14 @@ static int __run_one(const struct bpf_prog *fp, const void *data,
 	u64 start, finish;
 	int ret = 0, i;
 
+	preempt_disable();
 	start = ktime_get_ns();
 
 	for (i = 0; i < runs; i++)
 		ret = BPF_PROG_RUN(fp, data);
 
 	finish = ktime_get_ns();
+	preempt_enable();
 
 	*duration = finish - start;
 	do_div(*duration, runs);
-- 
2.11.0

