Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D696C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1683120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1683120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeHaT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:26:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47025 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:26:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id e23-v6so10246755lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYEDYOJ/BI1K4Ba3Jx7tD5KInnv7qmblNEitfg1drHk=;
        b=PZfo/IGKGc3CCE7kSOGOsQQ5hgk3WBGtffhD8fx5S766EiEiH6pf8idfFVvPxsmHnE
         Sqb0EFgUq3mN1w/Th4rr0W7SbNoS00lbeuSdveAcR8ObNirlWhYB7g57cWlefy2szNcG
         uR83D3Ymsb3VfpcodN1bXhPJYl6n/DDhyFTgDJA2Mh5Kt561oOy+1Ui9RHGZoSUzZDBt
         NceKGRKBoGHzR/WZDBQcrgYwA61OAcwYz1E0fEYmglFkr717LMtn9kXFwSHmp2Qb7g8x
         b98VIZd7/IDsdpHGqMZa+NpO07FrRibXZcauX/3JryDt6vh3mn69++PokxV2Xdwq0KoX
         fr9Q==
X-Gm-Message-State: APzg51BpvH3kTf0mzg2l98vKeZ1+JA72w2fuL9ow8hJCNXx14QKwe/Oy
        5YjtCp6XJkCaP2WFDs/wQn9HAlCgWhOefroeLttpVA==
X-Google-Smtp-Source: ANB0Vdby7I2+U29GBUA0zRVgh8IB8d9GcytWDcGe8vQulHFhNuY1IKOvuOzLKHVX3BNfX2+VFkiN7jGBmsnyURE8og4=
X-Received: by 2002:a19:9941:: with SMTP id b62-v6mr5051400lfe.63.1535728700291;
 Fri, 31 Aug 2018 08:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
 <20180829003539.668e514c@roar.ozlabs.ibm.com> <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
 <20180831134943.7f516fed@roar.ozlabs.ibm.com>
In-Reply-To: <20180831134943.7f516fed@roar.ozlabs.ibm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Fri, 31 Aug 2018 15:17:44 +0000
Message-ID: <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
Subject: Re: VirtIO console hangs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 3:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Tue, 28 Aug 2018 15:00:14 +0000
> Matteo Croce <mcroce@redhat.com> wrote:
>
> > On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On Tue, 28 Aug 2018 12:54:08 +0000
> > > Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > > I can always trigger the bug by pasting some characters in the
> > > > terminal window, the console will stop receiving keypresses, but I can
> > > > still see output from the console.
> > > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > > >
> > > > I did a git bisect and I've found that this is the offending commit,
> > > > reverting it fixes it.
> > > >
> > > > Cheers,
> > > >
> > > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > > Date:   Tue May 1 00:55:54 2018 +1000
> > > >
> > > >     tty: hvc: hvc_poll() break hv read loop
> > >
> > > Thanks for the report. I can't immediately see what the problem
> > > is. Can you try get a stack trace of where it is stuck?
> > >
> >
> > I tried but didn't get one.
> >
> > > Perhaps try this patch if you have time (it's a bit of a shot
> > > in the dark).
> > >
> >
> > Yes it seems to fix. Thanks!
>
> Okay sorry for the delay, I can reproduce it here and found a better
> fix, if I could trouble you to test again.
>
> [PATCH] tty: hvc: hvc_poll() fix read loop hang
>

Hi Nicholas,

the patch works, but now pasting text inside the terminal is extremely
slow, it feels worse than a 9600 baud serial line.

Btw, I had to apply the patch by hand as it was corrupted, some lines
were collapsed into one.

Cheers,
-- 
Matteo Croce
per aspera ad upstream
