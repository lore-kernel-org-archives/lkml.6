Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD12ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DD520844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJiieiMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DD520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeGPMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:46:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54515 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeGPMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:46:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so4635687wmb.4;
        Mon, 16 Jul 2018 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aXdgQOa4K3aE33M92Th56R4F8AMyuaxLHEjEXJdsbn8=;
        b=lJiieiMUEcpJ6msN6e8ncXqn2GBuM9D/TyM3KIAzxceFQKNBFVdPBkg6ohp+FNalT1
         U5AagopXgjN3Tpp9iB4Q9RKvFLcurLkIPACxD5mqSBwsXgjiKN02Q4XnYleJpOJRAUu4
         NGbL0MYOSv7bbn6+J66i9z+Yy6+aSy4AG/Ws5eQz1I2fkLx38e1ybgx3AgPHj2WgQ3EP
         avRFTQt9XMd1D8tv71qdDzlbUF1HICvg1D0EidP6wB78W5BusV4VnnFLl44WgJ3fE8xU
         cCEpCHY3dIydgH34G0aIMx3rRgYhaimIpf6xlAqG9TaGPIbnom5Ifwqsyz2M5XSAkrLa
         QtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aXdgQOa4K3aE33M92Th56R4F8AMyuaxLHEjEXJdsbn8=;
        b=RLieMG47CgQwqZY3p0obI0NfgA6Y4M1HNY/wTtNP5Trt+ZRdKIG435IzM5TIWZ6jAX
         rEyepQYOo5CXiX/bigZIoK4t9vzC3U25NwHNCdqgsf8VUvwopVD7T7VUk87/3yYniPpR
         Tx5n3g9v9ntQP3ELhbp4JbglLMuLhmbQR587Qx+CKSSxCC5TiRCG2/ghEaom5evkQTPL
         lhQzmklIPPziH5khL6MqFmqtlHqsM7iWLrCamN715/uqLNAEJqdxrzJCcNLGAn84L4O+
         zQEJUZ5f4SgG3pJ19/n1nkIVlZT2dx/polM/cmjKedRd5lChBQn5ygjLV9mQyR59SoHc
         9T/g==
X-Gm-Message-State: AOUpUlHh9quhKULmYxgao41/tvgjE/QWHGUtM0P3inan4lr0Ulh9n3yW
        Jivua0nizRRsgRWBd4q5T7w=
X-Google-Smtp-Source: AAOMgpe/Qt2EJN9tZ4/5h1lloFhjTzyxh7ylLWSSEXCE5iNTQ1IkgEw4ZO6BEvbriW/6RDJghRAYHQ==
X-Received: by 2002:a1c:b586:: with SMTP id e128-v6mr6362333wmf.141.1531743572821;
        Mon, 16 Jul 2018 05:19:32 -0700 (PDT)
Received: from mdionisio-BM1AF-BP1AF-BM6AF.powersoft.it (net-93-146-228-90.cust.vodafonedsl.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id z3-v6sm30264828wru.27.2018.07.16.05.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:19:32 -0700 (PDT)
From:   michele.dionisio@gmail.com
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michele Dionisio <michele.dionisio@powersoft.com>,
        Michele Dionisio <michele.dionisio@gmail.com>
Subject: watchdog: davinci_wdt: add possibility to configure watchdog period
Date:   Mon, 16 Jul 2018 14:19:09 +0200
Message-Id: <20180716121909.4869-2-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716121909.4869-1-michele.dionisio@gmail.com>
References: <20180716121909.4869-1-michele.dionisio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michele Dionisio <michele.dionisio@powersoft.com>

It is not possible to implement setting of watchdog period because it is
not possible to stop watchdog so it is nice to have possibility to
configure watchdog period at module loading.

Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 6c6594261cb7..5f95afa20fee 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -54,6 +54,10 @@
 #define WDKEY_SEQ0		(0xa5c6 << 16)
 #define WDKEY_SEQ1		(0xda7e << 16)
 
+static unsigned int init_timeout;
+module_param(init_timeout, uint, 0);
+MODULE_PARM_DESC(init_timeout, "initial watchdog timeout (in seconds)");
+
 static int heartbeat;
 
 /*
@@ -223,8 +227,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	wdd->ops		= &davinci_wdt_ops;
 	wdd->min_timeout	= 1;
 	wdd->max_timeout	= MAX_HEARTBEAT;
-	wdd->timeout		= DEFAULT_HEARTBEAT;
-	wdd->parent		= &pdev->dev;
+	if ((init_timeout >= 1) && (init_timeout <= MAX_HEARTBEAT))
+		wdd->timeout = init_timeout;
+	else
+		wdd->timeout = DEFAULT_HEARTBEAT;
 
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
