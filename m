Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-669745-1523937389-2-12888996774073956631
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523937389; b=OlBgV27gjQ0pf0JC2mwHdePjyG+RWoeOAPJC9ZqhOcBosQIfeV
    CC2NMTTcXfqu/qdW7RtmQRkEu2cQWiHDptTCgXcLjokdU4DVPFW/9GVhgTlxnHlS
    rxYhdBzSObwI4ZeSHYdhkd3OjJ/LgaKGPbS8/o/TEYnn4oQdbOaeA1Bnl768VSM8
    JlzQLCs144ofthYsgjOBjd61xrV71J4iPLzmvoSQyyRkmd7QuIucC9pt6H/M9PpG
    Z6r8ndmqoWT6l3kaQRhiLdlmpOW7z1/dejIg/gsyiwRypBs0I44l9bWKjRiy+z65
    45Q+Qg65CZ0fKw2N+yEAvc/c1hr81fmcaRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523937389;
    bh=BiUKmaEmts5jmpw3AbkILth2y4y21CzOhvl9jhFcIUI=; b=kcPaJYOozCjM
    C+2rKByVUK7eGp9NLbl98qL0fNtcpNaVytPLlnF5twyw5wgZ/fGHyevkQb0nvf13
    petICUloPb8z0pusdndSZQBfvhF6i/9NkQq3ARq4CfuRQ2r1m4gt5pJ+/5ljGNCa
    k/VN9+oeD4HXcj2tmE5DjDIcwGW7alkAuc0xMEAYnzekq+A7mU4LUhQ3h4WzUclN
    WRRzPyWeZGus8KSh3KmcYZUrBr4J7I+NUWFQnmymoRKjEft0V/vD7b8Mn08Y1ktM
    3kLPKh7mWppgVss6JsCgifWkNNoazFr+nhIgHfKqlFrVccS2Yvplc74T5iBHMvZH
    CMEXIAOM0Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=MJpVO6YP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H/8CeW0O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=MJpVO6YP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H/8CeW0O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJfxQpiXRPbJRwM1EPH2eUvU3BGIAvZ40qwLfdCXEjUMmg7GSpnSN3wpVlY9+KTBwO1vIHdEEKHo8sA7RuCw6CINWC4zBustBTvndxD2BTXs3FrDdP+K
    9pO5iI10nUjoDdlZYcFPLtWV0PtonVO59HWs/AGMiNA0TTdxvwCM8PKYX3C+ddUOVHM2wYbG+F1g5oxvB1GLRI5dz/3tl92rAlLowFpxdqtB+1JMhFovoTAp
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PdkTMVOh89TUlz3WfdMA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDQD4Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 23:56:25 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:35549 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeDQD4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 23:56:24 -0400
X-Google-Smtp-Source: AIpwx4/R3WJ2X+7vqK9Ir56TxcY+feTqhGJV7FbtvpjPfUp/ML+D80f8u/Qc41neCym9qEjDL8/GEA==
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: bart.vanassche@wdc.com, tj@kernel.org, ming.lei@redhat.com,
        Martin@Lichtvoll.de, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f1e278d0-bcf8-506d-7298-0a194f4893f0@kernel.dk>
Date: Mon, 16 Apr 2018 21:56:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/18 9:46 PM, Jianchao Wang wrote:
> rq->gstate and rq->aborted_gstate both are zero before rqs are
> allocated. If we have a small timeout, when the timer fires,
> there could be rqs that are never allocated, and also there could
> be rq that has been allocated but not initialized and started. At
> the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
> the blk_mq_terminate_expired will identify the rq is timed out and
> invoke .timeout early.
> 
> For scsi, this will cause scsi_times_out to be invoked before the
> scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
> the moment, then we will get crash.

Oops, this looks good to me. Applied.

-- 
Jens Axboe
