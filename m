Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677A208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JebYb7ZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1677A208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965012AbeFOSni (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:43:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44941 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756422AbeFOSng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:43:36 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so3118430ywm.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XZMeox8qYKo0Zmx+LAXM2Lk6Ak4U19DyeJ1i+E7dae4=;
        b=JebYb7ZOxGjK47hZWB3smgBsDjfCpUCt3H4aXjiMH1lI3ULj2fpefT7UdLOQtDC2z/
         Fv1sf+7NtxuefV2u33Luh5iKDnS3WeYU/vnuh+52BZxbW9IzIsPYkJ/XWnvg3P+/cDlm
         wO/lY9vYPIAZi5/+MKDywMdu9C93cWUvc0hi5Pp3SeVH/iQCDTOXwWjQVd26gLHVHMo7
         0sxNxWxl9c1MM7kjnfOwSJE+3tQW1lN8nvj2jVdh6JRTb827YezgMtY3TloNWGzRLbCF
         WNAW5PMy5fR3cgHNSN5in7mh9HjIBU+oXQpMmDOBGM3eepPF8OKEZXnaAkU2Uv5O2/43
         Ivjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XZMeox8qYKo0Zmx+LAXM2Lk6Ak4U19DyeJ1i+E7dae4=;
        b=qe9mZSbFzTWwXUysM0LUniyPB0gwdV5e1QRmhoYVRT1HzZQkaE0O8FwSGDpLkh6nDs
         i1wG8v9r29Ok2WCj6gWmAmYGJS0AYlLDZ9vyMU472Y1J9ZRG8hudTTjsHH7BzKrXmjKT
         nLupH/ywOOC5uO3z2/XXep9wMcOXyJMMe80NgU3pS120HjHyI+ZZU2GRBUJ4sZ+aeeGC
         CUf/wqNs02Rk2r9ki5WGOCa+ZiMe1LQ3bh7E7pLM0HvRs1We3sIk1/AGRBCuxPdM4/Gy
         aph5PkQcWGXtUhMKi58sEe417UCAlRjcqQiYt+9EkDrM4jIPBiu3BoJlRhgV0mNEjBh5
         r1oQ==
X-Gm-Message-State: APt69E1bGp+EMjuoNY/57+bkBFcUCWWdLWB00LziK+PWQsfaD4WgHK6K
        88YRQeQCw1UnfDuxuqCBD9A=
X-Google-Smtp-Source: ADUXVKIlwLLoZ7JCIBwzYYMRuiJPea484+6C9pOZbVisupr4k6Mt2Tv3uWhNHQblKncH9NMofGyv/A==
X-Received: by 2002:a81:9cd1:: with SMTP id t200-v6mr1480030ywg.217.1529088216078;
        Fri, 15 Jun 2018 11:43:36 -0700 (PDT)
Received: from localhost.localdomain (50-248-107-19-static.hfc.comcastbusiness.net. [50.248.107.19])
        by smtp.googlemail.com with ESMTPSA id v7-v6sm2872567ywv.91.2018.06.15.11.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:43:35 -0700 (PDT)
From:   ankit patel <ankit.mayurbhai.patel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ankit patel <ankit.mayurbhai.patel@gmail.com>
Subject: [PATCH 4/5] Staging: comedi: comedi_pcmcia.h: fixed missing or malformed SPDX-License-Identifier
Date:   Fri, 15 Jun 2018 13:42:15 -0500
Message-Id: <20180615184216.18483-4-ankit.mayurbhai.patel@gmail.com>
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
 drivers/staging/comedi/comedi_pcmcia.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_pcmcia.h b/drivers/staging/comedi/comedi_pcmcia.h
index c7d37b38e730..f2f6e779645b 100644
--- a/drivers/staging/comedi/comedi_pcmcia.h
+++ b/drivers/staging/comedi/comedi_pcmcia.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * comedi_pcmcia.h
  * header file for Comedi PCMCIA drivers
-- 
2.17.1

