Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0834DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF82216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkqw+5c1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF82216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeI1IaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32978 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbeI1IaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id i10-v6so5095504qtp.0;
        Thu, 27 Sep 2018 19:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=az4VG2kDleDEIQbELh7WthCOA8Gd6LhdwtP9/ZvOfHo=;
        b=Bkqw+5c1GtHiTVolD17G662qwMMLu6vxrmwWh2P/Y4hiwFVyI6Orsow3gGZSLhmxYT
         ExXKENpxj2kslGkCCzlpmfw7IUsaXWyb3pM8+M4pjuC4v4sLgE6uJeUN8yceffxhh+xm
         Z8IkyslRHX5r1oqcmZkOFGtQxMcu8YH6GDg+S3vWsIhGSWn6dS6DdAaSRhPsCwwfDt3n
         X6iwRvwqLJ8Ks/epNqXlqCDuf52wLG/+MkR/DftJgY9jYTrwXNwf8T4G1bgbV5YFe/U9
         F2QMfGNMAHjM5Kvn1Zdfp99FqZICXpM9WR1H3C+1YzgaEz+HVLUbSdpDP7+G4NbJ5KlA
         n0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=az4VG2kDleDEIQbELh7WthCOA8Gd6LhdwtP9/ZvOfHo=;
        b=UjGAQZfFXRv/OgbpKpJ4+A5nNsrxKTD0ZcP1LMPTN4iso01feLaV8zX1iaEODyCOqG
         T4y0hlXjxKDAJBTEIo16fRoa0TmS1DcpJimH2o+7u+FXiJ/jWrr3qOAai2fRWDOtC4+w
         SU0HYTDZq9GphnthwtnRucUkyEUFTQ2ifOKhFsTG5KVEyZok55Etam5HXNe/bxzF9tsl
         GKMT/8ixGqLfkY/ZEXCJgpPu/WYwIphC1f937sThytjzxK1zL8NXXv4xs3nO10sPZPsa
         M3lG/OrUuzscJ3PyYbKNMXf8qYwoUdgGo3A52TO6pOMERJbNftXt/I6RC/EJ8uTaTH44
         QAdQ==
X-Gm-Message-State: ABuFfojdIFFDikLBvW+sywKnEFC/17Y7kkzGq4elRfmHK72xfPbvjG/5
        KmuI/w4SlBJKaOiNKTze1jzW/3i6
X-Google-Smtp-Source: ACcGV60JqKUvyyH5iwi4ShgSCQNQnWyYoYgDaS6HtK3L3Qd7vRwX82rXU/2sIVYulvbp6xibvDWRsg==
X-Received: by 2002:a0c:e083:: with SMTP id l3-v6mr3265594qvk.1.1538100526525;
        Thu, 27 Sep 2018 19:08:46 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:08:46 -0700 (PDT)
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
Subject: [PATCH v3 2/7] drivers: nubus: Avoids building driver if CONFIG_NUBUS is disabled
Date:   Thu, 27 Sep 2018 23:08:11 -0300
Message-Id: <20180928020816.11251-3-leobras.c@gmail.com>
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

