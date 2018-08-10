Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE829C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95753223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3OsEgME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95753223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeHJFtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43706 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so3417058plv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAVAZUBTaKjbVIUDvSgHMd2gmsGSFlm/tSB8aHnv0iI=;
        b=N3OsEgMEryomyu2U0uonujem9/GDg0YBwkfYfnFG9AnYI3HGOmr877lI9l7K5VbYBn
         63mpY12XbnWBzoZPxSzz7RREB30fdomkhz89PYYoPlPyEb67I4TtrBqJSRblpBCm2h4Q
         xsl9tGNDoLjNljOdLFgVjwFECWk5Fsv0YkzsMp04V9QjP3+p5yuwgKBbfMud3v9Kv0m1
         VCHdzATvyDS0N4Q3PuxTlhvsV0f1y78Nu341a9g+uq6XY8tJS+yLFiSqGn2kEz5tQ/lk
         0JS9xXnVpmMRmmf3yu6z7/NH69GA7ooInxYyOeyFKGRKeL0vVKI9Kr2qR3QIDiC/sdIf
         OWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAVAZUBTaKjbVIUDvSgHMd2gmsGSFlm/tSB8aHnv0iI=;
        b=RWgxMnhTtTqXE3wSznoB1Tt/0z3jNHFpBgwDUFM7ZG89qI4XZg9trL0xhY4z3KMAj+
         y0QVrSvWJ5mAb9495og1/ZfJ7OnZDdwceXnTeHvYGgDV/VkRRZdmxsNI5rsEB+ZELB4d
         XbYAY7FDUqQzHFwszxNaiO0KwEZ37sFq+RAI2UKuwX8Q45oqR7Sw/EQUCgDY/4j15BqK
         L1h7zLdnPs4VLCWv+d+D5px8VZUupr7tl+B6GjDq+jXirAj2g+2cDDfyNb9Vg+pjdJnp
         7+yCYbKoGq33KlGxi8928JRmMTRheXTheB+3/55kEpG1LOs7q1CsNCFoImQYFhbdU6vh
         5xjw==
X-Gm-Message-State: AOUpUlGqsEAfcUoGG29x5HFLhRa3dHPl1KIzaruD9Yrqj6TsS806ZMQn
        eG4jiN9PZ46xLZCrxzII3f0=
X-Google-Smtp-Source: AA+uWPwzIpH2G8o75LUnwMg459EadCbE9KWA9qu6FvCn5OrJKitF+28ZhJrFeDLrPxzZeS7MgExiqA==
X-Received: by 2002:a17:902:d807:: with SMTP id a7-v6mr4482721plz.3.1533871284601;
        Thu, 09 Aug 2018 20:21:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:24 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/16] staging: gasket: core: remove debug log that could crash
Date:   Thu,  9 Aug 2018 20:20:57 -0700
Message-Id: <20180810032111.197743-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

A debug log in gasket_alloc_dev() is issued regardless of whether the
device pointer used returned success or error.  The log isn't that
useful anyway, remove it.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index d12ab560411f7..37d14e30ffa21 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -234,8 +234,6 @@ static int gasket_alloc_dev(struct gasket_internal_desc *internal_desc,
 	dev_info->device = device_create(internal_desc->class, parent,
 		dev_info->devt, gasket_dev, dev_info->name);
 
-	dev_dbg(dev_info->device, "Gasket device allocated.\n");
-
 	/* cdev has not yet been added; cdev_added is 0 */
 	dev_info->gasket_dev_ptr = gasket_dev;
 	/* ownership is all 0, indicating no owner or opens. */
-- 
2.18.0.597.ga71716f1ad-goog

