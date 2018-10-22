Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5763C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF70A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF70A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeJWFOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:14:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40981 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeJWFOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:14:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so4703118plq.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cF87iTWvaTCtGmZTBYMR1PahgEZzqFKElPmxR8pyPx8=;
        b=UWvRbefU2e1Ko5dKL/YCXOThrP7BnzPqljxxqllr4m/TA418XL8f3fdHXkI2qZjf6g
         QB+ovHRjdOx77wHLpT4sn4aS1DabFolP7h4pqY7WE4EuVeUrirJ3jhrX67FcRmCgQVC3
         281JQyJt/NO9XKVYObx0sUNsi5yN/hPceVnldyb/hNWuvJvfOU8q0hR9Qi5GFIfu1iNP
         JUeJlmphxt0uCmxLWVLg/MrcZr+8z9ypnWb2VBFTbsyABXw6DYPIrBXoa4CSHQ9Rkig6
         cxVxr9IueyEev2jadEKqC9UmmYncANpnBMRJ+o18nHcrLe7mFZDJ7xudyxSLPzhNJkpo
         W/Vg==
X-Gm-Message-State: ABuFfoiUkB9Mr5s/WTA52sCkpBS7OrPORvetl7KnFGRhd28olWBj76Y7
        PgNlyo952wJDb07LzUGV4jE=
X-Google-Smtp-Source: ACcGV61cEGlwkNKQMSz2HsxsKFQQ2GTHJGGYfpyXg4++jUhHBfROpMvw9C0wXSZLJh4Gsjqby/qHOQ==
X-Received: by 2002:a17:902:a7:: with SMTP id a36-v6mr33344480pla.87.1540241648723;
        Mon, 22 Oct 2018 13:54:08 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a79-v6sm46228372pfa.124.2018.10.22.13.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 13:54:07 -0700 (PDT)
Message-ID: <1540241646.128590.16.camel@acm.org>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Mon, 22 Oct 2018 13:54:06 -0700
In-Reply-To: <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 22:28 +-0200, Johannes Berg wrote:
+AD4 The lockdep report even more or less tells you what's going on. Perhaps
+AD4 we need to find a way to make lockdep not print +ACI-lock()+ACI but +ACI-start()+ACI
+AD4 or +ACI-flush()+ACI for work items ... but if you read it this way, you see:
+AD4 
+AD4 CPU0			CPU1
+AD4 
+AD4 lock(i+AF8-mutex+AF8-key)
+AD4 			start(dio-+AD4-complete+AF8-work)
+AD4 			lock(i+AF8-mutex+AF8-key)
+AD4 flush(wq dio/...)
+AD4 
+AD4 which is +ACo-clearly+ACo a problem.

Your patch made lockdep report that the direct I/O code deadlocks although it
clearly doesn't deadlock. So where do you think the bug is? In the direct I/O
code or in your patch?

The code in the column with label +ACI-CPU0+ACI is code called by do+AF8-blockdev+AF8-direct+AF8-IO().
From the body of that function:

			/+ACo will be released by direct+AF8-io+AF8-worker +ACo-/
			inode+AF8-lock(inode)+ADs

I think that is sufficient evidence that the direct I/O code is fine and that
your patch caused lockdep to produce an incorrect deadlock report.

Bart.
