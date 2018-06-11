Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lYBIJbpiHlvaVwAAmS7hNA
	; Mon, 11 Jun 2018 11:53:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80248607E7; Mon, 11 Jun 2018 11:53:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5DlBYdr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E5FE560351;
	Mon, 11 Jun 2018 11:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5FE560351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeFKLx0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38471 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933180AbeFKLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id i83-v6so30085572lfh.5;
        Mon, 11 Jun 2018 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TRrbPoVvu+WEQ4B9/OSd9cynE1TicIWPa1lIblSUjJk=;
        b=r5DlBYdrzbPNRzIJWpTSwIbKgixHzVHhxLhXF/JMluPxhEG1oPc9KUXMPE5cwlNqf+
         6U8dI+p1WE/qkznRZtiEbCw/92M/TE42rdMaOCUZReqVJTVpt1Ba1OH8b2YNc41YtiOX
         AORM3bT1LI3LtBK36tLuMWLFWgylpactdgoibsNXbxcOr2WILzMobViOSVfj7YvMCVYZ
         BJJgcPYnce55aQE1hV2n1EtZrzq22xAfHf/atcKN5zfypTWrVcwwUCeXUAIfe6hI7iil
         c/o7aHZ8vgwSrj7K4XMdqaNm3euQ/Y4XbhnmKWSiCBWn4PnKQMVV0/GUEzDtFryd9DVY
         VhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TRrbPoVvu+WEQ4B9/OSd9cynE1TicIWPa1lIblSUjJk=;
        b=VUDSOa1LPR7HXYD7JeOpH6C7aiT3wwmLSRQ0YsUwdb0Wdx7fkdP2lRKTEaUTw+uqJU
         t6yYqcA8EpQ+wIdrXaJjhUo9Y1NkPvjYQRTasSSTJn3Tg58vV88dKKa2ze6P7TBCZEhY
         Kwtj2ZAziWhlWpc16SCp2apsf1VOC7zc0MaA5/TphGhPm7oO0EkiNghpwfepiyR1r8iZ
         QNWDb55ieViNKWDEjETAxQTKbFJMxVYeJjrmTlEWeMWNYgegm5eLEj+E+XKBzzSnZUOL
         e8Ft7ZBuV7/5Hh40piCmB2SJLuhLHyY/CeMBEgiEI/Dw6xuCo18DZ1VqFocU07qXgvZO
         nROw==
X-Gm-Message-State: APt69E1aciCfXNkRSzTK9uNlKhXe52Wy+wdRYPty6f5P1LR/95XtYyyt
        88Y5ch/I0QL3Tzz/5lN764966e1i
X-Google-Smtp-Source: ADUXVKKNfj2e6nxjwFBlalJdfnp8bAu5SSC66UztgAWjCfXxwr/dc4I8tNfh97s75tvGeOeSFp3FWw==
X-Received: by 2002:a2e:5f1a:: with SMTP id t26-v6mr11756782ljb.0.1528718001850;
        Mon, 11 Jun 2018 04:53:21 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:20 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 16/24] serdev: ttyport: Move serport structure to its own header
Date: Mon, 11 Jun 2018 13:52:32 +0200
Message-Id: <20180611115240.32606-17-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we can reuse this structure in other modules.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/serdev-ttyport.c |  9 +--------
 drivers/tty/serdev/serport.h        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)
 create mode 100644 drivers/tty/serdev/serport.h

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index fa1672993b4c..4acc5f41dc67 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -7,17 +7,10 @@
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/poll.h>
+#include "serport.h"
 
 #define SERPORT_ACTIVE		1
 
-struct serport {
-	struct tty_port *port;
-	struct tty_struct *tty;
-	struct tty_driver *tty_drv;
-	int tty_idx;
-	unsigned long flags;
-};
-
 /*
  * Callback functions from the tty port.
  */
diff --git a/drivers/tty/serdev/serport.h b/drivers/tty/serdev/serport.h
new file mode 100644
index 000000000000..15bc1ff6326e
--- /dev/null
+++ b/drivers/tty/serdev/serport.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016-2017 Linaro Ltd., Rob Herring <robh@kernel.org>
+ */
+#ifndef _SERPORT_H
+#define _SERPORT_H
+
+struct serport {
+	struct tty_port *port;
+	struct tty_struct *tty;
+	struct tty_driver *tty_drv;
+	int tty_idx;
+	unsigned long flags;
+};
+
+#endif
-- 
2.17.1
