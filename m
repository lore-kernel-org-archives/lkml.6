Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52DCC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263B259CB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTE2b+fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6263B259CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965125AbeGBJRK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:17:10 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35687 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965047AbeGBJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:17:05 -0400
Received: by mail-pg0-f50.google.com with SMTP id i7-v6so6869587pgp.2;
        Mon, 02 Jul 2018 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5gkltOvCryuEJis55BtM7nveKnuSo6mMDkVZbDBZUw=;
        b=gTE2b+fwRDemHxs990euZn7eV2GHxlOshzZeu1bI5Mf8+CQrgLs0qAKnz2nluU/fvK
         3HEYgTpxhTCwdBY1CqYoxrw1SVKiWWxe7Dezx8jJyZ7rpVPrnKaMGD6tc7JzNZivwkdI
         haOkxanlNgwT7nWmTM+H8vgQSndJRy0n41uLFQ1mhwku/G7EKrLULeLYQ0oAajQjHbOH
         +nIjhMqjt7ebefJZjgE+nVYunUm5L5Pr0m5tcXrNTyqK4LjmPAzs1Jm5H2PtCCc0LPqM
         K4P0KcDKX+QEDFQ5OTNbU6G/Q6m5XTyxSIuGS8qDB4AzGkjIJ9yxGH3OBdgZyOdIEco5
         /mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5gkltOvCryuEJis55BtM7nveKnuSo6mMDkVZbDBZUw=;
        b=Dtg4aQyBqjmnmgpays+oYTJQhMfro3xi/t/fwhd0OAXzOefF6RA+boq/99c01Tgije
         S26kYX5i46EVyS0Zh/P7KoHdZ9r7z8a7Ol8ST+aBFZfMHx7sJYE8IaaOZx+fQrX+82pn
         AjSP1IHQUBceOYfly/tcTDqI6Bpm9voWp7ECIt582cgDt+qb5dh1dwahQfwR6yQiCPdd
         kZtUV6aWQnFvG0D/f7av+Jr/e5yay4cFBhs3eOhPoxQAMblEpVTiDWwjNja6oG8udaol
         /eUxucp5AISy2463oBKudmrAZXc0KpOk/DUdrZv6Qiy49TEI4ZLOrGthJy6oCuJEqR7d
         +bdQ==
X-Gm-Message-State: APt69E3tvc5SPjZs+bHPZIKI4OoliU5O65KPg7AewGwXsWUlEcBiIYxA
        QQCOg8yjX/6ACiy7Dy5FajE=
X-Google-Smtp-Source: ADUXVKKKrtc8nryJrQkrUV4JL1+XeWdCUz25oP+5aOTTxBUn0M+wlnQJ9wka/KyV65RuL15C/rNNQA==
X-Received: by 2002:a65:64d3:: with SMTP id t19-v6mr21019700pgv.148.1530523024524;
        Mon, 02 Jul 2018 02:17:04 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 67-v6sm24527627pga.9.2018.07.02.02.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 02:17:04 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Teng Qin <qinteng@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 4/4] samples/bpf: add .gitignore file
Date:   Mon,  2 Jul 2018 18:14:53 +0900
Message-Id: <1530522893-8961-5-git-send-email-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
References: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For untracked executables of samples/bpf, add this.

  Untracked files:
    (use "git add <file>..." to include in what will be committed)

  	samples/bpf/cpustat
  	samples/bpf/fds_example
  	samples/bpf/lathist
  	samples/bpf/load_sock_ops
	...

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/.gitignore | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 samples/bpf/.gitignore

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
new file mode 100644
index 0000000..8ae4940
--- /dev/null
+++ b/samples/bpf/.gitignore
@@ -0,0 +1,49 @@
+cpustat
+fds_example
+lathist
+load_sock_ops
+lwt_len_hist
+map_perf_test
+offwaketime
+per_socket_stats_example
+sampleip
+sock_example
+sockex1
+sockex2
+sockex3
+spintest
+syscall_nrs.h
+syscall_tp
+task_fd_query
+tc_l2_redirect
+test_cgrp2_array_pin
+test_cgrp2_attach
+test_cgrp2_attach2
+test_cgrp2_sock
+test_cgrp2_sock2
+test_current_task_under_cgroup
+test_lru_dist
+test_map_in_map
+test_overhead
+test_probe_write_user
+trace_event
+trace_output
+tracex1
+tracex2
+tracex3
+tracex4
+tracex5
+tracex6
+tracex7
+xdp1
+xdp2
+xdp_adjust_tail
+xdp_fwd
+xdp_monitor
+xdp_redirect
+xdp_redirect_cpu
+xdp_redirect_map
+xdp_router_ipv4
+xdp_rxq_info
+xdp_tx_iptunnel
+xdpsock
-- 
2.7.4

