Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8072156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPaqGZYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8072156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeI0H6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:58:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41570 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0H6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:58:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id n3-v6so622671qkn.8;
        Wed, 26 Sep 2018 18:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=bPaqGZYQVSwfK131ivTOy9NJoZHHfv8fWF5x5Bpce/ydhsq8I2QQbMkJcOOabbs+x/
         ZuAtrudjfCSVlEElbTk5yuNDfNZpmNhwEn2a7Ck1Gvg6Z4ZE55AzaiOmjr8wOV7PrQbh
         J3p6B0flIpPJwIArcPRBhPbCO2/a7DE260YMzZsrExSFqGr1u7yI/2CY9Vr4TAGYBA3S
         8fwuASzF9RXqdGA97p6/oF9p38m2bj/NZDrjwqZVQI+BbKeWIkRvIVXUuo2crkG3SwBN
         q7yn9T/QUQJPHJFpt8N7s3sB+8kUlkpmzTbQpQk9/SiYnE7jOniYECZcbtLtHoiHhtMq
         jZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=RF+Kai4Mxm9boG5HVgg1FUea7vAAlZ+dLLnv14K0TXhsxuVL6LDGerw4IbgtMBqa8c
         YHUfwULbQCCrAWP8U5yu73lx/8surYkmJXxnKh/Pn2XFjlKd+VFOnYu+4jAThBOnZxPO
         yqnQcs39dpUAAgHPtKyQ9zJNDfXLMGG32s0qNX0mhHbohYeWso+lkpGalrqAnqGyUkcB
         lHqmh3znMe2pEppWf3Pr62ltWHDk43v+10QRb2lHwxCQ1hWZJpWG0CrUrXeegodSGWkH
         97a2MloUQ+H2sRnWdROS+zwutnmTmIBBcfl1BlTWCJmXSRWeG7mN0d0Nl2ZdPKMDAnO0
         6XIA==
X-Gm-Message-State: ABuFfoiFeg6Aa0E1nzcyyIGPfDjUMGCev2fSDT9zCXJiCNPCm/zdRE9q
        nC9N7cHr+Gz3A0/zyoneTXA=
X-Google-Smtp-Source: ACcGV61LGXs+2y3kISxKIFoduBXqkSGbiqgkp4koU6VAU/V2k68kEkp6HUFlwzUTuE6jW/ZuqCY6vg==
X-Received: by 2002:a37:bbc1:: with SMTP id l184-v6mr6415136qkf.111.1538012534356;
        Wed, 26 Sep 2018 18:42:14 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id s64-v6sm362867qkc.70.2018.09.26.18.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:42:13 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:41:58 -0300
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
Subject: [PATCH v2 7/7] drivers: hwtracing: Adds Makefile to enable building
 from directory.
Message-ID: <20180927014158.GA8995@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
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

