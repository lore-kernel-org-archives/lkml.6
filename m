Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70901C65BA7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231E120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhtPLsQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231E120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeJCFGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:16 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:55885 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:15 -0400
Received: by mail-ot1-f74.google.com with SMTP id n12-v6so2412668otk.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J3Qh3Bl2YClR6CwBKobPsyQGEuRhLQSgqIJoc4enZwQ=;
        b=FhtPLsQyFnV7mIHUg4+qdFMVqvkJDOFuWx17/Yv2EoMqHDLVYHX9uIH2myuNsr/g0a
         uI7IUy/ZFnUkPbJRBfySiNXniDDAPBeE8P7bUJnDj48SN6OmRPa8pkmGnSkZvphcbPpQ
         5xArOtzMzIVCaoa0Ug2z5r8roIYyw1UGlAkj+/80n7H0TsIkXuhvP/KA7BjD+6ZrILPd
         WUJUdOxMLqKRIMca+1PHVeudwu6wvBAEtPZErvQStU/+KaH2qpkW+AGs2TiBqAussq3a
         ZcGFI9Aqm+xzS452XWeL8Oils/ByqdyF9SGjtJeMSnJlzx6OGSIcuLUeNol3QzvhI4NC
         AbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J3Qh3Bl2YClR6CwBKobPsyQGEuRhLQSgqIJoc4enZwQ=;
        b=Ptf0VaLLndRW1+G1RukQLQKp8t/l5AjAn/aDyq6WDORsyu+qaCC00qSVvtp9mNYkBi
         C6ODNdhm8p2J/CWt524KHzqvHx1EwyeB1I3CFBTtcC5/XMetMaVpVlD4XB0rqb4xVLsl
         1lfzL0QctiMpiip6++fHMH8HVvidc77vWQZN/Gk/mtBIID+ych2Gmjzvc6XcuC9Nx5dm
         46SHRu5MJKCIbdFTS2oXTUIuKT2ZmEHsUYAM2VpSlTPfTQS3QdhqQZ7TfjYj9UOIxE+u
         PXIq86zjYY7mV4gg2TGBAuhq08B8KVxhLvITNuAfk9cgHx+XZru29kfjqHEYCQ5xAnQm
         oPaQ==
X-Gm-Message-State: ABuFfojBrw0e3pTN9owv1U4y+Z/WJpzGJobeZ0Od3t5d6IoQvW7wviFo
        33haNlFwKjyho62jrzrR9xydcY2r
X-Google-Smtp-Source: ACcGV62CBqNBjVo2szQrMa4b4XwqdY+r4u5dX7RutGpk9y0S//35QMU03nkVRzWH3OR//6VOH16jVN4F
X-Received: by 2002:aca:3203:: with SMTP id y3-v6mr14124891oiy.14.1538518841055;
 Tue, 02 Oct 2018 15:20:41 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:58 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-10-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 10/15] platform: goldfish: pipe: Remove the license boilerplate
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Not required with the SPDX-License-Identifier header.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe_v2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index a1fbbf49cc3f..ff5d88e7959a 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -1,21 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2012 Intel, Inc.
- * Copyright (C) 2013 Intel, Inc.
- * Copyright (C) 2014 Linaro Limited
- * Copyright (C) 2011-2016 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
 /* This source file contains the implementation of a special device driver
  * that intends to provide a *very* fast communication channel between the
  * guest system and the QEMU emulator.
-- 
2.19.0.605.g01d371f741-goog

