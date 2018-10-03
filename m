Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C40206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quExXl70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C40206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJDBdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:33:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43347 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDBdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:33:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id r8-v6so6053654ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcbDPM+YPlERGymPnPxHphlyyRAb3msvP6XFTGFN7Oc=;
        b=quExXl70PH5cXp8fV189KgS3Ht/+tX21UdOe74V6xq1vxCK8aAyB/O4mNMbPPbKoUC
         S44uJxhmIatWl+f7FWhBbsh8u/SHW3A+S85Ow/aHITknXk9NLpvY6uO6wUQPRggMsk7q
         ibvUJb3OBJIflmas01jSfj0rEuN8wx911PMg/V65LKD/+5a+UIf8G8NZhilcFoTgkgqs
         /Tcd30KqRlACvqQuX3hn37XXNv625t6J2mrupC/TnscnRvW71KWGNGQO/SuMDXj87iIu
         jDIhxtlbGNnUrt8zKX0fS2VylIH6DP26DKjjVJnDD2q3r+HTg6YNtEvjcwnGjGpuQdXJ
         qbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcbDPM+YPlERGymPnPxHphlyyRAb3msvP6XFTGFN7Oc=;
        b=F3jaCPP3/WZNACPMYQxgcEk0es2YabGZqo08r/jNcKVctfqCHOwQ7Ag1Jix1+viReW
         ikejQRhz7ZCAIP0A8bvt/+yz3dWEWAXdImC718N/Q7EZgDy/vchMewOFrdAVAy0kq+nj
         wfDy/bpNF6PVMusj9r0G07qQfRLWhLKEbJIq4bU+s8kS5lC7oiQ7/SDWfa6WWmly3rnx
         lWQQbIN1BarCM0018t0nrFSwATremyf23bn3mA3jTbFEZlx/dq+1TuktNcmeKtxj8cIR
         GIrPVCXdWhRRM/irAXRf5lq7AG5k1vhbhebUV5BTlL6Eqhf/pAsxZEQlTi3HYZi7QpOt
         Yn3w==
X-Gm-Message-State: ABuFfojqE3+uD6nmdDygFwm0CK4XNE5CuBCI6IAvUL+s3ddDFEfExdBQ
        DRowlL0zrlZaXC1RYVqE1S2jpotYpQ==
X-Google-Smtp-Source: ACcGV6135JbYx3BHftyFTMuompeMwooIT7iZaKRRTrXX4pD1UjgOBFFUz7NpYUaD0EPfujUsQ8HSDA==
X-Received: by 2002:a2e:7809:: with SMTP id t9-v6mr1797007ljc.120.1538592214456;
        Wed, 03 Oct 2018 11:43:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:999:51:565d:44e6:f5ff:fe2f:8bf6])
        by smtp.gmail.com with ESMTPSA id l3-v6sm497478lja.25.2018.10.03.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:43:32 -0700 (PDT)
From:   Emil Karlson <jekarlson@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        lee.jones@linaro.org, bleung@chromium.org, olof@lixom.net,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Emil Karlson <jekarlson@gmail.com>
Subject: [PATCH v3] mfd: cros-ec: copy the whole event in get_next_event_xfer
Date:   Wed,  3 Oct 2018 21:43:18 +0300
Message-Id: <20181003184318.856-1-jekarlson@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <13bda116-5766-1340-81e1-48ca899ff41a@baylibre.com>
References: <13bda116-5766-1340-81e1-48ca899ff41a@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
be truncated on many chromebooks so that Left and Right keys on Column 12 were
always 0. Use ret as memcpy len to fix this.

The old code was using ec_dev->event_size, which is the event payload/data size
excluding event_type header, for the length of the memcpy operation. Use ret
as memcpy length to avoid the off by one and copy the whole msg->data.

Fixes: 57e94c8b974d ("mfd: cros-ec: Increase maximum mkbp event size")

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Karlson <jekarlson@gmail.com>
---

Notes:
    Changes in v3
    - Improve commit message.
    Changes in v2
    - Fix the off by one in memcpy parameter rather than restoring the old behaviour
      for v0 messages.

 drivers/platform/chrome/cros_ec_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 398393ab5df8..b6fd4838f60f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -520,7 +520,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret > 0) {
 		ec_dev->event_size = ret - 1;
-		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
+		memcpy(&ec_dev->event_data, msg->data, ret);
 	}
 
 	return ret;
-- 
2.19.0

