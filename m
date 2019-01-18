Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E37C61CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBED620823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHg4W+Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfARXau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:30:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46282 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbfARXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:30:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so6977136ply.13;
        Fri, 18 Jan 2019 15:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXL4qZP7YbRvfTyx9AD04ZGmWvKykJHmkbQQ6OFvsZo=;
        b=fHg4W+Trcy3uD0SB43ArWYO/iXEPyyn5KiyTgWefduIB5r5P1NjHQPPllvyELUfEG+
         3AsgEHD2aDDxy3AfestlcnJPUOK4vfSxt0tmRc3SjZASUJV3ye847p87oksOeX9w8CXc
         8aM0wSfWLpBSUfpPInCJDyb+xu46y52Pyt7eS9vUYVYK4EQB3DaX60LAWPG0EHx9pMIP
         362GkDxDfur4k2NMv+3ekh/G0ksx6WW1P0ffgrJWN2xIbFWKNXTTYjom8OSYS3/jELki
         D5fRXQTRzI3qtWOd7C50vYZpcUMYKLtyjkB2a2r/cOGgbHBBaotmjajCvwo0WENiAkYo
         DbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXL4qZP7YbRvfTyx9AD04ZGmWvKykJHmkbQQ6OFvsZo=;
        b=oWVGUjDcxKSpYgPch4qXew1iC328dkgwtE1eVtXjrFIMXdppVFU0Vt4WGJ4hk9jGsA
         CZ/VZAQ+NppbsLzg9o8X3axNzBdUGzlKIjKc5vbhKntRDZormEFyP/EvdBr73ofzNfLQ
         DNZMUeno6aRoakHHJK4JZ/gh1ieAj/z52kL2nKRpxBsegZsdYcp3M1B4BndLEyIa8PBu
         yujD25jtYLYMlykcKjrHrQi4dcVvjVrJXNxbZ0Oq6FamN6HJmlsIGdlHk96m40Zt0LR+
         WymewsnZ+Lcyy35KlUtOS73axelNmORxDIZJBR2My5NLmDQL2oX/VFPI7JYcneyb0O2g
         WWRg==
X-Gm-Message-State: AJcUuket7UNhiO9K4g4t+4EkLTusxiV+SLkMRr0Y9hPvDfCN4pacwxsM
        BD+Uc4vFBnqx/12JXfsG3Bc=
X-Google-Smtp-Source: ALg8bN6I5Vds9SMLHv5qIACRsXKpuxAAlCpYuy65m82Ajv6icuqgWHuf6CkEKIX8LwIPR7dD+cxGtg==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr20713575plb.46.1547854245776;
        Fri, 18 Jan 2019 15:30:45 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f6sm11857163pfg.188.2019.01.18.15.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:30:45 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] HID: input: add mapping for "Toggle Display" key
Date:   Fri, 18 Jan 2019 15:30:37 -0800
Message-Id: <20190118233037.87318-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to HUT 1.12 usage 0xb5 from the generic desktop page is reserved
for switching between external and internal display, so let's add the
mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This can be applied independently.

 drivers/hid/hid-input.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ecb1b6f26853..da76358cde06 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -677,6 +677,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 		}
 
+		if ((usage->hid & 0xf0) == 0xb0) {	/* SC - Display */
+			switch (usage->hid & 0xf) {
+			case 0x05: map_key_clear(KEY_SWITCHVIDEOMODE); break;
+			default: goto ignore;
+			}
+			break;
+		}
+
 		/*
 		 * Some lazy vendors declare 255 usages for System Control,
 		 * leading to the creation of ABS_X|Y axis and too many others.
-- 
2.20.1.321.g9e740568ce-goog

