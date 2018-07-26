Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D922C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5E220862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+vRZaOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5E220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbeGZRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:00:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42386 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeGZRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:00:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so2166878wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Scv+hQSoks3G9Y3kToV0CbIak8eCUDDsZEQWewEXN/I=;
        b=j+vRZaOPXjrGRaAmRAU62WHldEHOxgTKWWpKaNa3LwEGUosn8bNRzCcOcrtC0XYUKg
         pCZI8sUnWIy88mXynaq9qN0UxqilOAaU4n65/G0ozFZJsAaBcCcdQRdKrp38/17kRr6A
         OfJ1hFfZ/qP+eipZpx38luNGjS26JjR8+akBlLgHsZ2mXLhfXVyXAm+74PSolAiotadi
         A8XRZGVJRqJP5fPMYL0f1UTbBA06i6hojDb8yXdAshV1N70rKUhtjo6cqVwMlho19hlt
         vLx2GxpuBnrMi8lvgUMFd9vCEq5NzHq3X4Nxzzj6BwRienvUqa6LiAFmcRYFWVJr+VYo
         oWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Scv+hQSoks3G9Y3kToV0CbIak8eCUDDsZEQWewEXN/I=;
        b=f5YnfL77Q4JFrEMpiTMTpXg/WdJQmJ/13osOSWre9YntZOXfRBy7uxZZUApvHJNoYR
         2lPLLWAuR0UTtOng1AJKCvzhdhus+92e6ruvccf+QSdCa4gI6YmWUB62iqORYMVnhSRp
         PpKVskLF8zlYCJefAmKMjkr0FOsuRefy4uR/aYnFHz8hO2ut+fM55fXtOuzZY5p93nGe
         EznGAtcy6KENeAYiTSGqG9ReH6JQE0dmQLoiUhJIdonBJ+hIvG8+rnXmHRFQxPEgiJwp
         wHy7G6Er7YptVJ7vgB1UArXLpL2KYFidXh5sTeWHsZxgHTivOriDpqBMNDhGlZDjsPe3
         kN0w==
X-Gm-Message-State: AOUpUlGJS2j4gl+uwOPAONYMk+3m1MUhxbjoQqsuki4StRWWMJ6eExBs
        pc9MWTu7+rnzQ7cldNZfS48=
X-Google-Smtp-Source: AAOMgpchG/cshsx4tKFNG3N1AbV/cK90vU3DYe9TstZPBVzEqOoCbmZkQcBOdG3jDUtQV/e5aIogfg==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr2030203wri.124.1532619759869;
        Thu, 26 Jul 2018 08:42:39 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id 185-v6sm3119374wmh.22.2018.07.26.08.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:42:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 2A9F06407E7;
        Thu, 26 Jul 2018 18:42:38 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J7mY3xJ-0SPa; Thu, 26 Jul 2018 18:42:37 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id BA8F16408C4; Thu, 26 Jul 2018 18:42:37 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Staging: octeon-usb: Adding SPDX license identifier
Date:   Thu, 26 Jul 2018 18:41:51 +0300
Message-Id:
 <27ef6e7b67d4bbe0480bda81504c24b6305aa72b.1532610629.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180726154151.cQgnQWh1X1lfYjb2LGxEJEa5Bp0rQZWM4RQPL6ENFAs@z>

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
