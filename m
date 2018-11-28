Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FB720989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UyQb4EpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FB720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeK2Dty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:49:54 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34291 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbeK2Dtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:49:53 -0500
Received: by mail-lf1-f45.google.com with SMTP id p6so19884108lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSzNDlwgei09HfpJCFDGn/O7447JujbkPrzCU+KEiVM=;
        b=UyQb4EpWJEMhQTOivOsPMBNN13w/1ra0hJ9h74ryiKp1EQ6lZ3j4wVg+hLCy7r++OX
         ZMh+qRF5hkB8XZKwct1uSBLtSPIaxHOogoRFEnJGpAMM2zrQhcAuPfy21jIgw4Eodgx+
         ofdNJSAQxS3EBGFeL12NesFaW2MPyvXcO4BRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSzNDlwgei09HfpJCFDGn/O7447JujbkPrzCU+KEiVM=;
        b=Htfbree226dr2YWBIoLpPO5V67BPP0KDYwrvHcuw7/VhB/w2JWDMgo9rLqkE8Pw4hD
         I/b6sopFwsjf194/FZGHom+m05+rS+0yjDHf1SqWAMIO9IKpu6uh5Cvsm3JGV8yAKpO9
         TI8JFiqYPkJYzZn3lFOLLlnt1/IIoc+vApJxNXzdBMbp0Uw1GGL7haTQUy46fdo2i/b0
         k+aaT++onVXOwIhe7yIRU1mV3qNfHia906vE2aP9Xvi28it9cg/3H0Ra6YagyXkbt8lO
         8u36u9knKdF0j49NlDJQ+NNzbtARWP2L6VtQASZ/+1fmdf9nUXzLOOhxVuDE3ahrW5WT
         FYsg==
X-Gm-Message-State: AGRZ1gKt/KanWzsshqrO+kkLmAWNQSU0uevAdF5dak6zliuLkqGScNH2
        fRpPhjENilL5R536aSgQqRjWQcRLQQk=
X-Google-Smtp-Source: AJdET5d6mq1I99wZCraYc+B1zhnnGgdFV+Nz2Fb3hXpfIbdeeQJEtIvcWbmR0jMO+jdCkvYPSmNTUA==
X-Received: by 2002:a19:5402:: with SMTP id i2mr21447219lfb.128.1543423655341;
        Wed, 28 Nov 2018 08:47:35 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id t9-v6sm1219157ljj.87.2018.11.28.08.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:47:33 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id u6-v6so24052031ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:47:33 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr21021065ljj.120.1543423641179;
 Wed, 28 Nov 2018 08:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk> <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com> <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
In-Reply-To: <20181128074117.GA21126@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Nov 2018 08:47:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
Message-ID: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, linux@armlinux.org.uk,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        xen-devel@lists.xenproject.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Nov 23, 2018 at 07:55:11AM +0100, Christoph Hellwig wrote:
> > Well, I can tweak the last patch to return -EINVAL from dma_mapping_error
> > instead of the old 1 is as bool true.  The callers should all be fine,
> > although I'd have to audit them.  Still wouldn't help with being able to
> > return different errors.
>
> Any opinions?  I'd really like to make some forward progress on this
> series.

So I do think that yes, dma_mapping_error() should return an error
code, not 0/1.

But I was really hoping that the individual drivers themselves could
return error codes. Right now the patch-series has code like this:

      ret = needs_bounce(dev, dma_addr, size);
      if (ret < 0)
-         return ARM_MAPPING_ERROR;
+         return DMA_MAPPING_ERROR;

which while it all makes sense in the context of this patch-series, I
*really* think it would have been so much nicer to return the error
code 'ret' instead (which in this case is -E2BIG).

I don't think this is a huge deal, but ERR_PTR() has been hugely
successful elsewhere. And I'm not hugely convinced about all these
"any address can be valid" arguments. How the hell do you generate a
random dma address in the last page that isn't even page-aligned?

                     Linus
