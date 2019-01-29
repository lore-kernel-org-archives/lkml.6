Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C05C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665CD21873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfA2EEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:04:55 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41318 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726762AbfA2EEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:04:54 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0T44siD026446
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 23:04:54 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0T44nh8022444
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 23:04:54 -0500
Received: by mail-qt1-f199.google.com with SMTP id 41so22954481qto.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=y11jTD81XjH1EElqeRfE7Xw/b3lKoyZlzae7bPOBKx0=;
        b=SgtwrPTO0zGqFmzrSbdoZcoOe193GLsoM+lfywf8OeGRBchG6cfklXX2066eMwJI0u
         xgUSNLZoBV+gCoIUCZVal3TcxYULeFG9BoHjgnrXJ+zOaj3rVrtNOUt6Lawsy1+RAs58
         JMrVcruLVQX+aufU4ySfrraaNuvpjAxEZVe8EjJDSi7+skb4VDs+p507y4+qI346Iwsl
         FFeljE0IBitfdV3z4hBEYSucZmcbOoQJdERKacj++DHO9RjgAx8sVl2VHOou7RDKJa0B
         jMRmlZiwmZnIF5CFtkDxcWH1mECPEzY4P0Fx+vSXKzGAyzZgRpif9w621qoCK2cowh4p
         k4Mw==
X-Gm-Message-State: AJcUukdrIP6nEwTHbGjfxAXk092LXVLH7l562hF5WvH4acTDcpk5pvN/
        mywl5CoD66KXu6NAdEEzOkJDB80ykWMyoUr+rOf+g+GS/eHkqXAXRB6RvHo8PTo1VZ1JybwZmnf
        B7NK0/7SIIkMOPgucul9E6OuurLJDo7FrG5c=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr23687808qth.335.1548734688925;
        Mon, 28 Jan 2019 20:04:48 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5mfMh26PD4d1LfAVfW9Fqvz39U3UQWX2nY3k3P5hhAmCnWFaoftWjaSJxZ0bIzYsMbBYOFEw==
X-Received: by 2002:ac8:90c:: with SMTP id t12mr23687802qth.335.1548734688732;
        Mon, 28 Jan 2019 20:04:48 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id f2sm66705668qkj.54.2019.01.28.20.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:04:47 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/bpf/core.c - fix bitrotted kerneldoc.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 28 Jan 2019 23:04:46 -0500
Message-ID: <30924.1548734686@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the years, the function signature has changed, the kerneldoc block hasn't.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2a81b8af3748..2728b6247091 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1216,8 +1216,9 @@ bool bpf_opcode_in_insntable(u8 code)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 /**
  *	__bpf_prog_run - run eBPF program on a given context
- *	@ctx: is the data we are operating on
+ *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
  *	@insn: is the array of eBPF instructions
+ *	@stack: is the eBPF storage stack
  *
  * Decode and execute eBPF instructions.
  */

