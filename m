Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6724C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E720883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ignWh0Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfAIEFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:05:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45284 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIEFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:05:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so3678186qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 20:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4epG4gLi6n+9qJM+MiAW7epxzSzyrNi0F4+P6SFsXQ=;
        b=ignWh0Or2ecE59DXOOUy3SHgNZKrRDwCPWc2aSdPKX8XuJVtagVQ/hTpqSyAirPat/
         456R8RPtvZDmFvk2yvP6bSigDciBq4cJmQgej87FLTbw5ZM6ytW75YSvZAiKM48Bfewz
         UUNsSZ3TpFN27Xt25kGWvhbFrurQrg16lNgxKDeZ8LOR6BSZc6g/v89TXVA8VDzUEe/o
         RVYQAsTsqFSRctN5OtfrDgfO+MF+lUGUJDQMMOSst6iDWuaewAegbjOb4m5ArvCwS6A0
         mH3GmJr6Tm8NCcnd6tHTTfUjkTdgZhsGD4FDNgW778ddAfxJRS7ufOjwUhLDQeVOcu0L
         mpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4epG4gLi6n+9qJM+MiAW7epxzSzyrNi0F4+P6SFsXQ=;
        b=IdvGAnTvhbI948RhrIl1fInlkPVtGfMU+s4GImWebLpJAcuiMxL3fX0A+f/bz9zHl8
         RfIbJmH57Tq3Vd+2tmnFxk9ryUT/W/qOCA5K2wqqqrHzTvmtCQSmWQAEndSkgZb+xCE+
         Case4dev4ktE8aFrAJ9JdACF1xwlhSIW1ag4dLdRHBCLJnqm+LmgRs2mmcvMEhQ5fYdo
         oRpeLgtM0G8Dd54KStz3DrB7eDgljftwD9LY+CC4HEXR1tbK7BkZEbJBkdRZORaUXtC1
         4g1QuTGYoSmQ9q8WCGnBe23VIi8dSO4LOxJzMV0TCVQJXo2SGIVyhYMR0oDBhITy+3Dg
         WxoQ==
X-Gm-Message-State: AJcUukf/Pgn33MlteyB5K3IeN/TPsL5Og8AkZA4e3fv6MCbyugG47l66
        GXzcIDoldaD/zSy95F21ixJyctykDI2b1+fWcQbQ/w==
X-Google-Smtp-Source: ALg8bN6VecMsA6CS/V5ogjKxR3tkHFfeAD4jc6NeNglY/Pxw3t1vJvCc6+VWjJfVntwcqHOPcxmZZznTa6DKI36Clng=
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr3988780qkc.186.1547006699069;
 Tue, 08 Jan 2019 20:04:59 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hpCKoLxp-0cgxw9TqPGBSzY7RhrnFZ0jGAQ11HbOZkZ3w@mail.gmail.com>
 <20190107095229.uvfuxpglreibxlo4@mbp>
In-Reply-To: <20190107095229.uvfuxpglreibxlo4@mbp>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 8 Jan 2019 22:04:47 -0600
Message-ID: <CALaQ_hq-Ba_y1R2xozdJu2ywAitFQd6VsWB2g+FWqm3um=TbJw@mail.gmail.com>
Subject: Re: kmemleak: Cannot allocate a kmemleak_object structure - Kernel 4.19.13
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not all that sure it was memory related based on my Sun, 6 Jan
2019 13:17:04 -0600 post.
You'll see the log entries at 3AM, and based on earlier entries I
likely went to sleep around 1AM which would mean any memory intense
applications (eg. virtual machine) would've been closed out.
I have 8GB RAM in my desktop.


On Mon, Jan 7, 2019 at 3:52 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Nathan,
>
> On Tue, Jan 01, 2019 at 01:17:06PM -0600, Nathan Royce wrote:
> > I had a leak somewhere and I was directed to look into SUnreclaim
> > which was 5.5 GB after an uptime of a little over 1 month on an 8 GB
> > system. kmalloc-2048 was a problem.
> > I just had enough and needed to find out the cause for my lagging system.
> >
> > I finally upgraded from 4.18.16 to 4.19.13 and enabled kmemleak to
> > hunt for the culprit. I don't think a day had elapsed before kmemleak
> > crashed and disabled itself.
>
> Under memory pressure, kmemleak may fail to allocate memory. See this
> patch for an attempt to slightly improve things but it's not a proper
> solution:
>
> http://lkml.kernel.org/r/20190102180619.12392-1-cai@lca.pw
>
> --
> Catalin
