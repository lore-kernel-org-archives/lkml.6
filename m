Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3699C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6E21BC9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gynU2cv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6E21BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeGDLiC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:38:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37406 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933470AbeGDLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:38:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id q10-v6so4995085wrd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71UvbTv7VUznPRaquxKcZgOwQtVDWXhPuTfN0bSUvKo=;
        b=gynU2cv4SEz9FMnUZFPiMOnKNCrQi6IIJNqP6JXA6qyA23Lu2L51l4jv7PYbBQVxHp
         8SGbcRfU4CB8+wj1YccIgTZElGima+n4fN1eBU06DNN7fJuuXd1RZdKhdPsfNTVu63u2
         eDIu6Lal0Q3oYaHEoKynPQ3FYXBejmgBCCkQeureiSvRQhuO9N//dV/SfbSWTY13tLWK
         B2D8DyATZv45ccExENcR21UvodOfuTlVmx/7Sv4CAlfXewN4G8CccdfmLF4exesMhPnG
         LY99pUtIhx/aPEO4VWKHlLd3a19VhPkD4WpiwrnSb3Ebp1XOMxZfTr9Tp3Xl+c5T83yV
         gfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71UvbTv7VUznPRaquxKcZgOwQtVDWXhPuTfN0bSUvKo=;
        b=NmidJ4er3Dtmv5wG6OY6r/ZqvrS3DxX9+9dMTa8TnYRsgdy1JKjunB/IoMpnrelPdo
         O/YS/fVVm4fPtmr3DNnUv69WU4y15sRiBFr8hoO7WwLNgrIOs9HJTvW5n9VPPY6b+c4e
         gNHKplWDKCRwnE9/bJTd9ByNxuNF8FVCO0UR/XBZxWi+ydq55m6sek79jb5yjkqSdr6n
         Z7pBUjj+87csmVPmtKoGlC4XZ2NAx4fC+NWnHlrNRBFlV148Bh8u4ZdyxBPopkR0DJdp
         UwdNdSbPPHBC8M2ilH4AMaLihpJ5mHI6fLNvYy6Gt/qNfohwVaDEkuxBfEAOCKpgUnQj
         b3Yg==
X-Gm-Message-State: APt69E2DRPLGXUFFP9ZRjLil/rtDQ8Xmlii65y3rPlTT/3fnkRkm3xjZ
        +dNjINIdRSQILWSk/wQbyVLxAY1kYmA=
X-Google-Smtp-Source: AAOMgpdd7fpdz98B/e+jsRFaXDA745zdtN0SYC8DC6AcKWtrTREyYEQ5htHsTUB8LtO1MiH9JIPU8w==
X-Received: by 2002:adf:b587:: with SMTP id c7-v6mr1345951wre.141.1530704279701;
        Wed, 04 Jul 2018 04:37:59 -0700 (PDT)
Received: from arch.localdomain (x590e846b.dyn.telefonica.de. [89.14.132.107])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2800111wmh.6.2018.07.04.04.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:37:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: rename Hal8188EPhyReg.h
Date:   Wed,  4 Jul 2018 13:37:40 +0200
Message-Id: <20180704113741.25358-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704113741.25358-1-straube.linux@gmail.com>
References: <20180704113741.25358-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename header file to avoid CamelCase.

Hal8188EPhyReg.h -> hal8188e_phy_reg.h

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/include/{Hal8188EPhyReg.h => hal8188e_phy_reg.h}  | 0
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h                | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/staging/rtl8188eu/include/{Hal8188EPhyReg.h => hal8188e_phy_reg.h} (100%)

diff --git a/drivers/staging/rtl8188eu/include/Hal8188EPhyReg.h b/drivers/staging/rtl8188eu/include/hal8188e_phy_reg.h
similarity index 100%
rename from drivers/staging/rtl8188eu/include/Hal8188EPhyReg.h
rename to drivers/staging/rtl8188eu/include/hal8188e_phy_reg.h
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index e04e97e98ab7..a86b07d3c82a 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -10,7 +10,7 @@
 
 /* include HAL Related header after HAL Related compiling flags */
 #include "rtl8188e_spec.h"
-#include "Hal8188EPhyReg.h"
+#include "hal8188e_phy_reg.h"
 #include "hal8188e_phy_cfg.h"
 #include "rtl8188e_dm.h"
 #include "rtl8188e_recv.h"
-- 
2.18.0

