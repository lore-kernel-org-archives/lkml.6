Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1DDC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8518208CB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDt8laxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8518208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeGGVDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:03:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeGGVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TUFQWOkeTcGmD4gNXphKb6rRWlV/7/RryKCJoo4rsR8=; b=QDt8laxuBTM4m/WkO+O1pRESqu
        6XTh8a6zV2vV7W0JZs5Hkvy+BK+gFciWqoKmkDw/fIH56JM37uEazoRTLUoVvhhbuG2nRlsGA1Mgr
        ZQ4e6CubZNYZuVeg9gJP/03azDoRHQMk8CnPTuLzTdCZwB89otEzwBhmHeRx95dt3cDUEhAppIiex
        liTESVdEaRe3bvX4EotKgUOqRvrMmyKWS/bbrbxtAqEttNG9Z0YtT9g/zAHhY8A+VjGVO8x0A27zC
        hBP3Y3XP2vWAIPnScs5ca5/MZK03PAryWU5Ra4WL5ndz58FKHCWFV71Sr1sY1pL0jkhDNyBtF6Dya
        +BuozCcg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbuMg-0007k7-RT; Sat, 07 Jul 2018 21:03:35 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH char-misc-testing] headers: fix build error in
 arch/arm/plat-samsung/adc.c, add <linux/mod_devicetable.h>
Message-ID: <d5b428bc-981b-d2e5-b89e-3042e3c98899@infradead.org>
Date:   Sat, 7 Jul 2018 14:03:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

arch/arm/plat-samsung/adc.c needs to #include <linux/mod_devicetable.h>
explicitly since that header file was removed from
<linux/platform_device.h> (it wasn't needed there).

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/arm/plat-samsung/adc.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20180706.orig/arch/arm/plat-samsung/adc.c
+++ linux-next-20180706/arch/arm/plat-samsung/adc.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/list.h>

