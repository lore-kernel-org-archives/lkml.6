Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 747A2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29819208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gei59pQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29819208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934694AbeFLWDW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:03:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45121 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFLWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:03:21 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so1187309ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOtV19L7SmQyoPEbGJP3G988msGSoavq9SuclY4m7hQ=;
        b=Gei59pQnYRoCo43UNwzUlFjhO09GsLkY9jTNIhXxg71VDxB2hUs1CqQYj84/quYvvo
         BtnK6cicXlI0OSfF/Dw0Oy558xD9UuMLukcPpcmKOUtsKtV5v/5Q6WIcF0Z501p0sDaE
         ALBGze2LwM2TI8GdDqq8IHGQw2VqjNG9XfE+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOtV19L7SmQyoPEbGJP3G988msGSoavq9SuclY4m7hQ=;
        b=tyVRqRHShx2fxvnjCjn3s1fUv6rp3KgAJGFowJRg7T18f2uv+AAoFv4XEi/6O4jpl3
         PKRRlFjbJWvzvSY6Ms9sQ703iSeSVSPvAkIGaFAdzcX+FzYY1zWIdKpbvf1rnqOAp4bS
         RKn2untw9CBBavvSDovtWK9403SzJum+eWvH4c9mUZmFq4qgl6uaj9SXxBDmS2VfvZL2
         G5nrkixKcjMpNNTWnXGfVLWqJvhOBebfYbsKPg1D0uWWyPeW0MvkXutVc1Rb6vN5pxVo
         U+jRD3t/6e/b8d478g7m2hzYWG1/cIIIqq438uj+DsEuOzTn6xM0kosDqy4WxBQz1Ol8
         b+aw==
X-Gm-Message-State: APt69E3vf+CxQ9wrbFxlvTMUAgJYl1NMpZ2k4Wzfaq6GUk1sA3SdGRIj
        GZgqs/X8GNDJ/lwIX7dyu3q1Vr70LO/22JtkbNA=
X-Google-Smtp-Source: ADUXVKJIZ+tZqUC6a46kifRhCvdtpdbNzCIqR3pK7OvDbG5ERs6Dnf0GeOS6lrtho5aClOUQ6xjwvRVrLD2YwMZIwQM=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr2403191iov.203.1528841000715;
 Tue, 12 Jun 2018 15:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180612083449.100099222@infradead.org> <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
 <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
 <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
 <alpine.DEB.2.21.1806122134410.1592@nanos.tec.linutronix.de> <20180612215411.wcma6o7zd6cbytkk@linutronix.de>
In-Reply-To: <20180612215411.wcma6o7zd6cbytkk@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 15:03:09 -0700
Message-ID: <CA+55aFxCs+-6qNQoRLRx+-xzO_8dYXubK2B6LhuxObi7-ijbbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, quilt-dev@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 2:54 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> mutt sets this and the tip-bot, too. The difference is that quilt also
> sets the filename parameter. Do the mutt or tip-bot mails look flowed?

No, they look fine.

And yes, the difference looks to be that filename. Looking at the
tipbot emails, I see:

  Content-Transfer-Encoding: 8bit
  Content-Type: text/plain; charset=UTF-8
  Content-Disposition: inline

and the email looks perfectly normal.

So it's not Content-Disposition itself that triggers it, it is indeed
that *together* with filename information, so

  Content-Type: text/plain; charset=UTF-8
  Content-Disposition: inline; filename=peterz-swait-1.patch

makes gmail go "Oh, I want to help you download this thing", and makes
that "download attachment" widget, and makes the text itself act
flowed.

Yeah, that's just stupid of gmail.

I've sent feedback, but judging by my last attempt to get something
fixed (making the mobile application have a "Plain text" mode), I
expect to be laughed at by some coked-up QA person who thinks "flowed"
is obviously better.

                   Linus

                  Linus
