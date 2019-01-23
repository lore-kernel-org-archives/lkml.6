Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEABC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEE92184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSYgRM1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAWWCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:02:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37670 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAWWCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:02:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so4285035qtt.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Sxsy0LQFleHCbFvFAYk4SrllxaKgydfncMB4UmQ72M=;
        b=TSYgRM1tC4GWtlo5rNMDqhn53qOVmAax5bv8TGclxWtMcir75meUoeLe5fE4jGTpXU
         O4tndn9bVdek+xS4g+F3+C+CsBJ/dzoxMmHz79TpRoiTDP5Nzs2G+otyBjJvxxlYZeEx
         urQ+qsNd+VgoyaYLm3UgPD+tLo3+dFJKd0wG1YQZ6WM0XsIEViSOiDEbk25ne5faaxcw
         D3qBF77nTnltKM9zNyGrw4bw2y86rs6n9iPn+Is4YNpdlBDOsOLN7KUtQww6/MZd1FIc
         NUfi7v205zMscbw6miCPKKWONgoyZDD59CfqPtkBvj3xQTbIsKndRqj68X2EyOJOTURa
         GJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Sxsy0LQFleHCbFvFAYk4SrllxaKgydfncMB4UmQ72M=;
        b=d/HqtGxzJh7xc7SKmncGQXoIpGLCRrCv75TEohElYJXhI93SVm28RZfgV3I6A074wn
         tD6c/1Ipj7nWmasJqUmdQeGr2njzT+jG9U1w5oAa2Vsjp3QnhK1hNfm6YYSIFhG1C7wu
         gTv78FHM4MYmLujN3uqYyQEjhLZyYGeBepMahtr9ZrvFz/iGe8v0SX6K4yg6XVH45gvO
         x1XqotIC6e8O3xE83hODjF6WARKfYKKeS3/TSDhAc0YZsoEs9f7rrJsnypyYWXi2cX15
         gEziS9fxk5HPgrNeyFQL4BEzXsSs6So5L9SfuFXlDSTkgQ9Fm2Mu4MhPbO7VylsViR1S
         tcjQ==
X-Gm-Message-State: AJcUukdzQCLPWf3oGdcxaetQNSTaMLVFm3jzy/qa0X6JPuSYZh39EbKe
        oG3j5U78hRzOedhqDjoi7lp0fANGnR6mNX9wMO8=
X-Google-Smtp-Source: ALg8bN4a8MPowI8L5GoYnWUcYmuOqCHj28TWdKj56MQXxC/xE8sRP+EFtrGZKXZejLd7ODNO6KPXUjyfB2pur6DGA2g=
X-Received: by 2002:ac8:892:: with SMTP id v18mr4174140qth.297.1548280936447;
 Wed, 23 Jan 2019 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
In-Reply-To: <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 24 Jan 2019 08:02:04 +1000
Message-ID: <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Daniel as well.

Dave.

On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wrote:
>
> On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > Hello,
> >
> > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > Habana Labs since its inception two and a half years ago.
>
> Hey Oded,
>
> So this creates a driver with a userspace facing API via ioctls.
> Although this isn't a "GPU" driver we have a rule in the graphics
> drivers are for accelerators that we don't merge userspace API with an
> appropriate userspace user.
>
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
>
> I see nothing in these accelerator drivers that make me think we
> should be treating them different.
>
> Having large closed userspaces that we have no insight into means we
> get suboptimal locked for ever uAPIs. If someone in the future creates
> an open source userspace, we will end up in a place where they get
> suboptimal behaviour because they are locked into a uAPI that we can't
> change.
>
> Dave.
