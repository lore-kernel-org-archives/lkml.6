Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1860C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D8E23F43
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D8E23F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFVI7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:59:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbeFVI7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:59:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE564AF91;
        Fri, 22 Jun 2018 08:59:22 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Andy Shevchenko <andy@infradead.org>
Cc:     Ike Panhc <ike.pan@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too
Date:   Fri, 22 Jun 2018 10:59:17 +0200
Message-Id: <20180622085917.22969-1-tiwai@suse.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5d9f40b56630 ("platform/x86: ideapad-laptop: Add
Y520-15IKBN to no_hw_rfkill") added the entry for Y20-15IKBN, and it
turned out that another variant, Y20-15IKBM, also requires the
no_hw_rfkill.

Trim the last letter from the string so that it matches to both
Y20-15IKBN and Y20-15IKBM models.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1098626
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>

---
 drivers/platform/x86/ideapad-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 45b7cb01f410..307403decf76 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1133,10 +1133,10 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 		},
 	},
 	{
-		.ident = "Lenovo Legion Y520-15IKBN",
+		.ident = "Lenovo Legion Y520-15IKB",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y520-15IKBN"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y520-15IKB"),
 		},
 	},
 	{
-- 
2.17.1

