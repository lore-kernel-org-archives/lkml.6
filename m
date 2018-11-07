Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1854C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0E220818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyHNt1SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0E220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKHGQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:16:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKHGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:16:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so16489116wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=P9OsZxrW3wwBpHzc+kNFbzlkckvs+n4/ArAeGi+IngM=;
        b=MyHNt1SZEx9zZ5gGrzTmaH+0dK+COF6ksQEVDtQCsY3j75R3UwMhFIhHjkQI1Y8J9q
         2SZsuUMaCstdfdi1iG/ASBooskwY2gVD+7MSExn71FhWhWEib9H+6x7CiOfepB7v9/XG
         CH5Pqi5xpOi9sxFZmZR0nvTn80U1Ac7wJmv619x/zLCv3tCue62ujdorb5aE2KV/Moi5
         SQ7q1CKBVQHkeow7nliErEBOe68PCjKI6qrz4EjrqcMWHLjsglpeBkq7mmA7F0sf1ZWH
         6mZteUAI7PGKFymuj9MoynEfxgbJ/NuoYiRY5eQiLdZ1xi2u3C8SiESeanLETDBFo62K
         wkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=P9OsZxrW3wwBpHzc+kNFbzlkckvs+n4/ArAeGi+IngM=;
        b=C4L70eFNYYh9fE7HEHyIUh3MaMwZp3R+gePUqSe/TE7ZniW1OTSQuHrBvEpqilFEuL
         xndkDjnfqKABqfRxTfuJTn4w464OOnYJ7lkPdXZIHOGL4d0wKFifoVq5O8iXV1g5wEAF
         71xXwErox4u5XTYk+PuIv11NNWIxswU9LLpAiR8A160PIRBL1ig4KWKv6oEURYmoP349
         DGbeIQC6kTobPmT70UAqGQmXIR7fWRKgYIlVVqDu4YsqburdJPkaf1ogmruKiwnUhQNb
         4mpaH7EoKv5VURsGIXYZJDcI3eKSLqytM2rMG3FOk0BJT2RrVAR/he1tunBltlEHqAQi
         Hjxw==
X-Gm-Message-State: AGRZ1gKWKQKDo5I/Qaf2qn9cfeIeVQFCnwSbgefhPtmtwIF5rsuS9NE3
        etJDzie/P5bMCAUaJWmduVU=
X-Google-Smtp-Source: AJdET5c9iscqDktXubu2CP1KEfnBK5MJcC6jxVPYmVBhN1DV9eSuSkfjoBieps5kOIqgwR2+Ezq2kg==
X-Received: by 2002:a05:6000:1182:: with SMTP id g2mr1650240wrx.310.1541623480062;
        Wed, 07 Nov 2018 12:44:40 -0800 (PST)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id y2-v6sm3578764wrh.53.2018.11.07.12.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 12:44:39 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, chrisadr@gentoo.org,
        areklis909@gmail.com, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: emxx_udc: Added static modifier to udc_controller
Date:   Wed,  7 Nov 2018 15:44:22 -0500
Message-Id: <1541623464-49041-2-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541623464-49041-1-git-send-email-carmeli.tamir@gmail.com>
References: <1541623464-49041-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added static modifier to the udc_controller, since it's only
required within emxx_udc.c.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 65cc3d9..f49c863 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -56,7 +56,7 @@ static void _nbu2ss_fifo_flush(struct nbu2ss_udc *, struct nbu2ss_ep *);
 
 /*===========================================================================*/
 /* Global */
-struct nbu2ss_udc udc_controller;
+static struct nbu2ss_udc udc_controller;
 
 /*-------------------------------------------------------------------------*/
 /* Read */
-- 
2.7.4

