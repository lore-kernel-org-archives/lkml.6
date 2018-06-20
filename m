Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33187C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C32204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G1sHogQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C32204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeFTS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:26:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42233 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFTS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:26:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so223553pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2Guo6sOiKwQyHKcsCqSSvBpyPjzHBN4yiS48IleWVc8=;
        b=G1sHogQE3d9JBgPEwYYV8DrGbMEJinUvvlSQxluLHvGnAQ2vBuzHRhLa1euXAYlS/y
         SNLo9nutHvjR+dy7x7JGv6SoX8jh0VgnJqPNEryL/waTx+pl/msFGwLEHVSUlIE3uLvW
         M/1alR2D0nNLZt5DVndR6LHrv9ZFmy0fI3BgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2Guo6sOiKwQyHKcsCqSSvBpyPjzHBN4yiS48IleWVc8=;
        b=RqoljShP1QHgYTYrMOX6Iu7NoX1Le2ro7XoekdDMR7jSCLD9s3FBdy0TdLRUf0mp5f
         0ooXwu4smxsK6e6bxM0JLXPU4qY8cgeyStYJV51jsveuap8zXiH8UtHiY0vFYxhwIo9n
         hl5krS490lBPQr6u9PTsFkcZvqxzYHkH8KwXPylvUgq6D05SkbZBxghe2mfK8B6uM6sR
         Ng0DTxxUciXkxLGuKPxPrsZo7jkZSxKs+W5dLiCGvN4ij5hfQu3r0wBv4ixVRGp1/SxO
         FKeyGnEXBC7Y0TuDWNOxBYPdjW8n+3ug4QbSwrAgiDZYVFg6YBIbA4vQ2UZcPjlqxhnC
         2KGQ==
X-Gm-Message-State: APt69E2H7n8lwmz/J7TWOJIav+Avl9505j0+dqE8v1GxbWjBZoiEdfRG
        +D5rnl3v7+EPCWtjtTFvXpFm7g==
X-Google-Smtp-Source: ADUXVKJCTEnpIwhbbINDkdepK9mq9GieYVE4ra8nY99BfCZu8rtc4dvYLfRS0Q2914sIaL9T038uxg==
X-Received: by 2002:a17:902:7048:: with SMTP id h8-v6mr25001716plt.269.1529519163819;
        Wed, 20 Jun 2018 11:26:03 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g10-v6sm6978077pgs.17.2018.06.20.11.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:26:02 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:26:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] nvmem: rave-sp-eeprom: Remove VLA usage
Message-ID: <20180620182600.GA24297@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the maximum allocation size for the stack and adds a sanity check,
similar to what has already be done for the regular rave-sp driver.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/nvmem/rave-sp-eeprom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 50aeea6ec6cc..66699d44f73d 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -35,6 +35,7 @@ enum rave_sp_eeprom_header_size {
 	RAVE_SP_EEPROM_HEADER_SMALL = 4U,
 	RAVE_SP_EEPROM_HEADER_BIG   = 5U,
 };
+#define RAVE_SP_EEPROM_HEADER_MAX	RAVE_SP_EEPROM_HEADER_BIG
 
 #define	RAVE_SP_EEPROM_PAGE_SIZE	32U
 
@@ -97,9 +98,12 @@ static int rave_sp_eeprom_io(struct rave_sp_eeprom *eeprom,
 	const unsigned int rsp_size =
 		is_write ? sizeof(*page) - sizeof(page->data) : sizeof(*page);
 	unsigned int offset = 0;
-	u8 cmd[cmd_size];
+	u8 cmd[RAVE_SP_EEPROM_HEADER_MAX + sizeof(page->data)];
 	int ret;
 
+	if (WARN_ON(cmd_size > sizeof(cmd)))
+		return -EINVAL;
+
 	cmd[offset++] = eeprom->address;
 	cmd[offset++] = 0;
 	cmd[offset++] = type;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
