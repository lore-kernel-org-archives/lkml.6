Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF235C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691BD20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMV1bh4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfARXa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:30:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45613 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbfARXap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:30:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so6972931plm.12;
        Fri, 18 Jan 2019 15:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ApgiXS2bVmCTJmZTYf7Edh2FUNbmB207b8t5V0zCeQE=;
        b=aMV1bh4S94H+5vfO/QEBUO5NUa0R9FBiBnv16AESmgBVcblVmbhZw1ryxrJTr3IB94
         chYVLM1Pb1eh7PYqxI74IzqpXxJvUt7kALp15gAOAxWBD265FuF2QJFwf2jUPwe1LfUL
         nG0SlKliR8NIG+UeCUR8eBZRDf2MAwr4c99Ckp8zz81mqtqNGZWuRhzFW0L6b2S4QBRL
         RTY+noSNDuC5kIeQ3EKk4PoDxVvuKxsq28q0+8eaQw0yvfE4+HT5iu3PMyEvV9esNfZM
         4MnmIDbVdfZGRph1OgHXFRT5y9QELv+h5RmbaVQoG7P2ZC/u9WNrsQNT+U8paqIE73l6
         /pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ApgiXS2bVmCTJmZTYf7Edh2FUNbmB207b8t5V0zCeQE=;
        b=Z1INa2dn563JhDBAeL+P1UHEW6hRL1aRfx7r/MpMpVEVYuPJv6NT1pLhYUGQRE0JYn
         E5rZtvyPcOn6wiD/JkTlYziPs4syKqSUWqebXOctvr3SafAFt2MXhFzTLcYSR3KKCWAw
         f7GkhzhMH73YRNkClm5ku/U5Riqe1/Isdjpz5aUU9iu4i0KQsKfGI8xxWDOM+jN7R2Ej
         0pkRvSloAqq3MnZJL5MAbszfpbGc8NhJMn+VI76jh13ULy6iKpUT/pSX0dLKbtKEsPrU
         bO/x7I4zTUYP4lHrewlWJNsQBUM3YyUHFRz+yITKKtOxXDvKhSXjociIBvAeAnmb21GF
         TyUg==
X-Gm-Message-State: AJcUukfH+/aQdpPHQ4AeqUkcc3XLr8YRKzMuuy6Xlr3P32ldMZWyNAKV
        zaRsozcV2PHClkn10zM3wN4=
X-Google-Smtp-Source: ALg8bN5BPVs+/Zj+6TZzT60gFxxM1RPhq2ZTaAz/91nSQNCG+F9T19vdDPKli/4VLI1jxdYf3DlClg==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr20642057plb.113.1547854244932;
        Fri, 18 Jan 2019 15:30:44 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f6sm11857163pfg.188.2019.01.18.15.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:30:44 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] HID: input: add mapping for "Full Screen" key
Date:   Fri, 18 Jan 2019 15:30:36 -0800
Message-Id: <20190118233037.87318-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to HUT 1.12 usage 0x232 from the consumer page is reserved for
switching application between full screen and windowed mode, so let's add
the mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This needs the new key definition.

 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cebe8a8cce2e..ecb1b6f26853 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1014,6 +1014,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x22d: map_key_clear(KEY_ZOOMIN);		break;
 		case 0x22e: map_key_clear(KEY_ZOOMOUT);		break;
 		case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
+		case 0x232: map_key_clear(KEY_FULL_SCREEN);	break;
 		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
 		case 0x238: map_rel(REL_HWHEEL);		break;
-- 
2.20.1.321.g9e740568ce-goog

