Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0849422511
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkcWczvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0849422511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeKOC60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:58:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42194 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeKOC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:58:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so3725085pfr.9;
        Wed, 14 Nov 2018 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=+yls9oJorbmpf7QWL23T0ZZ+53Vz1DXjxTfu/kU/1Lc=;
        b=dkcWczvTS0//hGztr7Z8Um2d3g1szbbMnGEhH9KypN4Rr01t4IEApJYrKL8L2r+wJw
         hYn8yF1j5kKgXOUabZW+Do7pOuBgOFhKGjfIXCkfjO4jZcXqgXbfhdAWnwXSUUlOsKPX
         bD0ycwny9U8mONYAKQEAcPF/NZDf6+sCXxJrLAFOdvp7pQt0rCa9Pk2CMlWY6+l02bNh
         +Jr5GbXBQXY3/nuMPMRrLsjrGsg5bejgh7hHy/iySUjaUYeCkkahWCwF9Z1gto6JuTZt
         kITdMPor9j+gP/+ua5mwBNJpSVHKstM6P5yhOKO/R7ek7KbKaKlPnmLHXi8U9MNhN62P
         l7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=+yls9oJorbmpf7QWL23T0ZZ+53Vz1DXjxTfu/kU/1Lc=;
        b=TLXt+NyxYspdcDTyoNmH4sWmZkjgdhD2e9twTq7ylo85EjROyjjY20M3zZQ1PIRzzD
         rMkmPRHSqaL8a8unXIXr5obFlwbInk/5w4HY5JLyPnvIUjnwA26kDdepmaaOHEJYFIyz
         6V1xGaUw+Ki3MPz7aEJimZzlhnxwbrz/WgZhw28/+bxw//iasnAqCF2m7/uOFG70THE7
         l/g354puVztKA9X02NL6hmFaOVIk5TG3GnsEiPzZ1rZINXh1t2PFcsd2uM0TTZaHxKkw
         Kc1hLq9lDDyjiPQ4aZG2NBP5HMXi/GgECzL9aq+3OWcIRbQNRteSZGVh46j0JcapYW32
         ZLyw==
X-Gm-Message-State: AGRZ1gL5+4x9Mv3ZoenYz/b5qnN90zKfd0ky/+2OhqWwXEpJD+cVZol7
        WpaeZPDotBwYRomfzzDoNbY=
X-Google-Smtp-Source: AJdET5f1HRLG4oiIgEtYLgMHVEMcLqOjXLvCH1sR8JD58zxyE6d2EicULjf1gcPmOA4ScMfEl8Skrg==
X-Received: by 2002:a62:3101:: with SMTP id x1-v6mr2806632pfx.204.1542214467699;
        Wed, 14 Nov 2018 08:54:27 -0800 (PST)
Received: from sabyasachi ([45.116.191.241])
        by smtp.gmail.com with ESMTPSA id l63-v6sm22675772pfb.75.2018.11.14.08.54.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 08:54:26 -0800 (PST)
Message-ID: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com>
X-Google-Original-Message-ID: <20181114165421.GA3075@sabyasachi.linux@gmail.com>
Date:   Wed, 14 Nov 2018 22:24:21 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH v2] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
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
v2: Removed additional braces

 drivers/scsi/fnic/fnic_trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 8271785..bf0fd2a 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -468,14 +468,13 @@ int fnic_trace_buf_init(void)
 	fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
 					  FNIC_ENTRY_SIZE_BYTES;
 
-	fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
+	fnic_trace_buf_p = (unsigned long)vzalloc(trace_max_pages * PAGE_SIZE);
 	if (!fnic_trace_buf_p) {
 		printk(KERN_ERR PFX "Failed to allocate memory "
 				  "for fnic_trace_buf_p\n");
 		err = -ENOMEM;
 		goto err_fnic_trace_buf_init;
 	}
-	memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
 
 	fnic_trace_entries.page_offset =
 		vmalloc(array_size(fnic_max_trace_entries,
-- 
2.7.4

