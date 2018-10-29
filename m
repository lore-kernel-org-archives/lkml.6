Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD64720664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD64720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeJ2VFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:05:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33249 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbeJ2VFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:05:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so7553969ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PtdAGCoo6jxbL4lsVf3hTNw7lOjeF4+cr4UKTLomOsc=;
        b=UfdH0QKQTh9SOKxLjhx57EJY/g4upaq1WaHHMXVyn9Tpf9DnIONLlzKGWyr0Rf+14q
         WPnDkZ71rRtXsq7/LElJEUS12YUAg034eB1aYoxNflFZPCbLPuql8NnQj4QSHipHGiDF
         Pc7xcIxzTJfXsnYMBFm2GaBd4be7N8oczIrlb4ko6w5qquoroZDAYGjVpS2DPTm6fOuf
         88RYBQ2l0/Pt3hQq3U/Jm6/q89KkIe2R6ohrq91DB2ooD/7s91shLyc6W8eQQFajOjtR
         D54uWrCxjTNvTf7rs7h2VfNfLLtrp+VNWq0kJsebhpqKEDOOWenKlIWu2caEzymkEP/t
         wVXQ==
X-Gm-Message-State: AGRZ1gK28xKQ5wDciyN4SH+78lLeBblncTuH0VyJVJjDz2ho1f9ZgZMu
        DZVHCdEl2HptMOjjpRUU7t0Rm6gw
X-Google-Smtp-Source: AJdET5c0qMxA+D2jmG2upTOZF/JONGbi4aN9bkpuj8HOvuuaesHtHZxeV4wUNUC/MhFb7RZxvtmYMg==
X-Received: by 2002:a2e:8845:: with SMTP id z5-v6mr8816576ljj.98.1540815402909;
        Mon, 29 Oct 2018 05:16:42 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c22sm3014058lfd.88.2018.10.29.05.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 05:16:42 -0700 (PDT)
Date:   Mon, 29 Oct 2018 14:16:30 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: add missing linux/of.h inclusion
 (deja-vu)
Message-ID: <20181029121630.GA11183@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-Day tests found compilation error on x86.
Driver won't compile on x86_64 as "of_match_ptr" is
not found. Add missing include <linux/of.h>

At some point this fix was lost. So re-apply it.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 3a47e0372e77..7ba14dae5848 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd718x7.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
