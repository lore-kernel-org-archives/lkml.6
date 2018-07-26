Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CBEC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B82083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4fu8WTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1B82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbeGZOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:47:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44462 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbeGZOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:47:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so1726240wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Scv+hQSoks3G9Y3kToV0CbIak8eCUDDsZEQWewEXN/I=;
        b=W4fu8WTZR01i0cc6MxK15SD5NlJnpqeGOREwlaH7EAvI4fwLEIU/9yWWINQ70hIB2a
         wJJOxz7Ttq1Rs7p2x/EN9+vHpDxDOkG0fJSftv5bffnKo1AqyxmmKMA/Ejm2uEJVv+yb
         tJh338BD6lDPajoqzzol72VuzmDrqC/7FVEXYMwGqmOtOPs3jGlDDmHldmdY7ys30Lqw
         XaMfdrmL3X9LV77Wg3bJBxREZ8TftKElM6VcQDZ3J6HwzR5CzJwm59bABSCo4p3LFrxA
         KCFU1LIzP2W3366gUtLjGA/zp84+wCGvmw/KcftR/bPFzvNFRVh4jR198xjzFB+Y4Sor
         KEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Scv+hQSoks3G9Y3kToV0CbIak8eCUDDsZEQWewEXN/I=;
        b=n/0fJ2sAcAWuO7loD4Faz9A4Phz2SezzHigwSJq05xzOh3Zmw9FOlGLbLMN3h9JBGw
         F9zV/zLum/+LMxIg0wrk7LxS31h7Q3yombgxyABsUoMNU8pktI3ExApPQpZlBS5mBEf+
         SBoeXkBwWn2OVRrybDQKBBMkMve0GtLpvsiduEsSq8r8fKT/m5DoJfOgOGElwaBKbYIn
         EadLJYXgMvqOreJt4r/JHQtILfkE9FsM6pWbWqLq3X5R1WPc5raoxo7i6jsAL8H7uIQX
         IsBz7kAPC4f3HnE7gi+Rs2ZZXn+37fIuhcX/hUoXjSdrY0rUYcbCAcpvnS8nngVGbYCT
         8Pgw==
X-Gm-Message-State: AOUpUlEMKAlQRj72Zr4yruHKAq32rQLILhM4oXB6wzoAxwCpWBzjXc/9
        b2wFp0L4oguppcjdKYXNUiwqYsolk4k=
X-Google-Smtp-Source: AAOMgpcJnJ/MrBZxTWwccq5ulqXB2BwruCSxa1SsWPvOSPvjyzBIY7BZIBVgEIosIbkiLX7DrcTARA==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr1547605wrf.268.1532611822373;
        Thu, 26 Jul 2018 06:30:22 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id r12-v6sm1265773wmc.27.2018.07.26.06.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 06:30:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 6AFCB6408C6;
        Thu, 26 Jul 2018 16:30:20 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Klv1U6SID2l8; Thu, 26 Jul 2018 16:30:19 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id E580F6407E7; Thu, 26 Jul 2018 16:30:18 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Staging: octeon-usb: Adding SPDX license identifier
Date:   Thu, 26 Jul 2018 16:30:07 +0300
Message-Id: <27ef6e7b67d4bbe0480bda81504c24b6305aa72b.1532610629.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding appropriate SPDX-License-Identifier (GPL-2) that were missing
from code, header and make files.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/Makefile     | 1 +
 drivers/staging/octeon-usb/octeon-hcd.c | 1 +
 drivers/staging/octeon-usb/octeon-hcd.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/staging/octeon-usb/Makefile b/drivers/staging/octeon-usb/Makefile
index 5588be395f2a..9873a0130ad5 100644
--- a/drivers/staging/octeon-usb/Makefile
+++ b/drivers/staging/octeon-usb/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-${CONFIG_OCTEON_USB} := octeon-hcd.o
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index cded30f145aa..cff5e790b196 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 3353aefe662e..769c36cf6614 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Octeon HCD hardware register definitions.
  *
-- 
2.16.4

