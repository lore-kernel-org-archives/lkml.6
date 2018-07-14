Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2EECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DAF2086E
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udMSbQNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DAF2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeGNQEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 12:04:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34731 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeGNQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 12:04:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so24217858pfn.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jgNEbyv6Txaos5JxScl/OM3mPxccWTCtQsfLdoD43H4=;
        b=udMSbQNBUlZDSTcrIpsE3QurZnAdUh/9IGvpIjdDYQuYEweVNwQWtNo9Fo4b7FWaQ9
         ra9M5nXGr8c2DrCpPkR0wmUd1jMHbCEWcjLtfCDP6MuE4b5n9lQQnNVYdsLpRmvVeVvJ
         BK9XSTbil+c/VqAPEfsHijAWZwfSMCXauKBK7Got8C7+0KRomOCQVBfWihxvbPjaX0Ww
         Xxylds2oRVkdVAP40E09Eemm2MBIacQRDVFBKYPYU0EwX0cNR94gDlkb5rW5EY575+OL
         TIAcWTl21Df+gPxspCSiS9DTeJdJFfmPT9bGmYa54u+PhBIeXF6x6vVFdCbw3ziRh6lK
         NycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jgNEbyv6Txaos5JxScl/OM3mPxccWTCtQsfLdoD43H4=;
        b=eNgjOYFSi1ZY+lGw47mve/5Asc5QZsZioX59guRINHBdfDCf/OefLIVfrXGXUmryvP
         WmqwODh45s+T+avgsJRptB9BXr++u8gFvVNhhFm1Xiec70RsLrVpsYYCr6RCy0HJpOnw
         l5TJFpP+JHmdqKdYE4BW38WvkViGcLJ6bNl5wLACW8RQUhe2CCFxyE2gjUiFhknefa+Y
         8irJ8906Lz+w1ZvtWSB3AUxHA07jtVH0ejpVp51sAhMH7N5m/QYWd3bpy7+XTx62oH/J
         ajJbjV/CYmMP+e/QLBt/nDTfEA74pwvv4PZI9+HDtSkTARsebd/yi7q7L3kb3T/dsm6m
         s/9g==
X-Gm-Message-State: AOUpUlHh+wSKlDO/v+RsJnNNn1pgoS3ZzIzJ1OoRQpSgBYdsqNW5SEYw
        SMIBMp35uE84c8Pwg2pO8GvfvKwj
X-Google-Smtp-Source: AAOMgpcDO94zEFAaQ4EmCk/MubhMyvMD41nt6OfUY7ZQtA7inTGbpSaMcoT5OLE3Ru1Z/CIeELaSow==
X-Received: by 2002:a63:c20:: with SMTP id b32-v6mr9630463pgl.400.1531583104584;
        Sat, 14 Jul 2018 08:45:04 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id d12-v6sm14296794pfn.118.2018.07.14.08.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 08:45:04 -0700 (PDT)
Date:   Sat, 14 Jul 2018 21:14:58 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: comedi_fops: Shift assignment operator '='
 to previous line
Message-ID: <20180714154453.GA27869@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shift '=' assignment operator to the end of previous
line to conform to preferred kernel style line wrapping.
Issue reported by checkpatch CHECK.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 1f3b1106f478..e18b61cdbdeb 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -79,8 +79,8 @@ MODULE_PARM_DESC(comedi_default_buf_size_kb,
 		 "default asynchronous buffer size in KiB (default "
 		 __MODULE_STRING(CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB) ")");
 
-unsigned int comedi_default_buf_maxsize_kb
-	= CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
+unsigned int comedi_default_buf_maxsize_kb =
+	CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
 module_param(comedi_default_buf_maxsize_kb, uint, 0644);
 MODULE_PARM_DESC(comedi_default_buf_maxsize_kb,
 		 "default maximum size of asynchronous buffer in KiB (default "
-- 
2.17.1

