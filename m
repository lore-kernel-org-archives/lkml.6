Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934D0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634052084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634052084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeJZAew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:34:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37530 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:34:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh10-v6so4077837plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pj9AY0PqTIIYWpw8/+MFwgIAgGMdHVTRF3CAfaCMVxM=;
        b=XKnvkHxRVY1Fd5EL7+Wpn6KK4wuhnrwc3odiSHd1bYxKV/q8bT1Jy93eN+PdrgZvLH
         1kTs9aYDqdn+VqBr8fDpwdp3eF7ZAEJ4WBjHWU0XI6UFJaEaPWzszwfV0+fBVa26vESo
         lHps5vX9+OxLrhroetBGk0kkGG+hNesuECTiHFYDyX+BcSA27w19Qv1RRDmLf6XUzjbF
         SMHXqRYs/Boa4ykFaYepRXPhR/tT0jzLKaLk/P9l0HYFbla/oqmmfqLEzNE/kDJ/Pr53
         ngAWKzhdcMTKZMd0jlMhZuF16vjj3qwjLdijS4bFa0E/46ir1olEDSQLbjjfGERE8BrI
         Mz/w==
X-Gm-Message-State: AGRZ1gJNiFVCbGvkwk0XOXA67tR5137/BKo9yi0CSZmGGNj08OYSZop9
        hX/BcADxuBJivn2SiUNiIdA=
X-Google-Smtp-Source: AJdET5dov/0x99q1VzcU2T3yCwFVeW9yC9fd9X0amnWYxXkG8srVcpR0lAOWfcaZz6km75obQ8Q5QA==
X-Received: by 2002:a17:902:778a:: with SMTP id o10-v6mr1596503pll.5.1540483288690;
        Thu, 25 Oct 2018 09:01:28 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id q25-v6sm19257722pfk.154.2018.10.25.09.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 09:01:27 -0700 (PDT)
Message-ID: <1540483286.66186.22.camel@acm.org>
Subject: Re: [PATCH 1/3] kernel/workqueue: Remove lockdep annotation from
 __flush_work()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 09:01:26 -0700
In-Reply-To: <986cb39001ee9eb11dd546b79de9e0b4b8463d19.camel@sipsolutions.net>
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-2-bvanassche@acm.org>
         <986cb39001ee9eb11dd546b79de9e0b4b8463d19.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 17:31 +-0200, Johannes Berg wrote:
+AD4 +AD4 Remove
+AD4 +AD4 the lockdep annotation from +AF8AXw-flush+AF8-work() because start+AF8-flush+AF8-work()
+AD4 +AD4 already has such an annotation.
+AD4 
+AD4 This part at least isn't true, there's no annotation on the work
+AD4 +ACo-struct+ACo, only one on the work +ACo-queue+ACo.

You are right - I will drop this patch.

Bart.
