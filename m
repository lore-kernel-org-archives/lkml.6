Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C38C46470
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B344B214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey/7qYpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B344B214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeIWOz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 10:55:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37417 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIWOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 10:55:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so7134830wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNlv0Wegcg/20sPANhXobuE1yL29hBkVxc7VROKDXHA=;
        b=ey/7qYpDDr7uUefMh99kwvim/VZmamHOd4pMWN1AX6twVKxfRVrzCVulpKD39zS5T5
         YycEZoHBYu417T6GObNyHZtGUTDO/ZHNTpmTa/uVIKH0XAIhkhAHNiPRkIzhbxsIdQtf
         DRRnoSeo8l2e3GRokKAt5nimp0c3XIOWvK3qtBSMq8je6nnYOudGVjN9B3SOvacniMfu
         fCylsHtPBmFTzadnUQZTBtrVrL9B3WHVIeutptjkE0cMPDQDRaKY8P70UFz18w7jWV/V
         hOnt0mQQN9q7LOWF00xMl+AKM4xaIiVizTzrkJZq2qZV1APhLWFavShHJn9zhVkcmg+B
         vN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNlv0Wegcg/20sPANhXobuE1yL29hBkVxc7VROKDXHA=;
        b=sR62FY5EykAhcQr6xLYPoEchlHwbAiaqyRVacIp9G759r1rfQi2eALywmIZZorMuqx
         fDa1I5PjaoQCoAvQppXVlNiQMqP1pe4vkFBBr49XdGMxa5UJxSBJrv6I6F8otUiInObL
         wFw8tQR9s5yFhb2I7+SzC9jOIVo8+SEmoSFzdY1djD8VUrOe3sWbrKnhLhBaK06EORK2
         mkC/d8SWq2k0dYp14sQLjYJZctlPgDdVVzCZa6Hi8nDxuwnl+UyZkdh45RKspXaDBmle
         Se/MdW4d7oo67SlD7BCwoBB+ZhwQUl5ftNLiCC6gSlmoPG77TRKx64JIflCxQ3MdBaRj
         ekHQ==
X-Gm-Message-State: ABuFfoh92CrFYbbi3SUFr5YLpo2p+8A2syX+3nz9d3G45K1SkzKK9ri1
        v9b2Ub68DACG2joZSHd8y5RHSxjgFqjg/c+8Of4=
X-Google-Smtp-Source: ANB0VdbEvTvBEY6UoXyTmx6NO0jjNzBVIlGMeHYHLmhYqYh2BS46r7Z/CBVS4uqIiCLjEBtkqIcjxpPCzWA/DixW1vs=
X-Received: by 2002:a1c:570a:: with SMTP id l10-v6mr3415349wmb.56.1537693152402;
 Sun, 23 Sep 2018 01:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180912035352.11191-1-diego.viola@gmail.com> <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
 <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com>
In-Reply-To: <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 23 Sep 2018 10:59:01 +0200
Message-ID: <CAFLxGvxZmuXb6KbGggQf4y1_Tkv=Ri3PuE4Jnfwbs1VuA9z2QQ@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     Diego Viola <diego.viola@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Trivial patch monkey <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 3:00 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Diego,
>
> A few things, since it looks like this is your first patch.

git log...

> On Sat, Sep 22, 2018 at 5:56 PM, Diego Viola <diego.viola@gmail.com> wrote:
> > On Wed, Sep 12, 2018 at 12:54 AM Diego Viola <diego.viola@gmail.com> wrote:
> >>
> >> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> >> ---
> >>  CREDITS     | 2 +-
> >>  MAINTAINERS | 2 +-
> >>  Makefile    | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/CREDITS b/CREDITS
> >> index 5befd2d71..b82efb36d 100644
> >> --- a/CREDITS
> >> +++ b/CREDITS
> >> @@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
> >>  W: http://www.linuxdiskcert.org/
> >>  D: Random SMP kernel hacker...
> >>  D: Uniform Multi-Platform E-IDE driver
> >> -D: Active-ATA-Chipset maddness..........
> >> +D: Active-ATA-Chipset maddness...
>
> I think the extra dots is what was intended here :)

Diego, I know you can do better. :-)
How about running linux-next and hunting down regressions?
I think we suggested this already on IRC.

-- 
Thanks,
//richard
