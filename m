Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E764C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6A8213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0xY3ytC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6A8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIMGET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:04:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38452 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeIMGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:04:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so1903059pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z30FbZgOsqXYtT0pAvQC4ivHRNCwlSGvoFd+d8WiBIc=;
        b=C0xY3ytC2YCsoh3LnG7/PZuA0PCYN04qAT7PIK4m/r9RwYTVxINTpcARZ15qFvKhQP
         mgtYrNcEky7a1ENKE02XBrKmL+urhRSkOs/38IZ0IQfq1xaHUDNFXqpXpgfzyDxLERV2
         inAEi8eAw3MEx7OJwAhqrj/R0OunQhCOa+KqsrNEOF80bDw/twJmD77ZtpiY/Trk8ple
         YvrcHcFAgbPtgakyGN6aaRWOGQdgbTiMB3AZlX+ZOulACtXx5HWdAgxI7o487z96l7sF
         cxKvgEc4PI09j3fPUFrsLIP/WiYcks1SDZ/lVUNdqTXopJZkX9sqV9LkeHd/70es0QTH
         eTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z30FbZgOsqXYtT0pAvQC4ivHRNCwlSGvoFd+d8WiBIc=;
        b=WPBzr15rQvLhRw8/1t3xdrOtaFvu5sx7tuZtqTif3CtFnu8dkQ/R3HVK6KghEcnZPo
         lwJh3ir8uhdRE4qDPIaiOLvKB793aOpOMn1RZIiT/32wH71jCr/qHWbh9qvYBLJ7CZqv
         5NwUhyjUdBrgSQUP8WY08VwnI4hYZ7ifahF7gSk4mLjpbaxen4zj57xusEdsr7hVvyPD
         Z9dL6ydk1FpIcypX/LlAo5IpahhT69RiCeWK6rXcHgxvvTTQWUlXjEhCLGYktxlUMwhK
         qovQYGc2Uhjbqenx6RhJc1RjYKDVwYlEy7zp0R7+ZV2nLuQH2Gcz+dUFTFENQTOep1gl
         O6XA==
X-Gm-Message-State: APzg51ASh85vDNaoRpOGGkW5iLptdX/dBj8sIB0/m5rurivml9veTvaJ
        RW8t+i3l3VyhUHIgy1rrhDTUoBgY
X-Google-Smtp-Source: ANB0VdYahHWcTfA3v7WP6ktNEovHvfLPtlFGwZnN3MqxRUcOhcVyOsd/nYPBZjpNBGTfHcxhXeWiaA==
X-Received: by 2002:a62:d544:: with SMTP id d65-v6mr4901660pfg.107.1536800235136;
        Wed, 12 Sep 2018 17:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:877f:9499::2887])
        by smtp.gmail.com with ESMTPSA id b14-v6sm3620602pfc.178.2018.09.12.17.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 17:57:14 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] include linux/stddef.h in swab.h uapi header
Date:   Wed, 12 Sep 2018 17:56:54 -0700
Message-Id: <20180913005654.39976-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swab.h uses __always_inline without including the header where it is
defined, this is exposed by musl based distributions where this macro is
not defined by system C library headers unlike glibc where it is defined
in sys/cdefs.h and that header gets pulled in indirectly via

features.h -> sys/cdefs.h

and features.h gets pulled in a lot of headers. Therefore it may work in
cases where features.h is includes but not otherwise.

Adding linux/stddef.h here ensures that __always_inline is always
defined independent of which C library is used in userspace

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/uapi/linux/swab.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 23cd84868cc3..acddbe50a20d 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_SWAB_H
 
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/compiler.h>
 #include <asm/swab.h>
 
-- 
2.19.0

