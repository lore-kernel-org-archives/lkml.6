Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E84B21733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWAp/ODn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E84B21733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeI1IKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:10:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35518 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbeI1IKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:10:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id z14-v6so5049794qtn.2;
        Thu, 27 Sep 2018 18:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=FnsE+PwbSYT7Ik4sfBLqTvLMfucbH50GCrBzd4xVqgg=;
        b=LWAp/ODnG3g/fquiABxPcurrEfakZ99Tu80oGCcofFtOUhLF1bWOxFuRJ3Rf80PVL2
         dm/9+Ktx27QUf6igqhEcYlR8YxWKDz5TOiSkD8FfVIIj8MISfvvfZsS8Rt/K11rMYt1J
         Y+3KeJdI3v/2/zJjL6lsuAXDZrxuEcEoDn3LP9Dig/bSGd0VXqs2huu+tWciiHYtXBxf
         0iYVGubIElYZiG/OOJTtuvcXoYxocSgR5g1Xh1aVqJpdOTJqrGD/VYRZirL4LrfRd8LO
         eJkjlZPLopu1yOUQ+aPbsTWlwuLr3p4hGmskXdwKI3OA3vY2q3uhcC4bdIhpGRUHBW9v
         czRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=FnsE+PwbSYT7Ik4sfBLqTvLMfucbH50GCrBzd4xVqgg=;
        b=lOphwBFK31wYCR2ApDgqZXgOZlcLbQG6QJkDgUZ9DsncwiCG8hr6ZKKPdouMTWF8RQ
         fyffcJQ+Kg5N3Rhfm86IC4dI2l45EGSASsymHwsmI3xUGo1VxhcWjddVszecgurl0UJ6
         tgNWPS8eb6sEKH5tD89Xv/Z/hi4Lk+OC35Bzdkg64qkIPBZqiVg0hGDwYMYiOnY63Zu6
         Ij7Q+Vzd955n9S82xp6HYe6cEvjaApIrii/0mRE543h3owRjoA5/P/RXLA6IAYKxeCe5
         jqySxq6VrNFN1t/G2InDoBOxAX+2kJNfEyA4e48i+i4jjXuCAV593zSGlpCAuNPpg6UR
         5S8w==
X-Gm-Message-State: ABuFfog/fO2TlslYzLkc9jbWNZ27UJsvRerj6ETRNWV8iAv339U9cVL7
        lDf3CNKDaFSNzouijYCDM0A=
X-Google-Smtp-Source: ACcGV63R/LlHErhiNWXpVRyOdAdylp7VkaNLTyysrV+Mmv7R0bTo24jVt1Hs3Oi1NZ83+DU5WWd0QQ==
X-Received: by 2002:aed:2f27:: with SMTP id l36-v6mr10879466qtd.333.1538099330155;
        Thu, 27 Sep 2018 18:48:50 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id f13-v6sm1847655qth.62.2018.09.27.18.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:48:49 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:48:42 -0300
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
Subject: [PATCH v3 4/7] drivers: zorro: Avoids building proc.o if
 CONFIG_ZORRO is disabled
Message-ID: <20180928014842.GA10506@WindFlash>
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

