Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF37C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AAC2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuN6wNwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AAC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKBWJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:09:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34270 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeKBWJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:09:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so1025511pfe.1;
        Fri, 02 Nov 2018 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LKqOY3X2mSF1PqsDxQDTNAwXrcUAZ2hGrrOceQdvoAo=;
        b=cuN6wNwAjLmrd40sXtj/ILSfk7fAk9LiQBtMqZRWFf9LXOlp2I3d/lbVeGNAIP5yGH
         cs+S6Srpd+OQyVxhQwCMdoOsLkTPftnh+65VM7vAhqEz00V+rrb/9yDKsNqOVHDVWoaY
         DLeegtFhhQTO0/CbpAoL5tG19FBUvlMotDE/mwqRbH1dcBYJJ//GuQfheuOlOc35xJui
         AoTvgXt+Ev44GycVeToa20BownYS9Kv4Y+CCigxmDkDKMy50G9DgbTOS6xFLN5EGuj6Q
         ITG+2iQFu3crWJOjkG473LdyAwkPKFFeb98yjUC3QgTq4jX7QA0aOZXe0L3uV9nUEQFT
         Im3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LKqOY3X2mSF1PqsDxQDTNAwXrcUAZ2hGrrOceQdvoAo=;
        b=MigCknlgVopgo/SrCPZkqPKA1uQoh/Peb4UQ8zWkrrYn0QMaAdrge+gt+3Bj7UhflE
         uTm8Qb8pfcqSServdEJAQgVKAFqMIv4lf9bN5gaHom2HH/DCIK+UM84nUYKNN+hw4TXz
         r44wuYSG6TAU6gEAjBk8Q2PpQlNmxBpOIPCwpDYrVsp23nZA++jhKy3SN1+XQJxvLAEF
         J6WnWebIYed397zxoBMEDpCpfiGR4Hm9CZFxWkq9We3N+DNb23G+HzvH54sxhmwHKYCC
         FOobJkR6IwKUqOLTCeZ71IRI0XF02dmVqVIwy4gJa4Ydi4y5y30vqsZtyWW3KgvDlyJY
         aZSQ==
X-Gm-Message-State: AGRZ1gLG1BLXpAw6r6IfmTYp/Tirahep1fhPQwk0fljCv8vVeApctiMR
        3nDs7RJF7sjzoGZM1hqS4c4=
X-Google-Smtp-Source: AJdET5fKtQF6cmeZMkQfOB1Q9Nq0oHoA0JvPPw3NVCq+1wiYpYBhH89RkyTphazhL/JVgY7VcjPijQ==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr11030221pge.391.1541163736966;
        Fri, 02 Nov 2018 06:02:16 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q7-v6sm28205191pgv.78.2018.11.02.06.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 06:02:16 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] usb: xhci: fix small typo
Date:   Fri,  2 Nov 2018 09:02:09 -0400
Message-Id: <20181102130209.24507-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo of a misspelled "Calculates".

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Change in v2:
-add changelog
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0420eefa647a..d4446dc46fd1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4105,7 +4105,7 @@ static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 
 /*
  * Transfer the port index into real index in the HW port status
- * registers. Caculate offset between the port's PORTSC register
+ * registers. Calculate offset between the port's PORTSC register
  * and port status base. Divide the number of per port register
  * to get the real index. The raw port number bases 1.
  */
-- 
2.17.0

