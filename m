Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7365DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5625447
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smN5oqlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC5625447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeGAAUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 20:20:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37161 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeGAAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 20:19:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so6211749plc.4;
        Sat, 30 Jun 2018 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOF++X+h5N30v8uD5jFzsScxOobxBzvK5fKWDzi8OT8=;
        b=smN5oqlQDpqiVbK0X1ZffRBbpGuP9aKeJrogfP5TqB0qmj4Jf69qCYmqcypx7J0fxY
         d+qk85+7mokiYtgpyyZy3+Nn/3U+hh0/US+Oacp+OnDrbaOgzIZM+fq3rA3WS5ZnHb4c
         7aeOZ154FMjZohPligtIn0tizWMv6Rm1V7EkWpkeiNoudPo9Vs0DjBU1boKt8chD95cd
         Fcc3RQX8lchXulu0VGtGYdtYD83ZTxjUm5TLS21JkCJzsdLDoTN0I+yk/0p0A3lGmPMT
         wpxTD7+QA85IeGDWNXaZUcHmATVeIMNcwfiasFSzDs7+yQCZyPQIr2Rk55ZJjizrRcQS
         TKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOF++X+h5N30v8uD5jFzsScxOobxBzvK5fKWDzi8OT8=;
        b=hFyWuXZrxTd9A790kbvZ4/0eslSeKzsbLaVAv0KZrQbew08+JSvVUE2VwcpKw27J4X
         9qQjk0w+7dEx9p1ikC1EPeWuJBkMLzUau/b8ldxd2EFhvocVSdukVR2/BC3JbqrsxX1Q
         XjI8Lbe0wt+e2Fddj2lj5fIlumIB+QdbDb0Cr0Rsc2WqSzDQ46B0UivJBnDErPP0WIxj
         +aDxhVC/U9A/l15aNK6xkCDKwgjgp+AwA1iA+EUd4TGIsbqSDnZEneo8SVIDYvJpuVTg
         qR9zxsHToOvNk3kxAIvaFubdEKjscJsvkx5Dy8PZd5BiFHMPrLx8hT0Y3Q4nOlVA1Elv
         DpIw==
X-Gm-Message-State: APt69E0OhmH3iv/DfWN+s7M/9xHwgw6Gj6TuQQe9ERGG6Z1PXaPadoii
        EvW2qOosaqE0klfucL05Wi9hBQ==
X-Google-Smtp-Source: ADUXVKJgKJuSXVGzSQH0Uj0WX1wdgYjPgjfYWv5M0lzdA3wf3j2TCNvJvxz0DemwtBO9FLfXL3fiFA==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr20350632pla.125.1530404398151;
        Sat, 30 Jun 2018 17:19:58 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id b123-v6sm8424566pfb.156.2018.06.30.17.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 17:19:57 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
Date:   Sat, 30 Jun 2018 14:19:50 -1000
Message-Id: <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

