Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D7C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036221708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs/Os8vN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E036221708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeI1IJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:09:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36751 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI1IJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:09:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id a85-v6so2923458qkg.3;
        Thu, 27 Sep 2018 18:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=hs/Os8vN3OFq9MhYXzvai9Zxda/zMLh6bwiBNraISalZS6CVFd8vhXBUZGmyIJgUT8
         JxnW+j1hk+G2mBMe+UKL4oWMBWv+MZ84aFzltqlJ3SnPDoZcW7E+FcqH1khVTzgoiIPv
         xS/ZVGkxSvYHmbRJoLfQ5wESaanynBuxxZCgnRqeR1w2q+s6OIyGqgoxgqLpd3XCGdPo
         M+U5rE1Se5EfIfydu+QLBTOzXNorkVTCG/N04yzH7Yi2zZ+BmjgsPd4mcXkm4K1zmvwJ
         MCM7YlpD4/PuaU2B20sr+tZEgCveDt6CCdbwhxwUyYRoOQOl20bfXAuFjLQ/Y2U0rAK2
         p/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=H/822on9nxIRZu0Jv5CBc02MBzryjIlS1+1gAVYjOdWQOPPJk3hFPmYzBG9H5YDQwU
         qIMwKCZftmYkUFvBW82JU5+mQajF1ou0etWAVFc+XxNOLAd5Jb7aANEjQ2syjcBGAaL8
         iWWSc958ZxYBj9ovHyVZgnjl70gKkjrkhiuxqJqaeWgdni86FJLi0nTnXdtwpZm9wGop
         jENs1KHsTQW2w3g0LDwMs1WXdVCx5irLIvD74qpsQrw9H42nsm0D27nkl5qNLPoZ7jsc
         wGeL9wvojfNtlwcdF5sVOhVzADWcWksjLr1NW/FffWrcOcvYmLwWcNbzjKFwWkuBP6dT
         GlJQ==
X-Gm-Message-State: ABuFfogBOD0o1oQXWNsAydXXVGGJwk+ITbmyT0ouLna+6ljxHIURHwIT
        HyICU0KV39rfOLvIe6CYqGaFOKbo
X-Google-Smtp-Source: ACcGV603lpVz/o4820HBmGUtKp8uzyqtNxbevgQamUv20sDKfLg9SsMbQCzkxF7pgpZLuFppat1rbg==
X-Received: by 2002:a37:8b46:: with SMTP id n67-v6mr6674160qkd.262.1538099321790;
        Thu, 27 Sep 2018 18:48:41 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y7-v6sm1931829qkf.38.2018.09.27.18.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:48:41 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:48:33 -0300
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
Subject: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Message-ID: <20180928014833.GA10505@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids building driver if 'make drivers/parisc/' is called and
CONFIG_PARISC is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/parisc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
index 3cd5e6cb8478..80049d763aa0 100644
--- a/drivers/parisc/Makefile
+++ b/drivers/parisc/Makefile
@@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)		+= eisa.o eisa_enumerator.o eisa_eeprom.o
 obj-$(CONFIG_SUPERIO)		+= superio.o
 obj-$(CONFIG_CHASSIS_LCD_LED)	+= led.o
 obj-$(CONFIG_PDC_STABLE)	+= pdc_stable.o
-obj-y				+= power.o
+obj-$(CONFIG_PARISC)		+= power.o
 
-- 
2.19.0

