Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9414EC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1F20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE1F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeI3ETq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:19:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbeI3ESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6H-0000Gw-Gc; Sat, 29 Sep 2018 22:48:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006r6-15; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Jiri Kosina" <jkosina@suse.cz>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.377707616@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 028/131] x86/bugs: Fix __ssb_select_mitigation()
 return type
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit d66d8ff3d21667b41eddbe86b35ab411e40d8c5f upstream.

__ssb_select_mitigation() returns one of the members of enum ssb_mitigation,
not ssb_mitigation_cmd; fix the prototype to reflect that.

Fixes: 24f7fc83b9204 ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -505,7 +505,7 @@ static enum ssb_mitigation_cmd __init ss
 	return cmd;
 }
 
-static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+static enum ssb_mitigation __init __ssb_select_mitigation(void)
 {
 	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;

