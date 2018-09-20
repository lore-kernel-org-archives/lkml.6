Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B53C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAC02152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpnMUsNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAC02152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeITTqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeITTqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:46:22 -0400
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E3B2152C;
        Thu, 20 Sep 2018 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537452163;
        bh=YGjU15eXMdilnSA0dyG6zeQKwZsroa52XLiW6yptB8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cpnMUsNciyj/k/mgTurCZ4JQKWw+vxRR9agEujDbhCSTKwRjHtWEGklzsFlSNZftu
         QxKE+09DdIgYK2kJbvcQ6fyQ5aeKmsj6PM5ljI1LBGFg9HOrH2A20HOHS7+ahrZ4Pb
         vpQBXD8U4e8QRa+Oh/D0fYtpdseKCBx21PtuM1e0=
Received: by mail-qt0-f173.google.com with SMTP id o15-v6so8554032qtk.6;
        Thu, 20 Sep 2018 07:02:43 -0700 (PDT)
X-Gm-Message-State: APzg51CtAlMpdVOYgXNjyL9bm9abkQB/yboepafrTWPfXdMAqJYKR/8U
        Uqr5OvYcOQg+EVm896aNZRNkazr7ajJKbKtpFA==
X-Google-Smtp-Source: ANB0VdarLgjThbibYZRDaqc+K3uOmk2ps2dj+NDy8SwixaRBD3SqOLrnIdU/xrv0st2gBXoCv6ZSECwss/FpkPU0Kss=
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr28709351qvo.106.1537452162723;
 Thu, 20 Sep 2018 07:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180920151243.5524c6ca@canb.auug.org.au> <87d0t8jvym.fsf@concordia.ellerman.id.au>
 <20180920210711.4561abee@canb.auug.org.au> <20180920211755.1fabd744@canb.auug.org.au>
In-Reply-To: <20180920211755.1fabd744@canb.auug.org.au>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Sep 2018 07:02:30 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLRRCdOWABiTYHp7jupdiLfPRv95OSKWVB-HX=cevdQMg@mail.gmail.com>
Message-ID: <CAL_JsqLRRCdOWABiTYHp7jupdiLfPRv95OSKWVB-HX=cevdQMg@mail.gmail.com>
Subject: Re: linux-next: Tree for Sep 20
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 4:18 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Michael,
>
> On Thu, 20 Sep 2018 21:10:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 20 Sep 2018 20:37:37 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > Oodles of:
> > >
> > >   # < make -s -j 48 ARCH=arm64 O=/kisskb/build/linux-next_arm64-allnoconfig_arm64 CROSS_COMPILE=/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/aarch64-linux-  allnoconfig
> > >   # make -s -j 48 ARCH=arm64 O=/kisskb/build/linux-next_arm64-allnoconfig_arm64 CROSS_COMPILE=/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/aarch64-linux-
> > >   /bin/sh: 1: pkg-config: not found
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> > don't have it installed on my build machine either ...  do we have
> > pkg-config installed in the build images?
>
> Duh! ;-)
>
> According to the commit message we gained a kconfig dependency on
> pkg-config in 4.18.  I wonder what else depends on it.
>
> Ah:
>
> "pkg-config
> ----------
>
> The build system, as of 4.18, requires pkg-config to check for installed
> kconfig tools and to determine flags settings for use in
> 'make {g,x}config'.  Previously pkg-config was being used but not
> verified or documented."

Looks like until a recent commit, this also included nconfig and
menuconfig, but those were dropped after some complaints. I'll rework
this to make things work with pkg-config.

Rob
