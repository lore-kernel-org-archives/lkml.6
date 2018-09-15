Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5342ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7380520881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWyItxVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7380520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIOLyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 07:54:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38485 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeIOLyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 07:54:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id t25-v6so4035086wmi.3;
        Fri, 14 Sep 2018 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HkPIK++4IPoE0X3IrxwouzNzP6fuFdGXZQB7ulWfZqg=;
        b=VWyItxVCEoISu2gLe1+bUEvIZypKm6xWFbPfthWcV0TvvWO5Kbox4S4YmSgIQ5jhdg
         +oJHzji6bGWkvvygpk8t8ku/HeC4ACbBx3nKjr8u9TBnDW2Ijy172bPgJKJQbAxsCvkG
         1bFjnWOSQVr9goawihCAnWt96VfhWYW6NDHjSNBqD3jmWPtJrSeQ21HXA6keeHhXVwa5
         odA3DvrLeWiNaDPznEuD1WsKAnkEunNg+dem3ZzcmXrtMaTjEC+kxDN0CM59apDAxJs2
         8El4uXu7yXZN/dzYeqyZi4BkJu1wlJoiFdZjV5Kmtq8EhLYwe0JzrstWkdGkWNKZOTl1
         cyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HkPIK++4IPoE0X3IrxwouzNzP6fuFdGXZQB7ulWfZqg=;
        b=KCTs2w005dUW0lJw62J7+WxMsXOmRmGyLirqaOHM8LGQizQ5JiBwXwpcKfBTx+TGGv
         YoBIScvpMm3cNen/NlJN7yFwFis7tdmeS+4q/2/EVf6zM9rjDK8I/iboMpQSFzQsbH08
         ZL515jCitLZYk/07XLEesi58VVPGpLls/VmK9JwuI0lIJdfI/bu5d/hJaH5VZzfyh2q6
         TDBsOowc8xp5EEme+DpCE/pcrHCj5c1Zuo+ZgjQ6PKgrdJFnPoZwVabG802rlg8MsXt5
         O9aOQNLo64emXlQS/UEqOC5dF3Hk6DInzBj/HIgRgA601iEXaTeDJEjfPOjJA/bw6L8Q
         EWMA==
X-Gm-Message-State: APzg51C3JTAfx/5gMfSbQuBkTMLv5hkeyrzYvXO9Zew9og/v2xGJOEyZ
        nNSOhKAKoNLaS6NCpeZHxJs=
X-Google-Smtp-Source: ANB0VdZ10Neyr8eF3AewxpF96HX2BwT67B9FAhokUeiiECRmyOtRVLF4KtxWB+65c/Me2mc/o3ayVw==
X-Received: by 2002:a1c:eb03:: with SMTP id j3-v6mr4559519wmh.150.1536993416764;
        Fri, 14 Sep 2018 23:36:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f18-v6sm8808991wru.51.2018.09.14.23.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 23:36:56 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: mptfusion: Remove unnecessary parentheses and simplify null checks
Date:   Fri, 14 Sep 2018 23:36:45 -0700
Message-Id: <20180915063645.31295-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/message/fusion/mptbase.c:338:11: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        if ((ioc == NULL))
             ~~~~^~~~~~~
drivers/message/fusion/mptbase.c:338:11: note: remove extraneous
parentheses around the comparison to silence this warning
        if ((ioc == NULL))
            ~    ^      ~
drivers/message/fusion/mptbase.c:338:11: note: use '=' to turn this
equality comparison into an assignment
        if ((ioc == NULL))
                 ^~
                 =
drivers/message/fusion/mptbase.c:342:12: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
        if ((pdev == NULL))
             ~~~~~^~~~~~~
drivers/message/fusion/mptbase.c:342:12: note: remove extraneous
parentheses around the comparison to silence this warning
        if ((pdev == NULL))
            ~     ^      ~
drivers/message/fusion/mptbase.c:342:12: note: use '=' to turn this
equality comparison into an assignment
        if ((pdev == NULL))
                  ^~
                  =
2 warnings generated.

Remove them and while we're at it, simplify the NULL checks as '!var' is
used more than 'var == NULL'.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/message/fusion/mptbase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index dc1e43a02599..ba551d8dfba4 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
 	MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
 	struct pci_dev *pdev;
 
-	if ((ioc == NULL))
+	if (!ioc)
 		return -1;
 
 	pdev = ioc->pcidev;
-	if ((pdev == NULL))
+	if (!pdev)
 		return -1;
 
 	pci_stop_and_remove_bus_device_locked(pdev);
-- 
2.18.0

