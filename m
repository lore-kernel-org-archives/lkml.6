Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AB0FEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD9B208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWcHP+Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD9B208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeFNGdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:33:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33922 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbeFNGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:33:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so2711633pfl.1;
        Wed, 13 Jun 2018 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WdOdOAf1Z5MZCOEOfueIGfT2YxxrSi5nr1Gi0A31QOU=;
        b=iWcHP+Xr8lsMBOkjhbL7Xkvqe0pbNTY9Ki0uktilAh1yyHK9nBSufxBQF2qDa8QTwU
         pkef22haRKjJvSk/a+qGCVDqqgCPgW/XWNjZE36LIT8z7nnnF+5VDlFzsBysBA3my4Qb
         yXE3ITtCHC5yzd1qVBEe/VLCm0EYBJSV9wIeVGON7mjfPZZLYfWB+ZgikAT16SBYNW/L
         GycDJHpCEKVbgpy2f02BznG7uTx0znAvjHoISxFIZbj4sPJw/1WZ0cq/PqCNh8SmoYoY
         pMfapc1uvcHKtirhVXfu4ClNaXTRcMjTuJ+fImRny0eb/AsnoN2875QUXskKVEWOsrcW
         RZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WdOdOAf1Z5MZCOEOfueIGfT2YxxrSi5nr1Gi0A31QOU=;
        b=RUjWAFlv+V5iO4Nr8eXZ/QFPMqb8N8NAZiK8s4h7BA01pWa68BTyfbuUODjIUun6TI
         3w3bvXUKUmkggrGfZLYcyLkew/d9ZBQgPx0DSTScElg4fxq/sjZKdFHdKr9PfmJq+oib
         OZN6AhAssIm7/56YOy3A6mZWz05SLnmS/FG2B8RNgpGClzCwRVnu2l34UvbJo5BNLR6h
         ZiqvlZhhqFqTuUAr7LM0HIsDH1K6kf2aMl7kgWxoLsfR1tLaGX2xGLkWB5OkaxaHBJo+
         CeTL6eYNGpbrLGtx6AdepCTvwOzHcs1R9ZidFLAzZms3GsQER+tbX06pu3Z05c4ygOrL
         7XWw==
X-Gm-Message-State: APt69E1NM1KswuAwkm6qYxu+5LiqM1HILsxtGd6ThOauno46OiCrZxSF
        tuS3H5aG078bgHUp08LhkV2TXfJm
X-Google-Smtp-Source: ADUXVKIz85cUEvTVIb525SsPRoQwDo5zKo2nKSswtj4SL0XVP56+z/mdk+TRus23LHDFqGWNCQ17bQ==
X-Received: by 2002:a65:5003:: with SMTP id f3-v6mr1127655pgo.425.1528957981655;
        Wed, 13 Jun 2018 23:33:01 -0700 (PDT)
Received: from parths1.sibshivalik.com ([219.65.63.222])
        by smtp.gmail.com with ESMTPSA id m83-v6sm11341838pfi.188.2018.06.13.23.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 23:33:01 -0700 (PDT)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH v2] Fixed a checkpatch error
Date:   Thu, 14 Jun 2018 12:02:46 +0530
Message-Id: <1528957966-24707-1-git-send-email-sparth1292@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <b34abe879f77c55d29ef8a2b1cd9aa0e09ee2a3b.camel@perches.com>
References: <b34abe879f77c55d29ef8a2b1cd9aa0e09ee2a3b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: code indent should use tabs where possible

Here, spaces are replaced by a tab in 2 lines.

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
Changes since v1:
 * Updated commit description
 * Removed one extra tab and replaced spaces with tab to resolve
   checkpatch error

 drivers/usb/gadget/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index efba66c..0251299 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1217,8 +1217,8 @@ static void purge_configs_funcs(struct gadget_info *gi)
 			list_move_tail(&f->list, &cfg->func_list);
 			if (f->unbind) {
 				dev_dbg(&gi->cdev.gadget->dev,
-				         "unbind function '%s'/%p\n",
-				         f->name, f);
+					"unbind function '%s'/%p\n",
+					f->name, f);
 				f->unbind(c, f);
 			}
 		}
-- 
2.7.4

