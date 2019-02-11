Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEEDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D5620873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzmXhmms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBKDlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:41:05 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:56829 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBKDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:41:04 -0500
Received: by mail-ot1-f73.google.com with SMTP id q11so9733966otl.23
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 19:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qWPDfOlXuramtow7KSV1zTmIzyR/XqoO0VQtrh+RpUI=;
        b=OzmXhmms4G5PmaQpbOY3Wr5Ov+FXdEZCIxbI6mgH1uBU7JB39ElREirrztNifIEgb6
         E8vj5BduBgp1yk2iOSl7mv1mHYKC1z6JNVLktsUMdoF7WmyBb69uExzwkOBP1LSwS3cv
         el6+2o4NmLEZ6x1OOOGkB4mTaq3PwuCzh6aDn20xyADlsGYc1FwW9ny+Ub7lIYltvuTK
         HDbCykvUy58IccJKrjmB7VxHZo8abr3wWAOwWSZT9XHCUMcOqzDOQmfc1+CvURH+XAQb
         Xv9arLUDpvKzEPKvBgJE2PEKCuDIUf5EttyC2OFKSO+VquqidoPzzn1H2i/aWlVNI8xX
         H00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qWPDfOlXuramtow7KSV1zTmIzyR/XqoO0VQtrh+RpUI=;
        b=plzF3CtmU4UBtKJpngRbJjK/gUoXo2B7E5D4X1gPppszIX/LQsVJf51VV6Q5g0dpP7
         aFyF1P/gxVPwlPrWD9TwCCMxzY58ikzNoxsW7YMwk/8q7WxnIjbplpFgIU1I0XpZS804
         tVdEz6Dc2FIVznQYy0rH3d+wUlGGx2/hTW4GNOanUCI5o9n2zxl7lzp74rvSiblnVoRJ
         CkTVOaa1ZDrYwrv/kxVxetzqaIyLiSPqcFGXrONUt2Ypxwhe1HA8xBLq0z2aSYNnXMbR
         RnRLxRvvWClwku4P9YLpKGBsncfQh8Ko5ZW4zY1P79sOT9J3U9B3+TNjXknbzSldRntz
         dMAg==
X-Gm-Message-State: AHQUAuYsDHiGTrE6OrqTfuEVkcjifKKeDNSHLjVIj37YbEoYBKPCocoa
        AZAWjY7SC1syTy1OndM8Q9t225d9TcWFKE4=
X-Google-Smtp-Source: AHgI3IZBz4Gd+NwrA2B5PfutrpzR9sWPcsJEhFCXzQSJcwUOTibbOmZpuHUSScHyQD07vCIfMK0m3NZKOKhOnH8=
X-Received: by 2002:aca:5044:: with SMTP id e65mr2653040oib.11.1549856463576;
 Sun, 10 Feb 2019 19:41:03 -0800 (PST)
Date:   Sun, 10 Feb 2019 19:40:21 -0800
In-Reply-To: <20190205190849.GA2686@kunai>
Message-Id: <20190211034021.242932-1-jsperbeck@google.com>
Mime-Version: 1.0
References: <20190205190849.GA2686@kunai>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2] i2c: core-smbus: don't trace smbus_reply data on errors
From:   John Sperbeck <jsperbeck@google.com>
To:     wsa@the-dreams.de
Cc:     jsperbeck@google.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an smbus transfer fails, there's no guarantee that the output
buffer was written.  So, avoid trying to show the output buffer when
tracing after an error.  This was 'mostly harmless', but would trip
up kasan checking if left-over cruft in byte 0 is a large length,
causing us to read from unwritten memory.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 drivers/i2c/i2c-core-smbus.c | 2 +-
 include/trace/events/smbus.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..132119112596 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 trace:
 	/* If enabled, the reply tracepoint is conditional on read_write. */
 	trace_smbus_reply(adapter, addr, flags, read_write,
-			  command, protocol, data);
+			  command, protocol, data, res);
 	trace_smbus_result(adapter, addr, flags, read_write,
 			   command, protocol, res);
 
diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
index d2fb6e1d3e10..a4892a187842 100644
--- a/include/trace/events/smbus.h
+++ b/include/trace/events/smbus.h
@@ -138,9 +138,9 @@ TRACE_EVENT_CONDITION(smbus_reply,
 	TP_PROTO(const struct i2c_adapter *adap,
 		 u16 addr, unsigned short flags,
 		 char read_write, u8 command, int protocol,
-		 const union i2c_smbus_data *data),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
-	TP_CONDITION(read_write == I2C_SMBUS_READ),
+		 const union i2c_smbus_data *data, int res),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
+	TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),
 	TP_STRUCT__entry(
 		__field(int,	adapter_nr		)
 		__field(__u16,	addr			)
-- 
2.20.1.791.gb4d0f1c61a-goog

