Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFCC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF8621EF3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgnp+nrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8621EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHKLon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:44:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35669 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:44:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so8953009ljg.2;
        Sat, 11 Aug 2018 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QPcTlp1NiKnU+2Hio0fO9sQfFdRPZwvCWUZ4fYqhlx0=;
        b=Pgnp+nrEh95amwRDwD5aaFLJsCwE+hKpOJEV4ArhjlOudXq2uRDf0V+ejuPXag2xH7
         sOSOSQr/jVNLG971ZgvML8F84EBGMgNJ/7RWBe47hLz/uFBy9fiVNe2OlyuWxpM5dZCh
         OAsMu44yAcwuCuQRulVrFwRg+k8H5zbKXnn1g8CxG3L4RYtovUTtMATKcUacIWgkcFAi
         D7nFESe1SEQWCXkXfSwHAC5KrUQfn/uSmM1hx9lhLj62e3j4k+BkSI8XAa9T7iUOvYbv
         dGax8DEbBCpiR34qpCcxcAapZiIYGKXHG9uzNo7s0mSfdeVlilCUlsLAIbPNjgQPbiBM
         rFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QPcTlp1NiKnU+2Hio0fO9sQfFdRPZwvCWUZ4fYqhlx0=;
        b=HazbbP6n5XZNVhiegJ5CJndMAgwb2T+AOi5br7nrorItxE5FuYvdJLNi+Liri/lLEL
         eQFxRXipbFpUsQ/FHWAqdIFtSOMq/dWK8/GvxOtRZJOhkLJsas4Jn4eICFXfC7uhuYsF
         4RMVXle/C48J/n4Gj3C0siEDLTOMb6Y1AkI6FuA/aohRWN2Ii3mKvv1IrieYS/+ZTDJ4
         G6+1lfZ0VgweAzf1RUqGbi9hOvBsA8uUdJl87JPnWe8c8md+bw5JnLq8pt2wxxBkIHH5
         DTqfh0K9C8HUSQg/QhLbTmtEz86Xnvb4LSQljaXVOl/Z2b0UZLTU1RoTYP06d8bXFrwT
         aNpg==
X-Gm-Message-State: AOUpUlEwLyqRHIyWD7m7wsb+G7La8ovrWtDJ28UcGEtxocBLtyFaygmR
        5UDqoI/NzwMHg7c7C4V/avU=
X-Google-Smtp-Source: AA+uWPza90bVZaKWm7FCfBFANgYna7Nr7QfAyINNwDg/h9edgeTtd0SMotZOZg+4P4T8iEj1K3GT0w==
X-Received: by 2002:a2e:2c09:: with SMTP id s9-v6mr6683283ljs.88.1533978668025;
        Sat, 11 Aug 2018 02:11:08 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2e3af-74736162.cust.telenor.se. [46.194.227.175])
        by smtp.gmail.com with ESMTPSA id x11-v6sm2349093lfi.8.2018.08.11.02.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 02:11:06 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] iio: dac: max5821: avoid using CONFIG_PM_SLEEP
Date:   Sat, 11 Aug 2018 10:47:18 +0200
Message-Id: <20180811084718.6697-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already handled by SIMPLE_DEV_PM_OPS().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
Mutt still read the mail correct though.

 drivers/iio/dac/max5821.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index d0ecc1fdd8fc..f0cf6903dcd2 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -270,8 +270,7 @@ static int max5821_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max5821_suspend(struct device *dev)
+static int __maybe_unused max5821_suspend(struct device *dev)
 {
 	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
 			 MAX5821_EXTENDED_DAC_A |
@@ -281,7 +280,7 @@ static int max5821_suspend(struct device *dev)
 	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
 }
 
-static int max5821_resume(struct device *dev)
+static int __maybe_unused max5821_resume(struct device *dev)
 {
 	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
 			 MAX5821_EXTENDED_DAC_A |
@@ -292,10 +291,6 @@ static int max5821_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
-#define MAX5821_PM_OPS (&max5821_pm_ops)
-#else
-#define MAX5821_PM_OPS NULL
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct iio_info max5821_info = {
 	.read_raw = max5821_read_raw,
@@ -392,7 +387,7 @@ static struct i2c_driver max5821_driver = {
 	.driver = {
 		.name	= "max5821",
 		.of_match_table = max5821_of_match,
-		.pm     = MAX5821_PM_OPS,
+		.pm     = &max5821_pm_ops,
 	},
 	.probe		= max5821_probe,
 	.remove		= max5821_remove,
-- 
2.11.0.rc2

