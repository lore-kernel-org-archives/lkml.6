Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2497C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E8C2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="bzkGSdoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E8C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeLDOKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:10:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34345 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:10:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so8286213pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=OgI1Biz216dTM0OsrwyzMGJvKRXra4cITiLXHfMziwU=;
        b=bzkGSdoHurfqVV+cCDhQg/vyockM4Lxh2yBA8Rqhpm5PNqHggJwGmJB5uasnUHOsi+
         e/5NO+FBaKF/a9WjmI2wNqB+fBeclgQ5U8cmT1wqfsj2L/OvseftewzLw6xQaUHoTGWu
         mQ/1SBJtm/nGr766Ar0USHwioVdaR0tD6Kwb9T6OhesCXiiKaBs4CWX8M88Ru/eRQP5w
         rgltm6aOdBD+Kw/wGZLCleeCqZcxSna37TR10lx3MQlEAqzNTYVeq2YTlIr69IH8r6T1
         yzUCxnf1tHzLVAeDbBcS20I0y3KQwQV5F4q/xAkUiGoVGYtDvUqZYwN+viwC/2ctgRcN
         QwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OgI1Biz216dTM0OsrwyzMGJvKRXra4cITiLXHfMziwU=;
        b=gKqSaTdi+YijJ0Of4ozAaQ2XL8fltRV1d2z/AizTiHIHphvprEIZIx1pSO5kXnLh/m
         gAQjUurcr8RUG4waeblGEt+/0WZASbHkD/sw1aCnuSYRzUUBhE7oHeEUPgDdDaOCTyiG
         wdvEPoxWkWbnKqmiXHyF5ek20V/LjhLDhaqgsSByggyPYO9VwqP1KlsmVhrTu738opNV
         fhJOd6zDUoNoCBK89Fp6dNRGtJh7rJpiujYB/QLfHZr0nrG/nZefsVSqANsWIVbAlrXV
         d5EZA+2t4DFMVfAQHuFM6sVzFOKZ0W/QtzxH5O0Hl1KOnyt+WD8HKF8gUeyhEV5/i+VG
         lABg==
X-Gm-Message-State: AA+aEWa1XEgbcAmg3YeYX/uWFHvlcZQEbSKxfurK/Fo8saEedGoiynNF
        069AQJ3IU2irUC8Y5VH6pqrxBQ==
X-Google-Smtp-Source: AFSGD/VOE0dTE1stKeXyqSc9tQDatJthKkd9vkpV86uxpqbSW8qOAgrhfs8dKJl+f+D4pqMxQT5uXA==
X-Received: by 2002:a63:4706:: with SMTP id u6mr15984635pga.95.1543932647480;
        Tue, 04 Dec 2018 06:10:47 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.53.58])
        by smtp.googlemail.com with ESMTPSA id k129sm31298884pgk.29.2018.12.04.06.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:10:46 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 0/3] RISC-V SBI earlycon
Date:   Tue,  4 Dec 2018 19:25:04 +0530
Message-Id: <20181204135507.3706-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds RISC-V SBI earlycon and removes RISC-V EARLY_PRINTK.

We should use earlycon over existing EARLY_PRINTK for SBI console because:
1. It's a more generic way of implementing early console for debugging
2. Current RISC-V EARLY_PRINTK is a compile-time option whereas earlycon
   is enabled at run-time via kernel parameters.
3. To use earlycon with SBI, we have to pass "earlycon=sbi" in kernel
   parameters. If earlycon kernel parameter is not provided then kernel
   boots much faster which is very useful in real-world RISC-V deployments.

The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc5
and can be found at riscv_earlycon_v1 branch of:
https://github.com/avpatel/linux.git

Anup Patel (3):
  tty/serial: Add RISC-V SBI earlycon support
  RISC-V: defconfig: Enable RISC-V SBI earlycon support
  RISC-V: Remove EARLY_PRINTK support

 arch/riscv/Kconfig.debug                |  2 --
 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/kernel/setup.c               | 28 -------------------------
 drivers/tty/serial/Kconfig              | 12 +++++++++++
 drivers/tty/serial/Makefile             |  1 +
 drivers/tty/serial/earlycon-riscv-sbi.c | 28 +++++++++++++++++++++++++
 6 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 drivers/tty/serial/earlycon-riscv-sbi.c

-- 
2.17.1

