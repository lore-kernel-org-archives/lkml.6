Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51730C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE65A20858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1d0FkX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE65A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbeKPGZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:25:38 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34920 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeKPGZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:25:37 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so3111796ywk.2;
        Thu, 15 Nov 2018 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNOq9oINJ0J+C/vT4gXsM+kCD/N6LkuUBG1PR5VgTG4=;
        b=i1d0FkX0c2sDtdHLdPExT1poqT3YDap948Tfw7sfIYr8gfbJFsU+qIPAWg59a5ZuOA
         9h0U6Kwx7mNJUZGztM2u3nUDNpZHklspMVIk6ri7/sjQbWBieAUfZYppVwgAzsLe+w/t
         l1arl+Yk40luVx72IqkUsYwCetq74F3oovAsUWk6jAQ7wCjrmokMQX5HsdK6hSJCZIq0
         BcFg55d0WWZdX7tg/gOtkBx93VqLNR/Io+jBW8B3OqjiPKekNnOsV4zDFxkuKCcUqAU3
         UNiQo9aA5ygHGEzO83Px2Cm9heZVxenJ1A32vToy3LFJbjeyv4W8FGe1DuD7V7CsM3N+
         XKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNOq9oINJ0J+C/vT4gXsM+kCD/N6LkuUBG1PR5VgTG4=;
        b=DwAhzLfmAy3aVxDObYGcP1KGmT7ScV+OyUhEvk2GsIhSwiyZnCQCAeN8tAK6fxKAFa
         8MbFC4uktrrDabp6bMVh+xtk1tTCqFaKzADr3sVryCj6G2f82FQrtGBRuws7wu4IcsGj
         jmJjreoL8qgdCQXZKz7sxBmMg5sGsLq9OVn3ZhCThOsiM1NX3bappYjmEi444gAourCX
         qOyL9xhkrPjwrw0fBowRkVZpA1jXnHiVuH2emGgkEGl/Al2RCFuM2v7H5cjRQGxVpVxq
         Ej2axtx2UK5kBxDKzNzcw4b+CbW3wWodaKReqAFKCFmScofPIaVsQexl+GrSK18Hok8r
         ZtMg==
X-Gm-Message-State: AGRZ1gJ+10PLARtPQKHIN5gqPwuYtG2lYv+gNDKPYk0BzP33Z5z76GaP
        FJIcpl2HpA8+zWEukvTA0bqd60J/ze15jZnGl1SdArmS
X-Google-Smtp-Source: AJdET5dqinuimUIx1B2NCPxMUsWcQ8OgE+wOzlUMthIOMEOQR/noCiDWas9oa2CtrAEFq8q299H/5tLQatRADziBxJw=
X-Received: by 2002:a81:346:: with SMTP id 67-v6mr7345296ywd.275.1542312980599;
 Thu, 15 Nov 2018 12:16:20 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com> <CALxhOng8jc3WCmw-i5LeghjE5EKuJaXVZGHLN98+552qqgUy=Q@mail.gmail.com>
In-Reply-To: <CALxhOng8jc3WCmw-i5LeghjE5EKuJaXVZGHLN98+552qqgUy=Q@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 15 Nov 2018 12:16:09 -0800
Message-ID: <CAMo8BfLgf7+89X6bGtK9iKz2FkZwCtDT4W=ipc4R0OTgjMGoAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 1:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Wed, 14 Nov 2018 at 05:23, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > [...]
> > > Firoz Khan (3):
> > >   xtensa: add __NR_syscalls along with __NR_syscall_count
> > >   xtensa: add system call table generation support
> > >   xtensa: generate uapi header and syscall table header files
> >
> > What's your plan for submission of this series? Are you going to
> > submit it with other similar series in a common tree, or shall I take
> > it into the xtensa tree?
>
> I prefer the second  option.

Ok, I've applied the series to my xtensa tree, it should appear in the next
linux-next.

-- 
Thanks.
-- Max
