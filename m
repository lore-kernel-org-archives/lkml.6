Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C9C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213FC2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213FC2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJEFib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:38:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42329 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:38:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so3799403pgq.9;
        Thu, 04 Oct 2018 15:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2eCVFrVCkZ/k2TcpDIIc/2LcxzHPoY3pvxk7bX2qio=;
        b=O8wb8vGJkNMGa23rKaIpSMf4/+xm66vZ+iwXMEt1V7RM1D3wOGFCPsGYn8Yrf84d3I
         +E0YoauEuXLptNlcDj7KgmEu2huSNKW7HrlxJrbWWc/mHxJVEdHa6FPxCZzZWqnH5DBT
         tYJWXgyo2HVfJ3CX1XdTCLpgxe0W4Fc1mSWJc4aq4j71RIZm9xUafnCb47QHrB2mRWP6
         x+Tkox2NHKlMCZu9vkhZVix+60O+rpBs9oCXAj5FhlCYgYr9n5FSNDZ/i5/cuF5vSIt1
         0BF25yLRDJEqeDM8uSV/0VS/GbganTzgQG1Np0bpmX3MJkXgKlQ6gwuLnUPEzfPF6+RZ
         gI1A==
X-Gm-Message-State: ABuFfoiWA8DTVWatYRV/r51KaWNFLbdiKvjrEfLwJbARTapLZZRAwhpa
        NDlYRRMhB7/vCEmXEWz4vfU=
X-Google-Smtp-Source: ACcGV62HnfR7zT8gr9FbaLYySt1VVvTVeastQkyDk3IB/65Bw0JTCbdzpZenrafsusLjytOce4nYWg==
X-Received: by 2002:a65:4548:: with SMTP id x8-v6mr7515345pgr.414.1538692975395;
        Thu, 04 Oct 2018 15:42:55 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f22-v6sm9226791pff.29.2018.10.04.15.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 15:42:54 -0700 (PDT)
Message-ID: <1538692972.8223.7.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 04 Oct 2018 15:42:52 -0700
In-Reply-To: <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
         <1538582091.205649.20.camel@acm.org>
         <20181004202553.71c2599c@alans-desktop> <1538683746.230807.9.camel@acm.org>
         <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 22:39 +-0200, Paolo Valente wrote:
+AD4 No, kernel build is, for evident reasons, one of the workloads I cared
+AD4 most about.  Actually, I tried to focus on all my main
+AD4 kernel-development tasks, such as also git checkout, git merge, git
+AD4 grep, ...
+AD4 
+AD4 According to my test results, with BFQ these tasks are at least as
+AD4 fast as, or, in most system configurations, much faster than with the
+AD4 other schedulers.  Of course, at the same time the system also remains
+AD4 responsive with BFQ.
+AD4 
+AD4 You can repeat these tests using one of my first scripts in the S
+AD4 suite: kern+AF8-dev+AF8-tasks+AF8-vs+AF8-rw.sh (usually, the older the tests, the more
+AD4 hypertrophied the names I gave :) ).
+AD4 
+AD4 I stopped sharing also my kernel-build results years ago, because I
+AD4 went on obtaining the same, identical good results for years, and I'm
+AD4 aware that I tend to show and say too much stuff.

On my test setup building the kernel is slightly slower when using the BFQ
scheduler compared to using scheduler +ACI-none+ACI (kernel 4.18.12, NVMe SSD,
single CPU with 6 cores, hyperthreading disabled). I am aware that the
proposal at the start of this thread was to make BFQ the default for devices
with a single hardware queue and not for devices like NVMe SSDs that support
multiple hardware queues.

What I think is missing is measurement results for BFQ on a system with
multiple CPU sockets and against a fast storage medium. Eliminating
the host lock from the SCSI core yielded a significant performance
improvement for such storage devices. Since the BFQ scheduler locks and
unlocks bfqd-+AD4-lock for every dispatch operation it is very likely that BFQ
will slow down I/O for fast storage devices, even if their driver only
creates a single hardware queue.

Bart.
