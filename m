Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F19C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAE820874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqN7zquA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAE820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeFTKAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:00:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36221 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeFTKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:00:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so1263042pgd.3;
        Wed, 20 Jun 2018 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b8sxHq2Hg1LmC9J95gsE8Z3KViyec70IXYAnekNK384=;
        b=LqN7zquAKsYAbXk+9u0d5qi/VM4GpOlJLeisWW54y9hPLZAn2YiEtubOoUMyTRJr4w
         UOSIrKnN0Z0yGvAiZloC/RU1wiuN7Iiu9SSPBuCs3BOov+V/OnHvira2dlw2y1Z93cs+
         jv53IC0VN3+BM9TVvHntNanLucLNCDyQ+RiOr4Vjt8JO658H/RN/iZSxw4o0zFFUGnUq
         +qaCd5aFobvCTg5wYJ6tf/QHUMcKFC20Vv0Tr+mr4flwA9uiYWvSr0yzYiO8yt8QRq/0
         HvsO8272BYI/SpFz89mQ2j9gMhNisoBON8V8C/gAkqeBxteglL0CuRGXoJgt9rowdx9j
         RuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b8sxHq2Hg1LmC9J95gsE8Z3KViyec70IXYAnekNK384=;
        b=CWNJKvMds6Cm4xwW3PZyryMacjEY534QT4J/CaKvaAUw9/eaAZzmj2KiHakgW4izSg
         6lBaANLUQb8mt9EkCqeTxnBqRzI++qqP+phfFlBFm92EbEJ/XVJHKHjQaHfkLdyXL4nn
         dSUiLca7jlg5g3DOQRobSI6hSuUSUJGoowkYQrYdMt+cjNyYfsXn4mq3AtGmhcQO1cYs
         GZSCepQ6ZL+x+gJvmC8yeh5hlHn1F8XXvTehyWG4dGO0KwHnAZdrYvkC7AS0irDrz8G4
         RNDTr68OI1r0Wg0Geyif+jwqKmdn6iBvGIQAibHtKWQTXPgZ78zzXkgQgo2rMgapmfRJ
         4XOw==
X-Gm-Message-State: APt69E0tdT63ILPV1yrbYEei/ynU8BsvT45SdLAkVVWjeCBCP59rqd0q
        K7Am7w9PJKM2W5paLRT5HWfatdS9
X-Google-Smtp-Source: ADUXVKLFYF37afgk4QPq0Kold2kWgZWdblSYUr9wGkDZSS/BHmxZV+9oqW0velkoyD9dNC0MpVbzAw==
X-Received: by 2002:a62:a054:: with SMTP id r81-v6mr21849639pfe.10.1529488813990;
        Wed, 20 Jun 2018 03:00:13 -0700 (PDT)
Received: from ubuntu.AD.HARMAN.COM ([106.206.6.177])
        by smtp.gmail.com with ESMTPSA id a8-v6sm4127073pfe.72.2018.06.20.03.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 03:00:12 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, y2038@lists.linaro.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] ceph: use ktime_get_real_seconds()
Date:   Wed, 20 Jun 2018 15:30:01 +0530
Message-Id: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ktime_get_real_seconds() as get_seconds() is deprecated.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 net/ceph/auth_x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 2f4a1ba..99561c2 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -154,7 +154,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	void **ptp;
 	struct ceph_crypto_key new_session_key = { 0 };
 	struct ceph_buffer *new_ticket_blob;
-	unsigned long new_expires, new_renew_after;
+	u32 new_expires, new_renew_after;
 	u64 new_secret_id;
 	int ret;
 
@@ -191,9 +191,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 
 	ceph_decode_timespec(&validity, dp);
 	dp += sizeof(struct ceph_timespec);
-	new_expires = get_seconds() + validity.tv_sec;
+	new_expires = (u32)ktime_get_real_seconds() + validity.tv_sec;
 	new_renew_after = new_expires - (validity.tv_sec / 4);
-	dout(" expires=%lu renew_after=%lu\n", new_expires,
+	dout(" expires=%u renew_after=%u\n", new_expires,
 	     new_renew_after);
 
 	/* ticket blob for service */
@@ -385,13 +385,13 @@ static bool need_key(struct ceph_x_ticket_handler *th)
 	if (!th->have_key)
 		return true;
 
-	return get_seconds() >= th->renew_after;
+	return ktime_get_real_seconds() >= th->renew_after;
 }
 
 static bool have_key(struct ceph_x_ticket_handler *th)
 {
 	if (th->have_key) {
-		if (get_seconds() >= th->expires)
+		if (ktime_get_real_seconds() >= th->expires)
 			th->have_key = false;
 	}
 
-- 
2.7.4

