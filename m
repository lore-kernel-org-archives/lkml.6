Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CB9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03221733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxe4wfc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC03221733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeI1IaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40159 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeI1IaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so2925735qkd.7;
        Thu, 27 Sep 2018 19:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=Xxe4wfc1pjms+V4Wh7sSOGixTWY62Hc5ILFnE6egN4xy1B34Nv9AZ0se50Qy1yN5T2
         Ra9Fu+mEJY51Ttq2Hq4g3fIEA7V9KWuJg6BoBppVgL45RihcNCIl0toX/DWeWkEPr7I4
         VRo13ugKRs2JNN+TNE1uwOTpRsY2qvdTqUzLgG8VJghg8kIThDOOS6zhJsiOJjNWa5//
         mo5XC+wPKRllMDPbj8L3SgZENVvA3VmKk8wlnKqogFVvVwqvrdkUU0n+QzNykd85fDWV
         /jyfZ5TGOehX9RdUBCeG27LEyMCKH9sQIE6Q0fHITe17vWcvAOy7EyBTiXRAttR04c0v
         7F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=JnJ/axVEYdI3sZgARQqpOCwHui62oNOx0rSBd9gDhP5SJL5HgqsJoit0C/KNZnNm/Y
         iG6SXGFb3uviPvQ1vQwdyWysD2wWjAlX29ucIbQB4fagmL2U3Juxm0lz2gzcNSd1kWBH
         7wmoWvLTFYRt49ontvYcgu1RD1VHHuAH1GdONp46vNM0UNIA2Yyyz+yyGLFNGRQk4jnQ
         on7MtbcKijEKcd4ekEa6kYinquLs467R0oRAWAS/XH/fYedoJP5K3fD5c3Q/Z6+QivF0
         a/+IiS5gpUUAaj0MTTYEaAiDlDtb+GZJRpl4el573zGZNYXohYB3IZWFsDeQ9k0r9Ldw
         O9JQ==
X-Gm-Message-State: ABuFfogeW1/ll7boGn6PBMEW/azqFz7efeOP0ttZbLOl6AsNwkAgaftc
        coo5EjZI433vJ8mCBB8TmKk=
X-Google-Smtp-Source: ACcGV60t5s1FYvZ9OQp5nqj5w14/qiB6umyp/Lh9lGJzAOV2ktnWH7iJSuFbvXEISVkNU9bTyahJ0A==
X-Received: by 2002:a37:b101:: with SMTP id a1-v6mr10144828qkf.222.1538100532874;
        Thu, 27 Sep 2018 19:08:52 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:08:52 -0700 (PDT)
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
Subject: [PATCH v3 3/7] drivers: parisc: Avoids building driver if CONFIG_PARISC is disabled
Date:   Thu, 27 Sep 2018 23:08:12 -0300
Message-Id: <20180928020816.11251-4-leobras.c@gmail.com>
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

