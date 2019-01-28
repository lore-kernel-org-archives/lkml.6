Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB33820989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfA1Elj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 23:41:39 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:38992 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbfA1Elj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 23:41:39 -0500
Received: from mr1.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0S4AmI3031775
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:10:48 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0S4AhLC017326
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:10:48 -0500
Received: by mail-qk1-f199.google.com with SMTP id k203so17131673qke.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 20:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=MIgX3bW8bMehQLcxyRePAGOb6AOeg7AcYjxnuIEF0bs=;
        b=ntyqGNVHquYDORTvgSWdIIZ6tdRcwhcLeKoniX60gaDe6PUwmTDb91/vNsrO0dWqKz
         4531jXgif/Sczuoc7+8hDXkMWN+k3/Ed+lyFVhz9NYuM+MaPPPveBzVVqR+LT8Mvm8hY
         9i1ZHDBVi60yuS/pONnQ5KLpJOmswqRV87eXk5KMEZpi1yom3bb5AWMBrsJjo/f0yVHI
         O02Sqd8jWgiXkdxGfjlPOwnNIlDMkPVOAgrCJUGh5G23nUStQ4zbUoUBdAvKXjnbRpaM
         muDQAFOnjxb9rf2KfvGlAolFATdRK50TuX8JqMv0dDTseOuXyecVdTuFOevGqbzVw19o
         c7Hg==
X-Gm-Message-State: AJcUukdDFD5vFb3elnGahe7NHjZZO+mlWtt5854J9ahQY/QUbU+K3qG7
        xJg3Bs0QGIwsW4WWHBiL63jvqAW1F5vdmaCtHqkiDjUGREf0/i2t0KuyEVhv4/iV/L24bX5EHcc
        nvVZABYdHqYX4/oeycVHpw1P0bZeen9+fW10=
X-Received: by 2002:ac8:198f:: with SMTP id u15mr20351616qtj.62.1548648643178;
        Sun, 27 Jan 2019 20:10:43 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6IT/1DfX3BoLO9/1mnw4bBsGvIc70z4pfkA7qG/Tc9+Al3se+J32pjyPEk638bklmMjCWcKw==
X-Received: by 2002:ac8:198f:: with SMTP id u15mr20351609qtj.62.1548648643018;
        Sun, 27 Jan 2019 20:10:43 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id c17sm108683156qtb.14.2019.01.27.20.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 20:10:41 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf/core.c - silence warning messages
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 27 Jan 2019 23:11:15 -0500
Message-ID: <31468.1548648675@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling kernel/bpf/core.c with W=1 causes a flood of warnings:

kernel/bpf/core.c:1198:65: warning: initialized field overwritten [-Woverride-init]
 1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
      |                                                                 ^~~~
kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
 1087 |  INSN_3(ALU, ADD,  X),   \
      |  ^~~~~~
kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
 1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
      |   ^~~~~~~~~~~~
kernel/bpf/core.c:1198:65: note: (near initialization for 'public_insntable[12]')
 1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
      |                                                                 ^~~~
kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
 1087 |  INSN_3(ALU, ADD,  X),   \
      |  ^~~~~~
kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
 1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
      |   ^~~~~~~~~~~~

98 copies of the above.

The attached patch silences the warnings, because we *know* we're overwriting
the default initializer. That leaves bpf/core.c with only 6 other warnings,
which become more visible in comparison.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4c2fa3ac56f6..2606665f2cb5 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_CGROUP_BPF) += cgroup.o
 ifeq ($(CONFIG_INET),y)
 obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
+CFLAGS_core.o          += $(call cc-disable-warning, override-init)

