Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E8C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D152152C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ggF7jUHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D152152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJTVtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 17:49:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42310 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeJTVtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 17:49:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8-v6so689950wro.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RK1db71p1doYFuCGfEE1NLdP4LEETqtV01w8eRQfie0=;
        b=ggF7jUHbQPMBuzgjjE1ZSJ9H0neYUI42BFHKGWNXK7GgHTtct8R+T39RVP0cx41h3M
         L360cSFJLESd44XCP+s89e523uYEmm77QVO8RhAis+eMLTT11YlI3CBmLBkJyyWhOyl9
         jwF6OzRb9puvAQfqBA3ji19Pb5jBj5kmQs5urLofh92esCujfvmu9tlgbhZmP+DDVyxw
         2sB34Jx8KzJz5KsS9V7py3MmgFZMgCHcvyyPbLNfm8RGL2qqUgWXQOWDjqMByVmidS0K
         QcBx3k2OICAk3BGTb9Oh7woQxI7Hj5jya4WBxdlCK+fFkZt16DC24RfXHONj+KHg21N7
         i6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RK1db71p1doYFuCGfEE1NLdP4LEETqtV01w8eRQfie0=;
        b=cJAQEsaFDBznVzFMGbGbJZg6R9NmzB9W/2nei+5j5dhfEApvLiTRSG69kdi+WT7s1h
         1jg3koWXpzYaCQcrQ2iDaNV18AMwNPp7o8fIJppB9cGYAlN4ZZyqkBUfRqmr8qalHl7S
         deDr07ZDCIMVbw7KjqYapBQW27e2TRn49m+RYOcyu3+GF4JR5T+OokVeZMBjvY4kRKj2
         VPO6Sq6Y+gHO1NPKwsnWO1I8mXZIXGUhyDGRyO7NQjqejKrOJ0qTN1cXmgfICMEsTrr+
         mWSscT5QAjG1w9ZhXFF6Z7ge2rJzmGzDebKsoKDqXEFgaz58OUt3WmLw9Knn0+gEgviW
         YILQ==
X-Gm-Message-State: AGRZ1gJ2uKJMmRYDNCHF632R/mWgNKsYe5HWDa2ZITcacJFr3k1MlJ3W
        izn7sDoU9/vCWmKv2mEGghSWJA==
X-Google-Smtp-Source: AJdET5fai4n4Ip1a0hHB33795iEBz3hBXBP3ecQ6x/4i9IveVrF6RZUuoWlbXtxm2O0tkc3e8pKlyw==
X-Received: by 2002:adf:dd8d:: with SMTP id x13-v6mr8459254wrl.237.1540042717701;
        Sat, 20 Oct 2018 06:38:37 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id f1-v6sm5227207wme.23.2018.10.20.06.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:38:36 -0700 (PDT)
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
Subject: [PATCH 0/3] clk: add driver for the SiFive FU540 PRCI and PLLs it controls
Date:   Sat, 20 Oct 2018 06:38:21 -0700
Message-Id: <20181020133823.27103-1-paul.walmsley@sifive.com>
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

This patch series is also available at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/prci-v4.19-rc7


Paul Walmsley (3):
  clk: analogbits: add Wide-Range PLL library
  dt-bindings: clk: add documentation for the SiFive PRCI driver
  clk: sifive: add a driver for the SiFive FU540 PRCI IP block

 .../bindings/clock/sifive/fu540-prci.txt      |  40 ++
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
 12 files changed, 1221 insertions(+)
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

