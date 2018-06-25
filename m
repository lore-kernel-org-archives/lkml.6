Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDABC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499CB261C8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+M4zR9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499CB261C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeFYWXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:23:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39991 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbeFYWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:23:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so2133628plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=byxY/0OaFbO8Mke8fed7BcJcGU7bAvx1Q3jx0IjcKsw=;
        b=c+M4zR9jwu2S8iSYpKukVTTiHPtq1hqrIWWaIUR9RFQGAQyJCh30hhk5N7lDvkg2WP
         AKNnjJS/jAnKCdoU0YlIo8GOXJ6td+GBrQibYYYgUizVnvKiAgl0iGE6Kj5xS3ElOZHq
         k/vok9OU7G4fygPG2XYCx5+AsD9r7lQqyFDmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=byxY/0OaFbO8Mke8fed7BcJcGU7bAvx1Q3jx0IjcKsw=;
        b=XyxOXKK9/+m5zs5U4H5tZJ+XTUguG8qurovtbfgPpMohrvwqOZJS2+hGKvwQJJ12VD
         hrNKSFud5Bd4tHGRPDlHZ84EdqK/kPZ6YgSPDlLzH01ZgZ6QpP27XXjTw6hn0OyjKrGW
         qSq5vLU27r3weVIdReZqVfj6fFJWe/tnL0qQCTsHh5Tw6jeaXJ+6zaWQ8g0zQtalfE+5
         mWHxBw+DANbzaCjMypjSwVjrtdN1dftegBNpB372J2Kos6Mv9KwJ+xY10GM+pl4ebqi9
         3tT+UgvufyE7w1VZhvBQD/7TsZvGou4Q1POk9o2luBGXBd1shs0JkoHzxqbE5rP/DxL2
         40ZA==
X-Gm-Message-State: APt69E35bWFCIg9ZfpUuyOgd9fRkDWeJIWVVVKM1TaSgkmhFd/QbAMdP
        9P7fVa1dX9asDPHyTqMWPkiW4A==
X-Google-Smtp-Source: ADUXVKK2ReaDFf3aaEsAM/wpoIsVoJzsoozpS3Xf41mQAWRLx/zIgcqyGEfpehM5kNetJ+G9llG88w==
X-Received: by 2002:a17:902:8207:: with SMTP id x7-v6mr76167pln.57.1529965398678;
        Mon, 25 Jun 2018 15:23:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c67-v6sm28805pfj.173.2018.06.25.15.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 15:23:17 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:23:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: typec: tps6598x: Remove VLA usage
Message-ID: <20180625222316.GA5773@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the maximum buffer size and adds a sanity check. While 25 bytes
is the size of the largest current things coming through, Heikki
Krogerus pointed out that the actual max in 64 bytes, as per ch 1.3.2
http://www.ti.com/lit/ug/slvuan1a/slvuan1a.pdf

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use 64 bytes (Heikki)
---
 drivers/usb/typec/tps6598x.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 4b4c8d271b27..c84c8c189e90 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -81,12 +81,21 @@ struct tps6598x {
 	struct typec_capability typec_cap;
 };
 
+/*
+ * Max data bytes for Data1, Data2, and other registers. See ch 1.3.2:
+ * http://www.ti.com/lit/ug/slvuan1a/slvuan1a.pdf
+ */
+#define TPS_MAX_LEN	64
+
 static int
 tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
 {
-	u8 data[len + 1];
+	u8 data[TPS_MAX_LEN + 1];
 	int ret;
 
+	if (WARN_ON(len + 1 > sizeof(data)))
+		return -EINVAL;
+
 	if (!tps->i2c_protocol)
 		return regmap_raw_read(tps->regmap, reg, val, len);
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
