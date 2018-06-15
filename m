Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8198C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D02208DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlRt0qXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D02208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966002AbeFOSoQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:44:16 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43746 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756340AbeFOSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:43:35 -0400
Received: by mail-yw0-f194.google.com with SMTP id r19-v6so3664118ywc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PK3N1rjZNM3pihadyX32TVYGlDl0Q61NJI8mL4Ka5vc=;
        b=nlRt0qXrC+Z5Gh1XHB8/KGocZlZOTf3bxhKppseV5Rr0JMdXUsIdj8QdRztNUarBWh
         Ts/zAPM2mIIBbwlRpCsvBcj/YjZZh2zUn6Puap+bf7kMgsiNAJt3vjGdhfV3yd1tHls8
         loXun6w/53nOwGYtPjn/hYtkcodl5/OhZgEfvTDEHKkdHA6vV73A15ZSQzFlFMb91qGt
         /9fc+S4pniDku5k/de4Hk29yQfPqLlawMbgRlmZDcvOoA6d3BnxwZWDgmHYRobZnn9Au
         +9CQoA99vexY6T8ujuhvQm6WxYbXMzHTQqQ9AkyLbLdk5izUIcmOKO2VkMaSv+eSk1hS
         UVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PK3N1rjZNM3pihadyX32TVYGlDl0Q61NJI8mL4Ka5vc=;
        b=euS06MmwjptnJSEkC/vNKDimZZ5D2VmtXYzmZJmC2jtsp1C9qNaOLQ9ZAXoRc/75jb
         Zotq7qhq73yQ7Bt2QEMBH2Lj7xa14EsMFsT6ZWmZN+b2jwjcAWzQ/ur4rhK7lSLrf941
         uadej3dpcay5Bcxcsr4gYqOEmluBYOVooYPtFgbO6vwNeuvinDUd60BJw23lgU3U/ZX/
         jbnOSgjKIsjyI0k0hWyCBZlJbGvT2uco2aLtPEIXha3hnuGMzOexz68ulf2tINx464Nq
         n0Y/jMjxTJ4V+zSw0Y5iq076g20uj4BMnJ8Fp6fCCzAwhZziqm7TgvgY5+05tkV9j7Pw
         AlIA==
X-Gm-Message-State: APt69E3tjj2LWBITWnul0NJUkRZe2AFklC1a4JihAurAv/ALCVsyWam0
        53CMTtEbdlUBWm3rb++/gCQ=
X-Google-Smtp-Source: ADUXVKIOjAxwiY8trEBIZffbcXO5JrFScra2KbfkLDQOwbNOo8QJZnN3Ye+Po5MSzbtazavJ0mvNNw==
X-Received: by 2002:a81:9fc3:: with SMTP id w186-v6mr1500477ywg.188.1529088214654;
        Fri, 15 Jun 2018 11:43:34 -0700 (PDT)
Received: from localhost.localdomain (50-248-107-19-static.hfc.comcastbusiness.net. [50.248.107.19])
        by smtp.googlemail.com with ESMTPSA id v7-v6sm2872567ywv.91.2018.06.15.11.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:43:34 -0700 (PDT)
From:   ankit patel <ankit.mayurbhai.patel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ankit patel <ankit.mayurbhai.patel@gmail.com>
Subject: [PATCH 3/5] Staging: comedi: comedi_pci.h: fixed missing or malformed SPDX-License-Identifier
Date:   Fri, 15 Jun 2018 13:42:14 -0500
Message-Id: <20180615184216.18483-3-ankit.mayurbhai.patel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
References: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed SPDX-License-Identifier comment on first line

Signed-off-by: ankit patel <ankit.mayurbhai.patel@gmail.com>
---
 drivers/staging/comedi/comedi_pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_pci.h b/drivers/staging/comedi/comedi_pci.h
index 647a72441b8a..4e069440cbdc 100644
--- a/drivers/staging/comedi/comedi_pci.h
+++ b/drivers/staging/comedi/comedi_pci.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * comedi_pci.h
  * header file for Comedi PCI drivers
-- 
2.17.1

