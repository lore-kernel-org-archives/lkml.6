Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECC8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F06C21479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHgQCDRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F06C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbeITWTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:19:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34234 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeITWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:19:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so4608202plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVN56geaPE9OqftPhtBC5KZDrM3QbGN9zrlzcVvHwHw=;
        b=LHgQCDRQZZzSEpi7zyfHM8fXlxRq1oqzFrz0gbWT2wIwVpZotoPdgal3vTi8gbvOzG
         VOxscZBhu7PkINZKzQI1v3srxHwckrRJEEIlDI/gpJi41v3mkHAKwASRLQHIAS77ebpd
         mQPbDHVMC+lwegGBrRNRABGvyHVUvzfvyLXFPQihwqFXEBHBwTnn2MYNZBcezAUc1LWD
         9PKOwDRfVnxX+gccmBWJdSeSoR6xJ3OQU4ahERaHi/VmHRy9uHsQrw09MsEj/L0UrtG2
         BiG9svqXl15in3s7KdDx3PwkT1ZkLuZ3hEpXdwqUzA2PE9RUeS544QmLia+YYe5mlw0D
         LRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVN56geaPE9OqftPhtBC5KZDrM3QbGN9zrlzcVvHwHw=;
        b=VHq5fKZtXSe81bFYvfxbyJB9k4Umpw2yEO9oW5PS762uh+MTmAe046VUSeuew8OYvC
         Qwdi9hqDvufJHtS6GKcpM8OLblNR3CY3fYhR9PH5rrRmqVTYngIpgAf2sD9OvVuj7w08
         hAKdP/v9Xbg6i35tsDfmKVFirgdeWjmE3FUp9amv3Zx/WpBf2pq61trxkNy8eSxTyLs8
         w4CSMWUNf2s/B0Vh9NJ6mUxMDcMNfX4OrO+zQFJRKA4dxcl3SCkmQzCysHtiiTQbrIjz
         zrsSkHiYBwWLhQ2xkoqZdaSLwvsnxVsusNlEBFzyEps8yglHSDUmpbMiRVuAruFgXjOa
         SfvQ==
X-Gm-Message-State: APzg51BcVXCP5OcAsxvrWpgC45wZXYFePBN6auFRfZp3YQqUGAh8nkZ5
        7gpWiH8k3VjTtdt4ho+0hhdNOhALl9oRGr4xsZvlsA==
X-Google-Smtp-Source: ANB0VdYq5K4hF4XafV56XfdLasPEkFO8ab12pZ76uoi3JKD96muVekbRw3lhCyeHcBcTVGRrzJKvMoo0XI/eLomQb8A=
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr40844091plk.13.1537461312425;
 Thu, 20 Sep 2018 09:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180919003147.55692-1-mka@chromium.org> <CAKwvOd=X1K4Gm0GyoDpmPTrTPQ_6+Nvzg9J8y4gdy-R=67_72A@mail.gmail.com>
 <20180920113129.GA19892@kroah.com>
In-Reply-To: <20180920113129.GA19892@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 09:35:00 -0700
Message-ID: <CAKwvOdk4njYpcQzEEWbk5cFCSw4U=P0Pmk8dZ+OZj5Pees=VuA@mail.gmail.com>
Subject: Re: [PATCH] sysrq: Use panic() to force a crash
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, jslaby@suse.com,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        saiprakash.ranjan@codeaurora.org,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        manojgupta@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 4:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 19, 2018 at 10:59:51AM -0700, Nick Desaulniers wrote:
> > On Tue, Sep 18, 2018 at 5:32 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > sysrq_handle_crash() currently forces a crash by dereferencing a
> > > NULL pointer, which is undefined behavior in C. Just call panic()
> > > instead, which is simpler and doesn't depend on compiler specific
> > > handling of the undefined behavior.
> > >
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Not sure if it is strictly needed to release the RCU read lock now
> > > that panic() is invoked directly (I couldn't repro the warning
> > > without rcu_read_unlock()), but since this is a forced crash it
> > > seems good practice to keep doing it.
> > >
> > > The commit that added rcu_read_unlock() and the comment is:
> > >
> > > commit 984cf355aeaa8f2eda3861b50d0e8d3e3f77e83b
> > > Author: Ani Sinha <ani@arista.com>
> > > Date:   Thu Dec 17 17:15:10 2015 -0800
> > >
> > >     sysrq: Fix warning in sysrq generated crash.
> > >
> > >     Commit 984d74a72076a1 ("sysrq: rcu-ify __handle_sysrq") replaced
> > >     spin_lock_irqsave() calls with rcu_read_lock() calls in sysrq. Since
> > >     rcu_read_lock() does not disable preemption, faulthandler_disabled() in
> > >     __do_page_fault() in x86/fault.c returns false. When the code later calls
> > >     might_sleep() in the pagefault handler, we get the following warning:
> > >
> > >     BUG: sleeping function called from invalid context at ../arch/x86/mm/fault.c:1187
> > >     in_atomic(): 0, irqs_disabled(): 0, pid: 4706, name: bash
> > >     Preemption disabled at:[<ffffffff81484339>] printk+0x48/0x4a
> > >
> > >     To fix this, we release the RCU read lock before we crash.
> > >
> > >     Tested this patch on linux 3.18 by booting off one of our boards.
> > > ---
> > >  drivers/tty/sysrq.c | 13 +++----------
> > >  1 file changed, 3 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index 06ed20dd01ba..d779a51499a0 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
> > >
> > >  static void sysrq_handle_crash(int key)
> > >  {
> > > -       char *killer = NULL;
> > > -
> > > -       /* we need to release the RCU read lock here,
> > > -        * otherwise we get an annoying
> > > -        * 'BUG: sleeping function called from invalid context'
> > > -        * complaint from the kernel before the panic.
> > > -        */
> > > +       /* release the RCU read lock before crashing */
> >
> > The comment probably could have stayed as is; folks will have to get
> > context from git blame on the line immediately below now; while you
> > added context in the patch file, it's below the line so wont be part
> > of the commit message.
> >
> > >         rcu_read_unlock();
> > > -       panic_on_oops = 1;      /* force panic */
> > > -       wmb();
> > > -       *killer = 1;
> > > +
> > > +       panic("sysrq triggered crash\n");
> >
> > Otherwise this part looks good. Maybe GKH can apply just this part
> > rather than a v2
> > (if we even care about git blame on comments)?

Greg, if you don't care about the git blame of these comments, the
patch is good to go.

> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I can't pick and choose parts of a patch to apply, sorry.   Please fix
> this up properly and resend it in the format that it should be applied
> in.
>
> thanks,
>
> greg k-h



-- 
Thanks,
~Nick Desaulniers
