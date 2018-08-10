Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E48AC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A252240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4MFawWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A252240A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeHJNV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:21:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39712 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeHJNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:21:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so1432314wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PAZ+hHO6mzifWnu0mGLqxbFtSgwpTfqnoTOdHAew5pk=;
        b=W4MFawWzuyvHgvk8TdVaN7PCPzgTtLM3gpuB8fflfcfKdbQzIl8JIhfj1mKUc/oavI
         lD+fHy3QKu0I8BlySNiurcAihDKkadS/BIPh9nnMkLAHa7sgVpa3jqMSijW/4lomXS6U
         Pc3mSkY8CyRsDRqqmCKESHfKQ0ETdabvJKISrelALBERriheLtpuDUht0wbyV6vhpH62
         JandooIpJ0c0YF2dy1ECBgEzImUUyYrk0Bin2yZwCzVgBhYcKnszFKYXp/luFUfHMlTn
         aorTQM/BUyjtDnnDdC6Dm0t5ogRHsS0Uof/I9pjrk8qa3sMuO08IHB9TTQmydBz8eQ7l
         J27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PAZ+hHO6mzifWnu0mGLqxbFtSgwpTfqnoTOdHAew5pk=;
        b=W+KB+HA62Ft3z617ymFQ5PsXfU4arkZH20N1CX7ze9F0xfJPuOOeHWg6w/ecx3F2dW
         pq1zKKdvuLPWvaN2PtrNwQfSuQQLFexZmFjiFkXM8v6SyWPspMsWyhnqItPE/PohSrTr
         wlaP7cUEzKMpmUN32zQSFSxOWnWJn8DJUzXpIEegVTajWOso50eroK0maMgmROIFK1ME
         MiCgEl9wtmXux2VSEbJZbYjgtw1662OvKP/SC+ARtXQEUknLXn7N7Zx7W2F7aeFCUCL+
         s/Zn4mXRJhUlC+OPmI/0nk3Z50GMGspau/iWi3UHHmVIuUZuBpY00R4c9jRrigf0euWH
         hAIQ==
X-Gm-Message-State: AOUpUlEBrV5kBdLmv0P2uicYxVeCaXR+GgKUKQC+hOJSB5FQKMp77Q9V
        ZBdMNFa2wOI4TUxDllm7a2E=
X-Google-Smtp-Source: AA+uWPzSVSyTpxadnAV9kDoP18ZnzVshono/+SPNNGWYPXKGUKeul2iY6qFEXSVKrJqJo0RJ26XWqQ==
X-Received: by 2002:a1c:3b05:: with SMTP id i5-v6mr1225178wma.57.1533898311341;
        Fri, 10 Aug 2018 03:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id p14-v6sm14273994wru.0.2018.08.10.03.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 03:51:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 4/5] staging: rtl8188eu: remove unused IS_MCAST
Date:   Fri, 10 Aug 2018 12:51:32 +0200
Message-Id: <20180810105133.31224-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810105133.31224-1-straube.linux@gmail.com>
References: <20180810105133.31224-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the now unused IS_MCAST.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 4a56e54e38f6..0a952edf8a81 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -257,14 +257,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline int IS_MCAST(unsigned char *da)
-{
-	if ((*da) & 0x01)
-		return true;
-	else
-		return false;
-}
-
 static inline unsigned char *get_da(unsigned char *pframe)
 {
 	unsigned char	*da;
-- 
2.18.0

