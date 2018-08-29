Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A06C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C93E20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7hGBU+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C93E20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeH3Aez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36561 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so6827269wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Ksl3+bIKwLGQ87OTts86gobRR5IH4OZwn4L97F05Vc=;
        b=B7hGBU+wjlq06tEa2qHAuDs8M54u3r0bKR1uoFPFDPlfJY02vVfCKMrlItSWEdX4Vf
         QfqY/VxEyRRrKgV4kBYLf/nxvRTKyeDdfmI0gk5zuJUlp6XwbNDFgDbP+MUWGug+R3kG
         2HvxUtT2Wglaeq8wH/jY3KTHwiSVcYrH10VqHa4NN8qK35+z0ux9PPR0XODFZLTXaEsi
         XNVo8sqEtDVw4wNFnDJ2vxERUT2RGTOu/XIMyEnttuHxUuijI3cb9JP51WVyOXrCzc27
         AWl4aL0Umt7Hp639CGFgrSvTN9a1TY+m9AacsTKcPAjBDVzYt2Ox9XQDZ9ov2/afdcG8
         mPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Ksl3+bIKwLGQ87OTts86gobRR5IH4OZwn4L97F05Vc=;
        b=uNu4L1rdN4TGryI/R5y/UUPevVCnNsOKAiHEKNw63M1H3pLxY4C6THj17Na6N8oAw7
         aDD4KYuOwII7lShRteRyPfX6ozExhNG2Cjr5ZhZxJUUDJu+ZPzK4UHzA1+SajH4A4u81
         /E1FbuZ9ttFFjfftJ4ar+2jdbeBMr0ZDsrzdlFU8Zrh2/G7hcpAos/G2AFk94bPkSzcr
         yjzq+76hC0SHN6qyNHZprzahgc7UZ1VylngNlf4Al2Q9ozFA5pEgEeBE5BL6K/k/Ugae
         cj6YZl0u3WIByOfEOCYLOhVYAAq7qjTyOpV1hhFb+YeghdH9+TboGj4jfsYE3Khcibtq
         xdBA==
X-Gm-Message-State: APzg51B7djzYr4vofRwY1N+YqJuVXB1hhakUXCPnCd/IfmRZ+bfsuF0L
        fiHmPFvQF026G2+b21X0WS3RdWhJb7M=
X-Google-Smtp-Source: ANB0Vdbd76LP1X2Mr6OfKSILEZwM/OPErBvBjRw7OrwGRBL+2tZ+xuOqBKSvhV0SrdbBNc3ZY/S5pQ==
X-Received: by 2002:a1c:b54b:: with SMTP id e72-v6mr5396091wmf.117.1535574978329;
        Wed, 29 Aug 2018 13:36:18 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/21] staging:rtl8192u: Rename Rsvd1 - Style
Date:   Wed, 29 Aug 2018 21:35:39 +0100
Message-Id: <20180829203547.15650-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the bitfield member 'Rsvd1', since its name causes a checkpatch
issue due to the use of CamelCase naming. The name has been changed
to 'not_used_rsvd1' since the variable is not actually used in code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 7f11257e2675..132a6da3bf51 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -51,7 +51,7 @@ struct ht_capability_ele {
 	u8	max_amsdu_size:1;
 	u8	dss_cck:1;
 	u8	not_used_psmp:1;
-	u8	Rsvd1:1;
+	u8	not_used_rsvd1:1;
 	u8	LSigTxopProtect:1;
 
 	//MAC HT parameters info
-- 
2.18.0

