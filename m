Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B649C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFB320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gpiccoli-net.20150623.gappssmtp.com header.i=@gpiccoli-net.20150623.gappssmtp.com header.b="rM6/4SJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFB320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gpiccoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966938AbeFSQ1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:27:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35368 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeFSQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:27:10 -0400
Received: by mail-io0-f196.google.com with SMTP id u4-v6so773396iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=msU6brCp7EO9A40jdb+amT8U0bdsUZ4XNYEn+4YdzYE=;
        b=rM6/4SJC+A92oqDE/bQQedUz/AhROF0pgWTVRzrhqdWaiX5Tl9B5H/sfbyqQy/JLbt
         d21HyKHQBFSsXZEl/yv8btkknwUDaEmXG9DOEzCB84R0tbbcOoFwymrzhxq+6fwNY/Ml
         PRxxgUl2o4IKhqiE6mGXgkiGWXss4Rbyq3UgAz6+iBSWV7mzk69FvbP9JRhjufzvVi9+
         KZ+1c36uNW08+j/imJn9/KOJpmszoxBqchA89Q471ugNYca6C8yDwRTfe1IHuU1ROCHo
         Jp1dp6VoDCuFdA9JcS84e2IBcKFxPR9RQSJJ1FNyAT3xvrH+t5x3wxKzhiokDpp3RL0G
         /Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=msU6brCp7EO9A40jdb+amT8U0bdsUZ4XNYEn+4YdzYE=;
        b=sBCaC/ekATvHGXv9lSiQe/HBzg3hFfboyrL3GFHZ9cbgip94Pz34IJyvxRNqoXDH+D
         ExLofHx6JO76s5hncfgIECNUJ2zILypv9VjNz4udKuD55/f+VwRevUwEn9Jta/J0k2ly
         IkWGVBhyW7gt+E1AXeoKj+yeDh8IHqaSAsJk64YvhL2xRf6Z7RjK/wo12cFYY25yoCdp
         HTxteKMGmcoBkal2TA92NV9L8myKBf8GCN+qr5OJhQgSRZgGNHPYdF9kcoruR+NtMwNr
         xsXOJG+3DLyhpi21O16kXNyLGhz+1y16aB24Dy2nzUCqnVlwDSRUx+pYjTB+A2qHp4KP
         kcag==
X-Gm-Message-State: APt69E1I+ph9TTdyXJT9ublkiw7Eoex4zUh2PixOHluoqpsImCmN/4oL
        wydk9WJW+B96hsODGP0drEk5MhVEXkhjDtlQBOI0Mw==
X-Google-Smtp-Source: ADUXVKIjarAGFnd5rT6f2rliCCTSQ9UCRBwa97sW+sP6G1sfAEQ8NAPE0GM4ktFMQfxHyAuIHRw9Su5NKPBfXfibehU=
X-Received: by 2002:a6b:6806:: with SMTP id d6-v6mr13798592ioc.293.1529425630340;
 Tue, 19 Jun 2018 09:27:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:9909:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:26:29
 -0700 (PDT)
X-Originating-IP: [189.0.91.59]
In-Reply-To: <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
References: <20180618165706.42679-1-danielwa@cisco.com> <CALJn8nPbTy3Ne2a7L71c2YZ06Ccr2j0zs6TdptfRc7O-N9u=Yg@mail.gmail.com>
 <c56f43f5-7902-f7c8-20e1-955ad064c4d0@cisco.com>
From:   "Guilherme G. Piccoli" <guilherme@gpiccoli.net>
Date:   Tue, 19 Jun 2018 13:26:29 -0300
Message-ID: <CALJn8nM+S7STs+_MTje1qVCpa6MvnROS2+b5_GDz2wYs8etapA@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: pci-common: fix wrong return value check
 on phd_id
To:     Daniel Walker <danielwa@cisco.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-kernel@external.cisco.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Mauro Rodrigues <maurosr@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [...]
> What your doing is changing the phb_id to some transformation of "reg" for
> all platforms except which have "ibm,opal-phbid". This is what we observe.
> This is a radical altering of the prior phb_id selection before your patch.
>
> The question is, was that your intent ? We are expecting these numbers
> aren't getting altered in this way, this is why we have the patch. Your
> patch description appears to suggest you want this type of selection for
> "... pSeries and PowerNV cases)." , so I am assuming you did this by
> mistake. Also I don't see a reason to make this change for all platforms.

It was the intent - whenever we have device-tree information, the idea is to
use it to have more consistent numbering across reboots and PCI hotplugs.
The reason to change that originally is hotplugging a PCI device added
the device with a different PHB/Domain value, and network predictable naming
messed-up interfaces' names, leading to a machine without networking.


> [...]
>
> We have already done this, that is how we determined your patch was changing
> the domain values. There isn't much to tell w.r.t this issue on our side, we
> are expecting the domain numbers are set a specific way and they aren't
> getting set that way. The drivers which are looking for PCI devices are not
> in kernel space, and the PCI domain values are getting taken from userspace.
>

Oh okay, I imagined it was some crazy userspace-based PCI domain scheme
that led you to report the issue - confirmed heheh
So, you expect the old behavior right? Incremental PHB numbering.
I think we could have a kernel config option to allow that, this way
you could rebuild your kernel with that option and keep the old behavior.

This idea needs to be validated by the maintainers, or perhaps they could
propose another way to keep the old behavior to interested parties.

[Looping linux-pci too - original thread at:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/174760.html]
