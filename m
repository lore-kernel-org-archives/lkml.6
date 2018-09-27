Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53951C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075172156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur1ZvkjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075172156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeI0H5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:57:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33360 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeI0H5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:57:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id i10-v6so1132004qtp.0;
        Wed, 26 Sep 2018 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=ur1ZvkjRUXOqVDnp6VeaPbI05opelG949PtGWPZmLOV4lvqrnb05gsnj0ApFmmIch9
         pEhIGstSrm6PbM/e+/3nImbuj7Hh6NDW/w9HRYTkRix6ZozRxKTLZQlnY8p3+fYq4xTR
         kRBriwslUg8Tq+J4tBAr9bDCZjvRqxWrz4h9gw3WecHJDI4Cvz9GTJAskURF4Gw/r71f
         sfteDTGqCgygjLOrTNXeOmvvB16LYXAom2bpiMwWLXYt8t0h5O1TrhuyAMaQ3Ux6x4f1
         tHrkTw3nY90YqN+nJhgZden+VaBOCdzbyPDglq5QqxvL1dwRuMnDF1Au3Z0Vj75gcCyJ
         kaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=AM/uuiJklsG4lKtYDEsIzVSgHJpsdZefOn5x2ZbXZ0VBHnV4JOs+C3azCerswnfcQ5
         6GONqQo3lo8njcocjTMWVr5QgpTvHx99dGhUEM2do3IoyKB26O2zuaV/2DupEG83PtqG
         N4kLdxx/uNprTWiXHFELwMWuV3W3F2QEP9WLLZHnfeb56JM8O27u/01BShobwzquikoS
         N8eWuzWa/3a52nfVuIUnHWaT6TF4VcVC2lFFeBI2ckcxLMcYOZ8HG0J+SNuped0+D4dS
         MnnSGyi7QV4oTPdh/EPi8nRMhDsiDMfeRHlUA2T7NTgd2Jkn7ebxOXYLLRAXNKBjIWI5
         fUkQ==
X-Gm-Message-State: ABuFfogCCw/kX0UUcqySfy14+HUQ5MesBz4Qyft0QdctI4m8p4skUdlr
        D0tMFmopOH8ebvNIng+EfPg=
X-Google-Smtp-Source: ACcGV635gQaX0CnFQyT2kIQ+eG4LOHdwks0KjhtZuZCAYqxtfgUdc1AMpT5ZOXrtimSaq+TGYVuKjA==
X-Received: by 2002:a0c:b145:: with SMTP id r5-v6mr6367391qvc.97.1538012487098;
        Wed, 26 Sep 2018 18:41:27 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o7-v6sm463119qkc.67.2018.09.26.18.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:41:26 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:41:13 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: [PATCH v2 5/7] drivers: s390: Avoids building drivers if ARCH is not
 s390.
Message-ID: <20180927014113.GA8984@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
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

