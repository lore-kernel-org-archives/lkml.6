Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF035C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAEA2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Ez4DrqX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAEA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeH2M56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:57:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38565 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeH2M55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33-v6so3363156edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71gVRusD6E2BioSazU9UZHcOJze2HLKeGaU12HwD0ow=;
        b=Ez4DrqX5ptJK9z0WfyP+oXTEqoRXJIseghjXk3JKgRLEAJNrj9vgaBTvrIHIrtCUeX
         41heGLIhj3O+VtoadasG9hxa4yI0lQlgz8TrLfHSxMKU+is0Lpj8f5aL6dIUmeXJ72Kj
         wBSVIch0iX7ahRmvczdbTvzZ8D2ym02aRwj8/mvSglG3k5Ly7SY3t5fvq9rEeuLOCxV1
         yA5s146wgdWKLsEA/Fwu14f5xmAU0jq7TrlJod7RDo4OqtWK/fkOEGBUAVuSdPOg8ezc
         EXvE+XC4BBCUgyRTq4k+cpXDInFIFjZcEpqBsQzQnpC8SV1ZIy+ZHMcq5YIiMhZ/UhFj
         H8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71gVRusD6E2BioSazU9UZHcOJze2HLKeGaU12HwD0ow=;
        b=dnxMnRjxhGq1uwcKlEIz/PPO45NRr3yLicpWJoi+0HMw9IudyZZj59sbEophEf6voT
         lgYmfcYWQT6qmCT8n1MEpohvwoD3d94dVQIa/fXNFmxPq0QjN3fxlkn9F5MnTEQHUvHH
         alrt9woCoZ81EK+C10mC2u24LQ18U0OU1MqRpptIPrUp/mf5u1R6/4hFBwrFaWXpj0Eh
         BUsr25AhZbKP9opHvBC+BzTEFJLxfXhCzSK1VDrN7h4a8o3J3YdhTRCP2LvbUWuf5K/Q
         Wn5w7gV3hPWCqVxCfNK2cOqpbp5NMQwKoLzGeUYb2LjR/ugsysyasATJSseRXS9YJSkK
         KKxA==
X-Gm-Message-State: APzg51Bpy2PpSY9iapJfMwpk7Yr4/qjAT9G8Yd6SGyufbHlDAnr+P4KG
        6D0jsmPV1kbquTaHNHjBpxSoX/R7Pjw=
X-Google-Smtp-Source: ANB0Vda5/VzJkdDmi9aANO1JL9isk2bme6FXWGST922Zd6ohUcFbFKPw75oM7lOEvg78oOJWsGDaUg==
X-Received: by 2002:a50:c181:: with SMTP id m1-v6mr6732412edf.199.1535533321842;
        Wed, 29 Aug 2018 02:02:01 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id a41-v6sm1546569edc.57.2018.08.29.02.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:02:01 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: pblk: remove unused variable.
Date:   Wed, 29 Aug 2018 11:01:52 +0200
Message-Id: <1535533313-29944-4-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused struct ppa_addr variable.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 994a081994fb..22cc9bfbbb10 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1398,7 +1398,6 @@ static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
 
 	if (rqd->opcode == NVM_OP_PWRITE) {
 		struct pblk_line *line;
-		struct ppa_addr ppa;
 		int i;
 
 		for (i = 0; i < rqd->nr_ppas; i++) {
-- 
2.7.4

