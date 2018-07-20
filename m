Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C100ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147C720833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXY+t5xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147C720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeGTEgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33630 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeGTEgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so5617193pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTvpsayB2DxU8Uni61LcJB23ixJ+37hOawg0SdINgSc=;
        b=rXY+t5xXdL9hJOoxXAcrDubvNhOIfIOMb9DC9ilh+AiWIXidu4vJuMeTCNr+Ar3WzH
         0dk+qPlQpHMSQgHL02ZDX7l0woO89tmZVjQZBSkIl19rzkLZ89LMPYVP4GCfLUSsbDqz
         xkxi2JWquX3bSk3ZhCSvLM83ir67Dt65DufkFESnpMcILDhUDrAHgLnrE9CVNVfECaMv
         NLbGVN5RkbWxkqO1fSsW0A3aq3OEhHvViNoCajzzfAcVpswWuROL4WmDgUI626J+r1sz
         lrDpKBsbhmpy/h90jUW7tZ4RySVrUB8vs7gdM59yqLJAjwsi3FnMGQsVVeRvmCOp2DCd
         BZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTvpsayB2DxU8Uni61LcJB23ixJ+37hOawg0SdINgSc=;
        b=Uqa+f0sU6+BwcQbv7wwByJrgQh+5uoSvYraRuKqVc0Xztl2cdeKO6Fh2ZhRTNEjlim
         FiJrXhiqOT84clFxHeSBFkXSpPLwn6pZHFHe8pWsV6rnYiAP8YDKvZvKPPMui0/TP6gY
         VgGQjm9RPVxDgaYe6T3Nu2HFh2kXQ/zfqFR38huMik55cSQuX7plU7kilZX/UxyDBl6I
         rTHtbjQPSyKcJ82jaFoWr0rg8v7FcLFugMktD+ABOUzE/mnAc5UBkHPNsoj0cOt+L+BZ
         TlKvM7XtPrZ7VSxuRBVtIopWcfd/OU32X+lKtHItJMxclOY00EVy2qvzUIAR/q+EnObJ
         /zqg==
X-Gm-Message-State: AOUpUlEiTT7xPLTFwuVtCeaDlJxZgqiARd6767bW+Cs3hzCOyV5yeM6d
        v9KG3lWfNdd3Vox7QGRzjFg=
X-Google-Smtp-Source: AAOMgpeT7Iq/VfOM4vC9JM3GgU8KJwZbthVqsabwHpAqrVfj4IPS03SdllAQAGQjnKnfDNt7veU1Hg==
X-Received: by 2002:a62:6a01:: with SMTP id f1-v6mr472166pfc.156.1532058593307;
        Thu, 19 Jul 2018 20:49:53 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:52 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/20] staging: gasket: fix class create bug handling
Date:   Thu, 19 Jul 2018 20:49:04 -0700
Message-Id: <20180720034920.77320-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

class_create() never returns NULL, and this driver should never return
PTR_ERR(NULL) anyway.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 18cc8e3283b39..53236e1ba4e48 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -321,7 +321,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
-	if (IS_ERR_OR_NULL(internal->class)) {
+	if (IS_ERR(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
-- 
2.18.0.233.g985f88cf7e-goog

