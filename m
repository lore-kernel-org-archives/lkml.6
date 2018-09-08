Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A838C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB520869
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/dZCvqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeIHO30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:29:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeIHO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:29:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so17139206wrw.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iy1Xr/t2YQs4IaK8ziU3Xxt4ZLKzPW+pJsM1RK3G3tA=;
        b=n/dZCvqqHRhDYyowe4cSmdqp/GDHIa2nlCtZ2REaKI/pCsDoJPcurl71865SkT9SOS
         J5nCvcm9hh8KopxJjD9BJA+Jn6Lr9gqVTI0gT7yfTFvBe7XGUtftQkRKrgW6znfbqYWQ
         z8yDKebzC9VdiVReg13XXwiUoH0/dmoUk9dYG/LKfHGIWScDA9rcN8WsbblxSsBEq6cp
         GGQbf8HmG89T8V2LogpXd5O8DxARZv7BdzF4v0hyT58Zp/TYxWvHOyFTXHmduv7hXinG
         fP87zved++ra939YaLQzEllJFBVmtetqn563syGeitmWOl+LFMEzRhLSbX7bUJ49+jFh
         UoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iy1Xr/t2YQs4IaK8ziU3Xxt4ZLKzPW+pJsM1RK3G3tA=;
        b=mORYMgBbBG5aPJRI50/oKGYH9I3n6zWhOzqUmUqLvl5AGgjRCv0aog4HyKrtg+CQ7D
         JVIgUbcTvv6bzdUGa8gxezCCeVb7/DLs7b4kLpR19VrnWdaBUp1sKVs8yngdNRQtRELH
         rvuE3Um42vaB6JLassKBmGKzmxDZJCnLTuwTcBqwj/UI8OBX1V+aweg1V/VpJLIaD6mi
         W7wM+4PBu7GKsauGvvivawGNxT2GekEs8U5OalFu3h2VzC2L49vWpz0fF//OblADI7P1
         lqCzZ0AtzH+k09Ij2aG6sIRwSj9LJhqxpPowxcP76xJ8wZBgs7JxyYCORi8f8YnwNLqm
         kqXg==
X-Gm-Message-State: APzg51AMADO1VvGmliP51+1J/aIC9k5XRrSKOFXZ33jrdMRxRuSramyv
        /dDvtQSwdOyjx9l4x4h1SJF4FWXk
X-Google-Smtp-Source: ANB0Vdb0Z98JUtPf3+AbwAEAt6f3RSPyPP/gj0jq3OLSG8KJVe2VN4SpWqjBZmIw/T7tcE4YXOjHRg==
X-Received: by 2002:a5d:4fc3:: with SMTP id h3-v6mr8949200wrw.261.1536399856256;
        Sat, 08 Sep 2018 02:44:16 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id t132-v6sm13975018wmf.24.2018.09.08.02.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 02:44:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/4] staging:rtl8192u: Remove unused RTL8190_CPU_START_OFFSET - Style
Date:   Sat,  8 Sep 2018 10:44:06 +0100
Message-Id: <20180908094409.4043-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908094409.4043-1-johnfwhitmore@gmail.com>
References: <20180908094409.4043-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defined constant RTL8190_CPU_START_OFFSET is not used in the code
so has been removed. This is a coding style change which should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_firmware.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_firmware.h b/drivers/staging/rtl8192u/r819xU_firmware.h
index cccd1c82ffe0..794dca7dcd95 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.h
+++ b/drivers/staging/rtl8192u/r819xU_firmware.h
@@ -2,7 +2,6 @@
 #ifndef __INC_FIRMWARE_H
 #define __INC_FIRMWARE_H
 
-#define RTL8190_CPU_START_OFFSET	0x80
 #define GET_COMMAND_PACKET_FRAG_THRESHOLD(v) \
 	(4*(v/4) - 8 - USB_HWDESC_HEADER_LEN)
 
-- 
2.18.0

