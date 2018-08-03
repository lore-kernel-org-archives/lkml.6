Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBE021757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBE021757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbeHCQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:33:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57194 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732188AbeHCQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:32:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1flbBS-0000ia-DX; Fri, 03 Aug 2018 14:36:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] media: cx231xx: fix spelling mistake: "completition" -> "completion"
Date:   Fri,  3 Aug 2018 15:35:59 +0100
Message-Id: <20180803143601.4211-3-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803143601.4211-1-colin.king@canonical.com>
References: <20180803143601.4211-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_dbg debug messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/usb/cx231xx/cx231xx-audio.c | 4 ++--
 drivers/media/usb/cx231xx/cx231xx-vbi.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/cx231xx/cx231xx-audio.c
index 0025187c28e3..32ee7b3f21c9 100644
--- a/drivers/media/usb/cx231xx/cx231xx-audio.c
+++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
@@ -112,7 +112,7 @@ static void cx231xx_audio_isocirq(struct urb *urb)
 	case -ESHUTDOWN:
 		return;
 	default:		/* error */
-		dev_dbg(dev->dev, "urb completition error %d.\n",
+		dev_dbg(dev->dev, "urb completion error %d.\n",
 			urb->status);
 		break;
 	}
@@ -203,7 +203,7 @@ static void cx231xx_audio_bulkirq(struct urb *urb)
 	case -ESHUTDOWN:
 		return;
 	default:		/* error */
-		dev_dbg(dev->dev, "urb completition error %d.\n",
+		dev_dbg(dev->dev, "urb completion error %d.\n",
 			urb->status);
 		break;
 	}
diff --git a/drivers/media/usb/cx231xx/cx231xx-vbi.c b/drivers/media/usb/cx231xx/cx231xx-vbi.c
index 920417baf893..10b2eb7338ad 100644
--- a/drivers/media/usb/cx231xx/cx231xx-vbi.c
+++ b/drivers/media/usb/cx231xx/cx231xx-vbi.c
@@ -317,7 +317,7 @@ static void cx231xx_irq_vbi_callback(struct urb *urb)
 		return;
 	default:		/* error */
 		dev_err(dev->dev,
-			"urb completition error %d.\n",	urb->status);
+			"urb completion error %d.\n", urb->status);
 		break;
 	}
 
-- 
2.17.1

