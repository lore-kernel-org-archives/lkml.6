Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1137DC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5440217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuk3Eq1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5440217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbeHDQgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43229 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeHDQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so8052881wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XOjaooObl5XtjTXcMYnB4dbSmbk5JYZhgnoG6lwD5Po=;
        b=nuk3Eq1JYiuMJerooAX/agE8/ZqeyEhU4laqwUVeo0azAeE0UACx0HcgPyl7Bv8tN6
         dHH6PCnftUZ8Ged2YDpZvIDpqJJAVAdWmif0rnEDmKz739dP2f+ndjOJjdS0lUr6ZQWb
         8/eQjCx4d56TAg8ABiQ51owWxwnyevoP1ZUGgQGf+jWfGiYSBLj9PrErf/gB9L7GiDxo
         AFTT59BOIqNplSfpraYXq/AsLBINPweUCnGtKsyNRpvzZiE+v4LZKSxojUgX79zC7rlW
         kJAEK+7Sr5G6xhk6+gjKTMdMF0VLPdPCBAVEtltmecMa6rcBgqumZNI/5ChDDz8YPMmx
         4AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XOjaooObl5XtjTXcMYnB4dbSmbk5JYZhgnoG6lwD5Po=;
        b=WyQy2jnzbAxMnZtVD+CUo2j1pIlOxWYQ/CnYLh9uBnEOll2mPiZUsKttYztc2vXLED
         8U1D0UGiWY8hVzWbEZWaEAEMg19QBIMqZEl6lA5E8/3wBEQhfstYKP6hGU4q5UAb79kS
         8G8BfVKipjO12yNwbmg1HJx1SOyxqe8A2QRhWCcT1R4iyz+aKqvKtf7pnxitVDrfK6TA
         T7H1dlu3y/BWVJk0WcLxTXauLoXkKyFkfadLa7gsB/gefQYWjYaHSc5o9CnqbY6IeT+9
         nM3LVaBKqEH3HOITGZFdQ79ftZIXa2F3bOgtGACz3cqyFcNIS7bXQjhmwz68QrEHHGWJ
         DZCA==
X-Gm-Message-State: AOUpUlE6uNn+g+dnWZMECWgkmLgPjS6BN8GMF89h05dHbVzHCNUo7nvE
        B1cDv5HK0iJ9dK1+O21+3DI=
X-Google-Smtp-Source: AAOMgpcyW5ZBLURMuPLEfLF3UFFAEQxDgfVxBcjxXjgpa5AMYiTTTtrh1yZiAuXzJ7/iv69KDF6agg==
X-Received: by 2002:a5d:504d:: with SMTP id h13-v6mr4979916wrt.18.1533393355026;
        Sat, 04 Aug 2018 07:35:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id x14-v6sm5409149wrv.21.2018.08.04.07.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: remove unnecessary parentheses
Date:   Sat,  4 Aug 2018 16:35:41 +0200
Message-Id: <20180804143543.1500-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143543.1500-1-straube.linux@gmail.com>
References: <20180804143543.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses from if conditions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_iol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_iol.c b/drivers/staging/rtl8188eu/core/rtw_iol.c
index f7a86eac738e..fc3c66201e59 100644
--- a/drivers/staging/rtl8188eu/core/rtw_iol.c
+++ b/drivers/staging/rtl8188eu/core/rtw_iol.c
@@ -12,8 +12,8 @@ bool rtw_iol_applied(struct adapter *adapter)
 	if (adapter->registrypriv.fw_iol == 1)
 		return true;
 
-	if ((adapter->registrypriv.fw_iol == 2) &&
-	    (!adapter_to_dvobj(adapter)->ishighspeed))
+	if (adapter->registrypriv.fw_iol == 2 &&
+	    !adapter_to_dvobj(adapter)->ishighspeed)
 		return true;
 	return false;
 }
-- 
2.18.0

