Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A342075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A342075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeIENqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:46:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42571 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeIENqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:46:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so5346872lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NelYs/EqT/Fx+7sSuhyYfF4NmzW8l7r/BtC6f9jADw8=;
        b=uCeqx5fU2hhFP1xQCy4ovUEsApLuuvexCZH9Jc7PrpelOBhmwK4MowYpeT5Z1BpPjw
         /014zCQjdZXhz67trWTlzTQWNZY+14XIZBxL0XCKhAY3Vc+6MIXFGNLJXl8HlPCAtank
         1jB3ZT208P9FJAlAkEXOyxHnCK6hQq1RYhO8afuuO3XOFq+gibVD9WiFm3DVQ1GTsEMp
         IXNlzZewYXkn0+A+JvBCHQqhm0SmyE2jMInOm8GxQwE+4aXSKI9XKmAjhDc5np3AE+mz
         0/0FwPvTslOrXfJOZUub+i9P3HVpx5rzp2DBUi9+6wp11X+RK4NDdpA+ApqjCRP/7B53
         YLMw==
X-Gm-Message-State: APzg51AeEPhwmRtL4AFexgS3pV2bN2OM9+EC+4jDEMD6lU4uVo2DwLlN
        mXy/h4uC4dXDmEyY5QepkSHwFyYy8wUf7PbJFeFH1Q==
X-Google-Smtp-Source: ANB0VdZdJsNkJ/XWAUeTW4OT+2v7uXv7lGAYzq+Aa480ylZGzpYxElyu/295zqKWG9lF1Wz9jUvKJm3uDp/Kb2h7zKc=
X-Received: by 2002:a19:57c5:: with SMTP id l188-v6mr24362974lfb.109.1536139017061;
 Wed, 05 Sep 2018 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
 <20180829003539.668e514c@roar.ozlabs.ibm.com> <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
 <20180831134943.7f516fed@roar.ozlabs.ibm.com> <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
 <20180905135359.26992d29@roar.ozlabs.ibm.com>
In-Reply-To: <20180905135359.26992d29@roar.ozlabs.ibm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 5 Sep 2018 09:16:20 +0000
Message-ID: <CAGnkfhxbGAy8iW9cnb+c_tm0TRQ6VFVZ3NBg5gUG-b7QKwZivA@mail.gmail.com>
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

On Wed, Sep 5, 2018 at 3:54 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Fri, 31 Aug 2018 15:17:44 +0000
> Matteo Croce <mcroce@redhat.com> wrote:
>
> > On Fri, Aug 31, 2018 at 3:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On Tue, 28 Aug 2018 15:00:14 +0000
> > > Matteo Croce <mcroce@redhat.com> wrote:
> > >
> > > > On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > >
> > > > > On Tue, 28 Aug 2018 12:54:08 +0000
> > > > > Matteo Croce <mcroce@redhat.com> wrote:
> > > > >
> > > > > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > > > > I can always trigger the bug by pasting some characters in the
> > > > > > terminal window, the console will stop receiving keypresses, but I can
> > > > > > still see output from the console.
> > > > > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > > > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > > > > >
> > > > > > I did a git bisect and I've found that this is the offending commit,
> > > > > > reverting it fixes it.
> > > > > >
> > > > > > Cheers,
> > > > > >
> > > > > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > > > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > > > > Date:   Tue May 1 00:55:54 2018 +1000
> > > > > >
> > > > > >     tty: hvc: hvc_poll() break hv read loop
> > > > >
> > > > > Thanks for the report. I can't immediately see what the problem
> > > > > is. Can you try get a stack trace of where it is stuck?
> > > > >
> > > >
> > > > I tried but didn't get one.
> > > >
> > > > > Perhaps try this patch if you have time (it's a bit of a shot
> > > > > in the dark).
> > > > >
> > > >
> > > > Yes it seems to fix. Thanks!
> > >
> > > Okay sorry for the delay, I can reproduce it here and found a better
> > > fix, if I could trouble you to test again.
> > >
> > > [PATCH] tty: hvc: hvc_poll() fix read loop hang
> > >
> >
> > Hi Nicholas,
> >
> > the patch works, but now pasting text inside the terminal is extremely
> > slow, it feels worse than a 9600 baud serial line.
> >
> > Btw, I had to apply the patch by hand as it was corrupted, some lines
> > were collapsed into one.
>
> Not sure why that happened, I seem to be able to send myself
> uncorrupted patches...
>
> Can you try this patch for performance? Hopefully it applies.

Hi Nicholas,

This one works really well, as in kernel 4.17.
Feel free to add me in Tested-by or Reported-by (or both).

Cheers,
--
Matteo Croce
per aspera ad upstream
