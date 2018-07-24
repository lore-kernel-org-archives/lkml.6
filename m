Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C781AC67790
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F54920880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St2GGyJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F54920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeGXXbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:31:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34005 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388769AbeGXXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:31:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so5555737wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/oD0R3Z90QARiH+jvmG8mbyro/3L/Fxxa4VcHkoC/Q=;
        b=St2GGyJQq64oGwzt35YyTSGpFk+9egyP/+/ATOdCDOtoNUiaoezXQIOKvXXYPM1zmO
         C6NpJurmGNcEkxbyRzS4Cp6dWzt0bj1Z0Jb4BnfFFo7oR5wi6b9b/PK8aLP6mujjOtul
         Bud1mIxy9Qxjhvtd6fCQdV2uqsg1vFutAyVGIf4hKc6H3ASa7MKegYGUjVLQIwUglFw1
         HURuAfJ0EmLojcPDu29KS/+d7whpST12L1TWuiKaLOm2amrXCneZm0y2+9xcSV7OXd6F
         I9fqavzacY8fImOEE2bo3VfTr9XYPW9/uk0PvvRon7lIaY1AOKT4EZX+ZdpI1ZHhlbeA
         rT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/oD0R3Z90QARiH+jvmG8mbyro/3L/Fxxa4VcHkoC/Q=;
        b=KeT5xlsVLvGnjDXNrUIQr72cJBUeRV/aZLI8/1015Z/ZaYRoG5pDooq+W7Z+gxPBve
         qD5Se8Yb73EQU+2Ee3msoeK7p0hvNG5JzQM2cTWDOPw/ni40Fro2OUXprkhgUDGhE3X3
         MhknIsiA4QzupQZflmzxKcCTs9VtgVEG7R98MHe3fDdjqJwU1Q+N3WFtjGD8MRDgWAdF
         EXqJlAlCjmJPzo+grJomtci3BFTHBHX4nKIl5ZgToALav+mGCaGbLCFUVCqslfnIGdec
         Mh1x/ryu1vQaFn6388+GtI96RyU1HG54TNVdplkAiRGgp9YCMsvNv6JgUJly0B2tQY7B
         wBnA==
X-Gm-Message-State: AOUpUlHGPFCPN7ThVK7hCL3ZCeqp3+0uYfie16w6TEd/RgEkxRlYLPCx
        Bj9ceBnRWqT1BDIHl8JCzUc=
X-Google-Smtp-Source: AAOMgpckwg2JczcrG8yJhSPqD/J/jYrijTxUpNbUNYuR/yBWMZsLR5o+D0sQMXB1PW3pYLQ74Ig6HQ==
X-Received: by 2002:a5d:4acc:: with SMTP id y12-v6mr11912568wrs.132.1532470945693;
        Tue, 24 Jul 2018 15:22:25 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id g15-v6sm16750607wrh.48.2018.07.24.15.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:22:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id C9D2C6408C1;
        Wed, 25 Jul 2018 01:22:22 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GdIWBeis-cIx; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 59E97640654; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Staging: octeon-usb: Adds SPDX License Identifier
Date:   Wed, 25 Jul 2018 01:22:08 +0300
Message-Id: <20180724222212.8742-2-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724222212.8742-1-tsotsos@gmail.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cded30f145aa..cff5e790b196 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
-- 
2.16.4

