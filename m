Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SMRfB+w8GVv+OAAAmS7hNA
	; Thu, 07 Jun 2018 14:10:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0B843608B8; Thu,  7 Jun 2018 14:10:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 33EE26063F;
	Thu,  7 Jun 2018 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33EE26063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933225AbeFGOJu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:09:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39417 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933154AbeFGOJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:31 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005Zj-T3; Thu, 07 Jun 2018 15:09:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003Hs-4b; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "John Crispin" <blogic@openwrt.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.412991301@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 385/410] MIPS: ralink: Don't set pm_power_off
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

From: John Crispin <blogic@openwrt.org>

commit 81ab9f6c5ff8565e4cba330e340a8979a10521d7 upstream.

Setting pm_power_off is apprently wrong and makes drivers such as
gpio-poweroff not work.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11445/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/ralink/reset.c | 1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -98,7 +98,6 @@ static int __init mips_reboot_setup(void
 {
 	_machine_restart = ralink_restart;
 	_machine_halt = ralink_halt;
-	pm_power_off = ralink_halt;
 
 	return 0;
 }
