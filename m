Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9hYkDyFEGVtrEAAAmS7hNA
	; Thu, 07 Jun 2018 14:42:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2EDC608BF; Thu,  7 Jun 2018 14:42:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3DF4E607DC;
	Thu,  7 Jun 2018 14:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DF4E607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934715AbeFGOmD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:42:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40611 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933843AbeFGOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:42:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zn-38; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002wf-7d; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Travis Brown" <travisb@arista.com>,
        "Ivan Delalande" <colona@arista.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.857507722@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 167/410] lkdtm: fix handle_irq_event symbol for
 INT_HW_IRQ_EN
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Delalande <colona@arista.com>

commit 5be2a5011c039506e2862650c928acfb2e3d7b9c upstream.

Function handle_IRQ_event was retired in v2.6.39 and replaced with
handle_irq_event but nobody changed it in lkdtm so INT_HW_IRQ_EN has
been broken for a while.

Fixes: 33b054b867b8 ("genirq: Remove handle_IRQ_event")
Signed-off-by: Travis Brown <travisb@arista.com>
Signed-off-by: Ivan Delalande <colona@arista.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/misc/lkdtm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/lkdtm.c
+++ b/drivers/misc/lkdtm.c
@@ -566,7 +566,7 @@ static int lkdtm_register_cpoint(enum cn
 		lkdtm.entry = (kprobe_opcode_t*) jp_do_irq;
 		break;
 	case CN_INT_HW_IRQ_EN:
-		lkdtm.kp.symbol_name = "handle_IRQ_event";
+		lkdtm.kp.symbol_name = "handle_irq_event";
 		lkdtm.entry = (kprobe_opcode_t*) jp_handle_irq_event;
 		break;
 	case CN_INT_TASKLET_ENTRY:
