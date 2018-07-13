Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF90FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9444320873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+HF+Ci2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9444320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeGMLiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45231 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGMLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id i20-v6so11305353eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/qMptHSBgSlfszHX5ZVTEA+BbWxzN5m6BbtmnPh8h0=;
        b=W+HF+Ci2nMxTBxCJ4JxrQ7iGnx80CE6v/V9uW/T+wYfNGi9cc1fhf49jhlXVDL+qLv
         e8J7dkYH7QPIQO7xlQL8rzj2TPYNwhjGsU2+Wdhp00KQvcHkWXHTn6xqVuafe9Or1CS5
         5/oPRTF8og7KPlrjqi5QpwESNHjHcsoWSzGuPDEQVsA24oRWEhGi26mYSl8KHTXmj9XU
         GUkJiN9I6VzgzUZE9ywXrXA5B3tk1aabB/IAjNRQxF0Ni/cti368WZgl71LFv6BQ9hw6
         2zAC/C+D0yb9x8OOyY/Na/KyJKqGwrU6Vqi/pZrd20l7RlfYcSx18b8gWx+ld5iaiFQV
         zTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/qMptHSBgSlfszHX5ZVTEA+BbWxzN5m6BbtmnPh8h0=;
        b=um5xy7pr/OK0qzDYT7qXVeYE7fcBGa7nE4EFd/tf+VV78otuQ3GBtYrSRIqPwokrrD
         /iq4UB2bTfW9yYFMTOqJ1urxlW3X2dEniBLlEU6FnGPL/N/4DioekTun7w/Yvd+SdCZi
         6cuw8KAkBA4AHSVabODCSLb2zIlHP+bUyslmPYbl3hmLRkYsC4D73c16hH6tg4ndS47J
         BmozxGE0q8uCNWjur1DoU1jh1wDjiGqeYzq7fO3z7L76sHHJbjUUBTBkRkARtHJK6k9w
         vzlJpknx1LeYMo6DKVOI0YVt4t2ag/mgZwkPCnNwqyyP8GATWiKsqBb9jnctpg/n75Mn
         qD8Q==
X-Gm-Message-State: AOUpUlGP5zOjKuf20kQLClphRfFPskh6YC+nH3lO1yfspE+ewOOt/1sx
        9BLwNcvWD4eHzqyFmL/PShMiCMCp
X-Google-Smtp-Source: AAOMgpcMsX3dS+4VVtEgoCKx0R4Nh0HYWARyDomOJSUytnxKVLAJg3jL6MGfMR2WpACzJsj/c5MQKA==
X-Received: by 2002:a50:b266:: with SMTP id o93-v6mr6750622edd.173.1531481034384;
        Fri, 13 Jul 2018 04:23:54 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/13] staging:rtl8192u: Remove unused enum label CmdID_BBRegWrite10
Date:   Fri, 13 Jul 2018 12:23:06 +0100
Message-Id: <20180713112311.544-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum label CmdID_BBRegWrite10 is not used in the code, so removed from the
source code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 91b2e9e39368..d69b03ce7bd9 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -10,7 +10,6 @@
 enum switch_chan_cmd_id {
 	CMD_ID_END,
 	CMD_ID_SET_TX_PWR_LEVEL,
-	CmdID_BBRegWrite10,
 	CmdID_WritePortUlong,
 	CmdID_WritePortUshort,
 	CmdID_WritePortUchar,
-- 
2.18.0

