Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB234C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B2920652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0/y5dp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B2920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJEAvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:51:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55490 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeJEAvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:51:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so9890555wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7c4cPtMAJjhFJ2kJ9mNencpwCvqYGc9xJWGq2HXmQQ=;
        b=H0/y5dp2XY738ieLkdhobUIKhdzTGz3S1tXlLxqYdDaXeKpyjOs/YFQKeoeW+SQbXd
         kaSzJdUenx3+nLWBcG9oDL3FV0Wj5SNrnOq3vqDehbdj7SVBuT0gwbcVcdNZeUhdXzFm
         od27Emuu0N2OI8hfNFZ/vpVkTlaESJSKAcOcpbKVxZ0xiGRDZDr46C1aATPdubtrcb4B
         EhAnkEQe3FZKPQp5XprLHpNM6xBFUI0foPCMouRxD/SZpWAN5BMX55bj0QEY2lV3CCNN
         qJWXJCZb2AVGm9cy/KPt25WfnoH+L9l04RtbZPJ8Ivr32lAfE2kYfTXE8yT+TbxD+w8i
         QVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7c4cPtMAJjhFJ2kJ9mNencpwCvqYGc9xJWGq2HXmQQ=;
        b=cMfCRyEc4PbVyGjnDVbZJtbXDpW0vBhbpbIdLWjwAi9G7D/ma82Dlo28KqE8vEmxhT
         XGPL7YmKZADPcELGpv3yyrLJHiwXNZACQx02+C8QYFck9r40SdDI/PR3KslOmaFYGCcw
         GIQk8hRr95nxmcM888IeAGOdXcnLIXPXrlTk9RGIRy67exBRW1ONLRXK0dU1jNirZn2b
         h3s5UhQdB93CAWfbR8d5deQdDxW41bdpRZEdsPVELdab1dilaRjRfpDx9+6r/goEzp4B
         tmV8DA8tcc/MwLRRNkX+i5IQdkY1Er3WKGLtU0z/1cxFTtaLxWHyRX3v+ybaceNWadtw
         +5fw==
X-Gm-Message-State: ABuFfohFsRnIP0QG3osz9eS3dO8Egbcf4KDXlCDWHUlZFVaL6t6XSnF4
        g4ExaQ+hEnySfewySH2k91SSW/Ya
X-Google-Smtp-Source: ACcGV62VwwbDmBrJBEIEf8cE3nMU76Ba4/3RXnKQbRp8WfUXRQU5JjpSzV8G4ye4BkycOIKkBV6/Ag==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr5750122wmd.51.1538675838486;
        Thu, 04 Oct 2018 10:57:18 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa7d.dynamic.kabel-deutschland.de. [31.18.250.125])
        by smtp.gmail.com with ESMTPSA id o63-v6sm3697353wmd.3.2018.10.04.10.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:57:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: make struct field of mlme_handler const
Date:   Thu,  4 Oct 2018 19:56:58 +0200
Message-Id: <20181004175700.1500-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004175700.1500-1-straube.linux@gmail.com>
References: <20181004175700.1500-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strings in the uses of struct mlme_handler are constant.
Change the type of field str from 'char *' to 'const char *'.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index ade68af15e04..3e8a0ab46ff2 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -232,7 +232,7 @@ enum SCAN_STATE {
 
 struct mlme_handler {
 	unsigned int   num;
-	char *str;
+	const char *str;
 	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
 };
 
-- 
2.19.0

