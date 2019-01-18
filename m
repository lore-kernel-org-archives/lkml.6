Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD0C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2842720823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1w1TXBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfARXbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:31:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfARXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:30:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so6991865plq.7;
        Fri, 18 Jan 2019 15:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ga+oVqHLm0lhA1fwqdUImX2t8PWwD8cjXiVk50icN8=;
        b=W1w1TXBCGuopLfkanOl9XZW3ZUDryRB+Ze8+SZsvH8SKGavMTHWiGxqC+u6Pg5L9iu
         R3d4kmezOtX6uH3FdJRUdBuK2IJNv8lLJWj8skF80M4L+5cTlelznYk5d6qzkLDhMbEf
         Csdsjb8xyIdAatH+3KxnxrIdgxpq570CrE+gsXGYNciRqFjWPC7+7jc4KnMPdQqLPyRK
         J2bjvsjLT5Pvp8TkYy4l5XyLHH5KzVBkZPfAKiBKqfTDVlgmJ6AIe1UCpm7iNnzYPb9B
         ZyTtTYlHF4rsAK7nDBOv9cy951NqKo8F4KED0bcyJi94J99BOAiaXstt9hctpJLQmqNS
         vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ga+oVqHLm0lhA1fwqdUImX2t8PWwD8cjXiVk50icN8=;
        b=Gnox6+A/2cwy2AFBztX3dLgv3ou/aBN75l5f8WmkDDquFKaYfWjS51do93Bl0NL+sP
         JYch4T0+Fl0fzp7q9WxjjPBpzi8EkpiEk83YgjgbZRsqLe0TVLzEz0sipvDicsdWatsx
         vnaDdCqNxJyivVw+mkBIA6RwPt73fGIhCP/miU7fJczlTxEXwl2SXFl7zh0YGmEZyQes
         hy8HANkhGjqHOgZdSGKu1Ob0KwBisVS951QeuHj2CYrvztDVsGJI5moT49SFALjwjFHZ
         rvgMUyPKYMS4Otz0qoYNQ5JnVWmsoBsDfIgLJoHE5Skj6o1ZMBVJBJlspVDNo7erhftY
         HWmg==
X-Gm-Message-State: AJcUuketLREyDYZExYjZFOYeGiJbW+cJzLESoIs8s0Hm+6hfFlfypzsG
        wdZiKwYWgXisJKHkbx2k53w=
X-Google-Smtp-Source: ALg8bN6fbh6bvT7Djf5MUXW2LSztuYm5FevAb/KhsPyZCD01dYDZEkj0qmadHEwqy3f5jg4dhqSITg==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr21059934plo.257.1547854243292;
        Fri, 18 Jan 2019 15:30:43 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f6sm11857163pfg.188.2019.01.18.15.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:30:42 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] HID: input: add mapping for Expose/Overview key
Date:   Fri, 18 Jan 2019 15:30:34 -0800
Message-Id: <20190118233037.87318-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to HUTRR77 usage 0x29f from the consumer page is reserved for
the Desktop application to present all running user’s application windows.
Linux defines KEY_SCALE to request Compiz Scale (Expose) mode, so let's
add the mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This can be applied independently.

 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index def58c6aa835..5f800e7b04f2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1030,6 +1030,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
 		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
 
+		case 0x29f: map_key_clear(KEY_SCALE);		break;
+
 		default: map_key_clear(KEY_UNKNOWN);
 		}
 		break;
-- 
2.20.1.321.g9e740568ce-goog

