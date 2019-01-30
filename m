Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0AAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEABB20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OukjHMr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfA3Oan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:30:43 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40333 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3Oam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:30:42 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so10719905ita.5;
        Wed, 30 Jan 2019 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3heOv7cOx5PJDXp2Uridq5nLN8cpkYDuAE2O0EFdrdE=;
        b=OukjHMr71vp/RiG03eXX0VHzQot5L2OqJmMtCC9vCdB1byLzWEIA8DCE1r3VR4s2DH
         vcozeYfGWMaJT1N7ytrTiYx+YoP+QEBSYll3UrfKPFy8v2ECD1XpmSSoIco/X8MlhfRO
         nyQ8rzT4isSqh4KoW7lFrCIR0Jzzgaqs2mvCDxevGEVFAXGDv92MZk3IQoYf3uk4JwBm
         ispLtSJkKmoIqOUMFn5MlHIVv0ySt/Qc3ZNvDm6E88Qbc6vBM+rAtYt1m7R2iaR2LjhN
         42yFeAC9xKx7YK18UpuCcws5lfN2Bvsntn0xnF3z3gS4EfDXr/BMjH/UgWJnz4wKpac4
         MrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3heOv7cOx5PJDXp2Uridq5nLN8cpkYDuAE2O0EFdrdE=;
        b=nMZrwFeiPR0L5csVCl33d0904iGRV+0/jT/6Ppm4KDymkna0VOjUWtj/jSW2DPdWEN
         gD84s2N/oRuffrOg1AAfUP1HpFnDHHJZ58b6zecTB4IKTHDpOK0kHC2ROY9XfqxkbPcJ
         8O1pNve3LH0AWAL4hrRi9rQzlv92pLWPSgXhuF+kdw4B0I0vqUWuSGIGjiyb3k6SM5+h
         wh14fpSyhibD7DEo6TOkb+bwipyRyPP+mnd5YdpKI5t7hfQRxAupBcPKsDVsjs/PuLIj
         3dQzBEarFgTq4qNZGIBlMOsDwPoWesdhx4M1vhGv4lVcq9Hu+7PY42XbqTzn2Mun0GwO
         8gyA==
X-Gm-Message-State: AJcUukcQ+CWSjW0kH3qPNq1hvJ+WljKlYI76N6uA7ePzg+A0FYCqF2c+
        +C00mJ3Ple+/Xx2sYftz1voV+LO1aHrO/LJBW7U=
X-Google-Smtp-Source: AHgI3IZRaWcYL7fhyct26dXz5op/bVSqET343pPGfEFL48mHkTm1+6bGwGCpIC0afSxsd35uxqBQxR9BZN6Q7VVkbKk=
X-Received: by 2002:a24:648f:: with SMTP id t137mr14574858itc.176.1548858641182;
 Wed, 30 Jan 2019 06:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110160114.GA5641@hp-pavilion-15-notebook-pc-brajeswar> <20190110141930-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190110141930-mutt-send-email-mst@kernel.org>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 30 Jan 2019 20:00:27 +0530
Message-ID: <CAFqtX7=EvqX+pyj3izFotWbhPW1ObNcma_d9ir_83_wC-oiK3A@mail.gmail.com>
Subject: Re: [PATCH] include/linux: Remove duplicate header
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Ariel.Elior@cavium.com, davem@davemloft.net,
        jasowang@redhat.com, john fastabend <john.fastabend@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>, dhowells@redhat.com,
        ebiederm@xmission.com, james.morris@microsoft.com,
        Paul Moore <paul@paul-moore.com>, zohar@linux.vnet.ibm.com,
        mjg59@google.com, viro@zeniv.linux.org.uk,
        Richard Haines <richard_c_haines@btinternet.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 10, 2019 at 09:31:14PM +0530, Brajeswar Ghosh wrote:
> > Remove duplicate headers which are included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> >  include/linux/perf_event.h | 1 -
> >  include/linux/ptr_ring.h   | 1 -
> >  include/linux/qed/qed_if.h | 1 -
> >  include/linux/security.h   | 1 -
> >  4 files changed, 4 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 53c500f0ca79..8d7a2b65514b 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
> >  #include <linux/atomic.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/perf_regs.h>
> > -#include <linux/workqueue.h>
> >  #include <linux/cgroup.h>
> >  #include <asm/local.h>
> >
> > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > index 6894976b54e3..627b7aa067e0 100644
> > --- a/include/linux/ptr_ring.h
> > +++ b/include/linux/ptr_ring.h
> > @@ -26,7 +26,6 @@
> >  #include <linux/cache.h>
> >  #include <linux/types.h>
> >  #include <linux/compiler.h>
> > -#include <linux/cache.h>
> >  #include <linux/slab.h>
> >  #include <asm/errno.h>
> >  #endif
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Pls merge through the trivial tree or similar.

If no further comment, can we get this patch in queue for 5.1 ?

>
>
> > diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
> > index a47321a0d572..9ebdb60f605a 100644
> > --- a/include/linux/qed/qed_if.h
> > +++ b/include/linux/qed/qed_if.h
> > @@ -38,7 +38,6 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/pci.h>
> >  #include <linux/skbuff.h>
> > -#include <linux/types.h>
> >  #include <asm/byteorder.h>
> >  #include <linux/io.h>
> >  #include <linux/compiler.h>
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index ac0ef467d25e..2915ea6a5b77 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -30,7 +30,6 @@
> >  #include <linux/err.h>
> >  #include <linux/string.h>
> >  #include <linux/mm.h>
> > -#include <linux/fs.h>
> >
> >  struct linux_binprm;
> >  struct cred;
> > --
> > 2.17.1
