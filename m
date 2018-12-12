Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A451C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC342084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544610367;
	bh=Pv8tqM/wBE4oZrcPu2iAXJ2UehKEp6g/3QiP//ZWdVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U0ozvV88O+ikYpPLbvR69U4EDbUwiHh8xuvhsqPAjbXGvN0Lxwt0U8KeRpMw4xM9q
	 YUrm4E8F5/u/qr1kgZdmKOkE7bjWEwi/nXC9QLZQTutg3L7aAkrov7tBk7d7Gjyv5c
	 Dp5hSKQnmmzowrHCOzdtc46ZOJSMjvHcLKJ29+P0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC342084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeLLK0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:26:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeLLK0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:26:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52091A6E1F;
        Wed, 12 Dec 2018 10:26:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C21D5E7DF;
        Wed, 12 Dec 2018 10:25:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 6/6] tools gpio: Override CFLAGS assignments
Date:   Wed, 12 Dec 2018 11:25:37 +0100
Message-Id: <20181212102537.25902-7-jolsa@kernel.org>
In-Reply-To: <20181212102537.25902-1-jolsa@kernel.org>
References: <20181212102537.25902-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Dec 2018 10:26:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So user could specify outside CFLAGS values.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/gpio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 240eda014b37..6ecdd1067826 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 
 ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.17.2

