Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E47EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC218208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/Gry4br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC218208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965916AbeFOSnn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:43:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43748 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756445AbeFOSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:43:38 -0400
Received: by mail-yw0-f194.google.com with SMTP id r19-v6so3664151ywc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IlUTosCZMJv+soWexQFdhFKRR0kiGhN2CTnzNNC9ZM8=;
        b=a/Gry4brV+hL+8xkhZkkSJcKHdTJRNxXYNmuemkj7t5WwXFN9AjTq8umd7eCs3M3zN
         CD65wSJhuYjibme5DvZ2YasdilVpqGYFkaXxo2hz0wpuZHxNQwajArdZ6qq5XYPFXGnF
         Rv9UrJR+8bsKrlnvug/iUZstTmJXEw7Ujzu7lQJRtmLAPB6IbrvR3BQhekr6GYz6QWag
         AAWTY2jhjHLx7Y5/9sFlw6lTX1wWVTLBvzJhw8Oz4BgKkqzFKWIGzZ4c6rjIGeYfyGSp
         8SqGBNp0R7YlsVcfUX3SImrkcKkB4BA0+8UdFkAv7hTC3XnyhacUmOFlQnwo21tdT1so
         MOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IlUTosCZMJv+soWexQFdhFKRR0kiGhN2CTnzNNC9ZM8=;
        b=GMgVEO/jKru7Ou4XWXgqVFh9nr2QAeE+Sq/n0OYoihOq+iMUfvUM5VxPNJ7zBMd/bi
         I0Pw3ZNuCSrTLDchF1mP2pMyZzFVu+q1D1Ldo2ZDPiE1MxYSBfajNxvCHuAEpFBGxeSu
         65X+OK6RzRX6X3dVaD548s+eTMQltdUM9VwunMAxq2hLkMYcmcbel8Brb5Ma9t9APc1E
         brRVM5a8KZ9Td8Pxcd5LcuHyZ31h7slebAY7xWgnqILppU93vzPfF0SV4+vbAMR3CWVI
         RAoGlPcTOfRyPx5brEyazCrJiJVgMSlJTFbhubh9LCFAo0j2FEq8/7wiSdhWKaACm7Cl
         zEtQ==
X-Gm-Message-State: APt69E3t3tY1s7GbAUdXHOmuOaBlT0oxmnOpnyLZcHgpy2hnjmIpBkW8
        /cZOb0X+hxWXlMjUJPfF4DU=
X-Google-Smtp-Source: ADUXVKJAGZwUSfwdd+L458cp8zClZzPmBkjL0Y5BNqz3BgBHbQzm85z/J9AcLgjCv3u1vWCy/YZcnQ==
X-Received: by 2002:a81:35c7:: with SMTP id c190-v6mr1449763ywa.184.1529088217652;
        Fri, 15 Jun 2018 11:43:37 -0700 (PDT)
Received: from localhost.localdomain (50-248-107-19-static.hfc.comcastbusiness.net. [50.248.107.19])
        by smtp.googlemail.com with ESMTPSA id v7-v6sm2872567ywv.91.2018.06.15.11.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:43:37 -0700 (PDT)
From:   ankit patel <ankit.mayurbhai.patel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ankit patel <ankit.mayurbhai.patel@gmail.com>
Subject: [PATCH 5/5] Staging: comedi: comedilib.h: fixed missing or malformed SPDX-License-Identifier
Date:   Fri, 15 Jun 2018 13:42:16 -0500
Message-Id: <20180615184216.18483-5-ankit.mayurbhai.patel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
References: <20180615184216.18483-1-ankit.mayurbhai.patel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed SPDX-License-Identifier comment on first line

Signed-off-by: ankit patel <ankit.mayurbhai.patel@gmail.com>
---
 drivers/staging/comedi/comedilib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedilib.h b/drivers/staging/comedi/comedilib.h
index e98cb9752dbc..0223c9cd9215 100644
--- a/drivers/staging/comedi/comedilib.h
+++ b/drivers/staging/comedi/comedilib.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * comedilib.h
  * Header file for kcomedilib
-- 
2.17.1

