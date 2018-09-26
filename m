Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D855C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6021480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEQe4HRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F6021480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeIZIDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:03:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41277 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeIZIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:03:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15-v6so9502499qtp.8;
        Tue, 25 Sep 2018 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=+eFJ1SZwtq/lj7hGmmiR7y5o0Ud3EAoYPRUw5Wruwyo=;
        b=uEQe4HRU9RGOF5P5HZS9IbERSubF2n/90djAfUTJGrq8A82svvE6WraqzgzJWnC3Zs
         JkOM5xeTlbKSxiIiz8iwlZBNv7oS1GpFEXlu1hEQrJtUGL39fpi8v27PCRmWW/6KNIhC
         LG9yhq5tnOHU4K4YYqvl7ZA1FssUHrlNZZREdG9Sl4ZW04nN0+83PrLJZxnIabY2qSz8
         CZ/oNFVkTYSsUKaPAWKvGqhSfy7W6sz74D3AhpOHzxcpoaKZ7m0TJOUaVodLWXqPDKEc
         fM1vf5G5BJYYpYv6wtTj8SnTLpySDfTIN/4iZ4e0RjyInqpY+8bUYiwUjuOxOyGgdvRI
         hihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=+eFJ1SZwtq/lj7hGmmiR7y5o0Ud3EAoYPRUw5Wruwyo=;
        b=ppbwoWXAq0emgeOyvaoTkHqfs0gcYmurwfp76/1ZL2tfB67WspuYEnzrIlYLVhMtBj
         KOS+LSbc1ajI0SbIrWJ/5cmmdWa0XR/swxngNpIMWauhMpIYbgi46Z8/muEMj+Uv1EQj
         q3qZrhRtrRpg61RtgSYQfst/wzJUIRifXCQTjWUgvN1pHybZvOy47qnWxZs9oURUl9Xd
         UWPB3znexu0VczLzNOMh0YD6aJGhJXAWDbxJOShHWYW3UjHNPAkdVuz3D+jnUbqStojs
         JrFSMJurbNZB0PG945Wg1GfG1MhZZKG3f1b5hR2bJ5lTiV9bYg3btyIWozhGwBNuG0NP
         bZFg==
X-Gm-Message-State: ABuFfohhBpd6lRlxRI/8gXyHvlNnyCBUc4jZUIiMgHIEHjvg56eoXFeS
        W8M8oSf0v/CkvY9GSunGW2k=
X-Google-Smtp-Source: ACcGV62/2EyUz7I6ZZIrwXZhhI5uM44MlL2YP3bcoBxqusqqsWNxgLaFyaSWewpvW7LQDarJmK5sHw==
X-Received: by 2002:a0c:c119:: with SMTP id f25-v6mr1894741qvh.219.1537926770463;
        Tue, 25 Sep 2018 18:52:50 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e65-v6sm2244539qkf.39.2018.09.25.18.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:52:50 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:52:42 -0300
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
Subject: [PATCH 4/7] drivers: zorro: Avoids building proc.o if CONFIG_ZORRO
 is disabled
Message-ID: <20180926015242.GA14980@WindFlash>
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
 drivers/zorro/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
index b360ac4ea846..4e5c7045ac7a 100644
--- a/drivers/zorro/Makefile
+++ b/drivers/zorro/Makefile
@@ -4,8 +4,8 @@
 #
 
 obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
-obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_ZORRO_NAMES) +=  names.o
+zorro-$(CONFIG_PROC_FS)	+= proc.o
 
 hostprogs-y 		:= gen-devlist
 
-- 
2.19.0

