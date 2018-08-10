Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F9DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD71622456
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9r8pfTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD71622456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeHJVqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:46:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44581 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHJVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:46:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so7930315ljq.11;
        Fri, 10 Aug 2018 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NM4jQVeMG08+a8Rtopg+VzU9HMLBx0Bh52idZOyGfE=;
        b=i9r8pfTUkFdpxloKjmxEGXa8bHul47dWHMX2bOHiZFRWDO9tgqfadUfzbZ80Fkadop
         cqaBunriEuwK3Svz1vpUS4JYFngBHDefJVRpHiCVn2/l68anH66zzJYvDFHW/kt3knwk
         cwioZVaNTWszZVShWC1PWCo8GP5V6fRj924M6XeBcZ6MwKO9Hb7BgWNlab48pzP0FhfI
         Iz/3aHlbjdj0yeEteMYgsi6swfjXK7oTsagYmnRqtXnRGFMkTl/+4324hQLOaw4xBaU6
         jLoHpBctTQz9XNJEfJLyANB9aJHpb12BJWb8NsivxM9vBP86ekEUuWf6+0Y/+CANblo/
         /d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NM4jQVeMG08+a8Rtopg+VzU9HMLBx0Bh52idZOyGfE=;
        b=WbSa2gw8lmRG3cDzSjF5vUi2IfQj5WY39m9hMtGQwvMfhNxGwAoL4R588v6CXzlgTB
         X2KprsmJUwf/qI5lNIzWdwRjrYWPjdjAQUgngfWGxlcck3cv9itWlLMQOw3ydOS6ezF5
         tSLqzYR1mA4Yra9cOu+1lX5xgk5pVzAa4HhK6Z8KOTOCNc1z0iSM1oBo5v/TWDPu1Rw3
         uzGyuO5nEan0v6Dn9T3So5H8fRcmAhGZxr2kjzsVxf3K8U7zNJ1Mu/jejvDysKXOdd7Z
         k4T4ZCaIncKKFUErjY8sJxM8H43sCFSrtALPWX3GzINnty0XPPNEv0+5fJgKUocV/hjr
         gvAw==
X-Gm-Message-State: AOUpUlGz4Wj/6SXzRB0+iefkLDM/OCYyyrZ+XX5OGCDzh4OI5sijLLnQ
        xbXQF8tLVN+EDD9Dgpbxfx8=
X-Google-Smtp-Source: AA+uWPxvxJlQyQvFGZXRBxhldnTRtAgR9MRsgv2FYPLfWo/QbzDP2onkCTolx8i+y9h8xsKOd98mQg==
X-Received: by 2002:a2e:6304:: with SMTP id x4-v6mr5937636ljb.9.1533928504099;
        Fri, 10 Aug 2018 12:15:04 -0700 (PDT)
Received: from localhost.localdomain (c-2ec24faa-74736162.cust.telenor.se. [46.194.79.170])
        by smtp.gmail.com with ESMTPSA id d23-v6sm1734931ljg.17.2018.08.10.12.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:15:02 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: max5821: avoid using CONFIG_PM_SLEEP
Date:   Fri, 10 Aug 2018 20:51:09 +0200
Message-Id: <20180810185110.12710-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180810185110.12710-1-marcus.folkesson@gmail.com>
References: <20180810185110.12710-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS() is already doing this.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
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

