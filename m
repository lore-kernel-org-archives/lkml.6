Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9B21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HbuW5l3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeLZBbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:31:11 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52182 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeLZBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:31:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 09ACDBA9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uTds0fPnNsXH for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:31:09 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id CF387AEE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:31:09 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id w15so18491491ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pXuBTsZptzSBlMIYSMguBVj8gxIKjWfbz2dlm++A67I=;
        b=HbuW5l3S8l52PLzHWteV0sLfTkjtXC5QcuxIO6Mu3vyncEJ4rZklQC3ZICgaoU1kMT
         lnf58hazD26tUc3xMk9bytZ3nIexS8Awsdob/LUE3ot+kaz5mmCJch1eJBoROhAvFmFI
         wgu9V+puWmRsDu7iJijkrv7WpzH3EoiSn2aJAxes+Q2lLrN+mXCIc1HtD1xQb1T6kSzC
         Zu/uSvmHEN7N0jnPBKzKuRybfJKDbc+45B9/qQR37iopLVBISy65qea5+UefMzan0WB8
         If27ZsCWXiau24+GfK7fI/VVWFIultEkrjhtVNDXjRH6UzYYi3klZLjGADEA4HM9XKwx
         YzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pXuBTsZptzSBlMIYSMguBVj8gxIKjWfbz2dlm++A67I=;
        b=ZtRUuVBIpKqTwx+ba21f9e7PjVzUxb0pUkjEgfCBiyCFJfvjmvwjQgP05VultnDUET
         fdnQzEanQmcv1vN4thKlOlpP9qKGXCHQSvFaHqCUyJKo2eC86jMA9KVaGWgUr9bptcP2
         a9gQfjdhMbdk58grfbGTqgNbAlQbmhzn9Iw6pWPKqUawh4tXoCiAyvTOe9vruImVUyVU
         h1J1/hy/G6o5ZFnPBB+WNRQv+fF3kIaJdOtwH/blOgWQKVFmeNXdmJEjFm1z4VzhHWms
         nFjwsSKlu2AoXJb0hN/mi6wbMss6kFeRN3Hsd/CWtFQ1GxgylY0vWD1BcfMqkNo+ssyH
         h6Dw==
X-Gm-Message-State: AJcUukdg124AeQAoI/2f33J8tdc8NISmVsYTGHKnaSli9DWdYr60r5HH
        ML2UMtXQyZFf6PI/DSBGZfRRZCMLG6u8mIHytCxMYhlPtShoSvDf28eakyAnDcUKi8Gxlhnva5o
        EFR2NpNz7kAiY9aacB1jt0/Ve3SOg
X-Received: by 2002:a05:660c:b12:: with SMTP id f18mr11636780itk.118.1545787869005;
        Tue, 25 Dec 2018 17:31:09 -0800 (PST)
X-Google-Smtp-Source: ALg8bN53ON1JsxeLFKDzSFKQVK/TPwpISoKU8KdaHl7Hel2UcldG2/uDDgcUUVef1kAwoNttLazO5g==
X-Received: by 2002:a05:660c:b12:: with SMTP id f18mr11636767itk.118.1545787868733;
        Tue, 25 Dec 2018 17:31:08 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id y5sm3084816ioj.9.2018.12.25.17.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:31:07 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Andr=C3=A9=20Lehmann?= <lenneman@web.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8712: add a check for the status of register_netdev
Date:   Tue, 25 Dec 2018 19:30:39 -0600
Message-Id: <20181226013041.70740-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

register_netdev() may fail, so let's check its return value, and if it
fails, issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rtl8712/hal_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 7cdd609cab6c..7e2f8e0185d5 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -45,7 +45,8 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 	}
 	padapter->fw = firmware;
 	/* firmware available - start netdev */
-	register_netdev(padapter->pnetdev);
+	if (register_netdev(padapter->pnetdev))
+		dev_err(&udev->dev, "r8712u: Registering netdev failed\n");
 }
 
 static const char firmware_file[] = "rtlwifi/rtl8712u.bin";
-- 
2.17.2 (Apple Git-113)

