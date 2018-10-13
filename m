Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E557C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADD72087D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 05:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHgTMtor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADD72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeJMNSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:18:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35366 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeJMNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:18:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id y76-v6so5776621ywd.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5ZjR93lsk/QsNDThJvHfL1tgNrmPXJa5FymhsNnm0I=;
        b=VHgTMtorjUbUY2Xd5bq7mxiDC2IIAUhn22HMGgE3gLMM+7YsOXMo9F8R45xTwAD7fv
         zcHRYvCNdhL9CQpHkRNY9baExri+XpDVEikMxSLMqHTvUR4yKgqKptus+mBAdfQAeOqg
         SzAuMjEeOy5qykBgM48M0ehW+be6hveM6eg5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5ZjR93lsk/QsNDThJvHfL1tgNrmPXJa5FymhsNnm0I=;
        b=iWKtBqmDA5BBUHM6zQsvI3NsQIGJoxO3Q3+koXLu+x3t4Aagw3y5pXCfGICRUZcXte
         24WK0e7osMNY7Wa87Evym+skjZ33q50lL1IKQ5QyaSis/pDNBJ1zY0csWbvnEDUO/Xh7
         6YFlhI/GDcGH/G6DJTUvnXCQCHbXqgiVbTIepDMCUjrtEFrX+PDxThbA93KLylaBWTsL
         SoX2Wmgeg+GnfR7DCvvaAjuRUvJg5oVHs6UUMI6BbkpYfrk6jhhqR9HBg1TlYnrCmQfH
         CJrbQkxrKPbDe1nYMsphUd05Ny7lyzP1KR3ieylS/0aH/9tasQEu/p42mgNMbnMgLph8
         mPkw==
X-Gm-Message-State: ABuFfogYdAqGnQdeXTPeHV2HkWGqTKKZi4p13gSoMY/itpwQxSGFJ7Gd
        wKbvm1W5D1kSw7wONghWckFiHVsZgNbScAOyuAdM5A==
X-Google-Smtp-Source: ACcGV63i0zwnXwhptJ4IbdxPER4TiOK9TlLasNMVDDJZvd/QKEnds3DEFD7PqdtSmpKss8ARmR3ozVuufd74cxptqvA=
X-Received: by 2002:a81:1b85:: with SMTP id b127-v6mr5180363ywb.381.1539409342769;
 Fri, 12 Oct 2018 22:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
 <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
 <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com> <71ea9dc5-7502-40af-2022-b2196dd2d690@gmx.de>
In-Reply-To: <71ea9dc5-7502-40af-2022-b2196dd2d690@gmx.de>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Sat, 13 Oct 2018 11:12:12 +0530
Message-ID: <CALxhOniSbukoQYFzeLmWyD9tYE7Bgye6iq1O+fovvi1_G+56-Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Helge,

On Sat, 13 Oct 2018 at 01:53, Helge Deller <deller@gmx.de> wrote:
>
> On 12.10.2018 13:52, Arnd Bergmann wrote:
> > On Fri, Oct 12, 2018 at 12:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >>
> >> Hi Arnd,
> >>
> >> On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>
> >>> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >>>>
> >>>> Wire up rseq system call requires an architecture specific
> >>>> implementation as it not present now.
> >>>>
> >>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >>>
> >>> Didn't we conclude that this should be skipped?
> >>
> >> Helge told "I prefer to keep the warning for rseq for now.
> >> It reminds me that we still may want the rseq syscall.
> >> If the warning is a problem, you may simply add the __IGNORE_rseq define."
> >>
> >> I chose this option; I feel it looks clean
> >> "# rseq requires an architecture specific implementation" in syscall.tbl
> >> hopefully remind him to add rseq syscall implementation in this architecture.
> >
> > But he said he wants the warning instead.
>
> Correct.
> Firoz, please simply drop this patch completely.
> That way one will see generated warnings about the missing rseq (which is what
> we want).

Sure. will do!

Firoz

>
> Thanks,
> Helge
