Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF7C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F61B2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhMmFdsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F61B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeJAC2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:28:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbeJAC15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so3267078wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emI8eNHL+cFMrC8CWh2+bUXSzzhtSu5PqNifP8u47HQ=;
        b=hhMmFdsncesJZvIJcHTW+MObun/R1eNVHn1Srclin2E/3c9s9txEXqdJ/TXpMETYJu
         RjUi8PAkyULxPIfo1qMCwk16i9vimt41KOcqZBBaSl26ERnHeVNM91NdT65QbzJjLpuq
         yXLg99TKY2assBfRSwRxC0D78k37GJ9G6bbN6cepVRkmjHlk+ookFkJarLTpTBFCiWvs
         QQDqMwCxKuDO01fZpC1S1gsRxu5VeKOixe6kopSbWedHP9UnWq9P2AJX5btfVObQKIAX
         CHU27dvdmSriU2sioz9okzapOh/EeWQxR3SuqJFVeWUkXomQ1g+rg1Syszst0g/nBdDM
         CmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emI8eNHL+cFMrC8CWh2+bUXSzzhtSu5PqNifP8u47HQ=;
        b=ZBnKW1NmlSeK7oKA+Vmsh8gFtabn9a82eZ9ivVfB7+w+lHxImSk+6X34ikdou3C/Cp
         8njbj94JiCyUMT8WW8NHUCaUTh9Wu/jC+S4lALKCExoMROkXKyKattkPqF+K+An/oKdk
         wcQ1jTWjPSE5P//FxWi5HOaUZFFcrtVJOkxRD0dVQCXXwZ1BmaQHlQtV8fKJnLfMNCAd
         q2YpQsAs5VXYx/Yw05HX3Alz/G0X6qh8kDTTeTl1+obkL6VJRLQvFu/YuVUVxXud3HDB
         meDRaVsu7YhpTCbqSurmDEB9jZyiqYHs0HZI0MOLU/OSISKRr16UZdxeT1JEpqdto9wE
         KsPQ==
X-Gm-Message-State: ABuFfoj2QzbhyxvVCQsFkZtdjQg34Vy3AmLEfWvqLwy4CgWZXyQ7fzIW
        JcTZfJUmL1kbrKm5FoF1yQ8=
X-Google-Smtp-Source: ACcGV60D5UorPXSe5JQUJz+GsXoXbe+IMPZjNVbKsqQQHRv/6U3OUuC1/8FT5qyIEJ3eX8cp00HeTg==
X-Received: by 2002:adf:ee06:: with SMTP id y6-v6mr5292245wrn.318.1538337217001;
        Sun, 30 Sep 2018 12:53:37 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 18/19] staging: rtl8188eu: remove braces from single if statement
Date:   Sun, 30 Sep 2018 21:53:09 +0200
Message-Id: <20180930195310.1531-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single line if statement.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index f42668eb37e4..9f674bac3b96 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -90,9 +90,8 @@ static void dm_fast_training_init(struct odm_dm_struct *dm_odm)
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
 	u32 AntCombination = 2;
 
-	if (*dm_odm->mp_mode == 1) {
+	if (*dm_odm->mp_mode == 1)
 		return;
-	}
 
 	for (i = 0; i < 6; i++) {
 		dm_fat_tbl->Bssid[i] = 0;
-- 
2.19.0

