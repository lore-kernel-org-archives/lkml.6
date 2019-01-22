Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0888C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A570C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GBbaoHmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfAVTSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:18:06 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:37431 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVTSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:18:05 -0500
Received: by mail-qt1-f179.google.com with SMTP id t33so28905080qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fep/K3iSFnLcaJuXUv70p6kCF7GZTWyr2UGqash8GrQ=;
        b=GBbaoHmBQ8xHSSRa+8cHUZP03HUbDKMx+l8NzEBCmtW8kjkNrDC58nZllPPFLtMb6e
         +WuvKIHTcUbUWC51BOYnqH8J0/+Unpzo5QGqHkkp3dUKOKfbfCdtyO5JKQOzyFvePc6I
         RnP4FvekKrbd+p4s7mNYGNhJzP4Og8bIe5Gc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fep/K3iSFnLcaJuXUv70p6kCF7GZTWyr2UGqash8GrQ=;
        b=GRb31qwuDRqDOTaOJnFnmqIL0yOc+tItOmCgHYOKV3/YwoBaNe2wuYRWEmHwR+mHzY
         tue6cYOnxHt4BBdnimdlhwa6IIEp4urZE1g1HC2fCsW0Qcdv386Lf84THcgtIWU6cL7t
         1yYDn7cpoF29nWjpkprjeYqnPRyzmyPhGtx55NWGLNCrnV1OrkmG3m4QBoJfay4hRoh5
         UbkC9JXKDD8ejWg+7sqbxjWZNMGGjvwpR529QJ+ShY2IiRmDPzPVQzD+w+X9iu0f85RN
         iGyPPoyN/n3UEPpMemwp3AyiYkiBo54gG5EgNYi7/f7nDEsvkOVwbDsEUh3wyYz2/3Ep
         T0ZA==
X-Gm-Message-State: AJcUukevp7ATwDiaGK72FqolcvfSfw0N+AgGhX1A6phs2AEdDaeDrcEE
        WPPnrOxs2gdXJu7tK0LVZ2TsbYxh7V80KaNuI9k36Q==
X-Google-Smtp-Source: ALg8bN6z3Oj142xUNuQ6gEVJNhLVKgGVd9MLilJlvHXy9V+Wu32KxrxsgVPoH7Qkr2T84JF+yW3CZwQCfNVAymqWezY=
X-Received: by 2002:ac8:16d8:: with SMTP id y24mr33027582qtk.253.1548184684223;
 Tue, 22 Jan 2019 11:18:04 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi3oWnOWL8sDfjWX7YC6M5ASuhCZNz8tsCGgjvO5yJJRLg@mail.gmail.com>
 <20190116154901.GA3207@kroah.com>
In-Reply-To: <20190116154901.GA3207@kroah.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 22 Jan 2019 11:17:53 -0800
Message-ID: <CABWYdi3aN=7UCREjStzEaQdufb0Qs=wpbm=_ghP0cZe4C7GVrA@mail.gmail.com>
Subject: Re: ipmi_msghandler crashes in 4.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <minyard@acm.org>,
        Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to try this, but crashes are really infrequent and our
stack is slightly different:

* We have RIP = __srcu_read_unlock on x86_64
* Patch mentions PC = __srcu_read_lock on aarch64


On Wed, Jan 16, 2019 at 7:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 15, 2019 at 10:36:42AM -0800, Ivan Babrou wrote:
> > Hey,
> >
> > We've upgraded some machines from 4.14 to 4.19 and started seeing rare
> > crashes like these:
>
> <snip>
>
> Does the fix posted here:
>         https://lore.kernel.org/lkml/1547616802-31868-1-git-send-email-yangyingliang@huawei.com/
>
> help resolve this?
>
> thanks,
>
> greg k-h
