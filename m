Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A711C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE12070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XODis0he"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfADFR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:17:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38714 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfADFR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:17:58 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so260018ith.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 21:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4RVogGmCOPtYOGSGUhxwOrHWqYOotE4/p5kytcrWhs=;
        b=XODis0heNJ2W+NIb84LzMTgYQCRl2lUPMo7zOqOvOUQQcx6SkzlXKWDC9iS+vYLij1
         v7Sau8VLA14eK5PlCmhGfHlpkKTkbSt+DVMR5bPnr0GhDYwJAMpB63ePkaI5PuoGl2G/
         UI5Tt0XdJRjr+R+F2/dJjOnp5H4v6n81dEOXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4RVogGmCOPtYOGSGUhxwOrHWqYOotE4/p5kytcrWhs=;
        b=HU1yoCzbLeBZQlpddq1K0+7+O+yoR1Pg5xWgoilXPeS/mxFK6Y1B6CyG3Pq8GuFkX6
         sxdicld9SPeD7KQZNgeEhTchGWvUNzwXVpkpCJ9pGn6mqOCegSeotdckgmmeJry3tNwD
         RvQsbNKJ0kSV6qA09y/S+95I/HOHsZj3NFLXb6ZfV44hvSSBejD238MdjCuEnjKkRxma
         OKBLgNL/AS84ovm2nXqFPQIHgKCmlAbAtuWF3KuJFEPDaD4f5Xl2rvCSbzBQ0veRnSLP
         PTlJzMFMB5NxpSSxeAb916k370PrHnA8+nQJHUZXXryyV0mqp3m29uTh2woZZjq5PDLV
         8mEQ==
X-Gm-Message-State: AJcUukcxJ48zdBU8PGs35KmDnb5j6C3fqzeauA8+XWAFOku1gzGYWwsk
        g595cce5ZtGP4aVLYsCBEB5q0Et6Wuoro8e82TL59Q==
X-Google-Smtp-Source: ALg8bN6ZYgwQa7Exdh5enNBUC+loZV24isuMJcv3R1MwdWjT9J5xyBAYZy6jDs1g2jg30oM20aar4o4xP3pdSP5wq/Y=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr144733iti.166.1546579077282;
 Thu, 03 Jan 2019 21:17:57 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
In-Reply-To: <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 4 Jan 2019 10:47:46 +0530
Message-ID: <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
To:     Max Filippov <jcmvbkbc@gmail.com>
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

Hi Max,

Thanks for your reply.

On Fri, 4 Jan 2019 at 08:28, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >         while [ $t_nxt -lt $t_nr ]; do
> > -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> > +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
>
> Please add space after the comma.

This was intentional as I was trying compile other one architecture with the
previous implementation, it was giving the error. So I modified without space
after comma.

Firoz
