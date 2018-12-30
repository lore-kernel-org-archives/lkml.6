Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227C0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D667220866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 03:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv6kufTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeL3DPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 22:15:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45528 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeL3DPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 22:15:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so14384712qka.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 19:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xah13WLxMuzE38XZrxd0j/YgD+b5/57PEPZUeNyG0UU=;
        b=Jv6kufTbjKm9NQamPvTQC2ql0IuyQpKvgpqiI6No03Ao80a9Nf/7xGhlt1FYuXPvbd
         Yz/N3L7H9v2kkxZ25EVM0Z0LXQkrjQPAkQntWt2SplQssBEhb3MRw+h6QG4T9dD1SdjY
         fCowrBGBlMhavJwKRY1v2zI9S1lNq91+uPo2tAQ/0SgeTmx2qwua3vwAqt0N1UbaJfL2
         IEfuJ5bHJNouOPUbSBdaPXRbtEsCgAjty1aYnb80uVSeYPRSC7StOeYRt0taYAA2m/YO
         d5vMeH06+MlZ5j7s418SfxqWGdDjWvyO9vkXzQ39a2hUP5fQznKMbuv7rd02Pj6ASEp1
         mVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xah13WLxMuzE38XZrxd0j/YgD+b5/57PEPZUeNyG0UU=;
        b=Km0KmPJlOFj5yCvH5W+biu838V6D5YKqzfYW+8BNykqA9PE85/TxWLxm9Gh9tDw4U6
         +S/j60i0hoeIZ91ECAaE8Uqhj7Qfmw0233QyjWpdRovrbqREojLHT5Vpy05przbVty6A
         N1qOrrxWiPx6df5UldsmYRRScXpJQr4zkZ7JYFV2c2PLsa9Bbt8QI+8TP79Z5KwcNmX1
         5vR9CovtccE4xPcp7FR+ZwgGEnmBp6M+pQdpBOTKiWapZOTjLOMdxNm0VK842OsIg++C
         YMDOz1xTmhPbRh455enZ/u3qiVW1RceL6ThUCGLOu5rQnsJrNter+/LWFa+T1CxqNhXA
         aIGw==
X-Gm-Message-State: AJcUuker0tjchf6OAm1RGdQC3kO0Hfa5OWLI25CaTcBcrGcYvgcjVfox
        QwH3Hx6C7r+sujssEz8yo00=
X-Google-Smtp-Source: ALg8bN5uk12D3o98eN1olOR/t3sPo7C7OF06LPJcnYJbH2duCOsA7tW6NOS4vMk4vKTq+2M9S4VmWg==
X-Received: by 2002:a37:9a89:: with SMTP id c131mr30368797qke.173.1546139703036;
        Sat, 29 Dec 2018 19:15:03 -0800 (PST)
Received: from fibonacci.apt.net (cpe-24-208-224-171.columbus.res.rr.com. [24.208.224.171])
        by smtp.gmail.com with ESMTPSA id z30sm24223694qtz.26.2018.12.29.19.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 19:15:02 -0800 (PST)
From:   William Mitchell Jr <wdmjun@gmail.com>
To:     abbotti@mev.co.uk
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        William Mitchell Jr <wdmjun@gmail.com>
Subject: [PATCH] staging: comedi: cb_pcimdas.c: fixed an alignment coding style issue
Date:   Sat, 29 Dec 2018 22:14:12 -0500
Message-Id: <20181230031412.31761-1-wdmjun@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: William Mitchell Jr <wdmjun@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcimdas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcimdas.c b/drivers/staging/comedi/drivers/cb_pcimdas.c
index 4e72a0778086..a9d052bfda38 100644
--- a/drivers/staging/comedi/drivers/cb_pcimdas.c
+++ b/drivers/staging/comedi/drivers/cb_pcimdas.c
@@ -252,9 +252,9 @@ static int cb_pcimdas_di_insn_bits(struct comedi_device *dev,
 }
 
 static int cb_pcimdas_do_insn_bits(struct comedi_device *dev,
-				    struct comedi_subdevice *s,
-				    struct comedi_insn *insn,
-				    unsigned int *data)
+				   struct comedi_subdevice *s,
+				   struct comedi_insn *insn,
+				   unsigned int *data)
 {
 	struct cb_pcimdas_private *devpriv = dev->private;
 
-- 
2.20.1

