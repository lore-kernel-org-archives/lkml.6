Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA43AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D9220693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYYz4Rsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D9220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756432AbeFOSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:43:25 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41148 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbeFOSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:43:24 -0400
Received: by mail-yw0-f196.google.com with SMTP id s201-v6so3667394ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RnPqcJXmrOElipck5ReOimJZmvHi6b8UOYjbK2YoVeY=;
        b=WYYz4RsaTEMKnbsOKK6W/mQQxrDjiDkxdcYaQJ8y6sLai0+PpibjBVDttsCaqovcYg
         Z9Bgxqjyb399qRvZ/UFwoc489NhqbXwv8mha0yxroyASFgIhSq7ttgNxql1jN7TpyOaW
         fLFCsRhZmZRRTjkG9ulxk4f/bjHJYKc9y3hIMnVJ7j/Zcnyb/FoTWwDi/srYgo67fGqt
         61Yhz9MB+ZeaVTsyupkJDd0gna5G0a4Ca6vXLyPNyW7gLgt/cZLTgFvpU4dUOe+WdFXT
         d3Fte604pJLhzqoq/X/hHrkTz2bIJiWs3tli3a1LdnyV6gE2ABl/BzAvPjz1hMFacgW4
         9zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RnPqcJXmrOElipck5ReOimJZmvHi6b8UOYjbK2YoVeY=;
        b=CsYrhCvsQ5RFp5TADa4dHqGT/KGEIjsJuDBUUEzUKd/ejh7uPqCg6vt1PNMFxm8TQa
         d6aFDalxJuseTTs3EN8scn8GtaUqmkVDjqLc2pJhgc8/MI0WtkSQFErd2+hwi3NbQjtA
         4IlsyUu7OzqVSfOrnDjzTv25Mf7ZnTJcf3phjp6jycQO/eGTBc3BMCYRMdsthRD9/UI9
         1TJSljPbdtFb12vBTa1WF1JFAy9+BTV35EE1ovTofWpmpWFNCVbNm31Kuil/WQqAlr8b
         RgZlwDuwNBlAUswiPpz5PgYsKhf8VHqiXm5/2J/kpfCJBverLUtmlqp/HeU9NE6y9JmR
         iuTQ==
X-Gm-Message-State: APt69E3Ma+NG0AMq4BtcvJpW1O3Aer81EmdjOFde90IH3f2BYaOiU6JF
        yxRsoHGZC+UxrgVokPb8yPA=
X-Google-Smtp-Source: ADUXVKKlcHCol+4u7SsX9ezMz2Ynx6Jx2J79PhOuySkXYjnJKuttlHtjytXW/FkQhLKSfPT1QKvTRg==
X-Received: by 2002:a81:3406:: with SMTP id b6-v6mr1484070ywa.77.1529088203543;
        Fri, 15 Jun 2018 11:43:23 -0700 (PDT)
Received: from localhost.localdomain (50-248-107-19-static.hfc.comcastbusiness.net. [50.248.107.19])
        by smtp.googlemail.com with ESMTPSA id v7-v6sm2872567ywv.91.2018.06.15.11.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:43:22 -0700 (PDT)
From:   ankit patel <ankit.mayurbhai.patel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ankit patel <ankit.mayurbhai.patel@gmail.com>
Subject: [PATCH 1/5] Staging: comedi: comedi.h: fixed missing or malformed SPDX-License-Identifier
Date:   Fri, 15 Jun 2018 13:42:12 -0500
Message-Id: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed SPDX-License-Identifier comment on first line

Signed-off-by: ankit patel <ankit.mayurbhai.patel@gmail.com>
---
 drivers/staging/comedi/comedi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index c0bc413f7fe0..bb961ac79b7e 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: LGPL-2.0+
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*
  * comedi.h
  * header file for COMEDI user API
-- 
2.17.1

