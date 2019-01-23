Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B74C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9C21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dg2Ji7il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAWIUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:20:42 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45737 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfAWIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:20:42 -0500
Received: by mail-ua1-f67.google.com with SMTP id e16so420531uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiwDoWdlaWHfrnCrvIx0Ayx4AvDU0A49O2oCR2tRVfA=;
        b=Dg2Ji7ilyVj/6V8F+EgsbqlZ9nB92qithVwRpy195XgBofnAaXYtfelJCNek2IN3Ow
         H3fR16kvs99NDls875D0DtwWn9GIJF8FhkNiX8h1Go7/53OK4dYSRUW+csZQyIwa4uEN
         bDS2ryQj2TC6CuGnACg+J+kUpSFIFqZoDzsGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiwDoWdlaWHfrnCrvIx0Ayx4AvDU0A49O2oCR2tRVfA=;
        b=OQEuPHj3U8SqdzP9hbRrNkOgSo5+SoyNE2ZOjSqXaNPQUQRIuufXMgsEayXAh1UmG1
         nsl1nbJagtT8iaszmWqMr6XMbfvSaE0sDbZR+qZxvlovbnYSl56acipB7OxCGCAxfwu5
         V/02p/QVKUSaqOpMZBGXzWFPufAi0IABquHiN3mEEtFm+TWGKhKJBuaT0pv3/p8o02tr
         StJ6NNTvM76/RDceJ4kSsQPUTu99Z77TVRFAKUB3izu8YT5fFPMyYjrF/Glwfq3MD6f9
         wgZeps3CKWvUQv4+NksL5B/8AlETjJ3kC4nT/5YvG/+DbgoOxwBQUGBb/ITMLQ8/UI0t
         QEEg==
X-Gm-Message-State: AJcUukfY8HKaOYkj2sru/c1U8Lh7erddt9p4ChnHx0qatoCoVvZT8jV8
        /bpXVmOXkcP09G+d+aycosbAABhcBZ4SiGfcFbZ/sw==
X-Google-Smtp-Source: ALg8bN5yokV3+tj7kiVi4ywCjVpvBO1hUd/1Po9h436y6DAuvp3kBzoQvMbnPCn4f3FZ20wFg3Xl9F3h3YkDKmp9GwE=
X-Received: by 2002:ab0:526:: with SMTP id 35mr479239uax.25.1548231641156;
 Wed, 23 Jan 2019 00:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-6-gregkh@linuxfoundation.org>
 <CAPDyKFo=6NCiAzwF2mvfuvfCApiegBBnJdPM1EypK8xO38h_DA@mail.gmail.com> <20190123075956.GA7597@kroah.com>
In-Reply-To: <20190123075956.GA7597@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jan 2019 09:20:05 +0100
Message-ID: <CAPDyKFpZCTG-f+ejqL6v98JCfEU6zmXpVOv+cnBgM6RkHr-Etw@mail.gmail.com>
Subject: Re: [PATCH] power: domain: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 08:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 23, 2019 at 08:44:36AM +0100, Ulf Hansson wrote:
> > On Tue, 22 Jan 2019 at 16:23, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.
> >
> > Doesn't this boils done to whether we want to care to check if memory
> > allocation failed?
>
> You should not care.

Okay.

>
> > Somewhere down the call chain from debugfs_create_dir(), we end up in
> > alloc_inode() and it looks like that can fail, no?
>
> Yes it can, right now it will return NULL, I'll go change that to return
> ENOMEM, but even then, your really do not care what happens as none of
> your other code flow should ever care about what debugfs does, or does
> not, do.

In that case, why don't we convert the debugfs_create_dir() and
friends, to becomes "void" functions? Or maybe that's your plan going
forward?

Kind regards
Uffe
