Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF63C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD43206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhE3rzcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeLNRfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:35:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbeLNRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:35:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so6206943wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CN1SdvFOtxRNOhBTScq9GG/zR6hniZxeAvKJmAvclro=;
        b=fhE3rzcYuPBtkZvqLZ5s/SCO8lwsFJLcGWzuig16XHjHsjt1wouVsgwQYtDTpxPjhb
         NCbls59FImQtbsJTQ4WjQVVILujOoiPgM+7RZY6UKm8BWlgSjXr1nyhIk9drJg4xJ7g3
         h6s3tRjiIb5DByFNfInpDO76o+3hJMoT41598=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CN1SdvFOtxRNOhBTScq9GG/zR6hniZxeAvKJmAvclro=;
        b=ahPS6jDyCD9aO5TWXC8Ji6vDzR0Aq9f+2fAZTgYac4pb53yb1rWBZAB84pASXUUqrI
         WvailEDOHMVsWD2Pp6lFNOb0nU8NE8+xZc1XKab4549opVAwBO806PvjGCNzoWwAUE65
         8J7DqCs8T0Bxs7fOprpe1gRfkPjm01mzQjj5+4SRujwk10UZDfceTlGxbIOuYPcPPHaa
         jLP2kF8JisUWCpaT0KiYR9uOSjGvrRaQX879MXIAIHnsd3CuaFSYlsUrBNt/iVorwPEO
         UGzNhPMGcRieFkAw+0xS+5xtr/UPHe90vtcIFgey8kzz3LJVBlIZMGVVYmIET1F6n3LE
         xnzQ==
X-Gm-Message-State: AA+aEWYCMttgM9kgPhg6ouKFW55DVXK/lO0aEhLOgCeayduQDr3/aQJw
        N5B/GpbMKkBenNDHi/zdcYVSmg==
X-Google-Smtp-Source: AFSGD/XJE9iY3WRzuqSCEAcUpjQCS7zl6Htdighv0PFPINuVJ0VbidcXIg/zdQIXAza2F65MAdokyQ==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr3372055wrq.15.1544808935617;
        Fri, 14 Dec 2018 09:35:35 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id 199sm6259772wmh.21.2018.12.14.09.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 09:35:35 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, joe@perches.com,
        gregkh@linuxfoundation.org, himanshujha199640@gmail.com
Cc:     apw@canonical.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] checkpatch: add Co-developed-by to signature tags
Date:   Fri, 14 Dec 2018 18:35:28 +0100
Message-Id: <1544808928-20002-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Documentation/process/submitting-patches, Co-developed-by is a
valid signature.

This commit removes the warning.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93e84c9..b737ca9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -468,6 +468,7 @@ our $logFunctions = qr{(?x:
 
 our $signature_tags = qr{(?xi:
 	Signed-off-by:|
+	Co-developed-by:|
 	Acked-by:|
 	Tested-by:|
 	Reviewed-by:|
-- 
2.7.4

