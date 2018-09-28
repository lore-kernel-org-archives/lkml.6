Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E61C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA2521733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUMDJJN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA2521733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeI1Iad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35632 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeI1Iac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id z14-v6so5087523qtn.2;
        Thu, 27 Sep 2018 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e059U9EVFIrXzIdKY/vX6Gpjk8Vp1fLvpRknwNsZouQ=;
        b=CUMDJJN6yNfQfPCW439dOQT+mg2FWYBh8yUgNBZoAQPPMTfGpXDngoyfLVL+HlOd5y
         oihWC3LDp8QTHpjtZCQ83WH1tntlr3ad4P0XC+MJZSAmnddZBRSLjS4NQ9q3wtoWgayR
         77yvHHtGJK7YiQJAoFHgjJ1sLBigzfhw//dx3l3l2RhAeDMlvRiGeBaQC1PL2ZZKA0ak
         iF3FACthDKmxCOfaY0pYq5sCEv5OMWq76/YAZGAuFFr9/zHFomV9AY3YL2/dYgU4Iba2
         0Y4yBgZi3sW0i0NtVabWn/pZejIx7sZSiOUhkU/WM9l+5Kh1I4GO9IhlzdbgHFcCsA2L
         RuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e059U9EVFIrXzIdKY/vX6Gpjk8Vp1fLvpRknwNsZouQ=;
        b=padHfS/gRZpQxZupuPRZq7s9tMYRjG2NqJEvYmRSaBO7nRadHCXQrXlJ0Bf3QcCqfK
         aKQePUhZMtNhxMi6wHSALHAvabV/eQgZHgHsm2oV+WlEhRlOuAMr2LKfshPKEAAwS9Ri
         BjMZVPSfc+yIW4nUjhl0tQyNj4MRLfkVrGTQZqDZ58nDRHpafo48VxLXw6/BIdbkNiiZ
         HqxhK1vUhMNzIVTMerxu9tFAQUKKqsWeI9ajxDuqRAlzciUbHDrY7r2MwUy5994m27/2
         /Gu1NMehNJQ0uALi6/xMmwLDGOfXlToVvdvX+G6HQtGDEfJarERicexjKJvLFTQQpOOz
         GOPw==
X-Gm-Message-State: ABuFfogcTxDgnrVoif6+yzLXnOsi88yblWuUOCi6D1knxmQQbv4IGSpi
        zvvv5H11cyLMIscg7ijVI30=
X-Google-Smtp-Source: ACcGV63Hsji/ySypatu1xD4zofutjOYePf7Z6bqsj9iZGRmP6CfMfuBGZrIhJykyjXnZlNL65uhvTQ==
X-Received: by 2002:aed:2b43:: with SMTP id p61-v6mr10997907qtd.107.1538100551318;
        Thu, 27 Sep 2018 19:09:11 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:09:10 -0700 (PDT)
From:   =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 6/7] drivers: oprofile: Avoids building driver from direct make command
Date:   Thu, 27 Sep 2018 23:08:15 -0300
Message-Id: <20180928020816.11251-7-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928020816.11251-1-leobras.c@gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates new Makefile to avoid building driver if
'make drivers/oprofile/' is called directly.

This driver is usually built from arch/$ARCH and seems to have
no meaning building alone.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/oprofile/Makefile | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 drivers/oprofile/Makefile

diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
new file mode 100644
index 000000000000..361867ec2338
--- /dev/null
+++ b/drivers/oprofile/Makefile
@@ -0,0 +1 @@
+#Does nothing, since the source is called from arch/$ARCH/ tree.
-- 
2.19.0

