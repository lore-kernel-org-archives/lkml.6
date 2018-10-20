Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DCC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E5F214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hLHJWG8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E5F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJTWBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:01:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeJTWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:01:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 193-v6so6117731wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlbabcyQd1j/wICcOq6oJhFka402EV/LPkkjkVKQIUg=;
        b=hLHJWG8ATbbUnsr+VLWBYj85dk2wCVNErURhl2WpGrKPNcu84h0I+Po/hAOxAzRcXh
         q8uK6Aut6yUPuEKh2KOShDrhH+LPaBo0H+ae4E6humcFaeCJ5wzJ5UDorW/XnqHY8KUZ
         L2FNg2QPFtTiaMEDExRD8mgCsjvpbrumEPj8B1dxR8yL/+1/+fCZj2xd/KPRX18Tgcvg
         YAFpoMucVxUsgXYoSznTVvENRNTRVL1uQrXM79ADktBh6I0dQLbOCuK15snY9fPkhLvG
         phxh5Ss2X2WnDA2HRGpucmCd3Njp36ICbzZBaitx6qGs7Ov3Gi2rpkR1HgB/8POQAhEu
         sb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlbabcyQd1j/wICcOq6oJhFka402EV/LPkkjkVKQIUg=;
        b=GLKG55TpuAJn4GbWhQatn9zQlfOxmW/jW9lyG6dr4E0QfmlVqaS6EKzljD0g3ufCvC
         EAx7F5HmJDDS4hzNGNP8TmT2cGLJOFT5wuxBhK/tovi1Z3SzYnVkGzCPi8W/1L1WbcrI
         FkLu8v4KCKdHNAjMxWLVZ1mRpzY5Kg5xw09LJovzej+Xf7CwFRRm0cyYKAyZXrMv+hQT
         pW9uLLeqkuxMK8PmcmoQlQ6tINIBk0hZxOAqb0FiwkwijsYZcZIgWf5CLKBQH4yQktRi
         1cvU6o7DbXBexksRW0AyFz634zJ38cnzzgBIlcdq6dDxN8hHZyPgX9teQALZ/25orYX2
         IsuA==
X-Gm-Message-State: ABuFfogePUqCz57mgYRBNrH0zw1nDdFKv31Nx8KJbs0WbEzd0mkaV1yf
        KZHUCYyXpWQXwhHZJouqT+eCSg==
X-Google-Smtp-Source: ACcGV63StSgMHPhXytIVulh7lSgv9KF4DTrx0iLRWBJmnl1yLvDiNn6Fyc7tov+0pZqHpU2MvLKHuA==
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr8968379wmf.19.1540043433471;
        Sat, 20 Oct 2018 06:50:33 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id o4-v6sm16906615wrj.45.2018.10.20.06.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:50:32 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] clk: add driver for the SiFive FU540 PRCI and PLLs it controls
Date:   Sat, 20 Oct 2018 06:50:21 -0700
Message-Id: <20181020135024.28573-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the SiFive FU540 PRCI IP block, which handles clock and
some device reset control for the SiFive FU540 chip.  Also add a driver-
independent library for the Analog Bits Wide-Range PLL (WRPLL), used by
the PRCI driver to monitor and control the WRPLL instances on the FU540
chip.

It's been a long time since I've worked on Linux clock code, so Mike &
Stephen, I'd appreciate a close look at the PRCI driver to make sure
what it's doing makes sense.

Boot-tested on a SiFive HiFive Unleashed board.  COREPLL rate changes
and notification were also tested on the same board.

This second version corrects the DT binding documentation patch; an
out-of-date version of that patch was sent with the first version.

This patch series is also available at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/prci-v4.19-rc7


Paul Walmsley (3):
  clk: analogbits: add Wide-Range PLL library
  dt-bindings: clk: add documentation for the SiFive PRCI driver
  clk: sifive: add a driver for the SiFive FU540 PRCI IP block

 .../bindings/clock/sifive/fu540-prci.txt      |  43 ++
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   2 +
 drivers/clk/Makefile                          |   2 +
 drivers/clk/analogbits/Kconfig                |   3 +
 drivers/clk/analogbits/Makefile               |   2 +
 drivers/clk/analogbits/wrpll-cln28hpc.c       | 387 +++++++++++
 drivers/clk/sifive/Kconfig                    |  18 +
 drivers/clk/sifive/Makefile                   |   1 +
 drivers/clk/sifive/fu540-prci.c               | 634 ++++++++++++++++++
 include/linux/clk/analogbits-wrpll-cln28hpc.h |  99 +++
 include/linux/clk/sifive-fu540-prci.h         |  27 +
 12 files changed, 1224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
 create mode 100644 drivers/clk/analogbits/Kconfig
 create mode 100644 drivers/clk/analogbits/Makefile
 create mode 100644 drivers/clk/analogbits/wrpll-cln28hpc.c
 create mode 100644 drivers/clk/sifive/Kconfig
 create mode 100644 drivers/clk/sifive/Makefile
 create mode 100644 drivers/clk/sifive/fu540-prci.c
 create mode 100644 include/linux/clk/analogbits-wrpll-cln28hpc.h
 create mode 100644 include/linux/clk/sifive-fu540-prci.h

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Wesley W. Terpstra <wesley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Megan Wachs <megan@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org

-- 
2.19.1

