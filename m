Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BCFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FA221733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvmFn6I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FA221733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeI1Ia1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43159 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeI1Ia0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so231120qtq.10;
        Thu, 27 Sep 2018 19:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=CvmFn6I5WJhu5ZjswWU6NzsS8X94KzBnve8IPgf+Qo6+pGu2PExO5XGt9GjYlBuI6f
         yB0zavI67z3Rr315H9OjdoAxzOXkapemDB+UbEQ4nR7uWyDe5kyOwt3G4Hk5p3yhbDC7
         VFzi5S5oBin74hhJBjZrfFraRA8Xk7CZCc6MMPDptY+iI7gjh2tqqWEOTmbYvlkjW74v
         Przjh5jnrARDJ/euhODiw8YiBOw0ToWTNDFMM5SSONXmROOfa/oOUaT94qADuvKOiPNJ
         BDJ9sMRmwUHNSEUCAQMqeY7CJG90IDiOzZ+87daoHoqM/jclAfWRTnTrIioyRDLSCg8Q
         wn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=Jlawu+0MZF3ZNrDGOu4VIKVNEDEhh6WpZCkOcmNafm/aVWZkdtouXpBN7D/086jUnp
         N/kRPXp3s7bAeO0YbgEIG8M6/nNHV+gftaAa65T/XK+KnCWnjotZscMWJiCoaiW1frpE
         FtezT6PYZYKPsY1bqLZFISEP1+SysNLYy7KPxd9P8nt3Mcnq5ZZ5OUpYdVmFn8mqfuRP
         iPhzpHr7OHwtIps2zC9m20tBAwXQPqmGX8fZ7MOqcw1vNVWlDTNCQtTvNcdOks69XY5e
         4FFEXAetVe9uY0ewuQqrI3azlTZnhQcSMVBHr2M5eCTg9XhovRIiJXtKMOG/Bq+Qof10
         yckA==
X-Gm-Message-State: ABuFfog3z5ZBhOV6LHRPwBLF9LlpTKEzk4oEozjtU6S3nf7pdPntvo6A
        At+Z4A0e9vh2OI6ACxCKKjUVwdKf
X-Google-Smtp-Source: ACcGV60cYOoAvibTXe4yQuqsipnRLZW5RkMJuY3DX7N4kd0h5Qo3N/FN0jP/X1Ce5LsCwIBLW8pghg==
X-Received: by 2002:ac8:728e:: with SMTP id v14-v6mr10886397qto.126.1538100545277;
        Thu, 27 Sep 2018 19:09:05 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:09:04 -0700 (PDT)
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
Subject: [PATCH v3 5/7] drivers: s390: Avoids building drivers if ARCH is not s390.
Date:   Thu, 27 Sep 2018 23:08:14 -0300
Message-Id: <20180928020816.11251-6-leobras.c@gmail.com>
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

Avoids building s390 drivers if 'make drivers/s390/' is called but
ARCH is not s390.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/s390/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
index a863b0462b43..0575f02dba45 100644
--- a/drivers/s390/Makefile
+++ b/drivers/s390/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the S/390 specific device drivers
 #
 
-obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
-
-drivers-y += drivers/s390/built-in.a
-
+ifeq ($(ARCH),s390)
+	obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
+	drivers-y += drivers/s390/built-in.a
+endif
-- 
2.19.0

