Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B2620824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAENQegQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B2620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeJYI43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:56:29 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38975 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:56:28 -0400
Received: by mail-ua1-f67.google.com with SMTP id j38so2583490uae.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfaDUHETRy8/0Wh/vIwSpCThnNBKJKuvSaiBs8l7RiU=;
        b=GAENQegQFp2kSFQw2iZotCEyEMUCoXLegLYeNCiITfL54JwUbs3Na0cLB//qv0Mf1i
         lM5r6kzrbVam8BL4KSdMyRbOLy2DZhB50KfIjdZcKr1YyRPGasSs424ISEMqXR2ujWuw
         G2xjFac0aPwDr9CPk5EzaoLQIN818oVkkusS9+A4CMXitgOom5FFgxHNjV5AKVfWPU1R
         WWEkCX6iTccupIeTdkwCPUI2sECf4sVpOMhp59mHe0kJiwqBDRvfORi7ypM37MkfSkKZ
         pSyilKN7AzQ55GNEF4ix5AKeCldPL7N90Sd7+hgz4+XP5c0PK0WgtXrTcsUs0Sn9xIHj
         yWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfaDUHETRy8/0Wh/vIwSpCThnNBKJKuvSaiBs8l7RiU=;
        b=rNbB/cW85KF08KzWefHuEPcHi8xmKZMQaUPnPtXupyvtvRr/Gm1p0EmvGUHZI6izWv
         QKr6XrpFZqbY+F8MyFrprdNy54VziyKWsH9ZbXBP8IUiwCDBQ++t8h7fV02HlJfPRGCS
         h+eaqn3Davu+dp6mFmrFaPbf9NXKTU+W1oktFhY3fLmb/5kel17oIUt2bQZNu9tjl6V1
         ckIeFQKuxOBoE5uPGWnUgLYO99mAAOHsrvdwja9titYwURcdirqvN3VjmxOr2mkDdfMR
         nWvEEhzQcourxzlBqG/QQ8n5K0bGnxPsoqfSnepqlCOLZ35LbuRUiwSNsB6DfsAgUL9f
         CNfg==
X-Gm-Message-State: AGRZ1gJJr02Pc850Yr0hIt058aoyclzCcW1LDFW5QGre3f+8kBwgkwmL
        sOqB5rXpWEX8kiQ0tBohWjM25dKvmVjHy9FOuOL3TvgQS/4=
X-Google-Smtp-Source: AJdET5dje4/Tsr8IcN70uxPSlemqSMBQstiH4E6ED+/MlKfQ707S2VKCc4fxKcdiYhSD4SFPKYjgas5Vyq453eRI9VQ=
X-Received: by 2002:a9f:3b27:: with SMTP id i39mr2313865uah.101.1540427171082;
 Wed, 24 Oct 2018 17:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com> <20181025002312.GS3109@worktop.c.hoisthospitality.com>
In-Reply-To: <20181025002312.GS3109@worktop.c.hoisthospitality.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 24 Oct 2018 17:25:59 -0700
Message-ID: <CABPqkBR1NTcpD3WxFsk4XZ6mT+jteec3kZBgBTxR5gFUL9Zffw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 5:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 24, 2018 at 12:30:52PM -0700, Stephane Eranian wrote:
> > Hi,
> >
> > On Wed, Oct 24, 2018 at 8:12 AM <kan.liang@linux.intel.com> wrote:
> > >
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > To calculate the physical address, perf needs to walk the pages tables.
> > > The related mapping may has already been removed from pages table in
> > > some cases (e.g. large PEBS). The virtual address recorded in the first
> > > PEBS records may already be unmapped before draining PEBS buffers.
> > >
> > > Add a munmap callback to notify the PMU of any unmapping, which only be
> > > invoked when the munmap is implemented.
> > >
> > The need for this new record type extends beyond physical address conversions
> > and PEBS. A long while ago, someone reported issues with symbolization related
> > to perf lacking munmap tracking. It had to do with vma merging. I think the
> > sequence of mmaps was as follows in the problematic case:
> > 1.   addr1 = mmap(8192);
> > 2.   munmap(addr1 + 4096, 4096)
> > 3.   addr2 = mmap(addr1+4096, 4096)
> >
> > If successful, that yields addr2 = addr1 + 4096 (could also get the
> > same without forcing the address).
>
> That is actually a different problem. And you're right, we never did fix
> that.
>
it is a different problem but the solution is the same: PERF_RECORD_UNMAP!
That's why I mentioned it here. To show that this is needed for more
than one reason ;-)


> I agree with you that Kan's Changelog is somewhat cryptic; it took me at
> least 3 times reading and looking at what the patches actually do to
> understand :/
