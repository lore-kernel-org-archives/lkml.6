Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C22C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96D420651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96D420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeJWFqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:46:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42707 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbeJWFqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:46:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so20529460pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdEG8GP1urvpSBpD6MXwEH6aJ5nfUfcZCSyf80pHEb8=;
        b=AzKNXv+79dcYu/YEIOYGM6foXr0tTklJmWcKszI3KvHAhGemHizuCkMA4fs3z7YeW/
         9B+IFqMME4S9iy1CvMeQS0bNUEz97VI+BpaMMZNoI8yWfmVFcjnCochIQ4sQQLYOJ2kt
         l7vvz5oEU4y+tIPhYWfSpqK1RQgV04MDZwI32Cl+OL7iKboDBoHrOix9E2pjcELUu7Hz
         6z8C0+15+8ivbTZFuJFxQ2ZDba/CshArYANJMWzMRPxgeL4R7TOD0mnqeHRy5d3TuLPo
         a61v/mr6UNFbHLftD6lspDwdrN8jmQbouU+ma9EXAMETGa127WxIgzLlgxvYhObpoV5F
         vNRw==
X-Gm-Message-State: ABuFfoiV8sRbTP+8pNzRSzgJ+wZnpOAzuJCGtORKXkd+1iizEdvbFN6y
        ZbvPRUoRi5q9caJwpzTxbok=
X-Google-Smtp-Source: ACcGV61oytOTRT9H6E4Rxe13xXqGggTqtX1wm6+hLiwuiOqJ9fKSkoqA8IFarRiaWrv3UoxPmuS2uA==
X-Received: by 2002:a63:e47:: with SMTP id 7-v6mr44681554pgo.320.1540243594573;
        Mon, 22 Oct 2018 14:26:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j25-v6sm37636130pff.116.2018.10.22.14.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:26:33 -0700 (PDT)
Message-ID: <1540243592.128590.36.camel@acm.org>
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
Date:   Mon, 22 Oct 2018 14:26:32 -0700
In-Reply-To: <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
         <1540241646.128590.16.camel@acm.org>
         (sfid-20181022_225411_316091_CE34F84D) <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 23:04 +-0200, Johannes Berg wrote:
+AD4 When lockdep was added, the networking socket locks also were (mostly)
+AD4 fine, recursion there only happened on different types of sockets. Yet,
+AD4 lockdep did in fact report issues with it, because originally they
+AD4 weren't split into different classes.
+AD4 
+AD4 Did we remove lockdep again because it was reporting a potential problem
+AD4 in the socket lock code?

I do not agree. It is accepted in the kernel community that if locks are
nested that nested locks should always be taken in the same order. There is
no agreement however that the kind of checking implemented by the +ACI-crosslock+ACI
code made sense. My understanding is that you are trying to reintroduce
through a backdoor some of the crosslock code. There is scientific evidence
that it is not possible to come up with an algorithm that flags all
potential deadlocks in programs that use completions without reporting false
positives. See e.g. Agarwal, Rahul, and Scott D. Stoller. +ACI-Run-time detection
of potential deadlocks for programs with locks, semaphores, and condition
variables.+ACI In Proceedings of the 2006 workshop on Parallel and distributed
systems: testing and debugging, pp. 51-60. ACM, 2006.
(http://citeseerx.ist.psu.edu/viewdoc/download?doi+AD0-10.1.1.436.7823+ACY-rep+AD0-rep1+ACY-type+AD0-pdf).

+AD4 As I thought I made pretty clear, the report is in fact valid.

I'm surprised that although your patch caused a deadlock to be reported while
no deadlock occurred that you keep insisting that your report is valid. I don't
understand this.

Bart.
