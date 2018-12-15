Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36AF20645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZVz4Ch/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeLOFWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37757 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeLOFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so3664640plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfcYjdauiywCzBPSnuM2mOLdoDThmA8NHEBfirFw+VE=;
        b=ZVz4Ch/aMMf2RvKx7q3I3f0FJsreoYuTEk+kaPBUg93v2sNtXgKXgzqAlBiPbycTOy
         L97u3Y7cAAlMfy5veR2ntwIGn3pbCeSy5zUVgYZkGeXSPcSlEaZyL9GxkNddETqXtKb1
         AnWe+a0253+5IXtRMsF517mXPgKdKadc2lUCO2hSK7u1oTKtjWYP7OvJTsn+YrNQKx87
         ZYQuuERCAcw3LcIqqSvql31ibokeQvJJLtbvgTqN2aZY9K4OHH45BN5pgBAHDdjTs0T4
         GD7NMroXWIkZ0YjkY9Mu+k3iABkpjW3mc8BNVBkLNtrpwLcsMABPTsyoe7/C+X8k8Tw7
         pv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfcYjdauiywCzBPSnuM2mOLdoDThmA8NHEBfirFw+VE=;
        b=Ssa2RK407+/wR6PaKWBP6FJestbWg4Z3L79S3qtYNc812FIb3KdaXsMACg9q8b4pTe
         0kiriyXTPnnd4bDd79NJsu5Ir7r0EyfH8WrrvdyEZ4QvCjVezOGHd96D1KbeIsZ3lf66
         nMxfOGmBSIo4Q0ma874eBdMmtVqZbgmzmCn3typ2FdBS0jYNIUh3kZgiybuUMS4/DdY3
         N1TOZL2JntP9aYbEFqnxBLz2v9W8W99eho6ffW5bXBf0IdWc/cNwBONGQWrsheW5QsHr
         Dz77RRYYEzVvWhGdJl21FyNpZQQrc0hCKqlFi0AAGM3jLAPnujUDtAblP4oExtrGbirB
         DyOg==
X-Gm-Message-State: AA+aEWYsApceJlUqCpN9ZMyzhjPc6aEjNHgEcB/ikL/zqMy4gnNv0yZI
        XEN3qWoN9MypdPOdJJwax2g+opvDTK0=
X-Google-Smtp-Source: AFSGD/Va8i8w7fCbg5cTBlIyg6mEb1iUwjAxGJKeWfjhMuQiX3okFOD5OCQW2PPRQBjJXmQlHaWGig==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr5397556plk.208.1544851339423;
        Fri, 14 Dec 2018 21:22:19 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:18 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 0/7] arch: riscv: add DT file support, starting with the SiFive HiFive-U
Date:   Fri, 14 Dec 2018 21:21:47 -0800
Message-Id: <20181215052154.24347-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for building flattened DT files from DT source files under
arch/riscv/boot/dts.  Follow existing kernel precedent from other SoC
architectures.

Start by adding initial support for the SiFive FU540 SoC, and the
development board that uses it, the SiFive HiFive Unleashed A00.

Applies on v4.20-rc6.

- Paul

Paul Walmsley (7):
  arch: riscv: add support for building DTB files from DT source data
  dt-bindings: riscv: sifive: add documentation for the SiFive FU540
  dt-bindings: riscv: cpus: add E51 cores to the list of documented CPUs
  dt-bindings: riscv: cpus: add U54 cores to the list of documented CPUs
  riscv: dts: add initial support for the SiFive FU540-C000 SoC
  dt-binding: riscv: sifive: add documentation for FU540-based boards
  riscv: dts: add initial board data for the SiFive HiFive Unleashed

 .../devicetree/bindings/riscv/cpus.txt        |   6 +-
 .../bindings/riscv/sifive/fu540.txt           |  24 +++
 MAINTAINERS                                   |   9 +
 arch/riscv/Kconfig                            |   2 +
 arch/riscv/Kconfig.platforms                  |   8 +
 arch/riscv/boot/dts/Makefile                  |   2 +
 arch/riscv/boot/dts/sifive/Makefile           |   4 +
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    | 182 ++++++++++++++++++
 .../dts/sifive/hifive-unleashed-a00-fu540.dts |  39 ++++
 9 files changed, 274 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive/fu540.txt
 create mode 100644 arch/riscv/Kconfig.platforms
 create mode 100644 arch/riscv/boot/dts/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/fu540-c000.dtsi
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts

-- 
2.20.0

