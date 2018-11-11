Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2491C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E954214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E954214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbeKLFsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51040 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730691AbeKLFsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsp-0000l9-3F; Sun, 11 Nov 2018 19:58:59 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001kL-5y; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Marcos Paulo de Souza" <marcos.souza.org@gmail.com>,
        "Vojtech Pavlik" <vojtech@suse.cz>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.955471192@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 267/366] Input: i8042 - add TUXEDO BU1406 (N24_25BU)
 to the nomux list
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit a4c2a13129f7c5bcf81704c06851601593303fd5 upstream.

TUXEDO BU1406 does not implement active multiplexing mode properly,
and takes around 550 ms in i8042_set_mux_mode(). Given that the
device does not have external AUX port, there is no downside in
disabling the MUX mode.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Suggested-by: Vojtech Pavlik <vojtech@suse.cz>
Reviewed-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -513,6 +513,13 @@ static const struct dmi_system_id __init
 			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
 		},
 	},
+	{
+		/* TUXEDO BU1406 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
+		},
+	},
 	{ }
 };
 

