Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F466214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVSdX6Mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F466214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeIYOkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:40:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeIYOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:40:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so6226091wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Dy1Ja4gXW5mpcYa09YV9C9RPIHm8jQC2ppDhQxUJk0=;
        b=EVSdX6Mx2CnEozW4UKtglazK12DYGuXDZZtvfbARI2Ll68zdstGMmiIjm6NsJgO2zo
         KKn7csuEyZD/l4FKOuNT7ZE3OQapflc++hb6Znwozd3OGdA/9we91nSrisknzLVHz3ue
         lT+hEOxvfsuqb29Y0g5Hq6veXspRm0s6gy8iYJ9Pef9aVVUnqCoqbg0w+7E7p/ODDxcP
         C6dLM808NsMR9tw+m2WO+qRfZLhBu7eJvcYm4Plg7nVkc+4b76PzqYMGsqc/IJM5PYUG
         fSqirf2SnvBjPI1H2EiYiQd5gogBZ5pFFtlqerKW3P/vaN2A6dK5oRSAZdLDH1+/DH4s
         gOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Dy1Ja4gXW5mpcYa09YV9C9RPIHm8jQC2ppDhQxUJk0=;
        b=ATp8OV7Q+RfFsI+A0a/+iv9yGO4l9Ues5Sqb+QgQ/eKpwKwSHoqnaddQddNLCBtB2F
         Eah8EmyvGf7AFUTq1wb4DbDUkdTe0RCzIXnktSgr/NzQ/P8nrPZGUgb/CDN/r5O6rLeM
         NwkQND9yIUIvrkj24zhGGy79I1hq6UQaX+XpQct6L3QNp6UCkzhDvSp78Zr3A+QheWmO
         3Mzg1OZypNyCTt4FvynX49wB6DpyrHHncGleJ9cxp4FDK5SMmcdyX9PxfNFRcgA51jp+
         3NmE1KjQqI3gkqHYWSxSaih3TZeZfJJ9d3xUyZsuDyhikUAJXTAK+pdS5xixdRzvs6mQ
         B+Dg==
X-Gm-Message-State: ABuFfoixgUYwqQaxfbiX3jv4BFRkLHU7M8BYv3p6mpNryJi/NKdOX1H6
        1+ZqxvSWZa5RhAr0u82gECQ=
X-Google-Smtp-Source: ACcGV61uzR4dPSCZ/nNkWal5Nlitg66rWVXv56lmSzOHBYAqlXk/eV7IcLI5edPse7OtjYAoVIuIdw==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr1542792wmd.60.1537864457221;
        Tue, 25 Sep 2018 01:34:17 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id 94-v6sm2115538wrc.10.2018.09.25.01.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:34:16 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] staging: bcm2835-camera: Remove unused header
Date:   Tue, 25 Sep 2018 09:33:57 +0100
Message-Id: <20180925083401.22533-3-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925083401.22533-1-qader.aymen@gmail.com>
References: <20180924233426.32609-1-qader.aymen@gmail.com>
 <20180925083401.22533-1-qader.aymen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the asm/cacheflush.h header include from mmal-vchiq.c. This
dependency was removed in:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations")

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 51e5b04ff0f5..6e5c1d4ee122 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
-#include <asm/cacheflush.h>
 #include <media/videobuf2-vmalloc.h>
 
 #include "mmal-common.h"
-- 
2.17.1

