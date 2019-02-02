Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27950C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D882146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbBtHO6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBBJAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:00:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34843 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfBBJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:00:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so7863065ljb.2;
        Sat, 02 Feb 2019 01:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LtVR2K0xelraKNmc0kAouwOEPRRtdp2FqdLrjH2v6kE=;
        b=DbBtHO6JmgyezgdWtA+wpCQxkMYScw+gJtvOcn3LQDwww7DeAtjrv0xgBllU7YIgCS
         07NV55+pj7bjQ54E7tf794SFSzxr1mkUf+Ksn5+8NchL6SXG8beTcSnsOuz6weJN2FXw
         vcuHpOSipifEnxPPI+agSsbC7/437M30SC+yy0ftlJ5eK8/CVuGMhmNL7u7194FxlD+O
         GqGEJ2/Sxs5utexpP22sL2F5VQYF+6TJnL955nBdaXQwxjZ4u07uocSWSivhgSe7w4lx
         vs+0vLMt3ICEsNWkBZJlXzW8zimkGtT3v4adqYWfrYp8+JD7+KhFRtRYSkss7nVrgmIU
         qa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LtVR2K0xelraKNmc0kAouwOEPRRtdp2FqdLrjH2v6kE=;
        b=bCXcFYJ8OHjssKHVdtDvc6XVPZK9y48inRT/xwUNknyQdqFv9DfkCmnC+LDbEnym6f
         2eQa4u7R7X68xvlmJsnuo6J6O9i8qSpBGzikEiJRHlHaJsQ1bdA9mEi1OdR9LhKCVmKP
         TRXZR5FafYQyTTD9fhfdFg+UaALYi5qxiS+5PKjB8A58MFg+TQcrE7YYQq+lF2rw7uRn
         byMwQTg3/LgJpZ3TBEyMhpdCj7tROQaV91qHauyvOU/mk5FOPfpTQvSvrDX9xfN20+19
         RRKejOxbsJM/r7aKG7OI4A/auBN96JKl8O9kJZUnecLwHcnWETDExn7nNlQij3KxPkz6
         cu4A==
X-Gm-Message-State: AHQUAua/0vqOQzoOWFNOt2MW0NX/jOsQmA8sPdaApNdf1u5W34fXZKre
        UQDKuAYEhpBjZyr4PP3KrSkj+rJ6S1A=
X-Google-Smtp-Source: AHgI3IaCJaZkSuK0XF7zXLthdWPtvveAtzjeAi7kDg2n5zIbWxgdfJvGJw6kwaQ1JWByGFd73OzuXQ==
X-Received: by 2002:a2e:7c13:: with SMTP id x19-v6mr11736057ljc.83.1549098032422;
        Sat, 02 Feb 2019 01:00:32 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id e19-v6sm1710675ljf.67.2019.02.02.01.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:00:31 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH] iio: chemical: sps30: remove printk format specifier
Date:   Sat,  2 Feb 2019 10:00:03 +0100
Message-Id: <20190202090003.23225-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_fmt is used by printk wrappers. There are not any in the driver
code so remove the format specifier.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/sps30.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 376fac41ecb5..e03a28a67146 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -7,8 +7,6 @@
  * I2C slave address: 0x69
  */

-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <asm/unaligned.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
--
2.20.1

