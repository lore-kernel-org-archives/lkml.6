Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1941BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96A9222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfGF7kIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbfBMPLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:11:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36501 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfBMPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:11:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so1521339qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtPU5ZmnkfEsWiSuBnE/JwYXZnfWEiWHqxA1mdLbuLI=;
        b=vfGF7kIYqu2Lz5DQBuT4ZvhyXCHEZVRbusrujKnjtzQzMQah+wlWFr8Dv604Ep0777
         9ZwHbSOU/VrWtHDw6T/hMyXiY9t8GvZ2hdqesgYcq3GxFRVwhbUetxycRx/ZeS+WuIdM
         5E9Lvaw8wr+u7fwlq8EOv/kyAhlAP2TEvcyVE2nQmHqgOD5vzk7289sD+4A3l4MCTZxU
         /ZPJLN4JZt3nTjt9E0ki5Oz1S33EjqojyBvIiyOUArufCGUV7YMQdTuHReqaWIntOO+z
         rconVlk/fqpTeR2Q7Htwz8XE257tLFBFm9gPHb4vgxMRwx0CHs/BHErf4CKNmJxaWRMF
         9cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtPU5ZmnkfEsWiSuBnE/JwYXZnfWEiWHqxA1mdLbuLI=;
        b=tEEff/esGvDjTHM/P+5icUuNPTw1coTYoftEdxSUPNSZAXdc+6rcZbtozb1iR1R3ZK
         AqoIbwyBmrHLhjn8GDRJpoKFcFyie2wQHWd2RkJL7GvzMdSNlGZHjetn2Y/CeoaZlKJQ
         y7WtzATXfw88XPBo16A3O8/o/yKya2ax0AXd4goj0+7DQ8hmUSahlQDxuHUbkohlS6aI
         wJcCVLPDhVCS9NZ1Zmj9nwUNWn1GPiAPQbgmepHZLxwXglJ6luNd6wN47K7S1n8KelUt
         P8djeMgAmOKnVqACoHw/zc0t8ni7qVnlh/HpMfenQ5lKHmq8XM7WXjUHCEixJ31bYLFi
         L7ww==
X-Gm-Message-State: AHQUAuZw/+KUAfoSG1csNdKDdaP/cQTUHujJokVvBRdMvjhdgS74PCMa
        CpJ3e9E6t3wvidw/7u04Ep4=
X-Google-Smtp-Source: AHgI3IaODWQWJEg2JxJBQiMLi3uDFGDGbz/Hy6QJwxW/+cZAeZXE+8JN9UuyByuMg08QEq4pO4a8Eg==
X-Received: by 2002:a37:dcc1:: with SMTP id v184mr759458qki.212.1550070670104;
        Wed, 13 Feb 2019 07:11:10 -0800 (PST)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id f33sm25803802qta.91.2019.02.13.07.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 07:11:09 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update entry for drm/msm
Date:   Wed, 13 Feb 2019 10:10:44 -0500
Message-Id: <20190213151107.14833-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've moved the tree to a shared gitlab tree, so that Sean can help out
with maintainer duties.

Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
I can include this patch in msm-next for v5.1, but wanted to get it
ack'd on list

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..2141a1b6653d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4838,10 +4838,11 @@ F:	Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
 
 DRM DRIVER FOR MSM ADRENO GPU
 M:	Rob Clark <robdclark@gmail.com>
+M:	Sean Paul <sean@poorly.run>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org
-T:	git git://people.freedesktop.org/~robclark/linux
+T:	git https://gitlab.freedesktop.org/drm/msm.git
 S:	Maintained
 F:	drivers/gpu/drm/msm/
 F:	include/uapi/drm/msm_drm.h
-- 
A
2.20.1

