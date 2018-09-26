Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD97C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79BC208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWqZJCTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79BC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeIZID0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:03:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35061 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeIZIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:03:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id z14-v6so10644239qtn.2;
        Tue, 25 Sep 2018 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=AWqZJCTbrbLZQCGcJApGVRek4I3vA42BSNQkkRD11Myr+SEonNHwQhWgK+QDAevvPe
         /7IHIuN1ZhkJEjAYay/kWeM/qaYWm0/SRg4pvQme8/718tnZrR3IKQqz48B8lIrbG6N1
         eB1LqqY8piNAFKk+HZdb3y34qpT7jKGSS9fSOerbm3wsTjKTUaCNAquQhQ0VcTXNV/m7
         fA8/RSYTwbCseFXQddxI/40XDv5Ep7UFVJOcmyUZ1EeKKdxU0Bt2YNkE5FCHdxHqm0Np
         n6lYMx1EdQtGra//kIEAH/fBqOWj2BGJum2uhpQTK4EvvtiB3y5QF33wLRFiOHlkZe0E
         dw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=BxAEqJMXYnqUyTs62Hz2/azm0ZHM9Xd0P45CRcRPhk2dTiR3ug52ZwzRvw0PXc17uA
         fkl8+ZaR2jtVQs7kSkxGFwQTFTINMmnlIiw7tYF7X+IrKQp01pWJmwOV54aB1xxbUEr5
         3R+WKI39Nv1OfDkhb9AjBWS+Dx2zmr1QrwLhw1KjmOWr23345ZoTLbhR///QlvXKZBl3
         /BB4G8CEH/0zeiApD6SoQDHQGfwOjaDrNp1123UftoRN/rlIIBqtA2kHRvYdXlb/9pds
         U1rDxjvmI2UaDULTLaQKhT1eC4VYRatkDMfpL0HSe/6rxkZqeDyy4wfgFoEbW9pSYQzT
         RNnw==
X-Gm-Message-State: ABuFfohJqeRmhUNjZX5KAFZJ/pHC3PveNPvLlJq25KI3B6FkN8AZTtMu
        m5i1HGep63rzN49bYGGkWw8=
X-Google-Smtp-Source: ACcGV63+EQKDCynaQfmq1FTk6y4P/HI9trpCntexAQnt/InAZzDAwlDYMXOt2UFFl30xeRp/IOs/TA==
X-Received: by 2002:ac8:1493:: with SMTP id l19-v6mr2896194qtj.129.1537926782117;
        Tue, 25 Sep 2018 18:53:02 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id z8-v6sm2024556qto.72.2018.09.25.18.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:53:01 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:52:54 -0300
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
Subject: [PATCH 5/7] drivers: s390: Avoids building drivers if ARCH is not
 s390.
Message-ID: <20180926015254.GA14984@WindFlash>
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

