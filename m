Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA04C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEAF20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEAF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbeKGJwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:52:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbeKGJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:52:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so6560379pgq.4;
        Tue, 06 Nov 2018 16:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMgVtvHicGBUUxuh3iaAAtTX1/mR2gzMkTTpMy2rKd4=;
        b=MZ9QSAPYkXN9qP2qdOaFN9ZEDBVatbIR6FNiQr4yUuY9+EX6GbK3rFIhnzmMO5EAAQ
         tysSVKqohQbZnlgQVETLwdtmaezEo2jqZ7309IGw3J3ooOv1L38lmLhMfQ32WnB+p0jr
         2SdBGlCryS30TgwVNXAl7gxdAZulkvgDkaCRvV0Rpm/5KgtQ5F2H7bQfpJPclo8KnI4z
         RPg0zfPOiNX4I7DjPonBw4aCDVpgAHaTWUAl8O/Sd3gWAqUXEFa86bo97BOZfypY1iIW
         3XD5UiVQUY5vphV8nqn7zhSC/3zayNUCjs6bmjfgOq4NvNwa2sgY3PYfm8aUk8sBEj1+
         q5aA==
X-Gm-Message-State: AGRZ1gK+5dGB5mggVcAVLULjdA3ydbXtp5MwvvZqSYR/8oFmmqY8s/P1
        XIPFM4pZmMAzlmfHvbm/yiA=
X-Google-Smtp-Source: AJdET5foIWnr7fIto6pZoO5CX47D050Y1PR1AqTJV3EWit8dsqWosKyjoxIcvV+qblYfJ+eS9q0D6Q==
X-Received: by 2002:a62:5c41:: with SMTP id q62-v6mr12947803pfb.171.1541550254617;
        Tue, 06 Nov 2018 16:24:14 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 3-v6sm52390858pga.12.2018.11.06.16.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:24:13 -0800 (PST)
Message-ID: <1541550252.196084.200.camel@acm.org>
Subject: Re: [driver-core PATCH v5 7/9] driver core: Attach devices on CPU
 local to device node
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 16:24:12 -0800
In-Reply-To: <154145233508.29224.9891071445860629874.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145233508.29224.9891071445860629874.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
+AD4 This change makes it so that we call the asynchronous probe routines on a
+AD4 CPU local to the device node. By doing this we should be able to improve
+AD4 our initialization time significantly as we can avoid having to access the
+AD4 device from a remote node which may introduce higher latency.
+AD4 
+AD4 For example, in the case of initializing memory for NVDIMM this can have a
+AD4 significant impact as initialing 3TB on remote node can take up to 39
+AD4 seconds while initialing it on a local node only takes 23 seconds. It is
+AD4 situations like this where we will see the biggest improvement.
+AD4 
+AD4 Signed-off-by: Alexander Duyck +ADw-alexander.h.duyck+AEA-linux.intel.com+AD4
+AD4 ---
+AD4  drivers/base/dd.c +AHw    4 +-+---
+AD4  1 file changed, 2 insertions(+-), 2 deletions(-)
+AD4 
+AD4 diff --git a/drivers/base/dd.c b/drivers/base/dd.c
+AD4 index 2fdfe45bb6ea..cf7681309ee3 100644
+AD4 --- a/drivers/base/dd.c
+AD4 +-+-+- b/drivers/base/dd.c
+AD4 +AEAAQA -834,7 +-834,7 +AEAAQA static int +AF8AXw-device+AF8-attach(struct device +ACo-dev, bool allow+AF8-async)
+AD4  			dev+AF8-dbg(dev, +ACI-scheduling asynchronous probe+AFw-n+ACI)+ADs
+AD4  			get+AF8-device(dev)+ADs
+AD4  			dev-+AD4-async+AF8-probe +AD0 true+ADs
+AD4 -			async+AF8-schedule(+AF8AXw-device+AF8-attach+AF8-async+AF8-helper, dev)+ADs
+AD4 +-			async+AF8-schedule+AF8-dev(+AF8AXw-device+AF8-attach+AF8-async+AF8-helper, dev)+ADs
+AD4  		+AH0 else +AHs
+AD4  			pm+AF8-request+AF8-idle(dev)+ADs
+AD4  		+AH0
+AD4 +AEAAQA -992,7 +-992,7 +AEAAQA static int +AF8AXw-driver+AF8-attach(struct device +ACo-dev, void +ACo-data)
+AD4  		if (+ACE-dev-+AD4-driver) +AHs
+AD4  			get+AF8-device(dev)+ADs
+AD4  			dev+AF8-set+AF8-drv+AF8-async(dev, drv)+ADs
+AD4 -			async+AF8-schedule(+AF8AXw-driver+AF8-attach+AF8-async+AF8-helper, dev)+ADs
+AD4 +-			async+AF8-schedule+AF8-dev(+AF8AXw-driver+AF8-attach+AF8-async+AF8-helper, dev)+ADs
+AD4  		+AH0
+AD4  		device+AF8-unlock(dev)+ADs
+AD4  		return 0+ADs

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

