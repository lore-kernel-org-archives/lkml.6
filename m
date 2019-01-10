Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB12C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB09214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNDqQOnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfAJGtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:49:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39865 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfAJGtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:49:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so4875774pfc.6;
        Wed, 09 Jan 2019 22:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=eEJOT0okA+zkankTToP39j/tuXqOn8a/Jd6LGEx1DBA=;
        b=oNDqQOnxoIZ2EOK5U/ShtVcQG5PkAUMQTne76gQaNJ1OCr+YSHiQGHh/O65rkFzcdE
         c9tEBqoLPncgcja9cxpGZQyQ5XChA7PjvKgqhrGZvga8QAX9F6JEQqJNAPF4sLBZF1sB
         tmFF/q18cnrG9wKA08YyPZLi+H76jEXE7ZP0esbvUGOdPo/A9BVDPaxC+HvXd9yimgIL
         1TlOq9H0mzUh+l3SralKwykNwW1QifGfnT8HuNfiJKhhzmlAlPxbRQrWKgWo2UQA5Onm
         C7GkMboPHsbMg3ozU/CeDE6Fr+qMiPi1CBWknWaR2fSRz5Qm2sPZhkk+syS5tXjmCEUv
         DN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=eEJOT0okA+zkankTToP39j/tuXqOn8a/Jd6LGEx1DBA=;
        b=tCQnZSS8HGSNFTqvj13NWX2lSITnkmpc9VjY1VA1XPy+gOt8sqPERG0VOs94eSHjFf
         ad5IlqrxYM1amQiyKb/6kWBcb8Pp4aTQBDoeXLZDJ6xlMBdTuJh9XoiQgq2aWOZ/cXlG
         16731H7Vmp/Bam7SD800mqSgA+DAJlKOJh6CapMyVGHMq3lhBX6kAcjq4sp1kTFw9rTS
         4nQwkYGtRlaqAB2Wx1drjFYTFAyOWXpvdRENyNWx3NQRCayEKwYVWAinQZJ6Lt82Jkbu
         UjFX5eSOmqq3Mf9v0Q5Aj3cvBtn7NjZ5V1Cn6whpEGBORLi6QbH3IOmQRVHHXqYPOmSq
         fPlw==
X-Gm-Message-State: AJcUukcmkfrbIsQ3yOsnmKdDL+/5JtxsAw353jaCjfyD6zTC3lkrQ4Qm
        s/QzENQWNiZgqPCFBrXZUlM=
X-Google-Smtp-Source: ALg8bN4gzbEF0ECGuFoooWy0Lh4wex0eBfiTXcoSu/2WRTkXKozbeERrSU4d79Puwng9uNTJ0CJtyQ==
X-Received: by 2002:a62:2c81:: with SMTP id s123mr8955092pfs.174.1547102982312;
        Wed, 09 Jan 2019 22:49:42 -0800 (PST)
Received: from sabyasachi ([2409:4061:2019:ef6:e468:6878:1f4b:258a])
        by smtp.gmail.com with ESMTPSA id t12sm116815188pfi.45.2019.01.09.22.49.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 22:49:41 -0800 (PST)
Message-ID: <5c36eb05.1c69fb81.c3ab9.8a59@mx.google.com>
X-Google-Original-Message-ID: <20190110064936.GA25141@sabyasachi.linux@gmail.com>
Date:   Thu, 10 Jan 2019 12:19:36 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, jrdr.linux@gmail.com,
        brajeswar.linux@gmail.com
Subject: [PATCH] drivers/usb/storage/cypress_atacb.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unusual_cypress.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/usb/storage/cypress_atacb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/storage/cypress_atacb.c b/drivers/usb/storage/cypress_atacb.c
index 4825902..be2e346 100644
--- a/drivers/usb/storage/cypress_atacb.c
+++ b/drivers/usb/storage/cypress_atacb.c
@@ -55,7 +55,6 @@ MODULE_DEVICE_TABLE(usb, cypress_usb_ids);
 }
 
 static struct us_unusual_dev cypress_unusual_dev_list[] = {
-#	include "unusual_cypress.h"
 	{ }		/* Terminating entry */
 };
 
-- 
2.7.4

