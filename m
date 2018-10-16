Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C71C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D357020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj1LpLQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D357020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJPTxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:53:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34373 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeJPTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:53:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so5593657pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hST1FaPHjMpyd482c7Y6buEAGLstWiyDQ6dUfNNag8=;
        b=qj1LpLQJ2p48+q8yynXkymUaJ1FNnp86gsLPIAQDi/TyaWdzdcWqMYD5WQPPglCr7S
         tk8Xzd5dQ39tIp5SL69xSeV/b8gokbhHGdwjnW6y5QHeKZYRMc3uxS97OOX+gjooRrAW
         s7XOuukicrNapIhaw4npz66SXsCZA5csT28+RYr0BKjBAOpmkUp2T+fv1HajB1kW6kiS
         b4IYnXbI2uqzTOevWMromQ3AXr3079t2MyqrhvcgPc81BsgUCmpXxFkcPFX3X16Ld07f
         CZfpFhS8kuhU6/FZwbKowkrMEF1OR+EuntciLHIVVMNI4aHv6VDNYjRemQUGVhT6YZFX
         O65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hST1FaPHjMpyd482c7Y6buEAGLstWiyDQ6dUfNNag8=;
        b=pHqzTc95SXIR5iW+Ag1LG1fMX48zMaOeFr29U82Oyykb5dDDvx0N6YtlipFc22vyeb
         Oq8xUq/F5m0frvf/4ez+zktC2HX0zQdMqwnzBWtsLdBRKZM++nClQ8cHOYS9lYPO/9sW
         hlLfUN47aewOSsg2BRqdOSVxcLMSDQ7APuAvAJHMiHpMWIdg6W+ymoRDOAtspQ0/d6wO
         o1DoidWwaeL7TxdjLspb00ettDzQWqC/u0U6rhpM+BD0BlaCdTkVT9a8CtLf2c5z5uYJ
         VbLUjsRsCwF2pRf/IIrPaCtOZJcGkkY0aDQEYTuGJL9wubPDMx1TjUEbIH9pFXrWRvy1
         e46Q==
X-Gm-Message-State: ABuFfog5EsLsnVr49rO1V6E/frrAjQwmV2EL2aSc6B0l/SOOLvyzlMPN
        XKbnyChYvIe3OFsVejsdrPI=
X-Google-Smtp-Source: ACcGV61/69fbQBdP/wknLUentAeHpClIyrkfIc8FqX5MTb9+3N6rWL10wUUpu5Y4/naugJy6Cal6pQ==
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr21745196pfd.106.1539691417287;
        Tue, 16 Oct 2018 05:03:37 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id u21-v6sm23028375pfa.176.2018.10.16.05.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 05:03:36 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 1/3] staging: gasket: remove debug logs for callback invocation
Date:   Tue, 16 Oct 2018 05:03:07 -0700
Message-Id: <20181016120309.9082-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181016120309.9082-1-toddpoynor@gmail.com>
References: <20181016120309.9082-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debug logs for device-specific callback invocation aren't very useful,
remove.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f230bec76ae4e..a445d58fb3999 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -109,8 +109,6 @@ check_and_invoke_callback(struct gasket_dev *gasket_dev,
 {
 	int ret = 0;
 
-	dev_dbg(gasket_dev->dev, "check_and_invoke_callback %p\n",
-		cb_function);
 	if (cb_function) {
 		mutex_lock(&gasket_dev->mutex);
 		ret = cb_function(gasket_dev);
@@ -126,11 +124,8 @@ gasket_check_and_invoke_callback_nolock(struct gasket_dev *gasket_dev,
 {
 	int ret = 0;
 
-	if (cb_function) {
-		dev_dbg(gasket_dev->dev,
-			"Invoking device-specific callback.\n");
+	if (cb_function)
 		ret = cb_function(gasket_dev);
-	}
 	return ret;
 }
 
-- 
2.19.1.331.ge82ca0e54c-goog

