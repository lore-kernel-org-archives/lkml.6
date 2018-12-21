Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B8C21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4fXCXVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389224AbeLUH3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:29:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40550 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbeLUH27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:28:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so2106338plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RaqdtYUCJCieQNtJZqwmymeAd3xo0RQ7s0z68Qw6EnM=;
        b=d4fXCXVgKv/RnGcqnZVrs285PR1WONMXGRdsHIkdLA4UCngE/NalIRQgDwI4vnMgjK
         6Stz4Fz684Il7TYq76ET+ZpSm2CV48jF8Qr29wjU7O+TRMsIM0clna8AyX2A9cfwO/VQ
         YFZp+S6rwf3OYHVuaqH//1yrsp0uC6yJ8t5SOywbLFdD113RaO2mZQv1Qh6hkJ38M+tn
         Hzp1OdXGphMhpGUanfA+RQqimzSv0GbFlzEmIhuTv6CBqZ2xTnpq5f+imQ6Z2qD4apGn
         gTH9d26b1Y1arInxzJZfGYnK/KmHcqW/2rIAMzkRPV6A+9sKS493baTj3AAA1f7SyQXc
         d9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaqdtYUCJCieQNtJZqwmymeAd3xo0RQ7s0z68Qw6EnM=;
        b=a/VyjRmGX1KM3tKMj37rU3JAkfI1neiH5rBFNjZWrBIWOjQ70qYW6WATVYSF1osVLP
         fuAPAcEcFQNO5H4Hast5YM1vw81WYE+utH29bP3bXoTJXGgTT/HZXiv5UrQ+USBGa4ZJ
         vgznzTFofOs/DCMOgwVRTKYIpGRQ1hFpBik/n3xhTsutmlCuQrAPUILvuxHHdoCOCbNl
         12Z7Wsaop6RjvWCl2FTK/9VscfvDJ6ns617w+1AqSGGGRUL02YgWKN+8gTGJBBj1ryxD
         n0YhagbtNOX7Wvna26HfmlUFEWT/C97ewOSbGRiCD4MAYnrBb9Lnwo4iYIEeBCbOKtGe
         5GEw==
X-Gm-Message-State: AJcUuke5HD0AZ9wzONq8XLXg//kAZc8rq/ysJ1zI/vX7Nx4iY38JbPBT
        vLx6v2AZxjvvoOTf+zYKjKucZ6sS
X-Google-Smtp-Source: ALg8bN74SOnI/fjEYbyqeJgA4P/baUVCtiTo9IKkOnrGUt9T2vQEHupfJ8i96Teu7UX8udZOJfxmnQ==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr1470918plt.106.1545377338843;
        Thu, 20 Dec 2018 23:28:58 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f20sm27688275pfn.177.2018.12.20.23.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:58 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/5] tools/firmware/ihex2fw: Replace explicit alignment with ALIGN
Date:   Thu, 20 Dec 2018 23:28:41 -0800
Message-Id: <20181221072841.30199-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072841.30199-1-andrew.smirnov@gmail.com>
References: <20181221072841.30199-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(X + 3) & ~3 is the same as ALIGN(X, 4), so replace all of the
instances of the formwer in the code with the latter. While at it,
introduce a helper variable 'record_size' to avoid duplicating length
calculatin code. No functional change intended.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 tools/firmware/ihex2fw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/firmware/ihex2fw.c b/tools/firmware/ihex2fw.c
index e081cef730d8..8925b60e51f5 100644
--- a/tools/firmware/ihex2fw.c
+++ b/tools/firmware/ihex2fw.c
@@ -135,6 +135,7 @@ int main(int argc, char **argv)
 static int process_ihex(uint8_t *data, ssize_t size)
 {
 	struct ihex_binrec *record;
+	size_t record_size;
 	uint32_t offset = 0;
 	uint32_t data32;
 	uint8_t type, crc = 0, crcbyte = 0;
@@ -161,12 +162,13 @@ static int process_ihex(uint8_t *data, ssize_t size)
 		len <<= 8;
 		len += hex(data + i, &crc); i += 2;
 	}
-	record = malloc((sizeof (*record) + len + 3) & ~3);
+	record_size = ALIGN(sizeof(*record) + len, 4);
+	record = malloc(record_size);
 	if (!record) {
 		fprintf(stderr, "out of memory for records\n");
 		return -ENOMEM;
 	}
-	memset(record, 0, (sizeof(*record) + len + 3) & ~3);
+	memset(record, 0, record_size);
 	record->len = len;
 
 	/* now check if we have enough data to read everything */
-- 
2.19.1

