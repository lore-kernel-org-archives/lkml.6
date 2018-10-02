Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42A9C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689CD2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXYF941p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689CD2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeJBVWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:22:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34891 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8-v6so1752165plb.2;
        Tue, 02 Oct 2018 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CTGMRdJjJaMiYUDbtama3TS5jBIrJjL1fzXYXKoXmdw=;
        b=gXYF941pRSB3em/fuqkKuS/fnEAqu3sEtRYPhXOWkpqffPYxdMLTnU/lgbcL4r1DW5
         jezaANsOWKeQ3MVGPdFwCDsf0dwKsA5CArv2mVasX45hD71VfmlsN+Qd5jaYQ3PYVD3G
         xwOG82n3SL0coISe7Rs/AlzOgYMOwwajaa/pqrJ40x+XAdtj7jGCWEWk+nxUJIDKJlt7
         Y/AyFjwuicZ4BRDWGWM1WqR6KxnwnIZbLfEYeSFUixhbEbG77ZvAw1m/X3Pccs8Jt5wW
         9QaDmsFtqX2U8LiQ3VQ0NVXxRG0pQhhht1Oj2FSMi8p8g1nl3hE4PhoqgSUGBl5opyK8
         ycng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CTGMRdJjJaMiYUDbtama3TS5jBIrJjL1fzXYXKoXmdw=;
        b=luEvmNdN3qWnqQ4PU7UUicMW2WguVR24uEjsmRy19RyyeIAtApU0lZyKby/bFhm9Ra
         VhbhYjeJbTLVVL2nKYCFPu7dZtKpxfkiceICIcdmGs6+7qHAqKd1G0QA4b475Xl2TMmG
         IxS4e0SP3aQyaPbLLZIF/M5li6DsF4BZc6bnWBnRJtMAguUKE7gd1e1nxnt5U+gZyK/4
         zhEgf8A40jiEWt/yRa8fQU8/owPWnRJZRp1iZz1ELJQEY4u4bWKtgCzl9Qs32S9GIlnt
         xl/JswCHr6S2sREwrIUCiTRSes+NGkpnoUvAhtBZzm28PfW2G5A9FcN6TR4eRhEg3mbp
         yIKg==
X-Gm-Message-State: ABuFfoj/q2BXBCS74BOym1DbiqXwWQER+AVILOvku6PR7j/c8P8lMkVY
        DstQGkfhU+2xKeNQ8luN0PI=
X-Google-Smtp-Source: ACcGV63MjwaUusmfrq+jl+8Npo9MRwY69/5ex7WGYrsQ0BSGDSSzR2T2Kj7wFrrZkoFWTOp6ol0now==
X-Received: by 2002:a62:9554:: with SMTP id p81-v6mr16663285pfd.222.1538491106336;
        Tue, 02 Oct 2018 07:38:26 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id e26-v6sm21958380pfi.70.2018.10.02.07.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 07:38:25 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: Add PNI to the vendor prefixes.
Date:   Tue,  2 Oct 2018 22:38:10 +0800
Message-Id: <20181002143812.3661-2-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002143812.3661-1-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20181002143812.3661-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 41f0b97eb933..5b935f01e15b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -288,6 +288,7 @@ pine64	Pine64
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
+pni     PNI Sensor Corporation
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1

