Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E50C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0236E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac59sJB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0236E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeIZICv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:02:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43244 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:02:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id l16-v6so15139893qtq.10;
        Tue, 25 Sep 2018 18:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=iSiVGxFWRigTCK+0CKFW0C5ujNtzh890wwlh0T9vG8s=;
        b=ac59sJB30DrbxZJjoJ+rzattfu9sR5VUA2craYN+DGKDQCnhUxIfAzIR2jer1ZAXwQ
         HXsjNiV8/s5Btwq4LH3XBufoxTV2CMBLnSzr1TTMxJeHIFtN9GUiMsNMuJw8avDObO5d
         w7r9l3nA6gX+yoTU/SG2pHuXUUt/KxIYhtYVGXOwx3hk95e3Q7qyb//5DfkMbxA3iOZS
         aARbB/QJniPrM96Hct/XGSdIIsJ1mZu8KzTMlOs2ReW2/JA2lQg599rc+xsmaDO1KkEs
         p4VAYQnp+mp6wpXMJNxDDkLHmc6vXoTaEOwn+8cKlrbquyE399I1B0sHTu4zPrj8Oq+R
         rIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=iSiVGxFWRigTCK+0CKFW0C5ujNtzh890wwlh0T9vG8s=;
        b=QSZSxoKud3l7qaSPLCYZ7N6XhWjjewndyhwtVCAjRXDX4u0YNImNQPWYeCtuYB3/mK
         n7g3ZZ7VCeGVHXYuYl5CWO+ckNjNXekfCZQMrAy8+Ad3NfrfZTT/sz2BQTdDeBnOYEGx
         mQvu7/t30Kwyy3FLe1+KWfnEeNw1WUxcNtwHBW5fAyU/EQlOXrnxIl168PSs8oOr7+EU
         3k06tz/8iKQkd5h6b51KkxFge5WJehIePye4bGf+SAlwRRrR6tNbiw3LwnSc7/OecoCd
         6v9Ert8ixOXlxZmZeS4FPm6k8oncdHl5G2TxsP+7sqKcLmONWCkA+mBeQMhOdBV9/e7P
         cESg==
X-Gm-Message-State: ABuFfogCNtAuQwBoAHU7Vr2h5jYcLQGq7yuEHdIcQjhJZzGcZg4I42is
        3zb1fDdRrlmObJlhNqfD9ak=
X-Google-Smtp-Source: ACcGV63kNjGeayLCfRcm2eJdQhEfh20YFCNNfNFEx7MzkIcZhycI/0OtMdKw88LP7iypiLaGdTIKpw==
X-Received: by 2002:ac8:1b2c:: with SMTP id y41-v6mr2946123qtj.334.1537926745954;
        Tue, 25 Sep 2018 18:52:25 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o7-v6sm1916563qtp.75.2018.09.25.18.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:52:25 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:52:18 -0300
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
Subject: [PATCH 2/7] drivers: nubus: Avoids building driver if CONFIG_NUBUS
 is disabled
Message-ID: <20180926015218.GA14964@WindFlash>
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
 drivers/nubus/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
index 6d063cde39d1..827301c4a84f 100644
--- a/drivers/nubus/Makefile
+++ b/drivers/nubus/Makefile
@@ -2,6 +2,6 @@
 # Makefile for the nubus specific drivers.
 #
 
-obj-y := nubus.o bus.o
-
-obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_NUBUS) := nubus.o
+nubus-y := bus.o
+nubus-$(CONFIG_PROC_FS) += proc.o
-- 
2.19.0

