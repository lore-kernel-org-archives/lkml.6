Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16125C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA82E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUcgF9gO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfANCgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:36:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40706 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfANCgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:36:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so14517233lfe.7;
        Sun, 13 Jan 2019 18:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Opr3NrUjHsdMnnvPUkP3p8C3slPySw65l2P6gBVK14A=;
        b=KUcgF9gOacUtg0z2RsOIcf5psNNCJ+F8079/2+r98J5KOcR04FRcZ0ljHyqH7XBidb
         fKslQXOlkrciBbgMerFgi05CLYzdEQnxfACqf3mwUZW9g+Ucc2KQlgpS9K+O+AAL7tyZ
         3Wfs/a0F5BCXpHONuUpwW2WcQ2DR7VITwwso09DJWUAevoQoEXnscJHIzCFDMgpjJxvM
         g7qQDZR+WmphRYH2cQRaDUr1E5zFitJRXsSU63UcXGoi2oFEDF4h/tofLi22nktoTxGs
         /SqmNTlbiN5hY4uGVXFjSzw027agZsWPaaUx54+zhgc0oRMbrx5RY2ZAt4HB9j+86RmK
         XTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Opr3NrUjHsdMnnvPUkP3p8C3slPySw65l2P6gBVK14A=;
        b=etd8jzoPrOoChRVvrleO2fsHKhl00UqPcGq/H7ldY1XZ1FTn+oYj/klSNf9jW3M7JE
         7sWODCxynk1b2T80C9qObbYMCigy/xQiQkQOfgrYwftcUamvl1qedjZzn9dnOYnB0FFc
         KqlTbGixUBg0dCJz/Qki13fUYyL62t1yggOM6r/QR6NSHAgr267FMl2OqgKtn+TzcGlN
         SCfr7MLuHr0xEHV74Q8pRDuNl2XElUCUJIde9XuoNpeECXxJ9ozsIJDZrYVi7W6wbDHS
         lLVyACVjBcnm5CnUg7DUP4f1jwKPxhDbrzzDym3kQ2clv/eecmotd6dq54cBsez4Jm/C
         NVjA==
X-Gm-Message-State: AJcUukcDGcwX9Y4Y/p7GiBmcaryvGn6F6Mt/WC97OW45OSCSuUPzyxP/
        /RJQtTgz1XsCGB1kWz2qYM7kyh6sY/Ev/A==
X-Google-Smtp-Source: ALg8bN50HMQYy075e7ZefJlD5omcvIlmoSaFWBHvv9qPB9OtXZWcA2N8mbGpCedCsXmLT2Mw+MxSSQ==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr6025427lfa.65.1547433394797;
        Sun, 13 Jan 2019 18:36:34 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id m4-v6sm16876897ljb.58.2019.01.13.18.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 18:36:34 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-watchdog@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/4] watchdog: hpwdt: Don't panic on foreign NMI
Date:   Mon, 14 Jan 2019 07:36:15 +0500
Message-Id: <20190114023617.10656-3-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114023617.10656-1-mironov.ivan@gmail.com>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, hpwdt unconditionally panics on foreign NMIs in some cases.
This goes against the default kernel behaviour (which is configured by
unknown_nmi_panic and panic_on_unrecovered_nmi).

With this patch, hpwdt will simply ignore NMI unless one of "mynmi"
flags is set by iLO.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/watchdog/hpwdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 2467e6bc25c2..e2958df46c69 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -33,7 +33,6 @@
 #define DEFAULT_MARGIN			30
 #define PRETIMEOUT_SEC			9
 
-static bool ilo5;
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);
@@ -164,10 +163,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
 
-	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
-		return NMI_DONE;
-
-	if (ilo5 && !pretimeout && !mynmi)
+	if (!mynmi)
 		return NMI_DONE;
 
 	hex_byte_pack(panic_msg, mynmi);
@@ -332,9 +328,6 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	dev_info(&dev->dev, "pretimeout: %s.\n",
 				pretimeout ? "on" : "off");
 
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
-		ilo5 = true;
-
 	return 0;
 
 error_wd_register:
-- 
2.20.1

