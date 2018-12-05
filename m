Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5842082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkJICTC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5842082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeLEKW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:22:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47020 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeLEKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:22:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so14278950lfc.13;
        Wed, 05 Dec 2018 02:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1l/0ojyAiKky3zgZMFV1e488sd/4sXLGN9k23hLWbio=;
        b=ZkJICTC7+KgKFKtXHXOAGaorjXgnOYlL+WadRCXwuohBEH/QxMbQcHFO0+Ihw7HTiE
         Y0ISX+vL0k+b2Ge+8SRt2/Y8yR2iZQ3RP2fF80K1F1wZfCQjyBqO+X9LYUqc7gx53s47
         SNo3kP3wA7J8FNoFjxLNNmEjWmjK6KjZd6q4llnqQgRtBLZ+0IugNaw+cq5C2ap7oFNh
         xidVM/HEu2YvOA/OdtQNAzPuav1iwSiBFnd/6M8Cc9IT2NidZH4Rp6ZjX7/fHHhrmMN4
         I18qRu4H6c991rfkTDMTYWESgJQQyyPBm1YxUm/kckUaa45NFS7k+Ybupc5HcTtbVzPV
         OBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1l/0ojyAiKky3zgZMFV1e488sd/4sXLGN9k23hLWbio=;
        b=C793LCjHubdJyH+1NIeai1xmN9I0k37Ap4TsgFgnbiV9R0+SDzrT10Um8ibb8OsKgM
         nMH8pvtI0OhW53KXH27zd3CqEVAy5fl0ST/tmbocCVJPS4JZeK+yfLdswNnwuSx4HII1
         hQVIVHAWaZAkq5gDswh41EjyyGX4W7Tg1SEUDLm7RtF8EFfxkWh8G5bD9KKJsM+Pxv2g
         ATUkhQaYnUV7p6zoAUvSUbXJD+Kuw3LXFZQpRRFUc6TG6iTftENtNDJhxftyJj/Sig/C
         dH0cckxiz7A7qHkkzvZ4OUHedca00sceavk/DXOqD6DAGkEvxNu/NJgecqARNbSmnmNZ
         yRjA==
X-Gm-Message-State: AA+aEWYzwkSr+4Un0FHs+F382Uj6SLHW98I64/9qcBgWFptSVXbX3qYl
        SHKZzAU+C1OC4ouqxCs04pb6YsNe
X-Google-Smtp-Source: AFSGD/VurSiUvT9h9EM10+r2S9CIc7UoKszfKgQKxbnwaPCM35Y3glEaw4xrUoUTdepRs1Mo3R8qng==
X-Received: by 2002:a19:914b:: with SMTP id y11mr13132212lfj.98.1544005373159;
        Wed, 05 Dec 2018 02:22:53 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z64sm3422200lff.39.2018.12.05.02.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 02:22:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gUUKU-0005WJ-TD; Wed, 05 Dec 2018 11:22:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] gnss: sirf: fix activation retry handling
Date:   Wed,  5 Dec 2018 11:21:49 +0100
Message-Id: <20181205102149.21167-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix activation helper which would return -ETIMEDOUT even if the last
retry attempt was successful.

Also change the semantics of the retries variable so that it actually
holds the number of retries (rather than tries).

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Cc: stable <stable@vger.kernel.org>	# 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/sirf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 71d014edd167..2c22836d3ffd 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -168,7 +168,7 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 	else
 		timeout = SIRF_HIBERNATE_TIMEOUT;
 
-	while (retries-- > 0) {
+	do {
 		sirf_pulse_on_off(data);
 		ret = sirf_wait_for_power_state(data, active, timeout);
 		if (ret < 0) {
@@ -179,9 +179,9 @@ static int sirf_set_active(struct sirf_data *data, bool active)
 		}
 
 		break;
-	}
+	} while (retries--);
 
-	if (retries == 0)
+	if (retries < 0)
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.19.2

