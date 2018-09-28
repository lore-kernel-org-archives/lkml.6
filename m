Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B573C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48621733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8SZdRT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA48621733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeI1IKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:10:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35534 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbeI1IKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:10:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id z14-v6so5050076qtn.2;
        Thu, 27 Sep 2018 18:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=c8SZdRT8uG27oQeqK7ZCzA/WksemdQTwt+kyyR+bEonEmei04H6YjdDbDlg2122FOG
         T3cYP5zY0QTnz1iQaI24ZuCYzlIrFldDqR0TURihKRKun59nsNfPYbA76y8jr4BddIsV
         y6XRn0ZBykh9amdfA0EMnSPcKd6pU5gl9k4SEXXPzIpUtk5wC1riIQrQ1FHfqVycvMCI
         W+R5Qf/6WQh/57idCg4ZF4hE8OAD0lcvCWyrg4cEn6evO4i7PO83SgmtNK0XM/PUPkPg
         6ifNF53OjVGuim2OtRj7lEfYcpi534CAF54EO14KGsfj5SBYZLT8vPD591b3bSWSWZVb
         aIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wFwPD257gEf6jcXSywUF4KDj7r7qvliCjiZQYQyJ1vc=;
        b=mb2ZZyxjWVMc074eNO0ZPMy0s8RL6b1NiN7we7vAX2xMEvHh5swh3OwaxlMWZue4bA
         c0HKoh1RPCcTi/2WZwTfQQpR0Fm1OmwiHufFfuDIBHFeLCjYU98RSTuhY1kyqgXzCc3+
         9mhND/2z/km1d4zIqpA2U/a2AM8TX4TzvKwOSDe9SeDVn4nhNFCBVup9BV+EpFHzXVOR
         6tzaMWXIWAS9SxcUZRxMfHHFyrMFXk6kfb6sZOrW/kfe4gG3CBYyEBZR2OLsM+T6xQWX
         pd7BuXFN8RUAjl1OY8bG1Sz/FPlfD497dDXvfJMYuUED73BxZmiUsqiAd5jx1+tJBtKw
         +gqA==
X-Gm-Message-State: ABuFfoiy5RYHexy5n1pTrMfq2uOqJUMfHjgy7dvCEM1kbSR3D7Td3Nm8
        oeeSj3peeVBGOY/KRbXDlMXOa5CE
X-Google-Smtp-Source: ACcGV61hrLJe6Vh1+sdcXCNxSUhfr1YFWDxiRAC3Qp1ck9WvXcpgMlx1QPBYJveKh0sowCwKDUbkYg==
X-Received: by 2002:a0c:fa52:: with SMTP id k18-v6mr2522052qvo.170.1538099339271;
        Thu, 27 Sep 2018 18:48:59 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id x76-v6sm2282427qkx.25.2018.09.27.18.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:48:58 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:48:50 -0300
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
Subject: [PATCH v3 5/7] drivers: s390: Avoids building drivers if ARCH is not
 s390.
Message-ID: <20180928014850.GA10508@WindFlash>
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

