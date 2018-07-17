Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF115208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g42ZOam6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF115208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeGQCkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32832 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731605AbeGQCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so8219741pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CceS94XGce7hZjlMr8K0ztNYFq4qFu17/SLtuWFd9WM=;
        b=g42ZOam6dMDP8C/7z/xdjWOGjhrkeM+aGgibdQFkIQIN+ns1aYS1f3kr04FZv+OlOU
         /R6grIpArXqDEuBnOs/bM9GzPetHM6NnMrcNE/G6B9q9qWhzbhhqB7yrDWef1nPeSMVA
         fMVHueH2UxjCkOazwrDe9DBgppty4XGQ3tE8mvg/FoZ996KilVnu+ozNM54kdSVnYYNl
         reBzpBKlbkxxJD+1PkjJuxfwIMKDIr0PG9IKyLb/YtOksayyfUsMEvvat3XM+Q174iiL
         m8J1tlwdZ7AO7CPPHoGTgQNMW+d0wdx31moQMlNrBxLA+tVJc+kqONtePaJo/f+F74Eu
         41Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CceS94XGce7hZjlMr8K0ztNYFq4qFu17/SLtuWFd9WM=;
        b=ibXbRbIvq375sOfQvOpp4eBL8ohyFD19O8XoJSz17AhconGMhT5A5bZIVe1ycAMD1i
         pXzhgARmStDg1ixtDf5gAuJ6rBQ7W7uT+ygmu1j8nmuyGeTiIxEJtfoxd3Z3/hdZ5Nn4
         UIMQ8wLadpCZOddqPZggFiRGCf+OAADa4VWkOGx0mtuTZ4toxeBKzZqnzHmFj85NXMM8
         Sj6Drxk9Db7HElAC19KI1PcsBVVyFqNarvlBtvcU5Ay9Ux6YxtS4Zuj4mULJpqMMTXzY
         NFhYxIwSVPdP9pS6Ow7KdM7PNspKbZrvfARS7PRIeUiEbIvzbkW9d26U2+KYyXeMJQmE
         b0rw==
X-Gm-Message-State: AOUpUlGnQo4HLdVuO9nCeEIGVGtFl53u6U9c0cLUr1sjmN6Rv8IEQDy/
        NIlUidzuk5wMWSN7bwCfEJM=
X-Google-Smtp-Source: AAOMgpdBgIf8XS57AVKSlDHnisnGLizyg2NFtJS7f0yyGIhgXy9VmTpIpMJOhkMG5xEeBGWzrTC5lw==
X-Received: by 2002:a63:5758:: with SMTP id h24-v6mr17504415pgm.432.1531793399948;
        Mon, 16 Jul 2018 19:09:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:59 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/32] staging: gasket: gasket_wait_with_reschedule use msleep
Date:   Mon, 16 Jul 2018 19:09:05 -0700
Message-Id: <20180717020926.176408-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Replace schedule_timeout() call with msleep().

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 803566229bfcb..442543573f6e9 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -14,6 +14,7 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -2097,7 +2098,7 @@ int gasket_wait_with_reschedule(
 		tmp = gasket_dev_read_64(gasket_dev, bar, offset);
 		if ((tmp & mask) == val)
 			break;
-		schedule_timeout(msecs_to_jiffies(delay_ms));
+		msleep(delay_ms);
 		retries++;
 	}
 	if (retries == max_retries) {
-- 
2.18.0.203.gfac676dfb9-goog

