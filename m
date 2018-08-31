Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D3C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619A20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpLK+bEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1619A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeIADjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:39:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40649 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIADjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:39:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so6163622pfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u2c/hW29Ku2OOossmzLDia39VFGH20ceUz/q+FPbXeU=;
        b=HpLK+bEdwZz7rRdRmNq9cNVcSsdR4G3bWImEttcPvqxS0DKMzezangnBDf2tXolb5I
         G+0bl7vVbfCc6+JHaTiUwssJgtoqNMz030JiyNU/w6hG+NpyTZf754xdcRRgDO6/10aM
         pPvg323pG50hi9pcbFTX2hNlDmuvI1ULEHp80wuIz7HBDpy55OssLgc1sVOOOqad5TSU
         decSuNIZbRb77xYrS/AdD+lwl0VcLZ1f1ySyab3TME8msoJ6dVdXCRlNzX8+ZQmojwrY
         ZMFqoNLTYWeAkYoFgAnx66NWjq0d6enT+KkcclKR6/3O1kdpwthOphLlCiJN3lzSdGI+
         f3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u2c/hW29Ku2OOossmzLDia39VFGH20ceUz/q+FPbXeU=;
        b=ZoMSeDVJwbtIu6kSbnYddF21txYQbk6b5LCewYw7ZVDXWMPE9dK3gyxcof55nr5f0z
         3OIVUaRoKMQf9D6sp9ShT7pCCS1Cm7zNSbjUnHOIJPBtxpgJ/6CNgQzQg4A+94Yoy/kG
         xHC/mixcSzqfwmvSION+p0qqdQBv035zC/yIPEdPTCaa1dTce7KZMrYPNULNkpBu/8n1
         hYSeKtluqy1DjrpzMxJycSz5gwyv3gymQXO5TzGlb+ZwR+ZAVTKzyC5NG1pkVpgQ5VFw
         S1IQ7dEvtk2Um7+Sx2UgoYhUnA7Qp7H/DBwvIZfk9fHhRmFyx2A3yYeJonZiNI+M4Lja
         XgYQ==
X-Gm-Message-State: APzg51Dp8ddjsHhaOKX2m7macILZIkc7fp/QegJnrVBCuHNM91qkwsJi
        Cdlr88Mzs7DQ/x9Rs0clRYPdsy1D
X-Google-Smtp-Source: ANB0Vdaoq+s2WOBLmn73YyJQ8OjCdqnf1f2GA7r/F2vHptumlsLYNPIQUhrBJwVd+woVbxxLZSHDQw==
X-Received: by 2002:a62:959a:: with SMTP id c26-v6mr18365344pfk.234.1535758203010;
        Fri, 31 Aug 2018 16:30:03 -0700 (PDT)
Received: from dfrey-debian-linux.sierrawireless.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id o21-v6sm19462637pfa.54.2018.08.31.16.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:30:02 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, David Frey <dpfrey@gmail.com>
Subject: [PATCH 1/3] regmap: fix comment for regmap.use_single_write
Date:   Fri, 31 Aug 2018 16:33:31 -0700
Message-Id: <20180831233333.17223-2-dpfrey@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180831233333.17223-1-dpfrey@gmail.com>
References: <20180831233333.17223-1-dpfrey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/base/regmap/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a6bf34d6394e..16414ccace96 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -149,7 +149,7 @@ struct regmap {
 
 	/* if set, converts bulk read to single read */
 	bool use_single_read;
-	/* if set, converts bulk read to single read */
+	/* if set, converts bulk write to single write */
 	bool use_single_write;
 	/* if set, the device supports multi write mode */
 	bool can_multi_write;
-- 
2.11.0

