Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C882156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1VkSiCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C882156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeI0H4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:56:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43437 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeI0H4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:56:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id v18-v6so609879qka.10;
        Wed, 26 Sep 2018 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=j1VkSiCnXyZfqRMkSeVVgvvQLIikE6B2suoNKKz1wXo04RnDKfr4ACq7zBtMu/5oZY
         y1fyXZTWcNCHwS7+eodRGwJo2AitCsbpBFPWTYK8dMuzjkn+dAac1kmCHptrWdyBhwTJ
         D0OMQxCi5ag8Ac6o4ICn88KDI3YHm89Z6Z7px+61LKlCjQkTGHeg7A+veHj0MSz7zNgb
         tJhjtD5Fes7lP3VOBvPIILN0RkHHmf8xcDC8yMe8+DnzoAuCcxcxrAQDWBrGBTTy+NO1
         KXga19G+gqoT/7838MCeHIDJuDwl2vaE0nxMI7RcuhwFAOgRBPYeGxWz1VgU2byK6RK4
         5rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=OD6C0M0m/mFsP8KBtkT1ytprkQdPzAYV01HSJ44BXhIOryuHkS/UeMZEb2Z2i5CE9E
         qK2ScckHN2bdloqr/f5U6g+4f31C070so+gXm6Oe8kw7rXjATEExgxiUSdVILYeuQIcZ
         Evhk/HsZ+cN6FYoVC2b92qdjYPpDWEvD1MBC37gG8m3I81rTYIzkgPDF9iLyEeID053N
         mmGTQE0oLMuIaUljKFXAHZ3RgsK9R1f2xxymZd/fvIp2JiY/kmH1xOIQI6iJNrC+xva5
         8n9jH355yg0i4CmPR/0YcXFDIuBjh36gPqHFoMwTeRHkq6m2YPvu7e4E0BWZY800l4IP
         iZXQ==
X-Gm-Message-State: ABuFfojXXlTo+n3OVKV9Ipv0LAP7i9Sj/G9R6vvwZDHCuvraQT+7oVgt
        xlDPkU+P0iegqqjaQSC+zk+9lgvI
X-Google-Smtp-Source: ACcGV600fnGzHAFuatXk3BE872ZM2CO6bbt5pEab81Vus8WP68KAfBz7h/a238QavPxTAA3imkd65A==
X-Received: by 2002:a37:f42:: with SMTP id z63-v6mr5847447qkg.132.1538012448900;
        Wed, 26 Sep 2018 18:40:48 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 141-v6sm373802qkl.31.2018.09.26.18.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:40:48 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:40:37 -0300
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
Subject: [PATCH v2 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Message-ID: <20180927014037.GA8976@WindFlash>
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

