Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE24C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535A721480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmhpj/2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535A721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeIZIDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:03:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36731 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:03:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id e26-v6so3473968qtq.3;
        Tue, 25 Sep 2018 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=Dmhpj/2lW0bjrKhvWrcqZCGz0PJ9R6TwZR+qrE8GZsiRUlnAebtJuen3GXKVB9tJRt
         qLg6dFqNsrKU5BIq4jpFRQIaeWiluWCsOm1+yqU5OVRLnmZQRPiUscxYOEyTIDMggJRF
         3hJI3pSvsyPTuoCqUEmMz0CG7Nne4ZKyAA1IHRUEBkwnrwtxJkAZTTffDN2bQwvZjSs+
         f2aKUWplpwFdWENlbBBiED5NHnI3y5K8sS7AQzrK0NjTFDc8BoJYFy32OhAjOT8BS0FP
         z1IL44uo6v60LdwujOJEp/Io7rjj0TW9iKb5UfNH8uDI4cKESkHTNx/hKSVhYNqZ96Xj
         fHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Ml1FFJEZov3NZzRMfIOgz+x2FcVyTrOzctjRuk6MfEU=;
        b=Gw+ELitfMEn/3KKakoSaXWC2WtGXLscSbom7cRwAOPvBtiCaEPnW3gtFzgtmrZHA+j
         fGMEwnV5NQC4WCdaBrF5KDRTCOF/RKx4X5urNdz0EQi5Ejli4fpPwS2Vg8RiAMGnN+dO
         E3YKtyDopyrp88RMVod0hnY5/zsNTbGS02cF/4b8+kOdD89PBZrRaJr0yA+Bd3b5Illh
         uI9FrnQhFb36l6Aefag8VQfkjtPtiiCaBVNTbFDqt0KxXMl6GhjkjIQFcNwijc9Y335x
         PsLK8OZj+0CI7fhzPsKR+xc0B0t0XIl1CZFbZJ/fWNV8M8Adv12QHmV2yqKD850q6oNN
         tgng==
X-Gm-Message-State: ABuFfogQ3emrarrD1+sUDOXatxKLGLT7SKwah2Rg9Aci5whDLiVf/Dxh
        u0NkA9IVjhz46x48u7nQJyI=
X-Google-Smtp-Source: ACcGV60FmmK55WhK5+LX8SYxaBUTEEF64A+qTfE3IMhoH69gsRriKk/Zp4fYlCQoS591DXs5dEpVcg==
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr2923762qto.188.1537926758264;
        Tue, 25 Sep 2018 18:52:38 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id i32-v6sm2490215qtb.21.2018.09.25.18.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:52:37 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:52:29 -0300
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
Subject: [PATCH 3/7] drivers: parisc: Avoids building driver if CONFIG_PARISC
 is disabled
Message-ID: <20180926015229.GA14967@WindFlash>
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

