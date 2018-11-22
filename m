Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D14C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEB420684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIO3/Rzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEB420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437089AbeKWAcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36035 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437061AbeKWAcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so9352767wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hoUTYB5KkJTpu+bkxPRKVpze2f+eDEwwGqJaTalid0c=;
        b=hIO3/Rzfoiem1dkBJrOaM97JTZbIBWIRy8UXeByEa639/qyAHa9G1DxPjXNVXTgkSJ
         K2kuraA/QePjdt1eIxs2p/bSuJ7q8N135I/3D5SCuTY7Tu9FiD/qbW4jWtZ/N/Fkvl3p
         gA4t6+67jZ30Y8a9q18ZPSTZ5/Dc1gasWzvcmMQu3TQPk0E9VkV4HME+QLIfh037LNfT
         sJbaPN352QIBUip/3tl1gXvnq1W1B77K6ANip+GV7i1Bxy7qe6MigAt1z+xWvuQ6NJgv
         Qde9+x4iGbkjsAz8Ist6LhO+/Iv0tDCH3eKaA46m6uSpTRotO3kxOtsEMPxunQ8lHaMR
         FTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hoUTYB5KkJTpu+bkxPRKVpze2f+eDEwwGqJaTalid0c=;
        b=PLzEXgb85eK2jNt8RyRnyx13hzIVP3/+8+crx7QqbkorqNLHRjHDwNEhgHifn1yJdN
         D3bqpTwrAARbLUQCWRmWvcmTq1mqTTJMZr/HNOkhUYqwwF4mr+0grFV2Z0jTLiVDHfcE
         ZWGdPHPYDQKbm0nz74YiVdFvwYOXI7Pk33jcqmvrA9azPhwL4gJrtDISz79nNzT8uiQn
         raC6Zc1pwWl62RkctDcQX0uPRubx1Tu2DW2TDU/8sF9/PrGXos4xDN+INh07Uvdcrp6k
         02NEen6akI3RAm1UoQkpijjMxNlFmUKp6pz6l+0L7GenBul5qcrduzXPx41oeFnxDZCZ
         NmtA==
X-Gm-Message-State: AA+aEWZ5YU2cykf/E2jJy/aKGwugRwKJ4i6kE2U9O4sOJtWvs2OePu2B
        kqHdBsCxMeSHp3dBthYAPbAHMFBD
X-Google-Smtp-Source: AFSGD/Ug9KGtmd9n76SXj3o5n5Ex6e/kRjW4uYyoa3Oa35ca/ZEkxFiKscefhxNJB6ZGwlGj0N9rDw==
X-Received: by 2002:adf:9d08:: with SMTP id k8mr2151314wre.203.1542894755512;
        Thu, 22 Nov 2018 05:52:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:34 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8188eu: correct spelling mistake in a comment
Date:   Thu, 22 Nov 2018 14:52:14 +0100
Message-Id: <20181122135218.1703-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122135218.1703-1-straube.linux@gmail.com>
References: <20181122135218.1703-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling mistake in a comment reported by checkpatch.
checksumed -> checksummed

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 5a41766bba68..75b7d8c2cc50 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -273,7 +273,7 @@ static int usbctrl_vendorreq(struct adapter *adapt, u8 request, u16 value, u16 i
 			}
 		}
 
-		/*  firmware download is checksumed, don't retry */
+		/*  firmware download is checksummed, don't retry */
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-- 
2.19.1

