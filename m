Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F10C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9032A21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asO4VPsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032A21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbeIUB7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:59:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42468 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeIUB7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:59:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so9553469ljc.9;
        Thu, 20 Sep 2018 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlfs8K54P3Vti/yQHi04L9XCI4qztXUSQnOLgzOvccs=;
        b=asO4VPsfa5uLNKssvb4Sz7vGg6vX/Is7UiwsFLW6myMBeJausjMkT9n2OUOL6BxzGc
         8JaynRAKJVcTQS04h7Phw/Vep1Sek2K5Wow/3lOGsUmr4T4pMlp6uwWDrgd/6j64Gp5B
         NHoAeCD4DJFE6ZieHoyNNrBXA83FrDhssnWL4euHKGAgrv7Sg6J4IdTX4eif+bbG5Rke
         Fb5FNWJUw84DlZllrmDc3cLdyy3K/fnx8EaxPbJGoUOlStKN6381+bBt27LHyk8+CNUr
         c3GYWDMhmK5Gq0jL3d7rEZgW16QcxIXA8EwPtN0019u9yicknnOd8FkbVUq0zHzn8mKT
         5IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlfs8K54P3Vti/yQHi04L9XCI4qztXUSQnOLgzOvccs=;
        b=cpl4Ul8KsOdY4kqWZ3P5jdEdwOr7HpUl4sQj8rQrFHUXIuAi7ZDfrZDHEG1v2j0rDY
         i/KrrBXZZYIHh14pfNxZVoN8inqongycwxHzhhsPHQsXtWn7fYfWwa40rP2ial6qxP2o
         jTII347EExUOWWCSMg5LRRjhw5698XUowmTG30WR510gSMc6gZgdKhRRAbHx+YwZLqtT
         x0qAnmHM3/u0orgcndiRgudIErMzzHFEOlvzh/4/giPD5kG0Gxy53FJ6Mj9pxCTatROi
         rNRNkjIv0vgHhqtlNYrGFEOpJiZdVtjO4sFuhIQezd8AOW3GKAnn8iA0cNqXLAa03Zsf
         IxVg==
X-Gm-Message-State: APzg51AXhAc5jgZZ0dclyLTJTu815kr2yX8YSiakKWivWSZb7RJybPli
        0KLeq6pVslD1NjkpDtwdinE=
X-Google-Smtp-Source: ANB0VdYIsLOGW6cFduubAEXfIqDvHzm7WDoEmrmhwIqCqx4ShvWMk8KnfXRqcGAoG0mS2Zv2Y7utUQ==
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr26380765ljh.68.1537474450345;
        Thu, 20 Sep 2018 13:14:10 -0700 (PDT)
Received: from linux-veee.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s133-v6sm452873lja.3.2018.09.20.13.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 13:14:09 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] ARM: add serial.h and set BASE_BAUD to 0
Date:   Thu, 20 Sep 2018 22:13:57 +0200
Message-Id: <20180920201357.16426-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

For years arm has been using serial.h from asm-generic which sets
BASE_BAUD value to the (1843200 / 16). This is incorrect as:
1) This value obviously isn't correct for all devices
2) There are no device specific serial.h with CONFIG_ARCH_MULTIPLATFORM

That value breaks early serial console e.g. on Broadcom Northstar boards
(CONFIG_ARCH_BCM_5301X) which need BASE_BAUD = (99532800 / 16).

The problem remained unnoticed until 4.14 and the commit 31cb9a8575ca0
("earlycon: initialise baud field of earlycon device structure").

Above commit started filling "baud" in the "struct earlycon_device" (it
seems to be a correct behavior) and changed behavior of the 8250/16550
early console driver. Starting with 4.14 kernel's 8250_early.c sets UART
divisor if both: "uartclk" and "baud" are set. Having wrong value for
BASE_BAUD (and so "uartclk") results in broken console setup.

Solution to that has been introduced in commit 0ff3ab701963 ("serial:
8250_early: Only set divisor if valid clk & baud") and requires setting
BASE_BAUD (and so "uartclk") to 0.

A change similar to this action has been pushed for MIPS in the commit
c8ec2041f549 ("MIPS: Add custom serial.h with BASE_BAUD override for
generic kernel"). Another platform using 0 for BASE_BAUD is s390.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This problem has been originally reported by me in the e-mail:
ns16550 earlycon baud broken on BCM5301X since commit 31cb9a8575ca0 ("earlycon: initialise baud field of earlycon device structure")
https://www.spinics.net/lists/arm-kernel/msg644295.html
---
 arch/arm/include/asm/serial.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/arm/include/asm/serial.h

diff --git a/arch/arm/include/asm/serial.h b/arch/arm/include/asm/serial.h
new file mode 100644
index 000000000000..e12f262290ad
--- /dev/null
+++ b/arch/arm/include/asm/serial.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM_SERIAL_H
+#define _ASM_ARM_SERIAL_H
+
+/* ARM kernels support multiple devices so there isn't a single valid value. */
+#define BASE_BAUD 0
+
+#endif /* _ASM_ARM_SERIAL_H */
-- 
2.13.7

