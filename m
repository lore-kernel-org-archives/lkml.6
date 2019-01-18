Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A7C61CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58B32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWxgfNZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfARXa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:30:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42798 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfARXap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:30:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so6985784plp.9;
        Fri, 18 Jan 2019 15:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldH8+mC8u22aK1nS5Q+1DGD8yOUPj+mC0pR+mip+tQo=;
        b=dWxgfNZMXrjv+1tdVjSv5pSXxBfEjSZY+bPioJnEyANWx/NpxFRjuL7FAAdPGE9g1s
         ++mIdpro9b93CVhZhD6agaxSaWTby6/Guyy5ehPFR0/Qqs1Nz9vitywy9UMtkQ4M5M+P
         bxj4s5Wc5rqMw+s0o1+VzsHmMe58ovtIYRkaK6GRkUb/KxDtNgSd9aAegl8k9qA4Ae/P
         j4fueiami+641sbci6sCjyP4oT7iroxAfUc+gu+ruZNOp+l/4XpYtay/HZS4zipvYTYn
         s9fGQDsL/Awwzm3VO1AanlgiZrsxo5+lesyWzKdRMvZJpakFYqtnau2w3Xvrc5Ot3cva
         /xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldH8+mC8u22aK1nS5Q+1DGD8yOUPj+mC0pR+mip+tQo=;
        b=f1T9qEjOJ3ImZ8D9pNYS7GBYGgWB6yF6AZz/S3MqnN1tB3YO8X1yLeYozCBYIAVkSX
         GHy0LtEtLpAqzl7RZjVuj67f1lnKMkE37NBd/pZ+SJaXP+aXA5aBxcd7wuI8DtcpSIkZ
         9mYx1lLNiF21fYW9VguhCQKJxzt6y+oAmWUR0T48aFJw+y/qPbV26+3vvvvTf38smZjq
         sh0I5hl1Nuc/DFNpw53EOTI2zbLrHTe0p4bZNs6/qtOA0dnMOAvnZo/TqDufEZdhmUFY
         at5S7+om/vbgmszClhNiDoMMYdzooRokkl3R0FSoEVNwMjSa9P4TC9Hcn0aefrhRbO6e
         bl7w==
X-Gm-Message-State: AJcUukcPXl8qNInc9aCXupa1H4FhvmLwFayD5PkSpPU5lTXAzRRioRCU
        ysnOKB53l9FvyUIfCSErLoY=
X-Google-Smtp-Source: ALg8bN6bklIT+S6OtF/fxrUYw80pkP/FQRCXFEVpX3jt9LRchmgqeNyrPDkXIThkFPkgjnRvRDkPyw==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr21087999plt.304.1547854244121;
        Fri, 18 Jan 2019 15:30:44 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f6sm11857163pfg.188.2019.01.18.15.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 15:30:43 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] HID: input: add mapping for keyboard Brightness Up/Down/Toggle keys
Date:   Fri, 18 Jan 2019 15:30:35 -0800
Message-Id: <20190118233037.87318-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to HUTRR73 usages 0x79, 0x7a and 0x7c from the consumer page
correspond to Brightness Up/Down/Toggle keys, so let's add the mappings.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This can be applied independently.

 drivers/hid/hid-input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5f800e7b04f2..cebe8a8cce2e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -900,6 +900,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x074: map_key_clear(KEY_BRIGHTNESS_MAX);		break;
 		case 0x075: map_key_clear(KEY_BRIGHTNESS_AUTO);		break;
 
+		case 0x079: map_key_clear(KEY_KBDILLUMUP);	break;
+		case 0x07a: map_key_clear(KEY_KBDILLUMDOWN);	break;
+		case 0x07c: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
+
 		case 0x082: map_key_clear(KEY_VIDEO_NEXT);	break;
 		case 0x083: map_key_clear(KEY_LAST);		break;
 		case 0x084: map_key_clear(KEY_ENTER);		break;
-- 
2.20.1.321.g9e740568ce-goog

