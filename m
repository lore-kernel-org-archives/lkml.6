Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A84DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1506D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWMax1W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1506D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeLMFzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:55:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45312 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMFzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:55:00 -0500
Received: by mail-io1-f66.google.com with SMTP id n3so658122iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPwmbs+eMKBM/R1Fl5Iw7wxb1/vt+pVABCjRvqdSHrI=;
        b=sWMax1W5CIuwA5ApYx7+Cq8zcQ7OHOn5yEdDFNRw+oEpYbYGt6omD2NEBXgp0sBTz7
         8CPvJBSIoh6L6wffLU29v97+VHjWKygAn7ty8DYNFe7fFFYOx0QFZMzVsrf39hJtzKN8
         /UY48Iaalz6OAdau0engc4rTZYDXewa4P6pIo5SLEdPsFHYjHH09U8RbgfZr8hwMY4M8
         qGdJEoCQoEHPMUx76OmjYS9oCqfKp1uX23MJ70ia5smcZRvhQ+uEQCnopbFpRU5B3zvc
         Gd5GKJ979wd/YKz9jk3N3Btqvnf4zr7cXspNbPIaGAf9pEduFYRIDY7U+ARZ+79UFXN9
         RURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPwmbs+eMKBM/R1Fl5Iw7wxb1/vt+pVABCjRvqdSHrI=;
        b=cwy/ac8FIcNFZcARYp/vyBbVugzx1Ur9apkaVjkjbSWGkymxjWkCajIIV3N34VqDqV
         cwEVZ1g7euq9bP2sSB1A90YNwiMECKZ9PaX4X/riPnjLML12H2h2tDaqrncfr1x3miCz
         nvOWvv+B2dWd5VkmK3kLijEKTukqTvt46dS2aQoguVMX4dlw2ORh44gFyrM402vwFjPq
         7AFsDzeABwhN+1O+9+MJvbTSBZ7hvcvOkrVPAx6CqNRQvugAT0l9H+2zeb1uV36lbtZK
         lqh1xZ2WBFhw7ZG1vF1BuCiFFHMHUlJqmpHNJN3PAz2vtNTdL7ezVyv0nA5C49oSAn1L
         U8EA==
X-Gm-Message-State: AA+aEWaC68rJE/THd22P8yAu6rHO2zOPc15JO2t4O++jVzcf3McCeHvO
        aTgUBNqFwlpnAa4dRvwO7TiXwdLMYy9lJ09FC0Q=
X-Google-Smtp-Source: AFSGD/VTXsftXLeQAuSWh9z/LtJCmALstGv54EI6JuK2rvXEVwK+lWnVuid7UzTwxYpJWFW3lQBwK9ii2qcSURrBDYs=
X-Received: by 2002:a5d:81da:: with SMTP id t26mr20083008iol.93.1544680499332;
 Wed, 12 Dec 2018 21:54:59 -0800 (PST)
MIME-Version: 1.0
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
 <9cb1526a-e82f-dfa7-4b3c-5ea911a8d476@arista.com> <20181213051853.GG4860@jagdpanzerIV>
In-Reply-To: <20181213051853.GG4860@jagdpanzerIV>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 13 Dec 2018 05:54:47 +0000
Message-ID: <CAJwJo6YZNtdsQuGyk6=YDj9QzvktfYeNc5FTi-qw5ttQDVoJ0w@mail.gmail.com>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical sections
To:     sergey.senozhatsky.work@gmail.com
Cc:     Dmitry Safonov <dima@arista.com>, longman@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        yang.shi@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 05:19, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (12/13/18 04:35), Dmitry Safonov wrote:
> > I've tried to review it and found minor issues like missed
> > debug_object_is_on_stack() for initializing already active object.
> >
> > But than I come to opinion that it's just generally unsafe:
> > debug_obj life-time is protected by bucket's spin_lock.
> > Check the conditions when free_object() is being called.
>
> I thought about it for a second, but couldn't figure out if this race
> was real.
>
> E.g. uart case - if there are two paths which concurrently free and
> access debug object, then the same race condition should exist for
> the xmit.buf page. debug object's lifespan should be the same as the
> lifespan of, ummm, whatever the thing that debug object is attached
> to? I'm surely missing something here.

I think the point of debugobjects is to reduce the damage caused
by an improper life-time of objects.

IIUC:
1. alloc_page()
2. dynamically allocate a workqueue on a new page
3. schedule some work
4. until the work has run free_page()

So, wroqueue fixup upon freeing should cancel the work TBD.

But maybe I've misunderstood something..
And it's 6 am in my timezone, I'll catch some sleep and
will glance this with some morning coffee.

Thanks,
             Dmitry
