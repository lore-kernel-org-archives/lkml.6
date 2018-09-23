Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE2ECE567
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D73214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 14:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAahLgqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D73214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeIWUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 16:04:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40765 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIWUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 16:04:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2-v6so957465wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=woFvUYwj8BBUHcUvpHe/b1ZVibxeWyq3E5LYghki1Tw=;
        b=uAahLgqKWPG6zuhTKjHidItjFaL1AJRyaWAnlxtSpssBrWzbu18w91Khv8Ejj3lzlq
         VwVTFKkpvxugS3AEAMbdgFm2rWUMzy6Enkvk/mmDL6BUh+FhjA0Truey+qNH+JIHMqS0
         9/O6EarSBkwbz0xJy9l+AhNL2uiVCIWOcosIuZq30FcF91x9Cr72fikT0gGyAHhNx6kw
         WHQvhcnlw0xVuNLPtSnljLrmtiafXmAdNtYV6GtkUf9zN3h41vwstAqqk6AuxOpXl4sG
         u8enNi10lnLZh+mOlQMNMGpbo7iinGD/TXp9cxLRJOv2y4MBUujSeBZj21U8Cpiso4ID
         D7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=woFvUYwj8BBUHcUvpHe/b1ZVibxeWyq3E5LYghki1Tw=;
        b=OrKiDDNaqAB0HNG41AUhDTrf4U/n5+ATfqLx0rt9ovslQ0nyBIPlK24+QZgE7Xi4ZC
         MwNnxtT+J9KHx+8mEfkuGj3gUHkm0AQBpYjjdolc2+dOqeYGIE/e2BMB9vF1ySVb571B
         eogTkMUQxC1JuJjG3jHOHwdlU+Wt61RPV/m5woYrd5HQGegckelYdKkksccz0XoWrnL0
         XLV/EDk7NAAhQE/OAoh7urtDC888xtP33mFbOiaI1O/gEWCPIdiPDYKXYTtBB2yFgAkF
         3JhRLyF0EmSaio0kBzUM08VYO8ms9AWtqdoH+VAd4JuJlH3AWQP4lQTcjfUoALwWQgvh
         YdLw==
X-Gm-Message-State: ABuFfojl3gJae1lqscuN/6W9KZWmlSoh44qskE1CHGnnmdbpmUoid0Qq
        N+jMhCmez1tTwwcHtpIQ/7U=
X-Google-Smtp-Source: ACcGV62MwRJn/RdHvyPZck+Tv/QXgwQg9tgGxCmV3v4/tb5wloIinrNgyamGBUbnQJRK1EO3BiK3Eg==
X-Received: by 2002:a1c:208c:: with SMTP id g134-v6mr4227302wmg.144.1537711605676;
        Sun, 23 Sep 2018 07:06:45 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id j66-v6sm47477498wrj.28.2018.09.23.07.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 07:06:45 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] staging: vc04_services: Surround complex macros
Date:   Sun, 23 Sep 2018 15:06:19 +0100
Message-Id: <20180923140620.14583-5-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923140620.14583-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: Macros with complex values should be enclosed in parentheses

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index d8e660240a44..f818cf2e27e1 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -92,14 +92,14 @@ typedef struct vchi_msg_vector_ex {
 } VCHI_MSG_VECTOR_EX_T;
 
 // Construct an entry in a msg vector for a pointer (p) of length (l)
-#define VCHI_VEC_POINTER(p, l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
+#define VCHI_VEC_POINTER(p, l)  (VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } })
 
 // Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
-#define VCHI_VEC_HANDLE(h, o, l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
+#define VCHI_VEC_HANDLE(h, o, l) (VCHI_VEC_HANDLE,  { { (h), (o), (l) } })
 
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF
+#define FOURCC_TO_CHAR(x) ((x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF)
 
 // Opaque service information
 struct opaque_vchi_service_t;
-- 
2.17.1

