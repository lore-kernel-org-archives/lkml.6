Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9340208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQjo9PSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9340208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeIZICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:02:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46908 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:02:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id h22-v6so7671579qtr.13;
        Tue, 25 Sep 2018 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Ig8aYG+bq8ur+x3OT7VAaBFbnTbtP5co/zowmafEj4M=;
        b=SQjo9PSqRnFTjGgH2n9oA90lGG7neexgSwrXrvCDWHhqZXulbsfqV472Cw11m8SPK8
         BjJd/FMlgY0rTFOgdNdPHMCK2GOTm7AXiFW/e790cCgpelFRkHVJqDEe/uWxqA6xgoJq
         eCsQE7gMdnO6RL1qhkksuhJXS5pDpVKi2xbpml3HGy8GBIhAGTm36FYGjVYY9zU4w80F
         gA9P7659H4KMUB/ifH7RrA07B7R8U3nzAAkuNhgxYLQl21KFaWQt+RJ7fDGij2f83+Eb
         tUc47c/yq9N+8Y5255TvYqv/E3CcjegEZwb2g3BXOEiQQp/KSl5FH+QA4gbGqXkfzEZQ
         02nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Ig8aYG+bq8ur+x3OT7VAaBFbnTbtP5co/zowmafEj4M=;
        b=ZTcmP8DPGW+U8vWs/CIN8wR8pjcxHL+DA+5s1rZqcyLF2h8frVL78gu86/OAEdEhqs
         4MrSPbWyh7lEA7BuBdEWOJsYzGQs2Wz0Q7st88f8SMkuF0+HUSRMgzdU//9B22/sfjdu
         lwSpM9AS5GSbRw41kp4xLPvaV4SufknlAcjWAXvA9JDINzjtgluH0YT5gWEs8ZY6eN+Z
         aYf2VwuFQ8bfSXhEvQCzbpgRnn6FcAuLDqng43TVJOvTbIa02byaFggpPf1t0Vwn6m1n
         RY//LMgnP1gA+vqXkTAXJ18EqbWEOtgwrfpvwO8tjIYuK1Lsv0zZcOX3T2cxAIRhI2yN
         BvCg==
X-Gm-Message-State: ABuFfojrau3e323FAlt8UzMCX/w5HGK/bzadWJE1HeAy07+korqW3xbv
        mC87Jv3MY69qgdQgjj8CljQ=
X-Google-Smtp-Source: ACcGV636S5TB9/25jJ2RWfkFsJTbA6+u+VGr/eGvOWtifDzoZFCv60W+8QYuMsVuA8GXHXtQoNy3+A==
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr2771752qvm.6.1537926731832;
        Tue, 25 Sep 2018 18:52:11 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o79-v6sm3012466qko.89.2018.09.25.18.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:52:11 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:52:04 -0300
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
Subject: [PATCH 1/7] drivers: dio: Avoids building driver if CONFIG_DIO is
 disabled
Message-ID: <20180926015204.GA14952@WindFlash>
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
index ae92d17083f2..f5cffe232448 100644
--- a/drivers/dio/Makefile
+++ b/drivers/dio/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y := dio.o dio-driver.o dio-sysfs.o
+obj-$(CONFIG_DIO) := dio.o dio-driver.o dio-sysfs.o
\ No newline at end of file
-- 
2.19.0

