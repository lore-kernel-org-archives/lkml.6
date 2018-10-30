Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8397DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A2320848
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHBDvlke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A2320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJ3SyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:54:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34152 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJ3SyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:54:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so11860208wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PcIdga3zkqCuJMMCGKfLMgVBdR4DqN1Jn/lpPqPfX2c=;
        b=FHBDvlkeG5tM+SUh4g4qptsGHgK8OsP4k0df5y4l52hk6Y1Gg5f1HwaaoJzAYFdJEQ
         xzp+HIxUJsj3kmLc7mgb4pTpHaudgGKZbZjVTVDHJ9AZozp3s5Lgoy7XHVuCdW2Pze2n
         bBRC1N3r/AN84ziKil25hZFaMFzqgi5WdsXZ9uWjipuvN0JX+729y2nAhjY3JXYUP9RR
         MIaQTP7Y2FYfQzmuUuIXfwJXf+HLXqY/E6Y+QhE35kzQzcYdbTAob9yHzZ5y6XuBhtTN
         YjghldpzV88xnx+3UYs5AzS5piClWMpLVIr5nKcgSGX2343P0tuE5i29AccGhSf7/046
         zhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PcIdga3zkqCuJMMCGKfLMgVBdR4DqN1Jn/lpPqPfX2c=;
        b=ccFz8zZuzjSS9zXi/SWq16q6Rr03+ZupGzgFVtzy4vpl5bQHrpUZ0vLJmOU3pJ3ImT
         zEZKuH3cjDiSsdPeqlVQy8eW7hoPcExZ8qkGGLhuJy0tngFX2sK0N08Gm0tG2KF1hu03
         9lg11ZyLbZdF+AR1a4BpY+WYSD5QmB/HHd/4Zat4Ys7kl99sr9aXMRvYJlksq9kSyWd6
         idfmQWCM8dkzPn8cYHzTY5vv0tFok5zDvQD20DYfPBAx0K1cxSE+foH3DAzTWNOSvBSY
         ZESQ+IrOQwGYMpcQ+aApZ+UyqT3kbKmwFqHnwlLwcHp5ZZxOSl6X3gXsW40mhoMo6yhC
         Ls0A==
X-Gm-Message-State: AGRZ1gIMTIhwNu69MvHBITOxhkwbviy9kmtToEHXuBmeTagDXBJERq+Z
        ROtaqFHYoUO0nl+EzvViKzQ=
X-Google-Smtp-Source: AJdET5fSnJcvBXTDWEZzfcCwiO4xU4tI/3q70xIOCwRMF3mHO9fpl4eUh96mK+1CuwHUM5V/q8wRbQ==
X-Received: by 2002:adf:e388:: with SMTP id e8-v6mr697516wrm.321.1540893674667;
        Tue, 30 Oct 2018 03:01:14 -0700 (PDT)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id f1-v6sm18420825wme.23.2018.10.30.03.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:01:14 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 0/2] riscv: add ARCH_HAS_SG_CHAIN to Kconfig
Date:   Tue, 30 Oct 2018 11:01:05 +0100
Message-Id: <20181030100107.4590-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should improve virtio-gpu support for riscv.

David Abdurachmanov (2):
  riscv: add ARCH_HAS_SG_CHAIN
  doc: re-run features-refresh.sh

 Documentation/features/io/sg-chain/arch-support.txt           | 4 ++--
 .../features/locking/queued-spinlocks/arch-support.txt        | 2 +-
 Documentation/features/perf/kprobes-event/arch-support.txt    | 2 +-
 Documentation/features/vm/pte_special/arch-support.txt        | 2 +-
 arch/riscv/Kconfig                                            | 1 +
 5 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.2

