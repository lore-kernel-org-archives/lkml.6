Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E9ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DC62145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXZx6aQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DC62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJRAr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:47:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42765 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJRAr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:47:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id g15-v6so30482644wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qD2o9cmZz1jmzArJMVT5xubFcFRB++jYEz/m2rEDk+4=;
        b=qXZx6aQ4HRSAzKelDC/jAbJRiaEGkxp9kH3ucfusUmnpa606agug64k1kzVQz2Ifvw
         Wjbr5tpiLtfKSHgDZrMgzUDTKHZ+sGICg6UlqVdR2odjtCUEEaU/kmDDkICgwoACaW8r
         Ryl8JBykXc5qnAjQEh3G0gssyWFk2+pN4DcEerExQUrJHbELIGRq5FyOXb0mKaB26kOi
         vEiPyC404BDXIroCSGnIJGsOfoOuW6PB6Nd2tbCqZDaqgGDW081QU4dYwijvGjLiON33
         1UQGSiOHcCK2tCyxxlogJKG1pfZSUwD+07e5+li9Uo3s3+sinHYb76eIRqQj2BZraMkc
         Pemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qD2o9cmZz1jmzArJMVT5xubFcFRB++jYEz/m2rEDk+4=;
        b=KqQMsvkM/4vXe25ZeOBcXK2y3KpDJ5kf8EE8YjIrWo0EotvyaFfCwMTXsxaMzegOyX
         0i2Iffm78UXN77yTwUfa44XaneDVIBU2KGzwEcZN+vlQ4jcCftrMJly6WFencRcp4150
         RktlVCelsWME7a79H7iLBFYeLWQCcYp+z2+53aCvF6UwK/Dz2LbdjwMF4ZYGE9QQ3Wwm
         2TzDnxkpV9WBP3BAfx3GS//12hM0lyJQm07MYI/dYXh4N3kQYctk3k8em7YXIvAdO25z
         e73hTsdy+hpvr0PFSGvxUR+R5suN9YORA3vshsZJbC1tjHZaziRSXdAwoNw6zLn+8EJD
         Ssbg==
X-Gm-Message-State: ABuFfogSo1LP+cVcXPUd2O6lW77Q1Tok7gpxtLPAHc6c4A4sDU/yDgk9
        7Lr+ol6TMKGJMGv2rvg4fQAt0z0vfW5qWiz5AJc=
X-Google-Smtp-Source: ACcGV63Y0umZ5GViJ+cbd+LraGQkWKzL/QMWSKnN/HfRYHYC+H8UMbFmelhx88xwh6rZ7wsnL+fi2g5fub1SSyNYoxo=
X-Received: by 2002:adf:fd83:: with SMTP id d3-v6mr24198586wrr.25.1539795084337;
 Wed, 17 Oct 2018 09:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de> <20181017101831.b5kvh5jw3sqqhbat@mwanda>
 <87bm7stwhv.fsf@anholt.net>
In-Reply-To: <87bm7stwhv.fsf@anholt.net>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Wed, 17 Oct 2018 17:51:11 +0100
Message-ID: <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     eric@anholt.net
Cc:     dan.carpenter@oracle.com, stefan.wahren@i2se.com,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tuomas.tynkkynen@iki.fi,
        linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> > Drop various pieces of dead code from here and there to get rid of
> >> > the remaining users of VCHI_CONNECTION_T. After that we get to drop
> >> > entire header files worth of unused code.
> >> >
> >> > I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
> >> > snd-bcm2835 can still play analog audio just fine.
> >> >
> >>
> >> thanks and i'm fine with your patch series:
> >>
> >> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>
> >> Unfortunately this would break compilation of the downstream vchi
> >> drivers like vcsm [1]. Personally i don't want to maintain another
> >> one, because i cannot see the gain of the resulting effort.
> >>
> >> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm
> >
> >
> > I feel like everyone else already knows the answer but why don't we just
> > merge that code into staging?
>
> Dave's been working on a new VCSM service where the firmware can call
> back into Linux to allocate (instead of just having a permanent carveout
> of system memory that the firmware allocates from), and lets us make
> dma-bufs out of those buffers.  That driver makes a no-copies v4l2 media
> decode driver possible, which would then let Kodi and similar projects
> switch from downstream kernels with closed graphics to upstream kernels
> with open graphics.
>
> Given that the new VCSM service is a rewrite, it's not clear to me that
> importing the old VCSM driver is a win.  But maybe we should go raid
> https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2a and grab
> the new drivers.  Upstreaming the VCHI audio driver to staging has
> clearly been a win for it, so maybe other eyes on the new v4l2 codec
> could help Dave along in stabilizing it.

I think that makes sense as long as the firmware side changes are in
place so it can actually be used.

Peter
