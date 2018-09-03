Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB31AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E242086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E242086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeICVpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbeICVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3FF06D24;
        Mon,  3 Sep 2018 17:24:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 4.14 109/165] platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too
Date:   Mon,  3 Sep 2018 18:56:35 +0200
Message-Id: <20180903165700.987670723@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 58e73aa177850babb947555257fd4f79e5275cf1 upstream.

The commit 5d9f40b56630 ("platform/x86: ideapad-laptop: Add
Y520-15IKBN to no_hw_rfkill") added the entry for Y20-15IKBN, and it
turned out that another variant, Y20-15IKBM, also requires the
no_hw_rfkill.

Trim the last letter from the string so that it matches to both
Y20-15IKBN and Y20-15IKBM models.

Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1098626
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/ideapad-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1097,10 +1097,10 @@ static const struct dmi_system_id no_hw_
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


