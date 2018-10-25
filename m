Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C003DECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132F204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcxCxqJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJYJOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:14:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43009 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:14:41 -0400
Received: by mail-vs1-f68.google.com with SMTP id k14so2517738vsm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62cdOIV1L9nQC9Ob55U8Yfb1Ux9VJAu/jXLY0usxbUo=;
        b=dcxCxqJGYloCnwWS5TycdMRZMrxAYWi67ZAXLX7rC/34GmjD8Ee7WNeqXdezQ6mD7j
         Rsc3PGxxd9aAXB1uBiQyO9uxLP4KpcISDVfxi6Q4t5/t3XtNlPEjx1nP1sP17d01+EJ3
         FHE4i0mIdwbIC8Qzh5WcR+LZN8Jyz9jj7AHTidX8X748HTMyT2oAXoXVZnGRWm2yZKvi
         zZeQTh2k8eJHqFQL9F7+0btbBgIjm8L9lF/j2dWGIu4FzrrDQzRCyeM4uVrH8hcbF5zM
         Arl69giYh0OrOEC+dy58ANy7DhVJzqCxReflSlad5Db2D2lzkLxLpS1Gn6obdTX+aJ6n
         SHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62cdOIV1L9nQC9Ob55U8Yfb1Ux9VJAu/jXLY0usxbUo=;
        b=Lgare45UDLNoNdYrBd6GI9/CHrwz/u+6/9EkQKT232H+7qeiibP19BvXbntdDWnglX
         DGb4wEokoJUVz/2nlHswpwr5c0L7DsSFkja8BIBCSRTqJ+W++8BGZ2bY+2NfR7sJNCg1
         QagHMuX80r/YFBl68kPkWKRnr9Z/5ynWUX7KatcPNP6XpueKZG0HViKUYTJzzNZTgVIj
         4LqVW5Wd/D0Ed9CHRAJ2lYHIvXXg/XwGsvZlgMfPUixn5OlYH8F0BByKvws8s6uPxlab
         aa+KcU0eKMArO8we0xgsa/pXT7k77Blp1Jacxri948A9+51JQLGyzPO1EBe17Jp9bFdA
         13Fg==
X-Gm-Message-State: AGRZ1gIILGdf5bkCqqQFgvdFR2Ih4JoeoxbPZXqnAfrN1/1muUNLBQfu
        9DUV/giKRTWWe+DTFp7yntiHZV22rt5RS4nkr66LQw==
X-Google-Smtp-Source: AJdET5cWMvhMn7rbktQwPwDqY68HKkI/MfGoCXhom2zNdeKcxN90hmzQV7LmZTa8bAj02zoqosABc0Iq1MTPYIMD0ts=
X-Received: by 2002:a67:7a49:: with SMTP id v70mr2155145vsc.165.1540428260580;
 Wed, 24 Oct 2018 17:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
 <20181025002312.GS3109@worktop.c.hoisthospitality.com> <CABPqkBR1NTcpD3WxFsk4XZ6mT+jteec3kZBgBTxR5gFUL9Zffw@mail.gmail.com>
 <20181025003444.GV3109@worktop.c.hoisthospitality.com>
In-Reply-To: <20181025003444.GV3109@worktop.c.hoisthospitality.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 24 Oct 2018 17:44:09 -0700
Message-ID: <CABPqkBQYbQV86dWCHMZX0sMspkHXSpYOB6G+c2kSOf3d4R7dNQ@mail.gmail.com>
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

On Wed, Oct 24, 2018 at 5:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 24, 2018 at 05:25:59PM -0700, Stephane Eranian wrote:
> > On Wed, Oct 24, 2018 at 5:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > That is actually a different problem. And you're right, we never did fix
> > > that.
> > >
> > it is a different problem but the solution is the same: PERF_RECORD_UNMAP!
>
> But he's not actually doing PERF_RECORD_UNMAP, nor is his perf_munmap()
> hook sufficient to actually generate those.
>
You're right. But I saw that and thought, this is going in the right
direction: tracking munmap.
I agree with you that we should use this opportunity to track unmap
for his purpose but also
the issue I raised, which needs a new record type based on the new unmap hook.

> Now I agree that if he's going to do an munmap hook, he should do it
> 'right' and at the very least allow for PERF_RECORD_UNMAP to be done,
> but ideally simply pick up and finish that patch we had back then.
Agreed.
