Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3EB223A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBjPOVgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3EB223A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeHJCGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:06:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44672 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHJCGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:06:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so3462526pgp.11;
        Thu, 09 Aug 2018 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOF++X+h5N30v8uD5jFzsScxOobxBzvK5fKWDzi8OT8=;
        b=RBjPOVgEcpUtIaiVZ7u4A1RhapK9dajCXukUSaJHEN4JJAx0zcO3TawXOw37i8EF9Z
         /urQozaLeb6nHnCYsq+0eGcgX8SR9JxOvu0Tk9GHUDoo7FVOi/dWN3Y2R6P1Nqwz1Jn2
         MBvXiCdS9hXh4N/ddu1xgXmpcx9TY65bsvqS+fUoTsVPy/luFTKf5GocSlgIZ7jC8Uqa
         l6VObNWPOhoq2iESnY3bbtNjyBjcFtXJpZ5Atwg+eQg8bHDemo+v/HyizWlsgn17stFG
         IzP9YPy4NxlHsZgMEiKN4gGQ06tBpCL/87noB7CtVohfVA5Uwoz7FfwFhiMWG7UOClRK
         ZHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOF++X+h5N30v8uD5jFzsScxOobxBzvK5fKWDzi8OT8=;
        b=furAeRIvOPmzwaMSAAP0lM0iTpF3y2OwjdwHvVMV7tHLr7d2wx4mPC8eBX98pgqEci
         I5rGIRHg9pcxBCRo6T++CRqj6SvRQ6/d6q4vtpeuilStFH9vpV9Dm6FuGtOFrkmQsDQr
         ecLQzqQOfPCJSIEYr0MUkDYfMcnlSSN9VrDzw6MBxwSXMnjcqTdeWjGQwLzmXN9QexLX
         VLC8k+D7mmjAkOU4W6Gvcr1TVTSH2v6cGcQMfe9wzE/Pf7gU4JMj/lVch7H9tyy1ZX4K
         bdbTeC1KiDcBix6KEd73Stsz/8WhaIcBCn+aN7rd4xxJXf6IdYlkv2MB7JjvRIRtnJo0
         C4EA==
X-Gm-Message-State: AOUpUlEAo13zYIqb9/SDqU9ih7jlL2nQO8SqkIho0tGt547y8k+8UpGW
        YWNPQMUvv54j6b7vzcsfMXTcMR68
X-Google-Smtp-Source: AA+uWPz4GuVb5v1DIWkLhYGLsqw0xYVrHC/3eNLcHWjgmopHQMp5jxB3+LcqkPV6otFQXJNcqMNccw==
X-Received: by 2002:a62:954:: with SMTP id e81-v6mr4371306pfd.231.1533857970785;
        Thu, 09 Aug 2018 16:39:30 -0700 (PDT)
Received: from hobbes.alyptik.lan (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id d191-v6sm14275101pfg.172.2018.08.09.16.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 16:39:30 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH RESEND 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
Date:   Thu,  9 Aug 2018 13:39:16 -1000
Message-Id:
 <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180809233916.BduCYrghDsSudKsiT8nKde3cWEt6EkNmLIPsMk_0FXM@z>

The firmware found in the touch screen of the Surface Pro 3 is slightly
buggy and occasionally doesn't send lift off reports for contacts; add
MT_QUIRK_NOT_SEEN_MEANS_UP to .quirks to compensate for the missed
reports.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 45968f7970f87775fa..a793076139d7d0db9b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -242,11 +242,12 @@ static struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_STICKY_FINGERS |
-			MT_QUIRK_WIN8_PTP_BUTTONS },
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_NOT_SEEN_MEANS_UP },
 	{ .name = MT_CLS_EXPORT_ALL_INPUTS,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
 		.export_all_inputs = true },
 	{ .name = MT_CLS_WIN_8_DUAL,
-- 
2.18.0

