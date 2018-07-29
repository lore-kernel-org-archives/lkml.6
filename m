Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06311C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF6A20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDZBJBri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF6A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeG2WkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52125 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2WkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so10953658wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=++t0u7nIq4z5gcK4uzdbg9UIz3urn9Qn37qAku0EuuE=;
        b=QDZBJBriJSutjmFs9PyPJjW3Yo6C46Tu8SrC9YoW1fqR+7i40LIb+J1A4cxK+yVRn4
         E4nYmSJLixjsEHGhz/TCppP5RJh5NUqSWPVIH1IRQLA/7/vw0Mok+HHDvnFnFRmN51Rf
         K5t+MDCoX4duGb3G/QyKBPC480Vnve45ol/GIyU/5g+uyE4Mg6MPEsyF0tbMZzjfr2/P
         dU9oACsJpzzTD9Csk+lUvEzjKgFXBSYl/v1dmm/H4XyrDDS60qC+I/6L+QgsiYkOf2D7
         HlA04HXycWp8oUaUB9uWC3rA+/PyAgW6CUwG8xM9Dd90hrnxoCbFEeswtvI2v09sMpDG
         Z2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=++t0u7nIq4z5gcK4uzdbg9UIz3urn9Qn37qAku0EuuE=;
        b=lj9Xj1eLoTf2l4PMW/itdrPKdenXw/72Tw+QY6HaDadGKq7Z7ZH/QEs2aX1rX2rz70
         USnaR0m4/HY5wNIsa6pAl/L+KvdQh5DMBUnEiVs4mIqw0b8S7esvRryuy8nipcgsdg5r
         7SZMnGBtJJMX8NBoc/R/deQXDFAxWPVJ6z976Ys+54DJaJEluP+NsBUBbUQvnVKqJ2/w
         v9RuYAfu3ZFwH5KbFJXFty77pL3Jq4zZ7M/3LMkqPGRsB60dGeRDysZsSgpxyKjTIY3b
         krkCzKrtjfffZcqGrxUSWlcgPwUavJXcyDX0pj4OZV+wPzDXoH5+6cdX+s+JxMIZic/Z
         PNFA==
X-Gm-Message-State: AOUpUlEx52mGObSqXosIhGJ/SXV1dwZu4TzgAqe+EWnHt9q6MHiUes7R
        5p39LtWLD0GBLEEtV9Us+s7jPNsu7o8=
X-Google-Smtp-Source: AAOMgpe6CB2lGdQS7TMl4XKPGfTUfkVlw+tx3gbAGURCwg2KR0gdIlnEhmPcdA7ztPG00FljnRNLOQ==
X-Received: by 2002:a1c:f001:: with SMTP id a1-v6mr13316307wmb.160.1532898504716;
        Sun, 29 Jul 2018 14:08:24 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:24 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 02/15] staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
Date:   Sun, 29 Jul 2018 22:07:34 +0100
Message-Id: <20180729210747.10803-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused macro CMPK_TX_SET_CONFIG_SIZE. This is a coding style
change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 756e08bd341a..fab982668b44 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -3,7 +3,6 @@
 #define R819XUSB_CMDPKT_H
 /* Different command packet have dedicated message length and definition. */
 #define		CMPK_RX_TX_FB_SIZE		sizeof(struct cmd_pkt_tx_feedback)	/* 20 */
-#define		CMPK_TX_SET_CONFIG_SIZE		sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_BOTH_QUERY_CONFIG_SIZE	sizeof(cmpk_set_cfg_t)	/* 16 */
 #define		CMPK_RX_TX_STS_SIZE		sizeof(cmpk_tx_status_t)
 #define		CMPK_RX_DBG_MSG_SIZE		sizeof(cmpk_rx_dbginfo_t)
-- 
2.18.0

