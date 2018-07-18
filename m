Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B781FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767D22084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNQYp6iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767D22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeGRTkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:40:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39879 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGRTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:40:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so2413363pgs.6;
        Wed, 18 Jul 2018 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=llf8Iw9sPQ/qyZwz/lEupBJ8uYE99y//iXh8a9Ofy+0=;
        b=nNQYp6iHbjLKf+SzcjLC5F+Mwdn1GA5C3/ddWc2K/Mjww8IPsYISTna7ul5eWne7xv
         DvNpaZIUI/Flu01vGj5yNB6Baqivh/PtPuI8UkgpcXZFpCGgE7UWK8tYmQtVS9G/kuSf
         b7KlxYFp+EXCAGK8+DIApZFIKVsUqQwzcVAZ1zIDcM/hvP51yItqgyxKL1Ck+McASguc
         Xup5HRjJJRTkjL4GJY4zoNx7VP2lc/eQvFzRUwyTxfjYWye/Q+7vtRMynYzH8zwlMNCp
         5Jjx7cJCtevxj0brYylppAJGZuKZNiIn75Mtj3ZZ8FtjGFTspA7nGzPlAcBin8K3Q2MT
         Pfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=llf8Iw9sPQ/qyZwz/lEupBJ8uYE99y//iXh8a9Ofy+0=;
        b=fKezi7e3xNrc/yn2JPkBnEB92WaOICdxKSGo968I6xrLWwHPByiUBTk4HOp6yjAkax
         SMabl0RYs2wikNVgOvr5sMRO7kjGsn544lF4zdQGIx17Dv0FpYK0URwAyUoRWBNbk5qu
         WsVxN/VQsbtgbrIDNbKWXtHhVrQ1Vv0qmakVJ76GdIwFqEE2pO/U+xepl5s4rkuOG0mT
         JGZUrtZTlfgRcpSjGCIv2B1JCuEelF8/fdcRYAZQkhekkXoSWkBSNK3RFkWZqZnPc+6Z
         5yRLifQ6/WCNRYhI6Y/pFs8yJCDi2X0rPw6JOOMD/0Mp/vWvy9mfC8NKmL+G52wFTJfu
         hozw==
X-Gm-Message-State: AOUpUlEcF3lT82WSOC7nvRKk6A3NY4BoAzunGpmnD9EK8g9hErsiJ++d
        0yqmUlx8CUHFPjrSkdMOaHs=
X-Google-Smtp-Source: AAOMgpdLnE3309s7sJsGr926NIRkuxbLzq5+Jka7Q4/f5HJfOYp0NORzDQ0HSCjKmusUzj3cHEAAmg==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr7055461pgg.40.1531940461357;
        Wed, 18 Jul 2018 12:01:01 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.14])
        by smtp.gmail.com with ESMTPSA id p8-v6sm6477142pfk.186.2018.07.18.12.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 12:01:00 -0700 (PDT)
Date:   Wed, 18 Jul 2018 23:25:53 +0530
From:   RAGHU H <raghuhack78@gmail.com>
To:     Joe Perches <joe@perches.com>, m=@raghu-VirtualBox,
        Bart.VanAssche@wdc.com
Cc:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Message-ID: <20180718175553.GA5532@raghu-VirtualBox>
References: <20180718155855.4949-1-raghuhack78@gmail.com>
 <5ad3cf3212c434e73375eeb22d2f67fd70702744.camel@wdc.com>
 <47fc6920ec365a11b06f7c44f4a3f8d73d177e67.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fc6920ec365a11b06f7c44f4a3f8d73d177e67.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bart,

I'm starter in kernel contribution & I guess cleanup of certain files
which have more than 50+ checkpatch errors is good start.

Also one of the patch was accepted by Jens Axboe & he responded back to
resend one of the patch which was not getting applied.

But I get your point ,I'll restrict my checkpatch fixes to drivers/staging files

Thanks Joe for followup.

On Wed, Jul 18, 2018 at 11:43:11AM -0700, Joe Perches wrote:
> On Wed, 2018-07-18 at 18:06 +0000, Bart Van Assche wrote:
> > On Wed, 2018-07-18 at 21:28 +0530, RAGHU Halharvi wrote:
> > > * Fix all pointer declaration which causes
> > >    "ERROR: "foo* bar" should be "foo *bar""
> > 
> > Hello Raghu,
> > 
> > If you would not be aware of this, checkpatch is a tool that is intended to
> > verify patches before submission and not to verify code that is already
> > upstream. A detailed explanation of why patches like this one should not be
> > submitted is available in "A quick guide to why stand-alone checkpatch
> > patches suck"
> > (https://lists.kernelnewbies.org/pipermail/kernelnewbies/2014-September/012296.html).
> 
> Read more of the whole thread.
> Varying opinions exist.
> 
