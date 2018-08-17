Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC587C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644BD21868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN5MT6ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644BD21868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeHQKxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:53:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38742 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeHQKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:53:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so3354853plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oxYd9tBUe3mIdmHYv7nmihhe+nkMA9/6LfLq4v0CWfY=;
        b=VN5MT6ZK0aWruRix6lzlHT6a6VncoOwgXiW+u8S1+4JCAQhvmgdeL01OPtr8edFQTm
         TyEL0YhYiGTpTDetcWcOq3v/JdQcH8s51MrlQcGFiF4cERpn/g/jI6a+I2hQRvVfghG3
         IKlKtvspzWyyEUz9zKNve5qv5MyRfUQttqyb4QL2VMP8iqY9YFrwQjhfYm8rfrCU/sAp
         4HPTooxnrx3kIbtV6yY02krJwVFA1qFU4ZBPDArk8x0mSMXOg53CltwqV/eVbHbYWrWS
         FuXyl4/XkG8lC5UN+mD9yb6uJjTVGDQpakhl6fnohmqki2mtaxmQbrIE7e2NNnu13IFs
         e98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oxYd9tBUe3mIdmHYv7nmihhe+nkMA9/6LfLq4v0CWfY=;
        b=BpDqvPT8WgnEuenfZSeW2cNz32zVcWzTPaIGiRTAKESO+R9qTsDf8RYyxQOZtXgAh4
         CU598Ftm7RixSSmtpXI8NtHYwJ13bVhP10pcxqB54X5dK0NeOK4+hxwyqpnHUMvDyoR2
         TCdRAz2OM5JAO1/3W41yXNKgITKym+r8G0pVsHumnczkgTSDY1KKnXF0GC5a99iIVbAB
         Wk0uPfPn9VSuAWDb3+xyh50InEKiVsGIdQGwqBpD5h5B87MIJ+OJpUiFpz6FbM0Q+IEr
         8AeHdzFe0V5xw/JQaSJHI8NgHpb46d5PPCat5QDQn2hw4zopoHAgjGSxqNlU2WtuwKIr
         qlZw==
X-Gm-Message-State: AOUpUlHeUebuF3khD6OUN60WOHCZGrpElI1UOUB1XAui+2BwlmH9A1jE
        ThEidp3xw0OFW3cnlHg2L57I/91D
X-Google-Smtp-Source: AA+uWPyYypDi+HTWirL/+VZPQgJ8fzIgPUDJcWuRYmrz2jxxqZFVVHe3qbQ0aMdYPI9s/yr9xaiKUQ==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9-v6mr32384424plz.116.1534492285621;
        Fri, 17 Aug 2018 00:51:25 -0700 (PDT)
Received: from Gentoo-PC ([117.204.240.63])
        by smtp.gmail.com with ESMTPSA id b1-v6sm2045322pgi.91.2018.08.17.00.51.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 00:51:24 -0700 (PDT)
Date:   Fri, 17 Aug 2018 13:21:26 +0530
From:   Bhaskar Singh <bhaskar.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        bhaskar.kernel@gmail.com
Subject: [PATCH] staging: rtl8188eu: Removed unnecessary parentheses
Message-ID: <20180817075126.GA16227@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses and this resolve the check patch issue.

Structure dereference operator have higher precedence then Address of
operator So there is no need of parentheses.

This change is purely coding style in nature and should have not effect
on runtime code execution.

Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 676d549ef786..e611eda11b5f 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -36,7 +36,7 @@ void free_mlme_ap_info(struct adapter *padapter)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmlmepriv->update_bcn = false;
 	pmlmeext->bstart_bss = false;
-- 
2.16.4

