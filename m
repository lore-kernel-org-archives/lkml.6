Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1C7ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6DD20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/iDr6ZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6DD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeIODXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:23:45 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36295 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeIODXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:23:45 -0400
Received: by mail-it0-f68.google.com with SMTP id u13-v6so4461259iti.1;
        Fri, 14 Sep 2018 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41ZYEdyLhN3zbwL+4EHQPN+qKIn9OgvZjbT0LCVJgYg=;
        b=G/iDr6ZCnVvZYkuRM/E+cie1YuVxZIlCMPrE4b80Y5U7y7x/GhQ6t6YitxfQTz9gpe
         HLAu3gsM7neZA/IHPewNdAs+0OemWRZj3b6ab0BOm2qdHq8kPGT/YkP2KbeeUxiSSIyg
         6XZpvNHAXaxDAmGqccLxrSvysP80bC+mA5xzP9O3SUierxkrEBscciuZbCk2xpIc0yKm
         8JNdL2XTuiE3edI5xn7kYJujxQ9zf7A90sU3E/BJydN1Fs1C1BRZbcGBj0whVrvk2vkD
         j62LZIDZEfp4D3uSu7o9P/oNyQx8WHN71U6e2YB3Sv6p7524V+K0NvU1E2XUA4m7MW3m
         ZWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41ZYEdyLhN3zbwL+4EHQPN+qKIn9OgvZjbT0LCVJgYg=;
        b=EVamkWsnmQD4NSkL2rftmSDXhJDOpj9kATSy0qvYi8Qb3jd8EMluH5nY2ba9J7cqzE
         QV5n69yfkLEjuChCic/2JWEGh4/s28Vvf9GYnQH53EOWkSeMobgdEav22N0a70p7tdiE
         xblNjZrGjcTO72DNQLUXeysB9CcpNvHKrrrVn3ObRr187G/DgUEcaqfOiF5MbGN+sk8k
         pD9+7VAuQ3ed46QbiNVq9qbRPPQLj2Pof/5qztHJTCfKCQMxfoNWLu0Kr1z9lWvdEOGY
         XGiE6ZSOWA7u8jKaPi/YeJgMlJMQSO14SMEkrDM4BEdbjxjTbmbC6tsND7Uffs9He0V5
         SxWg==
X-Gm-Message-State: APzg51Cz2tm7fh6t9Tqxrd9ytHYb9wa+5zTZk0RgMEq9m4XVG4DVl/ET
        GpC+DS8DkZt6iVby50YopH32CXA3vyAykKYWYoc=
X-Google-Smtp-Source: ANB0VdZRU0LsJcyB8X2OhYAOCWyz0Z9DYefu0aV6GXQCm80avIingtPWM6CLHqcsxvHCEaFUGWjRjcanyFKnAHQuuY4=
X-Received: by 2002:a02:6612:: with SMTP id k18-v6mr12898038jac.139.1536962842018;
 Fri, 14 Sep 2018 15:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180901204721.13117-1-deepa.kernel@gmail.com>
 <20180901204721.13117-4-deepa.kernel@gmail.com> <CAK8P3a1zQBQz1ZtNZzkceut4k3eLjOjCwvOtBdEmc9cTsaFz+g@mail.gmail.com>
In-Reply-To: <CAK8P3a1zQBQz1ZtNZzkceut4k3eLjOjCwvOtBdEmc9cTsaFz+g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 14 Sep 2018 15:07:09 -0700
Message-ID: <CABeXuvrnzJJaZS-xp4+H7848+wbQ2TqsN9cVbM08a2naoyApCQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ppoll: use __kernel_timespec
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 8:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Sep 1, 2018 at 10:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > +
> > +       /* We can restart this syscall, usually */
> > +       if (ret == -EINTR) {
> > +               restore_user_sigmask(sigmask, &sigsaved);
> > +               ret = -ERESTARTNOHAND;
> > +       }
>
> I need a little help understanding this part: In the two existing copies of that
> function, you have changed it to
>
>         restore_user_sigmask(sigmask, &sigsaved);
>         if (ret == -EINTR)
>                 ret = -ERESTARTNOHAND;
>
> in the previous patch, but the new new copies you add here do
>
>        if (ret == -EINTR) {
>                restore_user_sigmask(sigmask, &sigsaved);
>                ret = -ERESTARTNOHAND;
>        }
>
> Is that intentional, or did you accidently leave a version in here that
> you had changed afterwards?

Oops, you are right. This wasn't intentional.
I will send out a v2.

Thanks,
Deepa
