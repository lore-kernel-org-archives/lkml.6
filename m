Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A6C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAFF2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBJawRXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAYUJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:09:48 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41547 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfAYUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:09:44 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so6395502vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7B0gQIQWlF8Bax9rKwXH7utiM4ileYlEu7GxLV2X8g=;
        b=iBJawRXa0hgodJOVFYTLGQNpOT+YyvP+13IEVK8JUVbSo6sxZDhIEIrcs/2j52jUPU
         oiP+VA1JgJaeFVoqoU9hlTC4jrtJu0sl8ZvmdIPA3ePkJSMZVv+DdUkAxvFr10hbgkTt
         SrGr2aAhoGx2NR+l9u3lOKOBT2mnEExGwW6woy0iCD1pqKE7zrbWiG2PJmgvJ4n+jxqG
         gcbo3TeoOlBe4AMyVAwCEn48huMrmGs8k7cbOUxLkEvv9YO5QD4Xcqx6ZPh+JcEtKNyu
         SwRApk1ubTYzXEurYzo23yHlyOeSQbwEN4G451+Fhneh8vqCaW2XAev9S8FfsxfkbYzt
         1/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7B0gQIQWlF8Bax9rKwXH7utiM4ileYlEu7GxLV2X8g=;
        b=M6CKrDzZmBHoSSwRB+Jx9IQNwcdEivGGFu3KBFVkg6GVdTilZNDwdjlZ4bz6t4VSje
         lBjA+BmS3cpNPs2TPsusWEvywZ/5vtgAHq1g/9o7GH1iD1IXVCKxvrJaiOcjkIOJvroX
         wWlRmwqmNQacTTYxO888SBEc1L44KKKFSj+dgoZeSf8LNtq+byO4YQ4cI5ouGKg+mKxI
         uSqv65ZjJ6SyDRy8NOFGAZHAW1KvhwMiLFDP8z8mCDu0eEUgqTdzx5p0fz4qjNNeo6F+
         Ur3mwb8qSSmo7STfabBey/Uk1jZnIbbGld746cgEPM13ULOwhmLLZ4qJqtfEuxblC1GY
         Q37w==
X-Gm-Message-State: AJcUuke82bmNde2runHN23qHCk1OX2bdg1VCxzftxG9TXs5pHDQHWZBA
        M2u1HZvJdSM3FTFCaDc0zydP4StLLQb/O1pBth8=
X-Google-Smtp-Source: ALg8bN4fpCqXFPa7jMtz+VutYtVhcf2zn68x219J0OqDH0M4cZ/wg04sCF1e+9nRIQpu7U0CUEPRL4WSNp6LLWU21Yc=
X-Received: by 2002:a67:741:: with SMTP id 62mr4775247vsh.228.1548446983155;
 Fri, 25 Jan 2019 12:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-2-oded.gabbay@gmail.com>
 <20190123122804.GB2194@rapoport-lnx> <20190123124004.GA19703@kroah.com> <20190123125502.GF4747@rapoport-lnx>
In-Reply-To: <20190123125502.GF4747@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 25 Jan 2019 22:09:17 +0200
Message-ID: <CAFCwf13JJK8BDE6DChxiMT9hOV99MBPffU0EK=aM2WrW3FxEPA@mail.gmail.com>
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:55 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Jan 23, 2019 at 01:40:04PM +0100, Greg KH wrote:
> > On Wed, Jan 23, 2019 at 02:28:05PM +0200, Mike Rapoport wrote:
> > > On Wed, Jan 23, 2019 at 02:00:43AM +0200, Oded Gabbay wrote:
> > > > +/**
> > > > + * hl_device_release - release function for habanalabs device
> > > > + *
> > > > + * @inode: pointer to inode structure
> > > > + * @filp: pointer to file structure
> > > > + *
> > > > + * Called when process closes an habanalabs device
> > > > + */
> > >
> > > It's nice to see docs coming along with the codei
> > > I have some comments for the formatting.
> > >
> > > kernel-doc won't be happy about missing return value descriptions, and
> > > although they are sometimes redundant or too obvious their absence makes
> > > 'make V=1 htmldocs' really noisy.
> > >
> > > In general, it would be nice if you could link hanabnalabs driver
> > > kernel-doc somewhere in Documentation/ run 'make V=1 htmldocs'.
> > >
> > > > +static int hl_device_release(struct inode *inode, struct file *filp)
> >
> > There's no need for kerneldoc comments for static functions, as no one
> > can call them and they are not part of any api.
> >
> > So what would be better here is to just drop the /** line and use /*
>
> Maybe it'd make sense to use /* for most of the comments in this driver as
> there are kernel-doc formatting issues in non-static functions as well, I
> was just too lazy to go over all of them.
>
Hi Mike,
That's what I'm going to do for v2, except for the comments in
habanalabs.h, which we made sure are written according to kernel-doc.
I promise that we will go over the entire code and make everything
kernel-doc compatible (I'm opening a jira ticket now :) ) but it may
take a couple of weeks or more.

In any case, I fixed all of your other comments for this patch.
Thanks,
Oded

> > thanks,
> >
> > greg k-h
> >
>
> --
> Sincerely yours,
> Mike.
>
