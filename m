Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A227223A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9o6g6lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A227223A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeHJCGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:06:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41526 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHJCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:06:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so3470555pgu.8;
        Thu, 09 Aug 2018 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lP4IG4mDY9DgV+tOoDW146wl3lit/aOFC7RSHZ9QL6c=;
        b=I9o6g6lUQirlFbkAQrk5QUCbYQsxxNELC68PBska0J7Zxyeoecx7YB9lCISpdahvEr
         KFE0Ie2oqiNvHDHaVuQQbQ3pjQrhFyx3xyLu05kB5vr6I++4JrbfmikKuUXGNIObznZR
         aY/IMF55CcgkpDCkSQ2HZHjn+mD3S65kOrtjZE8Sts+uTVPVP4yjN8eF68B5L/ImHs9v
         vStwno+cpctWBQPC/oeNc2DHHnWQ504zISyjANXRbhUUbuZxM3cRJ2uan24q98y/9g9e
         PvFihbFcXsANBEqnq6qcxeeZKhkshYwtp08LjhVT6CbcQXtQ4uC8KrDoS4xZ3hdTTSCg
         8LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lP4IG4mDY9DgV+tOoDW146wl3lit/aOFC7RSHZ9QL6c=;
        b=S9FW63SIyR9cC02aK+r6vuBmE3e8G8TFlLZfvQbrvSq4p7Xai7htSnLCNao1YFqwZ4
         12807cM96dcrGMrn0cJxRzTDPKbw5wWrkUVLFAQbV668zObv0c1E8WfVynyupEofMXAl
         jDHt6XHLo62JKWSimCf6f0VvasxmMeVHjV7EKA/Bb3A8d4KacPKcYNV+EZh2lrIlMEcP
         03rT9pPG0okkREuQ5e889TUfP2CPmIxLr2ugLQRNIdowoRWZdSwOT9a3jke8sIvipZ8C
         qvzW9jraaxaGE8O9cX/UXqTadjuy8OV399nhD5IjbbsZtAlcwOzSiRDd0CdeYPQB/w7x
         CXTw==
X-Gm-Message-State: AOUpUlH4/OUrH+iKe7UpadJExKLnTKM/2Pnc6fQEd/cYwvsX9eWzAEfY
        8BOJ6C/p2QgJUgZYxdDn6gRyBGkV
X-Google-Smtp-Source: AA+uWPzjUWGrAEZ0fth4KWn22Pd3XoFOhixcF9aSqnr/fGNN7CmSySZW9w6eLZxj2DC/8WQsseHjrw==
X-Received: by 2002:a63:2013:: with SMTP id g19-v6mr4014759pgg.68.1533857973591;
        Thu, 09 Aug 2018 16:39:33 -0700 (PDT)
Received: from hobbes.alyptik.lan (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id d191-v6sm14275101pfg.172.2018.08.09.16.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 16:39:33 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH RESEND 3/4] HID: multitouch: drop reports containing invalid values
Date:   Thu,  9 Aug 2018 13:39:18 -1000
Message-Id:
 <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180809233918.-kKKRctf3uzCrNNoRXrDMyXDqYk2nhbEVB1QuQzwbc8@z>

Avoid processing reports containing invalid values to reduce
multitouch input stutter.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c0654db0b736543ca0..08b50e5908cecdda66 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -694,10 +694,19 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 {
 	if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
 	    td->num_received >= td->num_expected)
 		return;
 
+	/* drop invalid values after counting them */
+	if (td->curdata.x == 0xffff &&
+			td->curdata.y == 0xffff &&
+			td->curdata.w == 0xffff &&
+			td->curdata.h == 0xffff) {
+		td->num_received++;
+		return;
+	}
+
 	if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
 		int active;
 		int slotnum = mt_compute_slot(td, input);
 		struct mt_slot *s = &td->curdata;
 		struct input_mt *mt = input->mt;
-- 
2.18.0

