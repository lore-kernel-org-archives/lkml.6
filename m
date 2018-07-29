Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519E2C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31B720857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMapNyW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31B720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeG2Skv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:40:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53941 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeG2Sk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:40:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so10546512wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XSF8o3Id0Zgpcd/q6+maD80rTPHuqgWeaMtipuETFzg=;
        b=JMapNyW92eQG13tn9WTZgHM+5kdUV94Bl8FQuIufnIBeb13/R4zrLJ4a1IpMB8XMQg
         2ehqF+44Tdwmr3TW5fJRIejQVxEY8D7mRoy1rVhjONEBnzcYhaVGtDwVunHfVOhsdIU4
         pFYX+3ZdeUpausEvIjL7J/s+3FrYGjndtTe1NePM63FjrBopJAk8uzSLRwxWwi3ueHN+
         7/wO05KxXCub9P0tetwckLgOsJQMOoGwdijnZMeKD26TSFOshkkY5aeAIRgha9WYXAWx
         OxXWSSivJ3Nf1vSu7g4UdfCaluYvpwNArrK1JkFDO8GR3uzcLvClEfrkSQPl8ZdRSmUf
         EXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSF8o3Id0Zgpcd/q6+maD80rTPHuqgWeaMtipuETFzg=;
        b=kHdn5iUeL5HLUy9rb0W1H+n1QSRQ/ZX9wgjdmKpaq+tUAZCBPr8NBJ1VI3LvhoW9yB
         TvqWfDzbXB+gACYoMwfmoxU4zjVmtLi/cbVj9VHuC+TjWXPMTimd2NakjvZB/2J1jxvT
         Q6YH+toeZi4Ixg+3hhKdJ+eHEgenoOXm0u+4pXOnEpHcvd4F2rduz8fzmuWvWyzDbAvx
         yYHRa2v/To+uTLFFcVpRAhwO23BB5wDybIMqonOrnHBe0T9u/MnI95ep/Evj50JAQJf5
         WZ9MPQHE2ho9z9IrGA1Q7F9l0BMle5Je2+LgMpjZrxVzVudO+OVdLyo1jlSXcs2fJL3s
         3HTw==
X-Gm-Message-State: AOUpUlEKRG8rJtuuX020REhK/Vyral7ClMV7lSkB8GjJz/BqkmsaiY7a
        pT1YREjz9X256cjoWbH/OPXb4p/v
X-Google-Smtp-Source: AAOMgpf63Ci6ckh1IPh/07sJjqWoDosoe0I0cRuEAK2Pr+2Qet/1VAD0YUQKz8AwTnYXfPvN62I9Xw==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr11970856wmc.107.1532884160024;
        Sun, 29 Jul 2018 10:09:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id v1-v6sm19916360wrs.34.2018.07.29.10.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 10:09:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8188eu: remove redundant includes
Date:   Sun, 29 Jul 2018 19:08:47 +0200
Message-Id: <20180729170851.2581-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729170851.2581-1-straube.linux@gmail.com>
References: <20180729170851.2581-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both osdep_service.h and drv_types.h are included from hal_intf.h,
so remove the redundant includes from hal_intf.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index aaa1718ca603..0baf4e616b6a 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -6,8 +6,6 @@
  ******************************************************************************/
 
 #define _HAL_INTF_C_
-#include <osdep_service.h>
-#include <drv_types.h>
 #include <hal_intf.h>
 
 uint	 rtw_hal_init(struct adapter *adapt)
-- 
2.18.0

