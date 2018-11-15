Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A402C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602402086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR2UDjSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602402086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbeKPCml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:42:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41532 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPCml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:42:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so9938603pfn.8;
        Thu, 15 Nov 2018 08:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=lrNKmcm6T6ynZmAfTCZMzh2G66aGSvahImaCoMcOLYY=;
        b=fR2UDjSPWocTLs0ySwE2ioCBqqB5pdms92szFKkShGfoK8YoEIbgwF9TAFHUwOFgJ7
         HJMHmIh03NvQB6RcSZzmPeQiC7MD9eGupU1l4JY46CVyOvR6ZFtt1LtQl3q6P3/TNouX
         hWA/sDY9SZ6rsT0AWq6KyDwcUGqsDBxXn+aVybu4PXQfk4OXlTVYvp00tktulQHvctUq
         DUCLUhByA0Ujdmh1PZVAfI+8Ilk/ke/Bb+qqwhfTaX499r9rcOPCOnWFnr7QX+a1v2zu
         EUoyQ4dlmvCohb1ShWK6RwivxmiYL4IqQmLedX9jxofXp7+uxOekdUrQC8hc9TGRl3j0
         MExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=lrNKmcm6T6ynZmAfTCZMzh2G66aGSvahImaCoMcOLYY=;
        b=mCLed8ZC0dKbmtz+Sd6WAg2FrONddCMTI2ivvW8TH5lcwZ6QxS4NBLZq4bMpeNVBJd
         rPB0PEL3rissUVmvdOtz96+3z5nkKT+TnEUUcrUOb9hfT/7NIRESsG675e0YxMGe+wr9
         fr1OaLHT+ZdrjacD7u44kbX0DLg2pcouUITaxDTkyzmMSaTYHK05KM4QMlzLQsRbmYRc
         oLqJRsYkuGVhNxPI8jWNnphxUF6akzD62enJKixrO6MFIy4deJD3RIvRVY9NmoldqYop
         ddLkytnbUI3qYfddAu4ZW6lu0+rx+TKwv9Rh5fNmVzOaVgPIZsIVDbI6+qieNxOtMJjK
         25wA==
X-Gm-Message-State: AGRZ1gKT/SyNhyQ7NmtiDqkRUIPm0UFThbB3gjsTEs2M7X0o2QFT2aqW
        ccVyyamNPJLOXD+b9UZ0Ss4=
X-Google-Smtp-Source: AJdET5fLTvzTrwFHtwBQKI8uzP/ubxM7XhBfitqzGIzQWo0+xcIvya2i6Y2J5hGGUY+h/7/ufvPlww==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr7240451pfm.253.1542299649578;
        Thu, 15 Nov 2018 08:34:09 -0800 (PST)
Received: from sabyasachi ([45.116.191.235])
        by smtp.gmail.com with ESMTPSA id s2-v6sm58186068pfk.133.2018.11.15.08.34.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 08:34:08 -0800 (PST)
Message-ID: <5beda000.1c69fb81.e6599.d3d8@mx.google.com>
X-Google-Original-Message-ID: <20181115163404.GA3025@sabyasachi.linux@gmail.com>
Date:   Thu, 15 Nov 2018 22:04:04 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] drivers/scsi/snic/snic_trc.c: Use vzalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced vmalloc + memset with vzalloc

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/scsi/snic/snic_trc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
index fc60c93..458eaba 100644
--- a/drivers/scsi/snic/snic_trc.c
+++ b/drivers/scsi/snic/snic_trc.c
@@ -126,7 +126,7 @@ snic_trc_init(void)
 	int tbuf_sz = 0, ret;
 
 	tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
-	tbuf = vmalloc(tbuf_sz);
+	tbuf = vzalloc(tbuf_sz);
 	if (!tbuf) {
 		SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
 		SNIC_ERR("Trace Facility not enabled.\n");
@@ -135,7 +135,6 @@ snic_trc_init(void)
 		return ret;
 	}
 
-	memset(tbuf, 0, tbuf_sz);
 	trc->buf = (struct snic_trc_data *) tbuf;
 	spin_lock_init(&trc->lock);
 
-- 
2.7.4

