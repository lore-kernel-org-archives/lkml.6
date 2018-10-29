Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E32BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D520657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413D520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJ3Bfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:35:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47026 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeJ3Bfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:35:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id bb7-v6so4074539plb.13;
        Mon, 29 Oct 2018 09:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvRsSiX+36nGlDuAeyGfIcF9SgCDE2QljcQqoXx5vfE=;
        b=R4o2R+/G4E4MveEWeTGTRuYvVFbRERq2tsqI6E56Q18Xr0j3QpNZgwXPcTl/FHkAtB
         AE6Tvc6ujUp5HgpcH8GotAJBPnLAWlF5gmGFGqjRUOwcpafnleOgGPwTVOWY4k4YM/zW
         7HlTwAZusSYUyIPfVuEK+Ke7OzvB8dVm7p3pNSYDfe1IKC2N48euUstOw2R0pa0a4cSR
         6cWx8cGmluw5GEWACic1exZd9jb8gJlBMBorrq4fOBxrMfOApPF+pl5x3S3AB66Gw2lU
         FGFnlsS0elnATWF6N48MXtoIiwMCZoZiVhfQ2xE5vwmzKoVMyzU7it1lLBb6ToQ3wMWe
         TNRg==
X-Gm-Message-State: AGRZ1gK0yMs0gMvnQJa+5Zl2l9bAivnFrRL/QMexth9BcC7OFTgDyAkH
        ytoT/SeOrprEX8kXGA8fU+j3c/o7
X-Google-Smtp-Source: AJdET5cAGoOYB/RcuUFf7NCaFPAUXplLLbDvufwigPY5KRYC3C5lphqq/L1aXnLSJi4y2WT2bndzMw==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5-v6mr15409187plr.100.1540831590524;
        Mon, 29 Oct 2018 09:46:30 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e9-v6sm27042817pgl.44.2018.10.29.09.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 09:46:29 -0700 (PDT)
Message-ID: <1540831588.196084.54.camel@acm.org>
Subject: Re: [PATCH 01/14] blk-mq: kill q->mq_map
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 09:46:28 -0700
In-Reply-To: <20181029163738.10172-2-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-2-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 It's just a pointer to set-+AD4-mq+AF8-map, use that instead.

Please clarify in the patch description that the q-+AD4-tag+AF8-set assignment
has been moved because this patch makes it necessary to have that pointer
available earlier such that it is clear that that move is intentional.
Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


