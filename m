Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810052172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="103k2DNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810052172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeI1NFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:05:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1NFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:05:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so3635540pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KN03EsNqwzZLnlgcrhu3QfV9omxhJTIAtxUA5lMJDbA=;
        b=103k2DNMlpo8p8eyDow1vMKfQzJaReUU0tUHrKkGyoVVjweKab0ynzWjyjWdT+qh5c
         RT/6E76QwCE2WOVorDZUnGUo6gouljGMlHqICrIEJJdFKH4Z0us+vUkEYjmBd8r6cb8U
         8dHuAr5UXHt6w8R0cp5gored7DFey7Jp9BGj3efftpopw6Vqfe9smpCm8B/ZQW0zXGQS
         tPC1QXZr1G72v01ZHhT0rjQgRv8CuItSKlPOcPOOr19TBVqgAO4KLzKm1lRfWoIGWk7U
         LhsFpIECTeznF7v2t6ZXHJG9MnIUsi8pjUaBaBAJDdGVPdpnKISFc57cKLoh69my6FMO
         Yagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KN03EsNqwzZLnlgcrhu3QfV9omxhJTIAtxUA5lMJDbA=;
        b=r58Am/uQNpV0e1JrmsE7DCYbhMYv6rfYcyZkf+2eYBZir0OYgwxGxi4slm1VKhmfoU
         cIr/+9sjo+4rallAcxds19ylnJhNchYWg74nqhQJKnFXcLw0kF7c/074B15oFuWfCRiu
         /dofO4Tj8Aql7m7YO8uXy21tY0vZFh+XXM2W+QVRvKIqhIjA+j4Bb6QA2YLBjf46MXXH
         xOQraHuy99w9P++VFcpfQ/eqTQIZh9z3vR1bq9WKYR5hfWgz8VHzrLGoY2R06myOQXYq
         EVMg3wur8DGaXcR5pPLoGfJ7EQGm57u8R44lXNgkXFH/XDbC68gNE+rN01vgeLjepMgM
         DKug==
X-Gm-Message-State: ABuFfogtZMyUujZFTTF+YxyHhEEltfsD27VaQNk9YQpGelRj2pS407/0
        +2vLJxN8/ywlgVFEoWpIUBOs6A==
X-Google-Smtp-Source: ACcGV626wHsqvG+MYyBe5tI3I85tq57WokGU7dXTqBiwZbUXTi4Gwf7pNzEF6Jd9rt5DBkTvyxX2OA==
X-Received: by 2002:a63:e255:: with SMTP id y21-v6mr13584289pgj.160.1538117001931;
        Thu, 27 Sep 2018 23:43:21 -0700 (PDT)
Received: from vader ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id k26-v6sm9248576pfb.167.2018.09.27.23.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 23:43:21 -0700 (PDT)
Date:   Thu, 27 Sep 2018 23:43:19 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20180928064319.GD29754@vader>
References: <20180928111124.745bf2ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928111124.745bf2ef@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:11:24AM +1000, Stephen Rothwell wrote:
> Hi Jens,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> block/kyber-iosched.c:84:22: warning: integer overflow in expression of type 'long int' results in '705032704' [-Woverflow]
>   [KYBER_DISCARD] = 5 * NSEC_PER_SEC,
>                       ^
> 
> Introduced by commit
> 
>   6e25cb01ea20 ("kyber: implement improved heuristics")

Ugh, thanks for the report. This should fix it:

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 2b62e362fb36..eccac01a10b6 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -79,9 +79,9 @@ static const unsigned int kyber_depth[] = {
  * Default latency targets for each scheduling domain.
  */
 static const u64 kyber_latency_targets[] = {
-	[KYBER_READ] = 2 * NSEC_PER_MSEC,
-	[KYBER_WRITE] = 10 * NSEC_PER_MSEC,
-	[KYBER_DISCARD] = 5 * NSEC_PER_SEC,
+	[KYBER_READ] = 2ULL * NSEC_PER_MSEC,
+	[KYBER_WRITE] = 10ULL * NSEC_PER_MSEC,
+	[KYBER_DISCARD] = 5ULL * NSEC_PER_SEC,
 };
 
 /*

Jens, do you mind folding that in, or should I send it separately?
