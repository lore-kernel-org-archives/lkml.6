Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1845CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A6B2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tza4NE0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A6B2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeI0H4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:56:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43540 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeI0H4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:56:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id l16-v6so1061541qtq.10;
        Wed, 26 Sep 2018 18:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=az4VG2kDleDEIQbELh7WthCOA8Gd6LhdwtP9/ZvOfHo=;
        b=Tza4NE0h50eH0auHPhztiJ+Hc18T1byxhVMJvrgmR41lBE8Gsz+Yyq3rQ7Fm1WeJle
         6BEgR6uSENMVaMe/EdYweeoLb2q2ly7FXiBSrVm2O3k2HG0XJwM+wNanBk5J2VqIMMzU
         0ISvQW+JHh3CzxBqEi8yMN/qDOgr0ebkEhoId+I7KHwuANY2LF8mAloDJ3p4l+pwQJtF
         d7tcohjY8Lf6vIJxwSp+EYR3ATRgOVEYplhMeS/OimFF/pUnA5Vz/OUvyjBhC/4IJMER
         4mSgq7rhEddv8Yu2JUABr2fJb5Lj7IDQiIZX6ZEgKP5992UfO8Por5EC7yoa1sFnxZr2
         EgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=az4VG2kDleDEIQbELh7WthCOA8Gd6LhdwtP9/ZvOfHo=;
        b=uKPhu0WDlbHGvJ/kxGoqb63+htaEv5r2ra/JNTD8cpk4SH4k+XRlVYKNb5zNmR6Fwr
         EnzIQmoYfsxuUuunOJQKpQrBXlabyt38R14QI4Gsaw9Zn0ngDxIZdGTxB1Cr9yGhySsQ
         V1EBtVE9aQJA2SiUZStSPXczDDkE+GiyL1r/IZBgnYMaEjZCb1F7qlWzKl9VVWBBJOtA
         tuYhaRlMYnuIXvKSsSEuBFI2ufWxs1yNy0oHr+C8+FRU2cle2ow3aLnaSpfqV9XHQQ6H
         gy/1DqhyPtiUm1q5hPP/vNzR5RBpTGfzbsD+t8CgHCxEPfCyRerBwkywP8PMp4E22FdC
         nlbw==
X-Gm-Message-State: ABuFfoitayanSTzwLUocW6anTIqKZbKNOrFQech0IBk8m9rdCp7QZG2I
        NQu/TFBwWkv5m1rYds6qDO8=
X-Google-Smtp-Source: ACcGV60ZCmvvTLVdxyo92oRKYJ8V2Bh8kTpd1D9LF4pjui2+sHZERtQvn6MCnlk1mVOnrKrfRQkCFQ==
X-Received: by 2002:a0c:e80e:: with SMTP id y14-v6mr6394038qvn.23.1538012428501;
        Wed, 26 Sep 2018 18:40:28 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 8-v6sm488422qtv.38.2018.09.26.18.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:40:28 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:40:14 -0300
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
Subject: [PATCH v2 2/7] drivers: nubus: Avoids building driver if
 CONFIG_NUBUS is disabled
Message-ID: <20180927014014.GA8972@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids building driver if 'make drivers/nubus/' is called and
CONFIG_NUBUS is disabled.
Avoids building proc.o if CONFIG_PROC_FS is enabled but
CONFIG_NUBUS is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/nubus/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
index 6d063cde39d1..1daa51217e95 100644
--- a/drivers/nubus/Makefile
+++ b/drivers/nubus/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the nubus specific drivers.
 #
 
-obj-y := nubus.o bus.o
+obj-$(CONFIG_NUBUS) := nubus_all.o
+nubus_all-y += bus.o nubus.o
 
-obj-$(CONFIG_PROC_FS) += proc.o
+nubus_all-$(CONFIG_PROC_FS) += proc.o
-- 
2.19.0

