Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42521C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5BF2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFWCvQa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5BF2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeI0H44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:56:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41989 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeI0H4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:56:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8-v6so1066513qto.9;
        Wed, 26 Sep 2018 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=FnsE+PwbSYT7Ik4sfBLqTvLMfucbH50GCrBzd4xVqgg=;
        b=vFWCvQa7tnqThSyIg61h11TzRYmazLFRVMagQ6EeYcNXsxMo4Wn9ZPlhVcIz5uAbTj
         aMXaDWfJupnoVdoged8/tDjnBoPqtUQHGXmwJiioFlRlKRh+AE9ozyrYl2WUKYMqQAQr
         nYgum1YolbePHVxfZ6CoR0bqbalfZq+ZMDI/4NPnxmqxj6CxijrUeBT57YLm4U7wQG3W
         puuLkxbQ7PbI1YElFM96GYy+SRbDIhCz2YYBs9/BD6Y71obgnwidCgDYfyDvzFSPIAIG
         b8zHD98GA38r2Enwn+U0szUgguDUZy8GHGqUZjUqUZxISXLbAxGYZXx7mGGzplbQTnWT
         nDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=FnsE+PwbSYT7Ik4sfBLqTvLMfucbH50GCrBzd4xVqgg=;
        b=REjLB42Rh7tBBw2GB02qkJsGTl+nNd9Cllh2Pt7OR9UOFNEi9TxlnwdvrOcYPGsBLZ
         dkdEky83AjDPluipVNfteQQSXsz2L0O/CFDoDucmVanr+1mtVnQLYoiJ7grvvaoJP9g/
         isQ87+bYWXslB24lp8hBWtW0PUhz/DISlqNW85vNfEZ95eioC3hIkpyiSajmzu9yXgSm
         vhDwHmOsqgdrqKPhQQ9mGeeI7bCfBdF38Zxr1khSMYZoHu6auynw1DjiHooezkvghEyz
         uUL91V2xWN1M+6bJu3zbHlVp8kdY6xby/qEAnywz8JEmiDXgMPJx+wbsvi3X3acORwi3
         ZKIQ==
X-Gm-Message-State: ABuFfojRm11lsU6WHabR/6LgtT1lsmPgWseptSEwETRd9KuLelNYbsbX
        nCkO4wqAeyKBqgJD4AhSGVg=
X-Google-Smtp-Source: ACcGV61TjBaHQXV0tUSKpRxUZWHrTiGPp/X8X64qgxOPcCcI5KRxNgoxsXZ8jZ3zCcb+02R0FvB+oA==
X-Received: by 2002:a05:6214:114b:: with SMTP id b11mr6408094qvt.168.1538012469007;
        Wed, 26 Sep 2018 18:41:09 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id a187-v6sm400221qkd.47.2018.09.26.18.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:41:08 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:40:55 -0300
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
Subject: [PATCH v2 4/7] drivers: zorro: Avoids building proc.o if
 CONFIG_ZORRO is disabled
Message-ID: <20180927014055.GA8980@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids building proc.o if 'make drivers/zorro/' is called and
CONFIG_ZORRO is disabled, even if CONFIG_PROC_FS is enabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/zorro/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
index b360ac4ea846..d580f9f08e0a 100644
--- a/drivers/zorro/Makefile
+++ b/drivers/zorro/Makefile
@@ -3,9 +3,10 @@
 # Makefile for the Zorro bus specific drivers.
 #
 
-obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
-obj-$(CONFIG_PROC_FS)	+= proc.o
-obj-$(CONFIG_ZORRO_NAMES) +=  names.o
+obj-$(CONFIG_ZORRO) 		:= zorro_all.o
+zorro_all-y			+= zorro.o zorro-driver.o zorro-sysfs.o
+zorro_all-$(CONFIG_ZORRO_NAMES) += names.o
+zorro_all-$(CONFIG_PROC_FS)	+= proc.o
 
 hostprogs-y 		:= gen-devlist
 
-- 
2.19.0

