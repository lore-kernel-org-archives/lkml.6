Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A6C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AA920844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AA920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKIJhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:37:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43784 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeKIJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:37:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so30295plb.10;
        Thu, 08 Nov 2018 15:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMC5yx8l6I+W1MLwZm69Ad0rXggLyhykDJoTEMkI8yg=;
        b=SgpLH48MOwKYMxGvSOg15zokytvV/vpkTNSG1F9Pt9qQt7NYUzyXlKJ9XlKv1FFvn6
         WqzsAbdyNtxIFVgI0+ffbVewmQ9XLHsu0KrVaKglRIPEosrOqMc6Idz4AjhTqpG15f1/
         Z2V9sJ/qPQQdARPIDCWnnonW8t0XSKwkQkR8Yp/ITpVTcomnPSpEDwnmru+1qOSXmpWm
         a+jrtssSifDuHMobxsAKPlqCScEYUD2naZK4UXYiXssjGu/myquZ8/QNYKXuQoPHHrFL
         GXYUA/k7ExQtmO9Q7n/UG9zsY3ZiZPMe+YIG0kC+0tWTHhhZO4FcBZI70F49kZbqEvd3
         5GuA==
X-Gm-Message-State: AGRZ1gJk05jZHXoxOA2zfa8ypbt8Pd3zFxePxTsvR46QfphnGoVggLTa
        sJa3dAQHtK9zOwTxjE+6Flo=
X-Google-Smtp-Source: AJdET5dcAe+5yZ5IVm6BhB/mN8AjAFk2uSqDS40p63EVPBJBYX7YJ9Uomj90rotpBdrEDQtycjC2pQ==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13-v6mr6702475plr.74.1541721588502;
        Thu, 08 Nov 2018 15:59:48 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id q1sm5446088pgs.14.2018.11.08.15.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 15:59:47 -0800 (PST)
Message-ID: <1541721586.196084.241.camel@acm.org>
Subject: Re: [driver-core PATCH v6 6/9] driver core: Probe devices
 asynchronously instead of the driver
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Thu, 08 Nov 2018 15:59:46 -0800
In-Reply-To: <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 10:07 -0800, Alexander Duyck wrote:
+AD4 Probe devices asynchronously instead of the driver. This results in us
+AD4 seeing the same behavior if the device is registered before the driver or
+AD4 after. This way we can avoid serializing the initialization should the
+AD4 driver not be loaded until after the devices have already been added.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

