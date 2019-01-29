Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CB6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC892175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfA2GEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:04:36 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:38708 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfA2GEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:04:35 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0T64XDA010367
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:04:33 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0T64Sxu006770
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:04:33 -0500
Received: by mail-qt1-f198.google.com with SMTP id w1so23189893qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 22:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=eWqEjg+/dtMP3m7ampBvtebCghcQMsCSILJgvWGnqGg=;
        b=ZfGCUBGMaeT/C7TfTraAJnsMZYZ0BkcaryAqmBz3U/pfMPVTPKzfj/PeTO4sSTUKiz
         NcdZ1NpsGmFWO4n0BJ5hww94Mjq7xYJ+mIQtbkBTVMQl51Hvw7DzjAadzSj6EdzYBE4s
         0hIeqIc9pU4L39W7xuull4X+n1nb9BsebIapBJSYk8ciFNbDU3VYkv76JmgpVw2ZPq/R
         +N/3M9dJI5GpSGXhhQtAqyMVcJSybBicqkO2KHKBweaaF+qDj+Pah1Q8mckzIsjwSAZt
         nCRduXiuoGtQ2mLEApgg4Ru51gkp7O+JawnvhT49BSjIhQf3a1GyhECv7IpfKy8t6Bsu
         7yBA==
X-Gm-Message-State: AJcUuke9hhkrjv0SLGyuykKNvTBi+tV1Lgk+wbC+jHmLD5qXPdk/J5xm
        67MgPa6hNdXjZbvk0SOLpwLfj9Rm+MmebotwZ0yxiEEu560N9oUkSa0E/aM0q3YgvskB9a4u+D1
        QctEq7a1PabLFRYQNTP3jMbkGM1tqoA2Eggk=
X-Received: by 2002:a0c:a326:: with SMTP id u35mr23396572qvu.190.1548741868529;
        Mon, 28 Jan 2019 22:04:28 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4KLF3udXg9SNwGaut3yHmve51TykjAqJOWyvz520PV7XkkE7DxbEBOXj+FUhfkDlGVGl+rQg==
X-Received: by 2002:a0c:a326:: with SMTP id u35mr23396557qvu.190.1548741868264;
        Mon, 28 Jan 2019 22:04:28 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id n11sm43546610qke.82.2019.01.28.22.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 22:04:26 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/bpf.h - fix missing prototype warnings...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 29 Jan 2019 01:04:25 -0500
Message-ID: <6349.1548741865@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with W=1 generates warnings:

  CC      kernel/bpf/core.o
kernel/bpf/core.c:721:12: warning: no previous prototype for ?bpf_jit_alloc_exec_limit? [-Wmissing-prototypes]
  721 | u64 __weak bpf_jit_alloc_exec_limit(void)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
kernel/bpf/core.c:757:14: warning: no previous prototype for ?bpf_jit_alloc_exec? [-Wmissing-prototypes]
  757 | void *__weak bpf_jit_alloc_exec(unsigned long size)
      |              ^~~~~~~~~~~~~~~~~~
kernel/bpf/core.c:762:13: warning: no previous prototype for ?bpf_jit_free_exec? [-Wmissing-prototypes]
  762 | void __weak bpf_jit_free_exec(void *addr)
      |             ^~~~~~~~~~~~~~~~~

All three are weak functions that archs can override, although none do so
currently.  Provide prototypes for when a new arch provides its own.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3851529062ec..99e55313123f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -472,6 +472,10 @@ _out:							\
 #define BPF_PROG_RUN_ARRAY_CHECK(array, ctx, func)	\
 	__BPF_PROG_RUN_ARRAY(array, ctx, func, true)
 
+u64 __weak bpf_jit_alloc_exec_limit(void);
+void *__weak bpf_jit_alloc_exec(unsigned long size);
+void __weak bpf_jit_free_exec(void *addr);
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 

