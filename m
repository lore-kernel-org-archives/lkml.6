Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2FF20873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq1vIHTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2FF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389332AbeG1Awx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbeG1Awv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id t13-v6so6549392wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jq1YxdCr6W4QQHn54BgEtJEOsaXEBiNTt6GiobGya/I=;
        b=Cq1vIHTEYaz1AVYdfScVPSK0xlAIgxdPtkkOUYmf10wXfxgQP51WmYK9mQGit24KMc
         yPqYRrSGNsPi+xZOq0V9GDPUC+CTsIbhn1iaPQX859KDv0zc5bfGabQuy5nZ7Bx0fR0K
         CEwdBjS+YPSS8nCkFTafFR165WB2/3opCprvtsaopwcqsrIzQr/GgQ5yPRNOAmwIfcca
         GMEDzIXg7MDBicPzAzN5xBLLHi8cL4OxaY8eDNCsWJMwJvRARonyFIrlNg+aDB7BcAxH
         lKhX57y+i2/DtR9ekbyP9QgV0/kmm9BqWBqiebnHZxXHUMQkeUb9UK8FIMbKcJ9fgUJM
         vKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jq1YxdCr6W4QQHn54BgEtJEOsaXEBiNTt6GiobGya/I=;
        b=gK/7qhydcbqsUUUHS3bdyQtmqxiI/sBtZtc1H7nS0a750uCSh0dVCZ8m/RKIey969l
         rbBXQOuDL3zqPy9xRPdKXKXUmYnE+mmorH64pJQyFQW1Fc613hE5OqhG/+JpbceFNWEC
         Wj1o3kV2jPl+K6U/LGprwybUYps8xc7qxEnsJoYFoKEMPM0ib3VbGeFwVpW8vOFmfvE8
         +jTXvLr21FOK8FdvatHHD2kvEx0LLc8moVcxCb+eKTZXneNA7qidU6e70KngMMEQuIYO
         8ihMcJXXzElc1IZhR8Gdsrtnx8RuY/bGEbYuIZA31RfTwk2ZtoRQnl8NOuPpwWvpqFAC
         D7fQ==
X-Gm-Message-State: AOUpUlGerqpFy888i5BX0ippnWaWwDfCEbr2mcOk2mbGxo70hFyU1YHP
        qcPmi2L8z/zdJZKkL8N5P9es1LKQwwY=
X-Google-Smtp-Source: AAOMgpefdSS6dK+7qVZrppb0xnN81jrkay7RBa76GpWG9o2HtKQx+qcJRn8vdFzrLOUG1rP1i5Am1g==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr6935981wrm.94.1532734122049;
        Fri, 27 Jul 2018 16:28:42 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/10] staging:rtl8192u: Remove unused enum dm_dig_dbg_e - Style
Date:   Sat, 28 Jul 2018 00:28:22 +0100
Message-Id: <20180727232826.28014-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type dm_dig_dbg_e is never used in code so has simply
been removed from the source code.

this is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 22e25a5cf40a..450bcbe3095e 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -110,12 +110,6 @@ struct dig {
 	long		rssi_val;
 };
 
-typedef enum tag_dig_dbgmode_definition {
-	DIG_DBG_OFF = 0,
-	DIG_DBG_ON = 1,
-	DIG_DBG_MAX
-} dm_dig_dbg_e;
-
 typedef enum tag_dig_connect_definition {
 	DIG_DISCONNECT = 0,
 	DIG_CONNECT = 1,
-- 
2.18.0

