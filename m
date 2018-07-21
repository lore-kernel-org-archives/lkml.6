Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51290ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0770720858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2++YpEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0770720858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeGUNuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46981 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeGUNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so9016060pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+xqQH42AHWVqN+bkEZOAkIfwyNU3aQ8/q5uyepghOU=;
        b=d2++YpEYgJZKS60QZNx7De9uBeMRj6m7GL/AO6tFogGRMaE3S4Jnq+C7R08qOtznm7
         OflfrtXHTs47jfGlsnW4yYV+VvvO7c34C7VpTiuWswuOMh9XnFYYfm3VIzJ9oEf+OBzM
         lBtyQlpJW6WpQJeEsYOUKWzrBKITAUGd5AlHhS5468C1SQT/TZ2q5NgEEuGSAsbriwz2
         awnMFFaxp3GjYiKZmFCJXCjmKk532p+bSrv1Gsh39qdGf+LN4IRKN7oNFg8IsoMi3oiD
         UzcMHeQcnOJ61LToe0e+5cEdRjIne1BsgsC/2ZuRoPsxhWjkT6I77I1EGb/JaKlhojBw
         dapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+xqQH42AHWVqN+bkEZOAkIfwyNU3aQ8/q5uyepghOU=;
        b=FAR0Als3LhiNcRYcIcNq+MtbqNtHhkiv9hvqZY46B1Z9vbuVWt0j9Ex2KQ4w9N2ZPE
         s5Dd1ErRXkv7324W1CrcbJKppt71iBq3ZMycCKNKHZKWfZft2Ep2IvlCASiJ/vr7MfjP
         DTXl9phUm8RIBcBu8OgFUIGwW22Hm6LFeo4a9PkZno/iVYUe087e4TxQmhV0NXbd7ers
         zf4fczJQJIJICr+gWRMtFG3o1ZnH4xhRtjbbVjnb9pBJiuG24iDNFp56KgNYDDgYee9s
         YJ+AJN34QzE6DnAG7IfcyNnI4JYBMeib0c0mrlq4BYYhkH8NL1VNxVKFnJrgrHO+FtO7
         P9rw==
X-Gm-Message-State: AOUpUlEZLBFYmPonxUAuUdLyS3VBvAL2m7P/CcJkidgv+kaFLMPJRNnZ
        gJQTuR/3sWoQoLfcPHnFVio=
X-Google-Smtp-Source: AAOMgpdxtsWIpLq+fqgsVdl/Eco1n3Olz/Xbk4pNywb3mii6+y7ga+0B9qHsVOXmMTUOqTm+/PkkRg==
X-Received: by 2002:a63:5055:: with SMTP id q21-v6mr5368935pgl.397.1532177854867;
        Sat, 21 Jul 2018 05:57:34 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:34 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/14] staging: gasket: fix check_and_invoke_callback log param
Date:   Sat, 21 Jul 2018 05:56:41 -0700
Message-Id: <20180721125713.88501-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The message should be passed the callback function pointer, not
the pointer to the gasket device.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 40e46ca5228c8..2cd232230845c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -205,7 +205,7 @@ static inline int check_and_invoke_callback(
 {
 	int ret = 0;
 
-	gasket_nodev_error("check_and_invoke_callback %p", gasket_dev);
+	gasket_nodev_error("check_and_invoke_callback %p", cb_function);
 	if (cb_function) {
 		mutex_lock(&gasket_dev->mutex);
 		ret = cb_function(gasket_dev);
-- 
2.18.0.233.g985f88cf7e-goog

