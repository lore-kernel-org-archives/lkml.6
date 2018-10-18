Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D7C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA632098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA632098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeJSEQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:16:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42612 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJSEQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:16:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so14784882plo.9;
        Thu, 18 Oct 2018 13:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1Ie4tNf8wHwRs2nchhyWctWXNY6iD8mRLyex2PDQN4=;
        b=EQTdkAgNO1FwaFD/+LYg8UioHPbrhVxtovHNX3P6YRogM9tUrZB+FFMggbDzPlrlUk
         u7W3qISgthSCGzGff+KsqlwtIGEzW7XJYX9vkDIuOK9HOdsVtHSE3dOPsqD/stPU80Pd
         VY8hQhB7kPHb4xoM6rNBFzC0wzPWccXw5DPiYi9LQS1Y1ww0VQaeweucJJS7023B5b15
         Yk1W55n0Kfeg3ud1196ZGA3Ip7Dvp/BUC8P8hyvvWk1vfCsmziBdmF0aK65A4yEVeXe2
         bv7I2cWP2XkJw4Pd4CpWROcIJni/q54acv0RX51QJN1Fnz1R4EW9px10C3SgHr4TkqYt
         yk3g==
X-Gm-Message-State: ABuFfogS4dLomhYtHFhJMI7ZW9+Rz0rUFGk9Rh/LmVT89CKXw5qLjXGH
        Iub+cBPjUm5XDBwDMvPHYnI=
X-Google-Smtp-Source: ACcGV63lkTpO4EhAJLZwF+kvi++Kwsuafurm2mE7WAg9vMkK4+F8UM3VOsGej0Ds+EdQMf7EHL8fxA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10-v6mr30364695pls.245.1539893638432;
        Thu, 18 Oct 2018 13:13:58 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i5-v6sm23424928pfo.107.2018.10.18.13.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:13:57 -0700 (PDT)
Message-ID: <1539893636.81977.29.camel@acm.org>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Date:   Thu, 18 Oct 2018 13:13:56 -0700
In-Reply-To: <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150926.29520.45280.stgit@localhost.localdomain>
         <1539886275.81977.17.camel@acm.org>
         <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 12:38 -0700, Alexander Duyck wrote:
+AD4 Basically if somebody loads a driver the dev-+AD4-driver becomes set. If a 
+AD4 driver is removed it will clear dev-+AD4-driver and set driver+AF8-data to 
+AD4 0/NULL. That is what I am using as a mutex to track it in conjunction 
+AD4 with the device mutex. Basically if somebody attempts to attach a driver 
+AD4 before we get there we just exit and don't attempt to load this driver.

I don't think that the above matches your code. +AF8AXw-device+AF8-attach() does not
set the dev-+AD4-driver pointer before scheduling an asynchronous probe. Only
dev-+AD4-driver+AF8-data gets set before the asynchonous probe is scheduled. Since
driver+AF8-detach() only iterates over devices that are in the per-driver klist
it will skip all devices for which an asynchronous probe has been scheduled
but +AF8AXw-device+AF8-attach+AF8-async+AF8-helper() has not yet been called. My conclusion
remains that this patch does not prevent a driver pointer to become invalid
concurrently with +AF8AXw-device+AF8-attach+AF8-async+AF8-helper() dereferencing the same
driver pointer.

Bart.
