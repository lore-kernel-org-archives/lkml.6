Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3456C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F8A20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F8A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389659AbeKGCsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:48:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34156 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389303AbeKGCsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:48:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so5330504plo.1;
        Tue, 06 Nov 2018 09:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeS6NACVlSlXdQdEkAlpY8Fw+v54xW6JjqzFAzK1/l4=;
        b=VDIdLxMvMTNTCVrvxw0RszY7i0NtxF994WToE5LtDuyzh6eh32cKNxSHRuNeR7NIr/
         zKEbpKayY6bKuP0GvcvBP+Jq5Jh42ssbZHvCwH1xABiT1OQv3Fro68mES6rTqPC2dzzh
         ocpdvxyV8EJbJtAkQI2J0DARfziGVkLsWsPcBNNgG+cZ/4yMBY2ro2YC4itGcrNbrFh6
         mesT0+KymD0x3MAPPE2iBxJZfNRhmcjHmYe6YGrXwJiL4dZhhuYEnQeRCvgQvNweEItN
         dihCUGXyw2n73x1Ml5W8F8afu5mGoxde2V6vboLRzJSdBd11LSQzTy1ScZOMfvBZkTT3
         +Dcw==
X-Gm-Message-State: AGRZ1gKTouNyI3pflMY+gh/Y3ttwU42eFyGa5/23dKRbKr4aikkeCvOG
        N+WKZPZ3ARTErV2ZHthGIe4=
X-Google-Smtp-Source: AJdET5dySXQf/y+zqd6CmiQDt8AQFPHkNoEdODYAAXR2Z3JTqPj8Ur5PKJNOSl1Wzy+TPW+MYQEo2Q==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20-v6mr27080239pll.218.1541524945937;
        Tue, 06 Nov 2018 09:22:25 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b11-v6sm36529501pgi.10.2018.11.06.09.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 09:22:25 -0800 (PST)
Message-ID: <1541524943.196084.178.camel@acm.org>
Subject: Re: [driver-core PATCH v5 4/9] driver core: Move
 async_synchronize_full call
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 09:22:23 -0800
In-Reply-To: <e2fec0e159757f31abbd258e284a844d0d8a2859.camel@linux.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145231976.29224.39638353241256116.stgit@ahduyck-desk1.jf.intel.com>
         <1541466289.196084.176.camel@acm.org>
         <e2fec0e159757f31abbd258e284a844d0d8a2859.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 08:18 -0800, Alexander Duyck wrote:
+AD4 On Mon, 2018-11-05 at 17:04 -0800, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
+AD4 +AD4 +AD4 This patch moves the async+AF8-synchronize+AF8-full call out of
+AD4 +AD4 +AD4 +AF8AXw-device+AF8-release+AF8-driver and into driver+AF8-detach.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 The idea behind this is that the async+AF8-synchronize+AF8-full call will only
+AD4 +AD4 +AD4 guarantee that any existing async operations are flushed. This doesn't do
+AD4 +AD4 +AD4 anything to guarantee that a hotplug event that may occur while we are
+AD4 +AD4 +AD4 doing the release of the driver will not be asynchronously scheduled.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 By moving this into the driver+AF8-detach path we can avoid potential deadlocks
+AD4 +AD4 +AD4 as we aren't holding the device lock at this point and we should not have
+AD4 +AD4 +AD4 the driver we want to flush loaded so the flush will take care of any
+AD4 +AD4 +AD4 asynchronous events the driver we are detaching might have scheduled.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Signed-off-by: Alexander Duyck +ADw-alexander.h.duyck+AEA-linux.intel.com+AD4
+AD4 +AD4 +AD4 ---
+AD4 +AD4 +AD4  drivers/base/dd.c +AHw    6 +-+-+----
+AD4 +AD4 +AD4  1 file changed, 3 insertions(+-), 3 deletions(-)
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 diff --git a/drivers/base/dd.c b/drivers/base/dd.c
+AD4 +AD4 +AD4 index 76c40fe69463..e74cefeb5b69 100644
+AD4 +AD4 +AD4 --- a/drivers/base/dd.c
+AD4 +AD4 +AD4 +-+-+- b/drivers/base/dd.c
+AD4 +AD4 +AD4 +AEAAQA -975,9 +-975,6 +AEAAQA static void +AF8AXw-device+AF8-release+AF8-driver(struct device +ACo-dev, struct device +ACo-parent)
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  	drv +AD0 dev-+AD4-driver+ADs
+AD4 +AD4 +AD4  	if (drv) +AHs
+AD4 +AD4 +AD4 -		if (driver+AF8-allows+AF8-async+AF8-probing(drv))
+AD4 +AD4 +AD4 -			async+AF8-synchronize+AF8-full()+ADs
+AD4 +AD4 +AD4 -
+AD4 +AD4 +AD4  		while (device+AF8-links+AF8-busy(dev)) +AHs
+AD4 +AD4 +AD4  			+AF8AXw-device+AF8-driver+AF8-unlock(dev, parent)+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +AEAAQA -1087,6 +-1084,9 +AEAAQA void driver+AF8-detach(struct device+AF8-driver +ACo-drv)
+AD4 +AD4 +AD4  	struct device+AF8-private +ACo-dev+AF8-prv+ADs
+AD4 +AD4 +AD4  	struct device +ACo-dev+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-	if (driver+AF8-allows+AF8-async+AF8-probing(drv))
+AD4 +AD4 +AD4 +-		async+AF8-synchronize+AF8-full()+ADs
+AD4 +AD4 +AD4 +-
+AD4 +AD4 +AD4  	for (+ADsAOw) +AHs
+AD4 +AD4 +AD4  		spin+AF8-lock(+ACY-drv-+AD4-p-+AD4-klist+AF8-devices.k+AF8-lock)+ADs
+AD4 +AD4 +AD4  		if (list+AF8-empty(+ACY-drv-+AD4-p-+AD4-klist+AF8-devices.k+AF8-list)) +AHs
+AD4 +AD4 
+AD4 +AD4 Have you considered to move that async+AF8-synchronize+AF8-full() call into
+AD4 +AD4 bus+AF8-remove+AF8-driver()? Verifying the correctness of this patch requires to
+AD4 +AD4 check whether the async+AF8-synchronize+AF8-full() comes after the
+AD4 +AD4 klist+AF8-remove(+ACY-drv-+AD4-p-+AD4-knode+AF8-bus) call. That verification is easier when
+AD4 +AD4 the async+AF8-synchronize+AF8-full() call occurs in bus+AF8-remove+AF8-driver() instead
+AD4 +AD4 of in driver+AF8-detach().
+AD4 
+AD4 I considered it, however it ends up with things being more symmetric to
+AD4 have use take care of synchronizing things in driver+AF8-detach since after
+AD4 this patch set we are scheduling thing asynchronously in driver+AF8-attach.
+AD4 
+AD4 Also I don't think it would be any great risk simply because calling
+AD4 driver+AF8-detach with the driver still associated with the bus would be a
+AD4 blatent error as it could easily lead to issues where you unbind a
+AD4 driver but have it get hotplugged to a device while that is going on.

Thanks for the additional clarification. Since I'm fine with this patch:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

