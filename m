Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42D7C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9921708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIlYUnCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF9921708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeI1IHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:07:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37616 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1IHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:07:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id n6-v6so5024367qtl.4;
        Thu, 27 Sep 2018 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=X4z7jPf+dvuu42+tYZqKX430fxhW5Xfzad8xEo8VLqg=;
        b=TIlYUnCNWpQijbfpEwuhe5dycr9EThxJFylubBOpgYIZ7lcXjakkDG5ZsH38m4ual8
         IoREXTJtYOpX7ZjioyUMOoQRwfSHC5B838qJ4KigSeAMfnqbt1KMWTkKN3bfQ47kNrYS
         DEOsmuXXVteRjhSqETJVZceoJt42ipuHYirFnVbacv59xPCYxTZe8NXrZlKAT4c+GBxz
         tz1q+EkUcsw68q+xNW0u0Vm83sqNXJp1PKYkR9x/ujRhauLYItsFViPOOXJJ9MHCQe8O
         Q/6Y6FZ7flYmhHJJAiza39a0gYeqbKAoLhPjeJrUbDEzXIsXLzUwwe37todopHB116jy
         XxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=X4z7jPf+dvuu42+tYZqKX430fxhW5Xfzad8xEo8VLqg=;
        b=Q+GciXnQU0mbvvvo+EB2zEiNgwmgGLh1DpHyxoJSUR0MeJ66Qo5GRDtpcTvIKxBvH7
         c9qL4BYyLxIqSXhUzdO1ojEkSvgDmYglgFG04vkGKB8Mdq4IYi97uzThEJQ5CfnhCBRz
         FdZZv92mjujpkRE24gxhRvOxOXBNlVq3Uuk1t23kzEk+pBaU8cNTprKfPv3gOyYc/D5H
         /q9Z6su0yIxKkaQpqnS2OTaHiGzfcnCQS1F7Fvwom+10D9oh9rwW6QFqR4UDskAfFsIi
         lz0UysuzEO0f2twQX1RN4LzkoxvDR2yk8t6nCIQ/pzyNa7hT1ArViw2LF2D6SOYbeNVm
         T4CQ==
X-Gm-Message-State: ABuFfoh8lJQJeum0SLupKdNGYidwloHPAWhnwSx1b0w/t8OMsqTNRxUE
        yw6AozVLhgomUjJlnyvM/6Q=
X-Google-Smtp-Source: ACcGV62xfoYJb6xff8wzdqw0f0gjy5qLeUwqKQYNIjIdi7GkRm3W8oYwVxaXrDdkbFg2u75a1EFq5g==
X-Received: by 2002:ac8:2d69:: with SMTP id o38-v6mr10364997qta.21.1538099198983;
        Thu, 27 Sep 2018 18:46:38 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id m190-v6sm2050250qkd.48.2018.09.27.18.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:46:38 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:46:28 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org,
        /tmp/v3-0002-drivers-nubus-Avoids-building-driver-if-CONFIG_NU.patch@windflash,
        /tmp/v3-0003-drivers-parisc-Avoids-building-driver-if-CONFIG_P.patch@windflash,
        /tmp/v3-0004-drivers-zorro-Avoids-building-proc.o-if-CONFIG_ZO.patch@windflash,
        /tmp/v3-0005-drivers-s390-Avoids-building-drivers-if-ARCH-is-n.patch@windflash,
        /tmp/v3-0006-drivers-oprofile-Avoids-building-driver-from-dire.patch@windflash,
        /tmp/v3-0007-drivers-hwtracing-Adds-Makefile-to-enable-buildin.patch@windflash
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
Subject: [PATCH v3 1/7] drivers: dio: Avoids building driver if CONFIG_DIO is
 disabled
Message-ID: <20180928014628.GA10427@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
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

