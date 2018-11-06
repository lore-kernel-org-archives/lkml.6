Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C804C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEEB2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEEB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeKFK1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:27:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44360 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:27:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so5299789plq.11;
        Mon, 05 Nov 2018 17:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RB5kf5WkwZdcoqGqrMmKLFR3uy3C5ZpadIkZIn3HqWE=;
        b=bRfp5N4i+hAU2IR/anuDyiztVR2Qj9xts75TfUo3+2NH7fJT7iE0ZYECxIhSS9ld/a
         R+lB2gcVLXea8MtWkRjBpvqgbfyyN7iYoza8fOw65vagzQ7px3J8lBI/RIC93VvCdrW6
         kEEkTfd4BH9F9VjZi/yqhHq8LaUPveC3X00IqjNPhtE3ABN6PAeUUL6AZG/xR5L5BcDO
         pw4L9uERcuu849N4UlSl9XNipc3A6eLYhjAwSxX4xjDP15keYqDJJee8ehqY9qpaO0If
         4FkRaxDKbIdpm/+uuoEwLspqWS7uVsQc66uM6Kf1ZbnnCacN2K/77+tIvSFrkZeQzEl0
         0GtQ==
X-Gm-Message-State: AGRZ1gKnRT7djGFn7ObuDZjkW+CXATCN2wblph89nJGMh5XHpHBADTvf
        M/3xqQttKsYSNAbx9TcKioM=
X-Google-Smtp-Source: AJdET5dgXM4hXc6b1LqOBtTi1tIzCJrdObE9tFVICMwKwq2t0Z/ih7b7vMqcM6GB5J0mmaupi/o0dw==
X-Received: by 2002:a17:902:d907:: with SMTP id c7-v6mr23845767plz.198.1541466291785;
        Mon, 05 Nov 2018 17:04:51 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u124-v6sm69765047pgc.0.2018.11.05.17.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:04:51 -0800 (PST)
Message-ID: <1541466289.196084.176.camel@acm.org>
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
Date:   Mon, 05 Nov 2018 17:04:49 -0800
In-Reply-To: <154145231976.29224.39638353241256116.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145231976.29224.39638353241256116.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
+AD4 This patch moves the async+AF8-synchronize+AF8-full call out of
+AD4 +AF8AXw-device+AF8-release+AF8-driver and into driver+AF8-detach.
+AD4 
+AD4 The idea behind this is that the async+AF8-synchronize+AF8-full call will only
+AD4 guarantee that any existing async operations are flushed. This doesn't do
+AD4 anything to guarantee that a hotplug event that may occur while we are
+AD4 doing the release of the driver will not be asynchronously scheduled.
+AD4 
+AD4 By moving this into the driver+AF8-detach path we can avoid potential deadlocks
+AD4 as we aren't holding the device lock at this point and we should not have
+AD4 the driver we want to flush loaded so the flush will take care of any
+AD4 asynchronous events the driver we are detaching might have scheduled.
+AD4 
+AD4 Signed-off-by: Alexander Duyck +ADw-alexander.h.duyck+AEA-linux.intel.com+AD4
+AD4 ---
+AD4  drivers/base/dd.c +AHw    6 +-+-+----
+AD4  1 file changed, 3 insertions(+-), 3 deletions(-)
+AD4 
+AD4 diff --git a/drivers/base/dd.c b/drivers/base/dd.c
+AD4 index 76c40fe69463..e74cefeb5b69 100644
+AD4 --- a/drivers/base/dd.c
+AD4 +-+-+- b/drivers/base/dd.c
+AD4 +AEAAQA -975,9 +-975,6 +AEAAQA static void +AF8AXw-device+AF8-release+AF8-driver(struct device +ACo-dev, struct device +ACo-parent)
+AD4  
+AD4  	drv +AD0 dev-+AD4-driver+ADs
+AD4  	if (drv) +AHs
+AD4 -		if (driver+AF8-allows+AF8-async+AF8-probing(drv))
+AD4 -			async+AF8-synchronize+AF8-full()+ADs
+AD4 -
+AD4  		while (device+AF8-links+AF8-busy(dev)) +AHs
+AD4  			+AF8AXw-device+AF8-driver+AF8-unlock(dev, parent)+ADs
+AD4  
+AD4 +AEAAQA -1087,6 +-1084,9 +AEAAQA void driver+AF8-detach(struct device+AF8-driver +ACo-drv)
+AD4  	struct device+AF8-private +ACo-dev+AF8-prv+ADs
+AD4  	struct device +ACo-dev+ADs
+AD4  
+AD4 +-	if (driver+AF8-allows+AF8-async+AF8-probing(drv))
+AD4 +-		async+AF8-synchronize+AF8-full()+ADs
+AD4 +-
+AD4  	for (+ADsAOw) +AHs
+AD4  		spin+AF8-lock(+ACY-drv-+AD4-p-+AD4-klist+AF8-devices.k+AF8-lock)+ADs
+AD4  		if (list+AF8-empty(+ACY-drv-+AD4-p-+AD4-klist+AF8-devices.k+AF8-list)) +AHs

Have you considered to move that async+AF8-synchronize+AF8-full() call into
bus+AF8-remove+AF8-driver()? Verifying the correctness of this patch requires to
check whether the async+AF8-synchronize+AF8-full() comes after the
klist+AF8-remove(+ACY-drv-+AD4-p-+AD4-knode+AF8-bus) call. That verification is easier when
the async+AF8-synchronize+AF8-full() call occurs in bus+AF8-remove+AF8-driver() instead
of in driver+AF8-detach().

Thanks,

Bart.
