Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C91C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50882146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHIGgFGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfAKJfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:35:02 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:34517 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfAKJfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:35:01 -0500
Received: by mail-yb1-f182.google.com with SMTP id w186so4700374ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MX/2rZ9Ui1xuyU6im60xpO0Kqrmer0lOdAC4uufDsDs=;
        b=aHIGgFGNs4DnhRrImTc5oEoRBdzp1iNCKHYyulmaTQLMJsdaR0lA/Q9ATLwpgYDZsm
         9MK7RYnoAYnGuSGotDeZ5r0hkk8OjcKeVcQ91kzZxGdYcUNNMNgsC/RklsXD/uxpOo4q
         Kw7cVUYR+ly+SYsW+wpv0tv6r/VW2cTAnep56divkpmC1pRc95oieNZIMyl0EjrQwBNN
         015CNb3eyxjvg3ukjE4XnjPPXDT4KIV+GK6aznAlMFefJgk6B/eF+HRnGojbD0Ne7JUX
         rFmISRCCFUf8AlDcBU4tKV3oP3Z1L+XRbCu80H605MEclby03dVsKeI+Lt2laRrqlrLp
         VE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MX/2rZ9Ui1xuyU6im60xpO0Kqrmer0lOdAC4uufDsDs=;
        b=sExe3BqM3PPk4msTuu811Tc4clud6gBuoj2VImWlYnht5bYO1UjuBKrMkADYfahVUw
         hh/2Ho5pLI/R/MMQmVLSnDyNU66NpHgDIawZZucJuwaNFSiMb0rdJPKdA5UVnOCSwIJ0
         4nPCnSzPUIdam/t2ZfGiwfyQyrgVFdOvNOr4shSN0VhPceyEFc+NRelLTNYhGV5VQng8
         Rrau/juUGO1hQ10BedKAleZ1Ltfq9HdiMbIh+NX7FrRyIcJy9CKOpZAg/W3eBi1wFI33
         R1cQ9JEwilsEk9fUxzcAcNTtCMHvXCdut0jgw/85qW4YnMtjuOWCCF7RBKkPDr/B4YOe
         Olww==
X-Gm-Message-State: AJcUukcjFTsipxMEM6f3OzX3e5jByYwCodxLtEgA5w+09nES6FUtyRpT
        wL0Pbr0NKwusM2by2BlCKtOihLA5+r7Ohq98q4GenA==
X-Google-Smtp-Source: ALg8bN6sW7b3gVF0Y0rj+bW48bqPvU/g68lZ+obdov5KWZwiJ4TCTf98PaLxhDWNL/GrUefTJs7Sq09sO6q2x5zLvBQ=
X-Received: by 2002:a25:b08b:: with SMTP id f11mr13308071ybj.236.1547199300403;
 Fri, 11 Jan 2019 01:35:00 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
 <CANn89iLkciYGn7GyKc2QitSjjTms58_GKFqjOJ=6G8wEFi=SJA@mail.gmail.com>
 <CAA85sZvciuNTc1NM1XbbBCqV-hWwjMZM+0i3vigtzmJ8CpPjHg@mail.gmail.com> <351f5da149072c8c1165f8f205ac5c852a92dff8.camel@redhat.com>
In-Reply-To: <351f5da149072c8c1165f8f205ac5c852a92dff8.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Jan 2019 01:34:49 -0800
Message-ID: <CANn89i+h4Og42OKaqJ8dsrupHkt2Lg1vPo-j92Bos98yPJzoNw@mail.gmail.com>
Subject: Re: [BUG] moving fq back to clock monotonic breaks my setup
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     ian.kumlien@gmail.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Thu, 2019-01-10 at 09:25 +0100, Ian Kumlien wrote:


> > This works, and so does: https://marc.info/?l=linux-netdev&m=154696956604748&w=2
> >
> > Pointed out by Paolo (tested both separately)
>
> Note: I cleared the tstamp in br_forward_finish() instead of
> br_dev_queue_push_xmit() because I think the latter could be called
> also in the local xmit path, via br_nf_post_routing.
>
> We must preserve the tstamp in output path, right?
>

 I was not aware of your patch, SGTM, thanks.
