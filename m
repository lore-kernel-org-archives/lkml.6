Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F073C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACC921733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVpcQBTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACC921733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeI1IKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:10:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42307 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeI1IKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:10:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id z8-v6so4983824qto.9;
        Thu, 27 Sep 2018 18:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=e059U9EVFIrXzIdKY/vX6Gpjk8Vp1fLvpRknwNsZouQ=;
        b=KVpcQBTjrlOH3LKyZy/zbEGly8Glb8ZUMar4j3GtDF4PXif8OlTAR23frJF4FOlroL
         DPAgJ0q3Wn/vUy7tRlpEP/4JRZIx12wPrAY6utr+KWBWmRlpPILnlwuyazwsj9r1V3wK
         MBz7M/JwKMj7FJ+6nIquQdeCWDCZmAS81u+txvDi9l2DR/VX7bsNi+UUlRn1VBpVDNrg
         X8JGk4PWrdE6ES0GYvGrpMxV4rIwdWCGRhb5rYroqGieIRqsvuqhpfGNydPCbONCElOG
         T6pJv8Cbv7wcedD7SyfMzapoQPNUb3dRUpZ7IkNLtOwZ21iiNMXA9exZiBb0ecwR+kOE
         paUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=e059U9EVFIrXzIdKY/vX6Gpjk8Vp1fLvpRknwNsZouQ=;
        b=AjPgG5d54Qm3mwyfEvfP31Z8Vxv5E3yyrDNl50aI3BFr/fjkCPFUeUTx0ucbURWfYs
         hjulWFDPy1vGf2xlgIMgUjJIwrWxb/KcbfgwRwSyckbCXtJ42xnDQ5FMH5xai4CAE6vV
         Lqnk5Q1CE4xBpa44CDbmSHQb7SBDjV8XaxciKepMeU1jczJumfemmofSfLhTf1dDrbVD
         Pl0QULf8wy5ftnMBTQ6MyrIfrGDLfWQMSHAnDLNQzmiZZ5NhlGS9eOiVfLLQUFa1r+N3
         D6oeBRdHmsMp3szZQ1Sip/Jb4IyXBNb7ps0uyVEoHSxfED55W+2Nv5fkp4i+Zn7y1H0P
         eWqQ==
X-Gm-Message-State: ABuFfogARZ+DAv8o128F7EK8dApJQ1T/LOOFTst4MzjzrIfkPGplO9Uu
        l7pqNqogaeRoVZFswxKLFXo=
X-Google-Smtp-Source: ACcGV61VDW3NTTEg77m4SCYJ6SFUyjd7eIOUhdgj7kWVr6o6G0xd4XlE6VbNW+8u0wG2v6lGm7LMew==
X-Received: by 2002:ad4:50ce:: with SMTP id e14-v6mr9913618qvq.232.1538099347670;
        Thu, 27 Sep 2018 18:49:07 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e67-v6sm2053234qtb.33.2018.09.27.18.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:49:07 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:48:59 -0300
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
Subject: [PATCH v3 6/7] drivers: oprofile: Avoids building driver from direct
 make command
Message-ID: <20180928014859.GA10525@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates new Makefile to avoid building driver if
'make drivers/oprofile/' is called directly.

This driver is usually built from arch/$ARCH and seems to have
no meaning building alone.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/oprofile/Makefile | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 drivers/oprofile/Makefile

diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
new file mode 100644
index 000000000000..361867ec2338
--- /dev/null
+++ b/drivers/oprofile/Makefile
@@ -0,0 +1 @@
+#Does nothing, since the source is called from arch/$ARCH/ tree.
-- 
2.19.0

