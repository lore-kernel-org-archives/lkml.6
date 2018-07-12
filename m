Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7991FECDFB1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EF62087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2gOrnBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EF62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbeGLVl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:41:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37938 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbeGLVl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:41:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so7407823wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67yM/hX5NFfjoyMferXSdV2ntq9dKwf+WajB3+uwOUk=;
        b=E2gOrnBcdPQC5eM3Nr9Oo/EWkoPhj8TgLEdgB31bB9bRSyhrGr8HzUyGrMxqnofMWA
         FEJNDFw3fLQMvYQ7fsy+fY6175yn8KrZ2rd83PP8YZIrRK9j5z40PAzHSbVF1fOI58ar
         6Kx2+zp1dTDqIo+YK9dVR00ZXrxUDL0vuXaAY3YDMSQcvE/dDSC2/tWPgeHbelTB4DSK
         htoBBvOsZRVVKBWFvIvzq7REQ/3wQcohONXWtgC2FCXWR65/HDxKrAqdeK7y2jCM3bNT
         uxFlH1p+WbRRI4f0/rqtNXFYQQdh3Ru+yVyT3r4IDuWFoAI2mtwISLotRUSIyB+SxVNR
         Sc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67yM/hX5NFfjoyMferXSdV2ntq9dKwf+WajB3+uwOUk=;
        b=XCy7dNtVjh8CuBFPXVCHf/YjyLTtumpXN6h9UXSWNuo/RIi51uihdE2Pch7jrD/Oa4
         bHM0NqTy+Ql7Xzbc9ITDpG3Bst8nnh1458Tqy9hNWVvnPA0SJZmYKcbfNsPUXnlwgYgA
         j+xf464fuyX8eNcDwe9oGATZptSqaCJPUCYW/n/d75D+Aif+eYBXCesR9bAaD2c+b9Ah
         YWsUmbK/cHKy2F5cq/Db5Gtc4lddguWYIHS+JZ/56vtz4C4ZuGSBuuchOOPfHxio9r8n
         3xeAaN2pNy/Y1J4VKCakgl3W8DGam7ajckZXGNt2Gh74+5JY4JF/Bcd5YPZy7MyI+s3t
         n+kw==
X-Gm-Message-State: AOUpUlGZFwx1uEYlux8wMgxG/FH8phLdZByR8KXGfj4fV32iW8nZjgyv
        29l/P0RLbTt7+AhjZcncqnA=
X-Google-Smtp-Source: AAOMgpdg9jRuuREFrBP6pwEIsbat75Kg56Y5Bb9jUfLSOx4D86zJAVeHE/fl/knIK3hJZUx2+i19tw==
X-Received: by 2002:a1c:e455:: with SMTP id b82-v6mr2520509wmh.93.1531431002318;
        Thu, 12 Jul 2018 14:30:02 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id f190-v6sm10789365wmd.0.2018.07.12.14.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 14:30:01 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/2] parport: ieee1284: mark expected switch fall-throughs
Date:   Thu, 12 Jul 2018 22:29:56 +0100
Message-Id: <20180712212956.16661-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712212956.16661-1-sudipm.mukherjee@gmail.com>
References: <20180712212956.16661-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/ieee1284.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index 2d1a5c737c6e..f12b9da69255 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -267,7 +267,7 @@ static void parport_ieee1284_terminate (struct parport *port)
 			port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 		}
 
-		/* fall-though.. */
+		/* fall through */
 
 	default:
 		/* Terminate from all other modes. */
@@ -615,6 +615,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 	case IEEE1284_MODE_NIBBLE:
 	case IEEE1284_MODE_BYTE:
 		parport_negotiate (port, IEEE1284_MODE_COMPAT);
+		/* fall through */
 	case IEEE1284_MODE_COMPAT:
 		DPRINTK (KERN_DEBUG "%s: Using compatibility mode\n",
 			 port->name);
-- 
2.11.0

