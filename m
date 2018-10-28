Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F160C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C4420831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYS7HTmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C4420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJ2BbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:31:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37045 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2BbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:31:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id p2-v6so5694867wmc.2;
        Sun, 28 Oct 2018 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bt4DL7L5StPNcHNCCX9ykvQ5j+a3BkQzChn3WaLtYMc=;
        b=IYS7HTmLJgc8l5O+CBKjlLwW/Hml97aprHyZiDqoUgzG6TwKy2KEbydMo759tUXKJX
         k+ieAifIt39A7U9aRVgMjH6AC94IS1HgmuwOAQs3d+8idFljjFB3NjtlZlIxJGEqzrvL
         JJAULIIae/4t+1Nh4j6efpMYTxmC1yZ+iPdNJbwQlXA0wtNBSykbEmO2ER5MMcf5grqh
         Vc/uPuVj8qigJ4xcc7RC5u+YrmH10QMHYDj1GKCB58Rr7k+Lg4QajjpcicKN34BTQiRU
         xjjCXtDR7RpyERzJ0S8qtBSWSkwKiI1gBWEydVweyywkA+sHdXOKPDsMa9o3piBm1UY8
         kgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bt4DL7L5StPNcHNCCX9ykvQ5j+a3BkQzChn3WaLtYMc=;
        b=sW2stA+zSQ4cYEFOv96UpqLTnbbwAzpRjAzuUr5tiq+JpJlaOwRF18hUHa84Kxrwhk
         njpa5Km0x3krra7EnBa1u5wZ8JAVW5fsazKqMnhNCA/+g6QbVRAA3AxeC13PDfWOVuJI
         2gIw7P5PS0I8gEADIy2LOryR4vY16DyNNwQvOVTUwrhhISIk0Htpb9FSzotOA0Q9LVrv
         409AGbsEJaWb25mYEM28HN9tcUq3bu+VY09r3HjNiOKEzoEmSMY/t6Owk2VQ0PAu4BN1
         OsRJiWyrzrLEXPwIZNRV3AlQpTqS5pNvFYnNZ/eza4wzDjtARtG++1m7af9+VZ5Cc1s4
         3qrw==
X-Gm-Message-State: AGRZ1gJhoy6+ifQ5iFZu+bzHe/eLOs8jhzxAwRf7v952XekU5RaLkaYM
        oHlZq2lqicFgmipAHl4J2bI=
X-Google-Smtp-Source: AJdET5cREJ8WAstB8buR/JaXVM4/ELHlBqbihrTrr3rR6PJblyaSP6v5DpCYKOjl/l+bQDiQ6MmTBw==
X-Received: by 2002:a1c:4007:: with SMTP id n7-v6mr4434228wma.46.1540745161307;
        Sun, 28 Oct 2018 09:46:01 -0700 (PDT)
Received: from joris.fritz.box (p200300CF83C0B500C714D115E7850A75.dip0.t-ipconnect.de. [2003:cf:83c0:b500:c714:d115:e785:a75])
        by smtp.gmail.com with ESMTPSA id m2-v6sm16549230wrj.80.2018.10.28.09.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 09:46:00 -0700 (PDT)
From:   Joris Gutjahr <joris.gutjahr@gmail.com>
To:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joris Gutjahr <joris.gutjahr@gmail.com>
Subject: [PATCH] Malformatted switch statment
Date:   Sun, 28 Oct 2018 17:45:46 +0100
Message-Id: <20181028164546.17178-1-joris.gutjahr@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed this coding style error I got after running
checkpatch --file on this file.
The problem was that the whole case block was on one line.

Signed-off-by: Joris Gutjahr <joris.gutjahr@gmail.com>
---
 drivers/ide/amd74xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index cbfe846911d1..fa39f279bf53 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -273,9 +273,15 @@ static int amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	amd_clock = (ide_pci_clk ? ide_pci_clk : 33) * 1000;
 
 	switch (amd_clock) {
-	case 33000: amd_clock = 33333; break;
-	case 37000: amd_clock = 37500; break;
-	case 41000: amd_clock = 41666; break;
+	case 33000:
+		amd_clock = 33333;
+		break;
+	case 37000:
+		amd_clock = 37500;
+		break;
+	case 41000:
+		amd_clock = 41666;
+		break;
 	}
 
 	if (amd_clock < 20000 || amd_clock > 50000) {
-- 
2.19.1

