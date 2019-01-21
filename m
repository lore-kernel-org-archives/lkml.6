Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9746C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7A120870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDluzDTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfAUPi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:38:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40380 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfAUPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:38:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so17889502lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iw55+vvuPeCgW86/mrVescTowc/XCVMNw57ySDbLNwM=;
        b=pDluzDTsFqtGfOuYs2erpgiTvMl788DDnCQBjHOJJzFGApHLh5mSN+U3mut2FK5R7o
         tXzOVRxNhldz1CCalMbFJ903YwFC4PN8DI4d10uN5V81d3zXG0/SbDGrJnzSSGI4J/lg
         PdFXfdomZv6LZmvFyyrdRTqtto2/nKF8JeE14w1VvV8NSuGO5/z6Js2T7Czvh7AS49qs
         CtJlSwZY13FeZevtRNnoJWJuJFUUpF5dZTmVpjbF9V9GRhTcuT88nMGz5gpTRO/4Oqe7
         qMk89DTtngBRnxUHrFfNBcW8MZypW5b4bKL3n+8nKxC8O8fM5yDiN/Oj9JkBuOg7rIiE
         lbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iw55+vvuPeCgW86/mrVescTowc/XCVMNw57ySDbLNwM=;
        b=al+3mLrPW77Xys4NN4xfJ5uOrcHKi9Tu8/O7zSCU7khxrjUqzqCmbwzp09hjqEXJ+u
         q3BiA6OKPPyQl33InOh/Xj8x9Nf5T4IPWjOMPU38Q1g7xRZXbl414OSRTZw6DdnaoMjW
         V/yIppb/r1TCDwj6tby6HJW29aJrPC4PiBToWNCv4Z5/Ma6MfVD3pNY9w5XR4/6CT7iV
         yb4UjSIoFIBkF3nHIpbUae6jEcthmFQi+PH4fex2Ymh4mV85Q7V3bJxSupxFeiEIe8xJ
         l5Ynh5HDFTZtiI8WQegDyfGatY4YQ7YUurXukcv/BFTuAbZCz6LMFl+7EToAsHDyEPDB
         Hrbg==
X-Gm-Message-State: AJcUukez3xsFTbSEvlt9rnYn9dHbg61HezFnXuiV4P0mpIvHPNCBm7KE
        9qnenvlHYDNM3/ExNN7u2xMEK8bKeyg7E1/ozVjojkli
X-Google-Smtp-Source: ALg8bN6vjvgBK/+v9ll+sRn+G8B/Y4uhqtyTxl6Ier5SF8B88KbFk0gF80JfFGOFGwM4MmLW4velA8mWt+67ekg3V/s=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr18238504lji.93.1548085103216;
 Mon, 21 Jan 2019 07:38:23 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZs98K62OE6er2ysBSJ2MQC=1xWapCw_tw458Z_K4BjMDA@mail.gmail.com>
 <20190121144657.GA27366@kroah.com> <CAA85sZum33M+1NRcfWkua+66CBTxM8ope+hoGASv6mR8NrwPTg@mail.gmail.com>
 <20190121151020.GB4717@kroah.com>
In-Reply-To: <20190121151020.GB4717@kroah.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 21 Jan 2019 16:38:11 +0100
Message-ID: <CAA85sZtizu_uvHhevg_B1Ok7K=O_J=agAmG5ic7M=1by5BCurw@mail.gmail.com>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
To:     David Miller <davem@davemloft.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

could we have your blessing to add the following patch to -stable for 4.20.4:
commit 41d1c8839e5f8cb781cc635f12791decee8271b7
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Jan 8 18:45:05 2019 +0100

    net: clear skb->tstamp in bridge forwarding path

    Matteo reported forwarding issues inside the linux bridge,
    if the enslaved interfaces use the fq qdisc.

    Similar to commit 8203e2d844d3 ("net: clear skb->tstamp in
    forwarding paths"), we need to clear the tstamp field in
    the bridge forwarding path.

    Fixes: 80b14dee2bea ("net: Add a new socket option for a future
transmit time.")
    Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
    Reported-and-tested-by: Matteo Croce <mcroce@redhat.com>
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    Acked-by: Roopa Prabhu <roopa@cumulusnetworks.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>
---

Also, do you keep your -stable queue somewhere where I can see it?
It feels like I'm stepping on toes, adding overhead and such, which is
not what i want...

On Mon, Jan 21, 2019 at 4:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jan 21, 2019 at 03:56:24PM +0100, Ian Kumlien wrote:
> > On Mon, Jan 21, 2019 at 3:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Jan 21, 2019 at 03:44:24PM +0100, Ian Kumlien wrote:
> > > > Hi,
> > > >
> > > > IMHO you are missing: 41d1c8839e5f8cb781cc635f12791decee8271b7
> > > >
> > > > Which should be marked for stable, it fixes:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=202235
> > >
> > > The networking maintainer handles sending those patches to me.  It
> > > wasn't part of the last set of patches, so perhaps it will be in the
> > > next one?
> >
> > I thought it would be in the next one after it's in the rc but perhaps not...
> >
> > I suspected that it could have been a slip up, since:
> > https://marc.info/?l=linux-netdev&m=154726015506044&w=2
> >
> > And i know that there are people waiting for it ;)
>
> Well, ask David and if he says I can queue it up now, I'll be glad to do
> so.
>
> thanks,
>
> greg k-h
