Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CCC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA3821A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="aX6mV49q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfBJNGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 08:06:33 -0500
Received: from tomli.me ([153.92.126.73]:56248 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfBJNGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 08:06:33 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 2761f558;
        Sun, 10 Feb 2019 13:06:30 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:76e8)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sun, 10 Feb 2019 13:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=kZOYIC6jF3s0ZZf/9dV0KiDyIPo0GnQP4qPbDmdCvTo=; b=aX6mV49qigumY8V3qL4locVcBs3VfY4si0LyzSk80brVX9puYlw7oYnNSezG4droOYX6wu1yEyIbXJSbBkL7eHoVyKBvJLEcINUVbC4nSq03u2zQAB2G1hsFptZIj1S5qjmw/CmOANHpJfqJ7cVnntwI1u2OdwCI/laCS9X6wJJ7MpdCjqdE3c2wmHzskVUsXvM3G28sdhwtScWiDoztd2gJbNKFF5qfeLJNZIhtD+f439TRlNu0D6uPTV+0QuBdG5UyYMCKnR0vFq5Lqyzb9Spi6oz8fESZ1UlEBxlATIM90Xtswnarb97BAbTwJJYray1Nnuk3bAa7E1nKecGPGQ==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Yifeng Li <tomli@tomli.me>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] mips: loongson64: move EC header to include/asm/mach-loongson64
Date:   Sun, 10 Feb 2019 21:06:16 +0800
Message-Id: <20190210130617.8392-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to operate the Embedded Controller from multiple platform
drivers, it should be possible to include lemote-2f/ec_kb3310b.h
from everywhere. This commits move it from lemote-2f/ec_kb3310b.h
to include/asm/mach-loongson64/.

This simple patch immediately enables the implementation of two
platform drivers. if there's no objection from the maintainers,
please consider to prioritize it for mips-next, thanks.

Yifeng Li (1):
  mips: loongson64: move EC header to include/asm/mach-loongson64

 .../lemote-2f => include/asm/mach-loongson64}/ec_kb3310b.h      | 0
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c                     | 2 +-
 arch/mips/loongson64/lemote-2f/reset.c                          | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/mips/{loongson64/lemote-2f => include/asm/mach-loongson64}/ec_kb3310b.h (100%)

-- 
2.20.1

