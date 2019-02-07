Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C972C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0112147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO9NUmVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGADk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:03:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42418 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGADj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:03:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3674353pga.9;
        Wed, 06 Feb 2019 16:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWqatzBoLVZPIIbjTL1UeI0Wg+QJBI2JUsh0P/6kqdI=;
        b=hO9NUmVpB5vJLaYLgDx9ifAoc89SZa8LJm8ArgqX8ygUDUO/1HlTIrpqcx+voW5IcH
         Nb9ffzRSWrnKf/BJWBQg7lOlwjfygM/NikbxPkZ/SVhTOVvZaz8TWwyDHBN2icbrsNFV
         gpBy6f65KUksxsAzcYgglRwZgBQHk58KOnNPEirmzFcgPnIsi2GogD5xl6OgxlMXJUWV
         9IaSZe3ggFRJSWHq54ePk0oUdpIkVVDM0OUMhUjVeslUaIUgel/aF0imYzV4sBcL6Mso
         EpaVGsa29EGDHM576rRdyx+GYnflZY02w3/+qGU13IgdWyFB62yGDqfFW3yuXFlFhoh3
         LydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWqatzBoLVZPIIbjTL1UeI0Wg+QJBI2JUsh0P/6kqdI=;
        b=ZIh6qDGfNmp7s/ljCnFUWZ5ViW8cad42+Nz7JwcZBH+E7GzYd7XKPIgBIuGXabg/vw
         HhAeNMnGeKp6PTid6aeqKh9aOaZ6BUv8BYpinLmRJ/kipLHPjfM5RKoyjhhGvXPBW4q0
         KwiUD8JQCikZgg9BU4juTpgbBoEvsp+yrI9jmCiCM3cn+s8s2wgWPbp6l/0E3SsWHgAm
         9WtWZ1ohJTATvt6bwFvSOGKhbQyQUky26NMeCi5kXeIvdEQTgvIKflSyst3hvV1oLNvX
         DQflYwRU08EQAXoTsW715vdsCoNsxuX9q7c60I18nN9nAm9X0cjKCo51pApvjMoB3pkv
         RbVA==
X-Gm-Message-State: AHQUAubaOeCZNfKiGc/iGjV+7bJfkCshXguP0fUc9gy/Oair/qqy7GAc
        DIOMvct8bg2cvXSat1FYLmqAy7Lu
X-Google-Smtp-Source: AHgI3Ia1uiFMIgktyxqzjXtc1MUatCEu+12TRv66bY27MU1ASOEHp+n+kVxjCdO5ZcEOOR7PEzTTeQ==
X-Received: by 2002:a65:6496:: with SMTP id e22mr11940257pgv.7.1549497818632;
        Wed, 06 Feb 2019 16:03:38 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id q187sm18316927pfq.128.2019.02.06.16.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 16:03:37 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: Drop superfluous initialization in xhci_queue_ctrl_tx()
Date:   Wed,  6 Feb 2019 16:03:31 -0800
Message-Id: <20190207000331.7547-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify filed's initialization by directly assigning its final value
instead of initializing the variable to sero and then bitwise or-ing
it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/host/xhci-ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 40fa25c4d041..91e592bfb80d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3379,8 +3379,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	/* Queue setup TRB - see section 6.4.1.2.1 */
 	/* FIXME better way to translate setup_packet into two u32 fields? */
 	setup = (struct usb_ctrlrequest *) urb->setup_packet;
-	field = 0;
-	field |= TRB_IDT | TRB_TYPE(TRB_SETUP);
+	field = TRB_IDT | TRB_TYPE(TRB_SETUP);
 	if (start_cycle == 0)
 		field |= 0x1;
 
-- 
2.20.1

