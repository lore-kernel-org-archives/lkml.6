Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF28C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438BC20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0ZeVMqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438BC20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeKLOBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:01:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40723 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:01:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so3644527pll.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U/YrlSOjfoby7Mh3Eo+o6RvHJVuLKIojmafn2+XFADM=;
        b=N0ZeVMqh/GxvW7RY+OFORG+5CcvBR0f3CoXyYFUVt3Mmk7sKyncT43NfN5IkE/esyQ
         uVOuGToZNwKI7GCbCgAePZuhrY5geZSFT+963W5Ssmy6ULSDYkYisTsA+mtMCHv2LDeQ
         L8l2jvgvvUZW04X4jMQXJmnGQwJw3qROQfL5kbhCXS40f7Wr+4rqTtYgNNXjqRHv2xMu
         RlnEUriSUAdFYLePAUJFRijeXrzdvm9PEOk98995f07dn8clela/LWKnR/9uh3FKycBr
         ofTOGXJFk2ux41OeqOGJBOOd+WRt85bm5oH40ggj5+9S3aDGnwqc9/NqrspurRn6qFJi
         MS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U/YrlSOjfoby7Mh3Eo+o6RvHJVuLKIojmafn2+XFADM=;
        b=UMQVrcSsbwbA7wIyQuqCXmwOwTaf1dqBtnIUUwuUMyp2bqGjavkq5I++7AN2/iIy5c
         I/60JmtHiOdMaRlPIr0KNYpCVzBZvZXPSy6l1wPuBZSKEaA2dG8VnY2TSXkKONv1tESE
         9iXCERT740x1uv9xaBiGapd1dBejFkN3qY2gAYSIOVIoSjxj3IlTPEDKj05aKc8fxXZY
         xUDOboSssmtnCSFgFPdo7ELuZ3U2OmJWvA6JXzmi7eGzx21ixluCTNxeW6JiBuDxdWNd
         1BN0v64FBy8Z5jjp8xcPFmED0YOhDZaWOWNDOFm/kUmEb0PIlapk1PzgX84bsBG/qY4f
         4qeQ==
X-Gm-Message-State: AGRZ1gJ2MCZYuxM+Ac5dkc2t3hnk/0ZMCI36U+iezfQB+yCBixSn6vi6
        hRB6T7bwmGYVbPufsJvqei4=
X-Google-Smtp-Source: AJdET5f9ZwFywKSWEbvLmCmGDyrrXyl6ezjc1ckvoaBe6bnFVWikKKkDR0gWzII6h2QcZnov4xTmug==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr18000173plb.168.1541995794071;
        Sun, 11 Nov 2018 20:09:54 -0800 (PST)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id i189-v6sm27536599pfc.16.2018.11.11.20.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 20:09:53 -0800 (PST)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong@andestech.com
Cc:     Zong Li <zongbox@gmail.com>
Subject: [PATCH 0/2] Fix some issue on RV32
Date:   Mon, 12 Nov 2018 12:07:42 +0800
Message-Id: <cover.1541995312.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fix the build fail and kernel module install failed on RV32.

Zong Li (2):
  RISC-V: Request stat64 on RV32
  RISC-V: Support MODULE_SECTIONS mechanism on RV32

 arch/riscv/Kconfig                  |  2 +-
 arch/riscv/include/asm/module.h     | 28 +++++++++++++++-------------
 arch/riscv/include/asm/unistd.h     |  1 +
 arch/riscv/kernel/module-sections.c | 30 ++++++++++++++++--------------
 4 files changed, 33 insertions(+), 28 deletions(-)

-- 
2.7.4

