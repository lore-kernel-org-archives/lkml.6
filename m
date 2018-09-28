Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A4DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC5E216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzXyfMSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5E216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeI1Iaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44449 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeI1Iai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id c56-v6so144325qtd.11;
        Thu, 27 Sep 2018 19:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=EzXyfMSHeE3uggB1jajQGCirYkUYO2SYR/HR4nkFOeKGuSr47eio46NJAhvm5AMWKx
         2qxt7/NmJt9nm5+xsFOssYFrz1q4CF5TnJB2ZdDFRqqcKch2X1/ledCpOhgqy8LkDUzM
         rJRNaQwehV4x4E+c/yoJVq0zIm8Wzmt27QMszJjE77O2oWNT3LTqp17pTibT78nIOd7N
         HWZHnpRwDBQK/OZZL6TE74bNW9Z0P+WiLrPpjRYJi4uhvjzR+C2eMy8NuflwE7E9Iyce
         yQc8mHvQK8mVjeRqFNX+Hha3hdLVxh844v2rkaLjxQlpfx9nHz8J+jL5aApaG1+3M5j/
         Yqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=OEbo3f40S0jGotEpYQWBZoLPk6TZGVNlDLt8aSLepahxpk56Fah4S6Q+UF6xZBdwhG
         xhSrsgIPaVMWhy3wVNTiMlYkp544gZCHVd5nzAASu5dkwwVXnXeoysJy+h4IYsxC9Mo2
         KKDdAkYtPhaBacydKcKElPM/qbyiAaCI0ZE2UmADqRizb+WXo/3O519lCKBJ7idRN2ya
         X5B4lBRhlTxWr4BhrXgYH+zKPklzjk8FyXip/hZJlifptSmLq+mvMp0FjZBm50D/+U+H
         uPz9TXtb5B0ZaFK/ffQz9+0leOKvOZOv4XnPtiRsUzIsTrHssm28+S9IcNVBPZQ3CyOS
         utmw==
X-Gm-Message-State: ABuFfoj/g951VSUpBkGhtewzYQLeUmOMTWaJ9VP8YOAPxZZAfGQHLvBB
        MSsdSXlhUrStrZpOcepweXI=
X-Google-Smtp-Source: ACcGV61fJjPLfKjDNM3BBkz6aye0dc98m5Gs7VJdKq02carowFgKkUmZHZG0M+uSDNShlAot8GkgGg==
X-Received: by 2002:aed:3bc2:: with SMTP id s2-v6mr2751407qte.207.1538100556825;
        Thu, 27 Sep 2018 19:09:16 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:09:16 -0700 (PDT)
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
Subject: [PATCH v3 7/7] drivers: hwtracing: Adds Makefile to enable building from directory.
Date:   Thu, 27 Sep 2018 23:08:16 -0300
Message-Id: <20180928020816.11251-8-leobras.c@gmail.com>
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

Adds Makefile to enable building the driver using
'make drivers/hwtracing/'.
Changes drivers/Makefile to call the new Makefile directly.
It enables user building this driver without building the whole drivers/
subtree.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/Makefile           | 4 +---
 drivers/hwtracing/Makefile | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index 578f469f72fb..a237be6b602f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -174,9 +174,7 @@ obj-$(CONFIG_MCB)		+= mcb/
 obj-$(CONFIG_PERF_EVENTS)	+= perf/
 obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
-obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
-obj-y				+= hwtracing/intel_th/
-obj-$(CONFIG_STM)		+= hwtracing/stm/
+obj-y				+= hwtracing/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
diff --git a/drivers/hwtracing/Makefile b/drivers/hwtracing/Makefile
new file mode 100644
index 000000000000..fe5773caec49
--- /dev/null
+++ b/drivers/hwtracing/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_CORESIGHT)		+= coresight/
+obj-y				+= intel_th/
+obj-$(CONFIG_STM)		+= stm/
-- 
2.19.0

