Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E81BECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31C22054F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGozjLkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31C22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeJ1FLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 01:11:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46902 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeJ1FLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 01:11:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id i4-v6so4549034wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IgxKR8/O43yuvNRXagIn2SRWHr7egVNk/e92BJfxOU=;
        b=VGozjLkvQAZemMqy/nuKOTuvvkB1R96Xclb3GRluGxFyRa0dnFUFQHmQ3ot6PkItJ3
         4ns0BsmoMhuzVd20BlwQaW/Lmt/6uL3T9Az2JNM3x8FdpSlP3ZqzFPDKyE3smo/jBKA1
         ELX4Rgo1AIcnfrpZbTlf2dwt2kVNppxpvA7bzm6hlob7t/IcYibhyFBE5XQ4gKKuxbxR
         tzO3Iv3829Ung+wH6o7cKlwq16h3Xy5I5vW6VvZWXnI6TAtztbb3yd9kkxQD65ojy1YS
         r+J90KWF/njjJRaxKG3dFSrkcIfgzI/zS1kTvtGFwYZx5fAE3k33IXj4Ix6wNg0I77WA
         Qy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IgxKR8/O43yuvNRXagIn2SRWHr7egVNk/e92BJfxOU=;
        b=Cyhmn4GQbj5OsDO3cTxEKfD8vq9o8ZCmJeUOjTo+maSAfyTJri5FATSFn9gJlu5g4/
         UDdVPyyfzsErPkxNG/hr0vh6Z0Z1yejT4tZUG/Q8av4nUMae25x0Xg0c2LoyoLKnefvS
         mL3RP7BJFx7pxLz7z3tYA8FDyT0t+db/qbmoopc3N71DyoPe3CyESsv3V7rK59CvNWGr
         JGxHv1MnURY7vqDhB/1Ym8L0pllm+71mEEGUgPKi7kgpp1xVd+BoInKczPqNAAGLRtDv
         oC2RUtvBpHaLmMV19X9VrSgHh8mm/pzmVM7dNzSjlNkyFZvvzOrlJrcRY79J7JZYK4HZ
         N8yA==
X-Gm-Message-State: AGRZ1gKWc3SwdS39FpNPjWD8kdQ6g5gwh/203Dm7+m6gaf5SU+feraBz
        T9Z/8v1eRLsEWj1NWT7Xhzb+o5ho
X-Google-Smtp-Source: AJdET5cBt8UfUnMrfXqCWFoLIcbC68Rv5rP08fXLohj9RSxJHafN2UYsSeo2+0A3w+AOwz2uuva/Uw==
X-Received: by 2002:a5d:4e01:: with SMTP id p1-v6mr7515857wrt.320.1540672143942;
        Sat, 27 Oct 2018 13:29:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id v16-v6sm5335784wrt.32.2018.10.27.13.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:29:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8188eu: cleanup long line in rtw_hal_xmit()
Date:   Sat, 27 Oct 2018 22:28:50 +0200
Message-Id: <20181027202850.25636-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181027202850.25636-1-straube.linux@gmail.com>
References: <20181027202850.25636-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup a line over 80 characters in rtw_hal_xmit() by using
if(x) instead of if(x == true). Also clears a missing spaces
around '|' checkpatch issue.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 35bc8fc32db1..a72e069269b8 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -611,7 +611,7 @@ bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	if (rtw_txframes_sta_ac_pending(adapt, pattrib) > 0)
 		goto enqueue;
 
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING))
 		goto enqueue;
 
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-- 
2.19.1

