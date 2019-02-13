Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906CB21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdm8uej8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392564AbfBMQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:16:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42779 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfBMQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:16:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so1334607pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2887dHta1s5cCDyuJYve8qha+fN4bbGmWnC3EO1Syg=;
        b=Qdm8uej8dAsZNAVXumy29idJXPP9w/liX12Cc5roGacI0nooOGIt5BqlleXqoI2IzV
         vtFEML6RbXflN6uhpff47gsF64nEqPedT3D8VxKgOhc+4xyEouFutlVIK6xPvqPDaqxW
         u4i/MY6/XYheQ2htCkytt5CSuU1tSZZChU5hV9XsYdo/+2xW8w9ZEkJlC4lLi9dfU9Tt
         Lf+iNPTHM5Twy7gzJ/RYMBDOxC0VJkufe/+lvI5RDDb/27q3jhMJyKqPVQ1WlaaHtjqr
         +AaQq4VhCr4tiJ8WzWVh5CcNsdDjlsogm8hUBbz/hUQrDCSrwo118mDsNWmp0N4HNMuZ
         GN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2887dHta1s5cCDyuJYve8qha+fN4bbGmWnC3EO1Syg=;
        b=DoU1izzZ6RhvEWgrglFxnO1QxWNM827QcVtg77YsGj/abdyAOcuoB3svBjrcmlBGc9
         jSQR2pqL1+2cUf/8MMjOq1sdYojPbE6NCgb8gyW9tOxwz6h36UbeAXWJJN04LSwN+hub
         bqkrfSk/YsLR40/hXRYthxKDF9K/z1VC2MVaSMghIHuT54adnc02U7s3a7BZxbKskWa+
         uw/8TIL6OZHMRPfiPnC7JnnkdgHxpomtjYyl/j+3ghR2hDC0zLY4aqPOeDReMm1dWHPe
         azKm17X9ftwYDoflFgglFEi6y0HnTECxF6+PrhKL7WWkpFT11gQYPFOekzoIym3KU0vG
         wsOQ==
X-Gm-Message-State: AHQUAubf9VvhNRdfQH/3iFZF8kwbU7p+cJV62zFNxdUOdjPiTfA0rKqU
        5Y/hlHrW8Irg6lgAOi8weQ0Iaa3eJciVkuwddHM=
X-Google-Smtp-Source: AHgI3IaPGov93Y7IYcP+HT1A5S1AyzLsYeqejiPog+RnS8g5b4L0klojYJvkq7Vflm/V/7Yd1igJsPu7XKi9JKWpkVo=
X-Received: by 2002:a63:5153:: with SMTP id r19mr1121469pgl.281.1550074591851;
 Wed, 13 Feb 2019 08:16:31 -0800 (PST)
MIME-Version: 1.0
References: <5c38b64a.1c69fb81.a0651.e342@mx.google.com> <CAFqt6zbaAmQCaKXDGR6hJEyh2PXJzQEsyO_TuHMg0jOX38_wog@mail.gmail.com>
 <CAJr6mf25=-92bt9xx1nvjnGHo-Vx0msRYCpytd-diAP2PB5b2w@mail.gmail.com>
In-Reply-To: <CAJr6mf25=-92bt9xx1nvjnGHo-Vx0msRYCpytd-diAP2PB5b2w@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 13 Feb 2019 21:46:20 +0530
Message-ID: <CAJr6mf0WynoZP2Z381raw1KL1bzYhYy5LCg0N14=ra24PGtaFA@mail.gmail.com>
Subject: Re: [PATCH] fs/coda/psdev.c: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:01 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 1:40 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Fri, Jan 11, 2019 at 8:59 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > >
> > > Remove linux/poll.h which is included more than once
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> If no further comment, can we get this patch in queue for 5.1 ?

If no further comment, can we get this patch in queue for 5.1 ?

> > > ---
> > >  fs/coda/psdev.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
> > > index c5234c2..f2bb798 100644
> > > --- a/fs/coda/psdev.c
> > > +++ b/fs/coda/psdev.c
> > > @@ -39,7 +39,6 @@
> > >  #include <linux/device.h>
> > >  #include <linux/pid_namespace.h>
> > >  #include <asm/io.h>
> > > -#include <linux/poll.h>
> > >  #include <linux/uaccess.h>
> > >
> > >  #include <linux/coda.h>
> > > --
> > > 2.7.4
> > >
