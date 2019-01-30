Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0508CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21482175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBuIzOQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfA3Chn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:37:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33865 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbfA3Chm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:37:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so10356886plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jF2YUk3CGXcsn7FfNEazANOC+yJqAca70TIA7Bif9jM=;
        b=QBuIzOQvBwrZBknSNZjXbekuNSuZOAZ7t8q4btJ4O7mGu5mU8svc37BE3n4cm4Nlfn
         7YEJ0byaoEwJv4U1Xrg5lg2gli+7hRqwkZMznVT/dEvNUp2QCYEzfnlivei0UAP1djfN
         Z+/fOgL7GAvAGt/PajU2d5AmI8kFg+ruboXzEzZGJSA1JhImBjVK7/0N65sJTm7TG/XM
         zGvjyHXn/bEkcycsrVogxtS0Sz55KqFw/kvNvxeWIHjFC9GFjGj+LiKNh8DCETYC7AT9
         UtHSbYZ6apHJQH12FpvI/U+u6MWYGkCBbiFq8Akr3/dVvQzgE5ac942jHdCjiDaA8as0
         VaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jF2YUk3CGXcsn7FfNEazANOC+yJqAca70TIA7Bif9jM=;
        b=X6S3D/QkF5oB0THeJOPTzQboX8CdTAaAZgpGhDA6RnN+fhyf+pnq1xLRBQHpCbJaA+
         5V/C0rgcQEdgQ/7Cs2oG+kTJAuLT4hHtQ6+BJQVd79UZY3LISb8NZcLPM+J011UjN3U+
         b/stIy1Q5YorITfh4zsX6YgNf+RsiqYfMRLdCrH0W5ScPNMO8UX6HTws0IozIQkLNV5A
         m1WBrTq2JNWRpiGwwdtvMpS1eBeSLYN71ZZDt6aKvxkWTexcTdSt8MZ00sbdSvWBcqMG
         jpN2HkDhP/a3dTpAXPOtaBrevAh3NfLS9Mn/a09qRlB4ovNQDjHBIIvWhVb+PnmNP/2+
         teCw==
X-Gm-Message-State: AJcUukdtdp18uJfPJ4Df0W/Ph2H4nkcPrE7NlSItglOai0nTowzMUGcX
        /DvbX13sk8rr6nMFS8zVY8gli8Aotr8Xr0F4ucU=
X-Google-Smtp-Source: ALg8bN4//XpMjLYU59grLqgxc75m7Qmb3h+PEaqFtcjMuA7ypQI7c2egmEDsQxXcNI50oFcN7oWtu4XRNClNMMsfFs8=
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr28432418plo.67.1548815862063;
 Tue, 29 Jan 2019 18:37:42 -0800 (PST)
MIME-Version: 1.0
References: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com> <CAFqt6zbyZnk3vAnRHV0JsXpVF=HxoC-WA9x434R+k36b0vtKzA@mail.gmail.com>
In-Reply-To: <CAFqt6zbyZnk3vAnRHV0JsXpVF=HxoC-WA9x434R+k36b0vtKzA@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 30 Jan 2019 08:07:30 +0530
Message-ID: <CAJr6mf0XT1rqdtT3muEuD+-+WsbSOeFZr_dawMFzsWT=VniQQQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, msuchanek@suse.de, haren@linux.vnet.ibm.com,
        Oliver <oohall@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 3:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Jan 17, 2019 at 9:40 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/printk.h which is included more than once.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?
> > ---
> >  arch/powerpc/platforms/powernv/opal.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index beed86f..802de0d 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -26,7 +26,6 @@
> >  #include <linux/memblock.h>
> >  #include <linux/kthread.h>
> >  #include <linux/freezer.h>
> > -#include <linux/printk.h>
> >  #include <linux/kmsg_dump.h>
> >  #include <linux/console.h>
> >  #include <linux/sched/debug.h>
> > --
> > 2.7.4
> >
