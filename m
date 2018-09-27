Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD01C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF962152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O27RloJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF962152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeI0PmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:42:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43875 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeI0PmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:42:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id r8-v6so1685829ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUo5x60M49/iGLPh1bZlbTMu44AMUY7kMOha20tuCec=;
        b=O27RloJBlvS9jvQwRZigFXqXzatnlKcboB67GjVzit9gxwB7XOinpdF+TTsVe5Rf3v
         fPRWvQZs4HZMp3JVzRnpJyTP8u/ECdePlJXdeT8UsGyzXCvmrTVXU/b/+LuHDizQeAjY
         0qltuujo5k2SXxbFOYYDmHAyaIXB00nFBCLhXmoFPEi8ZMnkW7o3xRC7JWV12X1L1PZe
         ob6ZMTSxuYPRENDFBhwQ5FcxZuTOnyr9Wqf8aGRClFr8RVQz7sXbHXpFYnvzFZDaNpC6
         BOE0B2smWYPo0cuBCxK00EzwyO6B8AguUPhBjW8P0dVOF9yiV8BwpNXFmxvGr6g0UHa7
         KQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUo5x60M49/iGLPh1bZlbTMu44AMUY7kMOha20tuCec=;
        b=Zlwk62HNUcA127FGR1XOTOFjWFZrZMZIh9vB3XmzmYMAsmFqSQXXWnmQdubVIOTLDr
         TcCvyNI+urRkevGpN5uwRuwMye0fsbhhzf03DNufhbvmfF6kL3hrp9uIj3Fw/UgrpaMy
         VbiHBG0auqgOhEuyNhe6ro+uNnBNJSd+5eBNOxnVt7Ikva7UOmxAARm6Qv582Z0KsZiv
         U5mvrbH8M/5OUm1V92UvWNe5V/6DSsxhSphNbGK0yshoaJoH9AxenDsR0Eed7s4VdLhU
         abQbZ6//lskyT50e44CmOOFTAFOBuOT8ZOCiNnfY1LGKOlZxVPvGz/9RsJq3u5Zqfp3t
         wKOg==
X-Gm-Message-State: ABuFfoibSA6oPlIHqDTXTmjZybp1S4YKF0KUzv+uyJ4z27kUQVdC0ybO
        d1+uMyIFGuXvi8NPQTHv7g==
X-Google-Smtp-Source: ACcGV62gH2P3ZkUZTzNx+3ELmgoJPtwWeaJqWP1tRR5swgzUeBodecYFiQnebRx7I47wi/W2H44rrA==
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr7038023ljb.119.1538040299317;
        Thu, 27 Sep 2018 02:24:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:999:51:565d:44e6:f5ff:fe2f:8bf6])
        by smtp.gmail.com with ESMTPSA id a17-v6sm319439lfj.13.2018.09.27.02.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 02:24:58 -0700 (PDT)
From:   Emil Karlson <jekarlson@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Emil Karlson <jekarlson@gmail.com>
Subject: [PATCH] mfd: cros-ec: copy the whole event when msg->version is 0
Date:   Thu, 27 Sep 2018 12:24:27 +0300
Message-Id: <20180927092427.507-1-jekarlson@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
be truncated on many chromebooks so that Left and Right keys on Column 12 were
always 0. This commit fixes the issue by restoring the old semantics when the
protocol version is 0.
---
 drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 398393ab5df8..457e4940dba4 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -519,8 +519,14 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret > 0) {
+		unsigned int copy_size;
+
 		ec_dev->event_size = ret - 1;
-		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
+		if (!version)
+			copy_size = sizeof(struct ec_response_get_next_event);
+		else
+			copy_size = ec_dev->event_size;
+		memcpy(&ec_dev->event_data, msg->data, copy_size);
 	}
 
 	return ret;
-- 
2.19.0

