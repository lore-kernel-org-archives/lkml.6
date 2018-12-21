Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCDA21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Am4bIxoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbeLUT1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:27:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43073 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeLUT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:27:42 -0500
Received: by mail-io1-f66.google.com with SMTP id q17so1081126ior.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rZjr0t7r+0yrFfTECBQDjKIAbla4O7UXrgAYzrDfzF0=;
        b=Am4bIxoUKSMqUVhwRhlo7/sR5IbLv6JUb1lMtOXDsy+4J9b+VUrFS0//M6njQKIi3M
         GcYbfMKlEb+BpXiMRt2N08oB5d8s/1S4lk1S3HscfQFU8B3jdVwGlesDpWjpZ/jy7adF
         RsaG11V9eM6aVLCmeLLmUF8u/n3dJJNYUYRPq/XbX/xaVeXL1dMwR7GV48nL88/ZKSJ/
         4yzNayxiSkKVjQKB06kyRvRWRmZFkCHvCg33XQMGbp2YzzfDLtGLE0+orY1mC8wkG5ux
         Ge2RjFJZ5F1Xq5lEtvc6/ootCWDCZ3bywWvY2PvF4oT5ByRYKxb9ZB3NpWWvLQUR1ouf
         DhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rZjr0t7r+0yrFfTECBQDjKIAbla4O7UXrgAYzrDfzF0=;
        b=nI02eg1MQ0fiobuiHjNv+WN/cMf0YiaBqj4SsY9F8K4C2qDGoEIGiLsgaIfehZpCj3
         bTGzpOuIwSUKGrbcJHaBPSinPsIGI0WJEL53TMDCX503XDJXYMLtPEwoTCOs1NoFv6Yj
         a3ZbgbpI0uj+8XbRrwwwh887TUQBKEig6YgBfZyus4EtcYmd74KNkVuyEhu+kLOQwb3+
         kWvl9xHQbheSobe5Zc0H8Yva67voklwTNlXUe3p/0f7qrxxZs5wl887DsVMJYo0HioqH
         jAIjdfo2wDD0ZxacwXJfprMbUTpq1xDzYDn9cOfl13OVs5ep9F3g+g5VuWEhrTpRn87a
         O08A==
X-Gm-Message-State: AJcUuke6L+1dQ2oUfqhdzqNk1EKJ8Faf8Qq4j/rojRrbnORS02TE+qtG
        eiiDIz6ChblogjreXHPLf2kjQQ==
X-Google-Smtp-Source: ALg8bN4cHLxcqS2VbI6j1wI964qIPqab1mnS29FQS4DLd30OCQWQiktpcX0qe7BhBD+JbEa2LQEq6w==
X-Received: by 2002:a6b:b28a:: with SMTP id b132mr2513633iof.256.1545420460856;
        Fri, 21 Dec 2018 11:27:40 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id l186sm6411860itl.22.2018.12.21.11.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 11:27:40 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Fri, 21 Dec 2018 11:27:39 -0800 (PST)
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <541e8b85bc2d3010741daadddc71ada52b847b8f.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1812211124180.777@viisi.sifive.com>
References: <20181221190615.19003-1-alistair.francis@wdc.com>  <alpine.DEB.2.21.9999.1812211110260.777@viisi.sifive.com> <541e8b85bc2d3010741daadddc71ada52b847b8f.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Dec 2018, Alistair Francis wrote:

> When the MicroSemi driver does eventually go upstream this will
> probably have to be discussed though as either the config or device
> tree will need to be edited to ensure only one PCIe device is present.

The right way to do that is to have two separate DT files: one for the 
HiFive-U board alone; the other for the HiFive-U plus the expansion board 
combo.  There shouldn't be any problems with keeping both drivers enabled 
in the defconfig.


- Paul
