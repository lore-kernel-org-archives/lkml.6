Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF433C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810ED20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810ED20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeLIW3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:29:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34568 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbeLIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:09 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002ia-RF; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72X-0003CF-Pf; Sun, 09 Dec 2018 21:55:05 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.923377810@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 002/328] EDAC: i7core: Return proper error codes for
 kzalloc() errors
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e97d7e38162dc305b4734a316ca758a2bbd1fa6e upstream.

... instead of possibly uninitialized return value.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: http://lkml.kernel.org/r/1423046938-18111-5-git-send-email-tiwai@suse.de
[ Add a commit message, albeit a small one. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/edac/i7core_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,7 +1177,7 @@ static int i7core_create_sysfs_devices(s
 
 	pvt->addrmatch_dev = kzalloc(sizeof(*pvt->addrmatch_dev), GFP_KERNEL);
 	if (!pvt->addrmatch_dev)
-		return rc;
+		return -ENOMEM;
 
 	pvt->addrmatch_dev->type = &addrmatch_type;
 	pvt->addrmatch_dev->bus = mci->dev.bus;
@@ -1198,7 +1198,7 @@ static int i7core_create_sysfs_devices(s
 		if (!pvt->chancounts_dev) {
 			put_device(pvt->addrmatch_dev);
 			device_del(pvt->addrmatch_dev);
-			return rc;
+			return -ENOMEM;
 		}
 
 		pvt->chancounts_dev->type = &all_channel_counts_type;

