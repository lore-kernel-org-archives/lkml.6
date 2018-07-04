Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B50DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C6420899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWoUTFGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C6420899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeGDNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:37:24 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:37495 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeGDNhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:21 -0400
Received: by mail-pl0-f43.google.com with SMTP id 31-v6so2658478plc.4;
        Wed, 04 Jul 2018 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NIXirEbeuV++v8JcEbpuFjArWdJGbIosORPadXSgT5A=;
        b=gWoUTFGrnf9KiEq2Mj8vy0T26AGXxB4hust7DEAOZElO+EboyZ3jQ5tYxPvcbBp33p
         yDvXe24h6VzBg7OrrpaznUMgEVexmjgFjjkC66/Wi5vkisn1QEsMeV7tE0SfO0pfcw3W
         XN89OORE4TQ2iEDx/uYccZlNuJacQHpwbZpJ5pgFn3doekro3mApu/l4v5je2G//i92H
         YMrkkGloh3m/HX5rpxdHNRZZ47oVKkCvgO49z8NK+tAgupcA52/RdT9rh7oV8cfZOdcv
         /yYv84rwkOX9juFufxxsdmLf222LEf6NKTZqRbJymKOd6pz4VuUeEOAV0Un8PIyAp6JZ
         9+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NIXirEbeuV++v8JcEbpuFjArWdJGbIosORPadXSgT5A=;
        b=lWw/sQ+1B7ngMFxvvY/EglgFXvLPwwszzWoJzDkM5Iy2yi/Sl3UvzXBhEmxJL+PATv
         5lNtt4I7djMVQCGM/p2/xu2ZnPZDPrOiT8aQnI3qfWj0pXqVsNkg9k5xjN2sijYIskAn
         NUJturA62xUuApAZW/yuq0U0STMEMhwl6hH9f3zPos0EjAlbSlSpfPaxMu3CtTummFJP
         NUhLnbE2fSr6CEAKIlSYn3x6e0FJeKDtOWC/Lahyc6M8m7w8KjiL0NQ1mnejrzmH8E9U
         D0B33XAWe0PSQx83F99VBAnjw5NFBpyjavKfrLYwqj/IAu2s+CLkPNUDkZyRVraDfbD3
         XzCg==
X-Gm-Message-State: APt69E0gk+trMGC5OZuichDOtIYterZtCxpnGqS/xwzE9iY2T30/7UOF
        UPJ6ctzZDQIvR0bttnANrYI=
X-Google-Smtp-Source: AAOMgpdwrivdC5ExIhCKOTFP1I/dnX2oKYWqhlP4vhXDdd40wPuLzdc1mwal05FRcU3xcRbb7EhdbQ==
X-Received: by 2002:a17:902:ba97:: with SMTP id k23-v6mr2163063pls.259.1530711441051;
        Wed, 04 Jul 2018 06:37:21 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3593913pgd.87.2018.07.04.06.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:37:20 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 4/4] samples/bpf: add .gitignore file
Date:   Wed,  4 Jul 2018 22:36:39 +0900
Message-Id: <20180704133639.11855-5-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704133639.11855-1-treeze.taeung@gmail.com>
References: <20180704133639.11855-1-treeze.taeung@gmail.com>
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
 samples/bpf/.gitignore | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 samples/bpf/.gitignore

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
new file mode 100644
index 000000000000..8ae4940025f8
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
2.17.1

