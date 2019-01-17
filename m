Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E843320859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io/sFE/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAQTXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:23:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAQTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:23:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so12308516wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pn9peKeCjOHw1qGW+5QieV2N/+CJoxs0j0b8qgy4Tug=;
        b=Io/sFE/ItvbHllAwnH0lN6lhF9rYjH3lcb5QGM4/OENpiuaq5UnNTg4hCXti8RV6G8
         pEJx3LLJ2HCKe2wg5e8O69OkxwxDRrQ58CG94zMyaqjYeO5TpiMumqdK+6bS2cSkm9vl
         WZbogFvjqcA1TeYOqdeMJv3oGK2Utd+IDIcZlgwWlH4DdQoBQv1HT8ryPih7FP9gInsW
         PAE337yP/yiHNo330pl22B3lIm+uSZHJ8Oxv6PEb8x3OoKDRJV2ydWfpv/K2mRKLENe/
         QcMRYqGDyQVX3ffWR9qfDNMiDsM2pzLCsto9ePCIMSiQ0vA5rkEjuFpuC2Cv6uhL/BNf
         eMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pn9peKeCjOHw1qGW+5QieV2N/+CJoxs0j0b8qgy4Tug=;
        b=CFYO1GctWHmbfkyz4kR2zIqsfTaX/15udnq+y1cRbhb6RojdWN97lKpz9816XBUZd8
         i/jjDXFGUS2Gg6JqK84bECz6Ny8Nv4VOmIFJuG3aBGH8R4jpO0yiuKdP+Kw/pRyD38DO
         LQ+PC8mImmpALLKREkujL/5qo3r1qE1kHNY8PKLVHxvGusODNEjm4fr8UsDfVponiuOx
         LxKQV0CnKUOfPiNBlH/8kD+34EqyW1YgQEZ2F3XZIHhjOZI/GMfDFnz3qneLrY/t3C5R
         t1t9fJ1OGgqtaGgmnUMztVnDjDjK6mwUOoxB7CC9NucvkiKm8y7Zw4Fu610Wtx2psDy3
         +qrw==
X-Gm-Message-State: AJcUukdLkE9j/CvDAkns4NU57b9xP2dmFUpDTgi4H5KuSfh74Qkt/8Gz
        0uDuGZWqRquk/hak7fjuTJY=
X-Google-Smtp-Source: ALg8bN6Ruwo9geU2UWl86V0Ftqi8OW9BVLONcHJYIycZpUdf13VwHFMK0Bguq+npwfEv58BP3ICi8g==
X-Received: by 2002:adf:f504:: with SMTP id q4mr13810904wro.321.1547753001085;
        Thu, 17 Jan 2019 11:23:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id l14sm167069378wrp.55.2019.01.17.11.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 11:23:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: cleanup indenting issue in mlme_linux.c
Date:   Thu, 17 Jan 2019 20:23:01 +0100
Message-Id: <20190117192301.17579-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117192301.17579-1-straube.linux@gmail.com>
References: <20190117192301.17579-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup indenting issue reported by checkpatch.
CHECK: Alignment should match open parenthesis

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 8180769610c3..2bc49d074ce4 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -52,9 +52,8 @@ void rtw_reset_securitypriv(struct adapter *adapter)
 		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
 
 		/*  Restore the PMK information to securitypriv structure for the following connection. */
-		memcpy(&adapter->securitypriv.PMKIDList[0],
-			    &backup_pmkid[0],
-			    sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		memcpy(&adapter->securitypriv.PMKIDList[0], &backup_pmkid[0],
+		       sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		adapter->securitypriv.PMKIDIndex = backup_index;
 		adapter->securitypriv.btkip_countermeasure = backup_counter;
 		adapter->securitypriv.btkip_countermeasure_time = backup_time;
-- 
2.20.1

