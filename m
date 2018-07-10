Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077292089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSinLotR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077292089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeGJOCD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:02:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44476 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933375AbeGJOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:02:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id d17-v6so4588529eds.11;
        Tue, 10 Jul 2018 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+P41hqZdZZn65l3PxiWaQyed9TWgOC00ExLR7aFXcqM=;
        b=DSinLotRtj1G4ncfQCWbWiTT5bGlNkR+doA3KdVBUN4MndqyE00lLBh7HwwIhNqr+w
         oOmk2CfvkSi97DS9zwTcPA10ePgp5A4oXIxDbhv5N7QX4AuKlsOitmJwv1MzSho8aV7v
         TVBV4rai6HjjDYxav7rLgY46CplTTR2JWw8qnkZhKLueNQXwLBXy4rcjKt8UKlp3bNd7
         tB5QzTVmjRh2MBhEPFbb8WZTTJGW46IeC3mYRtgbXLWp1BxLeufFkbaLpw5qhXAjVR3d
         5bCIL9uAPUSeY+Jeu9vV+jLZC3jNLQh+bNNAFudLP2/KBCtaYN5ptXc4K9SCgFQevlXq
         Slcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+P41hqZdZZn65l3PxiWaQyed9TWgOC00ExLR7aFXcqM=;
        b=r6rfI1HCuwNzDWnaGK1ziHm2FL6FckiTIFH6qwY32rx1TYRZWRv6EWky6k4+gNnC3P
         wHuQ3DtbeMn7zRIqGliyzF7AmgFXawcKF05hzdwPHVwaz3e77PeAKHffsVqbHgocfBLV
         UefIQQCx7M5RW8v4HBPkez6gg6Gvfqbmj7vXaXJ2ENOYKGvJ6a3HcFTtcKud/nvBHfhc
         BEGj9IH69sAFmOxGwwOF4CR+ioLvA1ZmxiBM9whufP6C0xR7Dqx4zKZuqV/JIGEqsJBa
         PZGq4HM9odO8RzDvz0Qeojj0CS/Gnl5i+5TzKGlhyskg+52QmUMd9gEkfqk6jKDTnNIw
         SAFw==
X-Gm-Message-State: APt69E1xPf+E0Nw4nDGe4NsWTFSwK8c8qQ2MCfw5FJ46AL6MFh6yRyCl
        yvMTuXAWp0XgxQEF604ttNz8BA==
X-Google-Smtp-Source: AAOMgpeq+GqsgxczMtfpwsejNAfwPxxDzqRWrRGFLYI/8m3h2zIpufhLs30Hr++GFekhnIXkJM9IPw==
X-Received: by 2002:a50:c015:: with SMTP id r21-v6mr26493806edb.202.1531231318550;
        Tue, 10 Jul 2018 07:01:58 -0700 (PDT)
Received: from freedom7.home ([2a02:121e:38ef:0:811f:2ca4:747d:afd])
        by smtp.gmail.com with ESMTPSA id q22-v6sm8296148edd.69.2018.07.10.07.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 07:01:57 -0700 (PDT)
From:   peter.senna@gmail.com
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Senna Tschudin <peter.senna@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] tools: usb: ffs-test: Fix build on big endian systems
Date:   Tue, 10 Jul 2018 16:01:45 +0200
Message-Id: <20180710140145.24687-1-peter.senna@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@gmail.com>

The tools/usb/ffs-test.c file defines cpu_to_le16/32 by using the C
library htole16/32 function calls. However, cpu_to_le16/32 are used when
initializing structures, i.e in a context where a function call is not
allowed.

It works fine on little endian systems because htole16/32 are defined by
the C library as no-ops. But on big-endian systems, they are actually
doing something, which might involve calling a function, causing build
failures, such as:

   ffs-test.c:48:25: error: initializer element is not constant
    #define cpu_to_le32(x)  htole32(x)
                            ^~~~~~~
   ffs-test.c:128:12: note: in expansion of macro ‘cpu_to_le32’
      .magic = cpu_to_le32(FUNCTIONFS_DESCRIPTORS_MAGIC_V2),
               ^~~~~~~~~~~

To solve this, we code cpu_to_le16/32 in a way that allows them to be
used when initializing structures. This fix was imported from
meta-openembedded/android-tools/fix-big-endian-build.patch written by
Thomas Petazzoni <thomas.petazzoni@free-electrons.com>.

CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 tools/usb/ffs-test.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/usb/ffs-test.c b/tools/usb/ffs-test.c
index 95dd14648ba5..0f395dfb7774 100644
--- a/tools/usb/ffs-test.c
+++ b/tools/usb/ffs-test.c
@@ -44,12 +44,25 @@
 
 /******************** Little Endian Handling ********************************/
 
-#define cpu_to_le16(x)  htole16(x)
-#define cpu_to_le32(x)  htole32(x)
+/*
+ * cpu_to_le16/32 are used when initializing structures, a context where a
+ * function call is not allowed. To solve this, we code cpu_to_le16/32 in a way
+ * that allows them to be used when initializing structures.
+ */
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define cpu_to_le16(x)  (x)
+#define cpu_to_le32(x)  (x)
+#else
+#define cpu_to_le16(x)  ((((x) >> 8) & 0xffu) | (((x) & 0xffu) << 8))
+#define cpu_to_le32(x)  \
+	((((x) & 0xff000000u) >> 24) | (((x) & 0x00ff0000u) >>  8) | \
+	(((x) & 0x0000ff00u) <<  8) | (((x) & 0x000000ffu) << 24))
+#endif
+
 #define le32_to_cpu(x)  le32toh(x)
 #define le16_to_cpu(x)  le16toh(x)
 
-
 /******************** Messages and Errors ***********************************/
 
 static const char argv0[] = "ffs-test";
-- 
2.17.1

