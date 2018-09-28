Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834C2216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaRv+wOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C2216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeI1IaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35360 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbeI1IaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id a189-v6so2948167qkb.2;
        Thu, 27 Sep 2018 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4z7jPf+dvuu42+tYZqKX430fxhW5Xfzad8xEo8VLqg=;
        b=NaRv+wOampHpKQs9p+jTUC+GToyyQunFlt6ozkOJodovVjoeac/l7hkX/BRMv9QgH6
         RFDnLP+XRkufbkbEDgXUp4gGK2USZ2czpszE5RgajgbV/EYgKOoOuNnS4QffGcE8xTsG
         eQbxK6m4VxZv88uxP16vhn2gDmrm0CrkEkX6SblRQb0cXAMB0r2cke58PksUgYMXNZNN
         7vT8zqGqxXWevGhBOdakiiVrkJKOEhDehE31/+1MGZJbv3/NlWfXPzFjvcUv9MFDV88s
         bbwocghtGYrPNL2Cq4lzjbHqUFzzU1xQVbZbif6aZt4rYxy4+uCMuTcNmq5hWc1AeCls
         1qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4z7jPf+dvuu42+tYZqKX430fxhW5Xfzad8xEo8VLqg=;
        b=njk2o4u1ddGS3CeRmKGB3D9kbK2lvvTWbVOdxbOzaOAVqEmClKmfy88bGVtjLuSdYO
         u+cxJH2pviNBrsmeubIZ/raHApNEk1WN1X6X8xBiSu4uPiFTegGfo3nsjWPINfL9oIak
         l/zNnP6Yhf0F0WiPpwNGsD7EyWShjy1vDRJxSzykW0AtbqsdTt0fnlLLcI6t7rfckhHU
         oDekpT8CJLBOsWqGbIoO1JRmQwdFyzWffgXr4TAB+mdYH6zO5MtDLWVlu3589hRgIks8
         o9+CDOeFHJ8jE3dRaKvDCRW1jymokbHWk0YF6QENXv/wOb7hlfdy6RhjyFdjAyFkOsAM
         bS4g==
X-Gm-Message-State: ABuFfojcKgPHlbkXJNugJDENdwu3u7wFNCDkhynOxtLHqL64z/ISjQpW
        tIXI/XKD8zL60JSABwOzYqs=
X-Google-Smtp-Source: ACcGV63d34VUnn0HRk8O+TyIF6tGHl9OrdvJwyFfNx/bXbBPtiyGD3WVuz73eDr+4rKxTXMAdvALag==
X-Received: by 2002:a37:411:: with SMTP id 17-v6mr3876805qke.68.1538100520497;
        Thu, 27 Sep 2018 19:08:40 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:08:39 -0700 (PDT)
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
Subject: [PATCH v3 1/7] drivers: dio: Avoids building driver if CONFIG_DIO is disabled
Date:   Thu, 27 Sep 2018 23:08:10 -0300
Message-Id: <20180928020816.11251-2-leobras.c@gmail.com>
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

Avoids building driver if 'make drivers/dio/' is called and
CONFIG_DIO is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/dio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/Makefile b/drivers/dio/Makefile
index ae92d17083f2..8fc80e805b90 100644
--- a/drivers/dio/Makefile
+++ b/drivers/dio/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := dio.o dio-driver.o dio-sysfs.o
+obj-$(CONFIG_DIO) := dio.o dio-driver.o dio-sysfs.o
-- 
2.19.0

