Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84610C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3226B2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3226B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407470AbeHATP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:15:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404699AbeHATPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:15:25 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D571C3C;
        Wed,  1 Aug 2018 17:28:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Terry Junge <terry.junge@plantronics.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 083/144] HID: hid-plantronics: Re-resend Update to map button for PTT products
Date:   Wed,  1 Aug 2018 18:51:50 +0200
Message-Id: <20180801164955.706498580@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Junge <terry.junge@plantronics.com>

[ Upstream commit 37e376df5f4993677c33968a0c19b0c5acbf1108 ]

Add a mapping for Push-To-Talk joystick trigger button.

Tested on ChromeBox/ChromeBook with various Plantronics devices.

Signed-off-by: Terry Junge <terry.junge@plantronics.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-plantronics.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-plantronics.c
+++ b/drivers/hid/hid-plantronics.c
@@ -2,7 +2,7 @@
  *  Plantronics USB HID Driver
  *
  *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
- *  Copyright (c) 2015 Terry Junge <terry.junge@plantronics.com>
+ *  Copyright (c) 2015-2018 Terry Junge <terry.junge@plantronics.com>
  */
 
 /*
@@ -48,6 +48,10 @@ static int plantronics_input_mapping(str
 	unsigned short mapped_key;
 	unsigned long plt_type = (unsigned long)hid_get_drvdata(hdev);
 
+	/* special case for PTT products */
+	if (field->application == HID_GD_JOYSTICK)
+		goto defaulted;
+
 	/* handle volume up/down mapping */
 	/* non-standard types or multi-HID interfaces - plt_type is PID */
 	if (!(plt_type & HID_USAGE_PAGE)) {


