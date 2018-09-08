Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24750C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF46220844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMIQ4kCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF46220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeIHO33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:29:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeIHO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:29:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so17098090wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmfwamrxWV/LWnq5Utn94RtScJeC6TOhXJ2MTGXrvz4=;
        b=dMIQ4kCfyuCIjShJOF4lbAtYEgWxeNIA1D4SRSVWpCw91+qW0p3UTzdM5WGoE+26mO
         3RoZ/AYW5WxOBuaZAC3yYAZBb5nfLpWCcRgbD7BADjoJJoWw2a8GVpMTiVAJTsB49OsI
         xIjat0Jn8z5rItP5W1qWsU0mHW7VwSCpMVpHnVyW6kL/n00mUXf5a/0Zk1u4UAQOOEdE
         +6oxe5iskgBUbxVJRGEHULc/tITpTGZOFPWN1cgtKkwPP5ZdarUx3j6t+e1ZyKn/5V8a
         iNF0QqUnDoNH+6wowf7v06PQJjGIu6AOeijTYY1Z03Ix1xP5KWU/BBtWCEKIZJBEbyjE
         ClKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmfwamrxWV/LWnq5Utn94RtScJeC6TOhXJ2MTGXrvz4=;
        b=aGpQvEejzlx48J4UcN6FOyx/gM9rnupiOgGPTES6tJLWzYDtArfQ8ih1irEWd/aiN8
         vkhULPkmmETeKmspNO9iQaoPmFr0ml1xJxI0k5tVkS0pAiVzfLzD/6690TOjsICqv9xS
         TVQSMJxntbJ5mMoKxdMFYXY1Ek837HAMtkrx0v/WrO/VFsQjBgd35x9o4+hzJ4tBSQby
         DTGkuF43flcjAqL5OYA27HNrx11U3MAmZlaLFjZBeCJqwGtepvgERIOeUi+lxMs6LwW0
         YFMVDwnzH9cgCFiq0PV4HbTEbXEebiIkw/AOLDcDXU+xDL/UlI6xDqCW38lKLV8qjfH9
         4HUA==
X-Gm-Message-State: APzg51C5PYb9uuShjkDi0lRV8fBWInxp+77Cp7n2KB18WWI2yUTKitIM
        9aYpmRd0dOvKzgpKJbMIaAf6Bf6c
X-Google-Smtp-Source: ANB0VdYA986aWMVnWgNb0ULlgEvqxsIo3xh8d++WFcL4LU+h+D15AVAiWSujuras6+sLsiVlqUmhHw==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr9311347wrx.103.1536399857700;
        Sat, 08 Sep 2018 02:44:17 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id t132-v6sm13975018wmf.24.2018.09.08.02.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 02:44:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/4] staging:rtl8192u: Refactor GET_COMMAND_PACKET_FRAG_THRESHOLD - Style
Date:   Sat,  8 Sep 2018 10:44:07 +0100
Message-Id: <20180908094409.4043-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908094409.4043-1-johnfwhitmore@gmail.com>
References: <20180908094409.4043-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MACRO GET_COMMAND_PACKET_FRAG_THRESHOLD causes a number of
checkpatch issues so has been refactored to use braces around the
parameter 'v' to avoid precedence issues, and to add spaces around
operators.

These changes are coding style changes which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_firmware.h b/drivers/staging/rtl8192u/r819xU_firmware.h
index 794dca7dcd95..e78e547044b4 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.h
+++ b/drivers/staging/rtl8192u/r819xU_firmware.h
@@ -3,7 +3,7 @@
 #define __INC_FIRMWARE_H
 
 #define GET_COMMAND_PACKET_FRAG_THRESHOLD(v) \
-	(4*(v/4) - 8 - USB_HWDESC_HEADER_LEN)
+	(4 * ((v) / 4) - 8 - USB_HWDESC_HEADER_LEN)
 
 typedef enum _firmware_init_step {
 	FW_INIT_STEP0_BOOT = 0,
-- 
2.18.0

