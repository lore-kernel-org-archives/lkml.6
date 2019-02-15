Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9BFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E859621927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="Dxj70XRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfBORmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:42:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36811 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfBORmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:42:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id o59so8651587edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oyg5e2Fqe1lBmVKvCNgWX1W0blb8z1UMq/gMtaiSG9Q=;
        b=Dxj70XRSUia5ZB207tNngozyJsJ/uQtwxbYH5iwakpMPMlU3b/TAXPj30YYW8twjAM
         +Y1qYdKMCntntkh2WYZyFIbpb3awCHXo2pyUb0ZaxDGWKDG4GcrRREFG7EDnfjVXQoYF
         1R83TlOaleFvVmr3J3Gk6gqIVXix5NvutlFLYY8uRPtNSiLtyIeQ7gh0Cs46ox6PDvgn
         d0I6np9vOD6uNgrEHFKkcRS+YPjIg2bhtXFeq3I6mNz9iEawTjI3By9xMpLOIejydl8/
         1/czNFuSF7kJOpuIZFoWoY7gRqk1XFz+h4ISwyKvHsrWD3i2FULEz+N7sxVhlcZ53KeM
         2fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oyg5e2Fqe1lBmVKvCNgWX1W0blb8z1UMq/gMtaiSG9Q=;
        b=LbfsLFfphSwv+9La/MvreOAC+RwXD83U/iU2b+qpgxSIJJ90hoPMXkVFAGmk/CF4F1
         EWaPNorrIVYy3E4heWZ1pCn67ElcYQsgOjtNSuDBxD4gWHNpvQXJILPDak5RnqPYTaAX
         xNRdG7jSgVxIkJ1tKHzrM5/vaKnJhy3oM93df8nrHzo0ip37K+KIpj/n6xwyW8yY3pmj
         /wOMT0T4oHcycTarP28xLbITFN5zSulyRG2dj64Fr3B/iStYt9xtwEXsjnfoH5SP5WNc
         MLLE+UkjLS5/M9Q8YMcFi911nBJFc3ZkarlDUk9/IGah8GmicKH5UnPH5gKi3D0w6hHN
         xHLg==
X-Gm-Message-State: AHQUAubN3et4qOVFpR8uTbuvH6jCus3ItuGRqzG9nnpEAQqkcMiVZkfD
        8/ljCNyCzyQ0FPXIJmMrY7r0+5RlYFyZoQvSbaE3Mw==
X-Google-Smtp-Source: AHgI3IZ5d5gDm2SHrq+UpsReMh2u651epBQdOf5UeK0JoDbP2qQiE8ih6KpRaaA6QBXX7py4BDd6K6IwRgvNcZFsHUw=
X-Received: by 2002:a50:a7e6:: with SMTP id i93mr8353504edc.193.1550252541631;
 Fri, 15 Feb 2019 09:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20190215170342.1b704e7c@canb.auug.org.au> <51ee23dd-b852-db61-ef21-ff5819488386@infradead.org>
In-Reply-To: <51ee23dd-b852-db61-ef21-ff5819488386@infradead.org>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 15 Feb 2019 09:42:10 -0800
Message-ID: <CAFTs51WKL7u+H_4_S1au_dGw20avosJt4n63pkhUXr7wV4aC6A@mail.gmail.com>
Subject: Re: linux-next: Tree for Feb 15 (net/core/lwt_bpf.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/14/19 10:03 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190214:
> >
>
> on x86_64:
>
> ld: net/core/lwt_bpf.o: in function `bpf_lwt_xmit_reroute':
> lwt_bpf.c:(.text+0x11e): undefined reference to `ip_route_output_flow'
> ld: net/core/lwt_bpf.o: in function `bpf_input':
> lwt_bpf.c:(.text+0x9d3): undefined reference to `ip_route_input_noref'

A fix suggested here: https://patchwork.ozlabs.org/patch/1043098/

>
>
> Full randconfig file is attached.
>
> --
> ~Randy
