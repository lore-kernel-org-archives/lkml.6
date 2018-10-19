Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B2521476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar3sWj6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B2521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJTEw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:52:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36394 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeJTEwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:52:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so4834957wmf.1;
        Fri, 19 Oct 2018 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k76P0C2bLRpzEIz57oKno9Hjh3eaOlbm7T5lpBJ3gZU=;
        b=ar3sWj6g5w8LE7sYO80GEp7BlpZCqMIWCmY4m3JdyLn3DfKjfcPyXU0w4KlezSzlv0
         2/pc6HGGUaNGVFUjTUajdlwW82HMcr8MfynqdVVeKCWJdf9yQ41mGvb1R802kB8819Rj
         RiBtkjyR88dzGhMa/pLLGsLU/dOEz6a9f7T9aE6hnM5CiyrpZvLoADUqjE02L8VdvPHh
         MIC151Ra+Zae6Xm+w3C78uOTkAE9P0F6XeFurmC1GoCx3olR20Vc1LliZbo26fn4fohc
         7DXy8ViZLJU4yG62KZgXMq191SBzRA7NMqOorff4uT4EGyRBvtLe6RnduL7RqXMRd/+H
         0JLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k76P0C2bLRpzEIz57oKno9Hjh3eaOlbm7T5lpBJ3gZU=;
        b=OQC7yY0UlUCVaM1w8GQPIg2YjsWGwaHteUxbObTvGnp+E+Vj3CuIhCrCC4tT7+Gbiw
         5c6bsNnRjo4pPw8gS8zNX3KuIWoQS/OC8q20bAtYseLJmtuemAEyP0sO2PM1Dgh7smJ1
         rXb76lijvjekod0Ptsixy5UzcTlgP4EQqc3qoH2PbRIjvXPbV5CENHjVkvNobDp2Kz9P
         1+eiZ1xhEwxghKL7HeJRwrqwsrmeF2DprNrjMx3YVEikCivXHR2aTbV6aE3WnLJRj6LZ
         37tDrMNYXR0OoVnjoHyJIfTp1NcLt8LJy/a7aG1llSUClh77SWGb5vinlLK2TaeBO7gf
         wjWA==
X-Gm-Message-State: ABuFfoh4pnkXQQH3Wyp4xSIxfk7sAzasUnoyfG3l61K78bqVuYLmzTGO
        ESJKje9/wAG2PaNtCTwKibE=
X-Google-Smtp-Source: ACcGV60qNzOc0ztbAOmg5pQWXydhbcf/WPtXkKOswLpE+0HL9Sy5riBbkfYzs/Py/Vv0EFLNLiBeCg==
X-Received: by 2002:a1c:1c0c:: with SMTP id c12-v6mr6081957wmc.18.1539981882543;
        Fri, 19 Oct 2018 13:44:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z7-v6sm28261961wrg.52.2018.10.19.13.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 13:44:41 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] rtc: s35390a: Change buf's type to u8 in s35390a_init
Date:   Fri, 19 Oct 2018 13:43:45 -0700
Message-Id: <20181019204344.28080-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018214207.4223-1-natechancellor@gmail.com>
References: <20181018214207.4223-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/rtc/rtc-s35390a.c:124:27: warning: implicit conversion from
'int' to 'char' changes value from 192 to -64 [-Wconstant-conversion]
        buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
            ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
1 warning generated.

Update buf to be an unsigned 8-bit integer, which matches the buf member
in struct i2c_msg.

https://github.com/ClangBuiltLinux/linux/issues/145
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use u8 instead of unsigned char, as it's clearer that this is an
  integer value and it's shorter.

 drivers/rtc/rtc-s35390a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 77feb603cd4c..3c64dbb08109 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -108,7 +108,7 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
 
 static int s35390a_init(struct s35390a *s35390a)
 {
-	char buf;
+	u8 buf;
 	int ret;
 	unsigned initcount = 0;
 
-- 
2.19.1

