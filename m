Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19506C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78AB2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL1I2pqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78AB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHYCns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:43:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36005 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeHYCns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:43:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so8665730wrf.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OtjOmuJoIe4hhjXH87njslSijBnpKl6kPPIEEURSpNQ=;
        b=tL1I2pqZIqbjJ97ZZDKjN8uBbQQY+6ZGUrx00/Eqz6G94IjvYu1ZMrWN+eWbEX9BWY
         JWd8YtNHr0Hkx9fSm6dEY6oiMiZ16yWHMestqk1pROuNXZ6U1zLMQZcVMP26Z2TWfRmz
         JMNdfHP0GfQxmKsjVPRX8vPLy65nhl0Fo0MYCMxhRPPG8WJB6LgBlTwgUcaABDUd3cry
         WkiiwHpQQuTJRC00ZfG4JRpZwUYR8dTryjKInXKZH8NcN8NaiW4Iigc2UGBL5wXf6gj2
         o1u6qheOhOQj1Chx5xPHQjJm/3DcPjbC8RRdOoogia70v3cwO2YqphhpVA+bg95DKAks
         MxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OtjOmuJoIe4hhjXH87njslSijBnpKl6kPPIEEURSpNQ=;
        b=JJHuqTtBfOe3c99VuB/lhbhtlzg/KPrcLt2Guy8RrLg+1Eo2AgbXHOQpAApA+OAzLm
         wcSh2nbJRc7SOdNx/q4P2KUMH8E6qwu6sdHVde/aIi4g/NxSMdZegbu/wZkESDMLsdCW
         0qCFCG0GNorphvmEs9WbkFaXu4lTXVulpR+BYs32H767EC5uxnv4klB131WLCaHJPWGJ
         VTFWo1Be/ezpDdE8KoR2tV/xtsHacdOyMj37sFMBVIypLuR6SYfTy2eWUpYHQ0sBAggh
         Mdn5IFXeSjdyPfxz7IdH67aybPG2NNwQVLWTQxLeKXvPibnh0d5fNfB4zMPxehrtmAjD
         BvVw==
X-Gm-Message-State: APzg51BeKfsy0LlF3mls49E2XuETm3LrHZ8lyIU0EcuggKHLcKabsQmz
        EWm7mp7KIvCTrT5qa66qJprf55iA
X-Google-Smtp-Source: ANB0VdbfitcVfHhVeqUsfjD2mmxM0STKwpJj5+y9b1Edc6GQi6mH5qjAZL9F3NraKoFLfh9IDG5WFw==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr2345231wrm.143.1535152026176;
        Fri, 24 Aug 2018 16:07:06 -0700 (PDT)
Received: from localhost.localdomain (bzq-109-65-61-84.red.bezeqint.net. [109.65.61.84])
        by smtp.gmail.com with ESMTPSA id f18-v6sm8453403wrw.32.2018.08.24.16.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:07:05 -0700 (PDT)
From:   GuyLuz <guyluz50@gmail.com>
To:     guyluz50@gmail.com
Cc:     guyluz11@gmail.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: comedi: cb_pcidas64 fixed '('  coding style issue
Date:   Sat, 25 Aug 2018 02:07:01 +0300
Message-Id: <20180824230701.9029-1-guyluz50@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guy Luz <guyluz50@gmail.com>

Fixed a  Lines should not end with a '(' issue.

Signed-off-by: Guy Luz <guyluz50@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcidas64.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index 63992c0babf7..a85334f53ff9 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -2173,10 +2173,9 @@ static int ai_cmdtest(struct comedi_device *dev, struct comedi_subdevice *s,
 			 * allows
 			 */
 			if (cmd->scan_begin_src == TRIG_TIMER) {
-				err |= comedi_check_trigger_arg_min(
-						&cmd->scan_begin_arg,
-						cmd->convert_arg *
-						cmd->chanlist_len);
+				err |= comedi_check_trigger_arg_min
+				(&cmd->scan_begin_arg, cmd->convert_arg *
+				cmd->chanlist_len);
 			}
 		}
 	}
-- 
2.17.1

