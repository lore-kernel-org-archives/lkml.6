Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B9CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11FA21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6nz7z+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfADFzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:55:14 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46942 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:55:13 -0500
Received: by mail-yb1-f195.google.com with SMTP id n16so4052254ybg.13;
        Thu, 03 Jan 2019 21:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdaP/nEJvWZE6mz44L21i/YDinDzu56kaUMBg4e2Q0A=;
        b=T6nz7z+KqWf37vh2S9aJ5ek6kGtyK4Uney7hivrnDCNh+s62gmj4hiVMgjil4PrFs1
         z/WhNp3tr74ZduubdOV3FtmyuxcOdlY6Jz31IbO6qQMQBaTLCeeSeu1pIpz758Sb52i1
         A3Kq0IDEqb+0mBrKmdHn0jS4GiQHOmhde/Cg1xwiM8seewyiBHf8xZFb6/kORSbA7jQo
         OPjnQT6HbExVMdQQhgKoMCifXGmVQDkA1YKtjshrX7e9vLQmBRYjAE63OkmXsyuHMHP/
         4+b8LFjtt9uSUwJHNwUITpKJkN4dqoOqFwZ6prPfdpEdg9RFY6LPExPNMwWZYGcArWF9
         ztCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdaP/nEJvWZE6mz44L21i/YDinDzu56kaUMBg4e2Q0A=;
        b=BTcyjnCXyntD11mETXZUTon3d6O2PC+U8izTU3kYQ955HGoKJXcetfurOekV0s+AOW
         vssnYBBwH9L5saAUdUyPomKYxjYUD4XN0qS/shYE6juTSECkw01pAH3jLv+EFvIQA9D1
         c6dZZN5ZzST3TPlui2ONY2MqSdJkgoTnW3FH8ZUFkIAuJUpklfE9zLxOkJI5Np9sE07+
         TQNMyAPUwuTVjkwQDGTe1IcbhiCIqdPml+I3F01nyRNt2JSw1O2BWat7f1cQaPiZdrFd
         hECc43y3hohh3qyKmiAgsor/5FSe2JQnXQpL7acFlOKFb0K6lDO7xSPf0RX8HksEgRz8
         8IFg==
X-Gm-Message-State: AJcUukdV+the7LEFWw2j/KKou1HEQOK5r3gU+wZnCfZO/GY66pL6l+Qb
        +xpHugdwfB3k4CHkgw9VgIe5UeJzJE6QakjY3+c=
X-Google-Smtp-Source: ALg8bN6r8R+fi/vLTNOuFY6MqmU1KhL/NsuDv8ai9OAJTmoCaXnG+4t5QwsuKuXOhAhqeli0RbiqQhSckjs70MPIcto=
X-Received: by 2002:a25:3504:: with SMTP id c4mr15023259yba.252.1546581312407;
 Thu, 03 Jan 2019 21:55:12 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
 <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
In-Reply-To: <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 3 Jan 2019 21:55:00 -0800
Message-ID: <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:17 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Fri, 4 Jan 2019 at 08:28, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >         while [ $t_nxt -lt $t_nr ]; do
> > > -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> > > +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
> >
> > Please add space after the comma.
>
> This was intentional as I was trying compile other one architecture with the
> previous implementation, it was giving the error. So I modified without space
> after comma.

I have tested that presence or absence of space does not affect the build
for xtensa, and normally we put space after a comma, so I've mentioned that.

Since this script is anyway removed in the next patch of the series it doesn't
really matter whether the spaces are present or not.

So, with or without this change:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
