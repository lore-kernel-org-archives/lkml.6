Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B347C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DF320659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFwsnMM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DF320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLDREO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:04:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50875 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:04:13 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so16558239iti.0;
        Tue, 04 Dec 2018 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnjA76WD+jgaf2MUEiVBqANAq2LPI0h6M33m0CcyIIk=;
        b=VFwsnMM844ylO04LebBMdccbQZ/xN96pNPBV70vMD8EGIw06HgPFxISWaJk3Sqis6Q
         WRzqvXSFzgJxePE1kTnwuQGU8MM6U5uGO8jiipALKyl1nGXEQNGC5iNaxq2xKOzhFx9P
         xi2Zw9pfyHLkrcwGDgjScRgdW5rAf4JMJTYzn5AFXCT2lGYNfmU/4zfBZ66e484IZEYY
         VWp7mwQ3XNnWtLDslUcvfhnJikA87/6WPUptvr3g0jhk8SIeNXeSF5lDrnvAdvT1bgNZ
         Uv6nZqD6DMW3ksU+MtkFMK5wNQ7/H4qA6tz2FGqEBLBzMhbpcF9WnwcfX4P+d9W4Venp
         HNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnjA76WD+jgaf2MUEiVBqANAq2LPI0h6M33m0CcyIIk=;
        b=QqyVZSrQ1QkP+x6YNPbhLbGltSOEBsL+krjoWWFD3ZU50twMbpwAZk/0MShx3A0Vb3
         +2FYFRAxUaoc5l+nXocKGY/0jiqKmUD4ypWRoqGxIj+qXoL7IXjYwgdpK1el7W5dIRVZ
         2lwEagYi6kmHnSJpuIy725ejt0+KxJX6vOwzDUD4yiVJcwkkm/90aRPnQHsJPj0arrnQ
         5l+cOsTlwDsOgSSMs41JLaqCrkhg/6Szd22bBqgB4BYh2u3drN0ur18uSfKYyE1GyBff
         yu3JNFholsOEtyLKiFiD3Sp/1dnuDG5hEbg6uSb712udjNYQdZEWiZkSi8QFLCQMvdkS
         bkGw==
X-Gm-Message-State: AA+aEWYLk2dfdhUu2P3xS0q7B0/o1DkIIl7/off0IR5/7cMavxcSO527
        bnMZhH3F4GgwEBCUvIm8apkzSRaSpUdiDqPQWxkl/Kh3
X-Google-Smtp-Source: AFSGD/WGG6JsaytzZ1kl4vTo8ACt32ruxpkM9i3fiX1lTNNlsnJ9fsNM/VEQ50Ymxk12NP6zzlS037sCklxWKYWgdE0=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr18817123jab.60.1543943052867;
 Tue, 04 Dec 2018 09:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20181130142557.2623-1-tiny.windzz@gmail.com> <CAJZ5v0hPPWx6ZbTPRLRMj_0zSF91ApS3BWgYGj31GqzhX45sYw@mail.gmail.com>
 <CAEExFWuZmcTLF+hFahucUuHzp81OXTxm5sJu_AooCz+jZJUnvA@mail.gmail.com> <CAJZ5v0iApdOc+kgpUrJGSvtmTsXfCFksWg2PsNekOKHaZbffrA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iApdOc+kgpUrJGSvtmTsXfCFksWg2PsNekOKHaZbffrA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 5 Dec 2018 01:03:50 +0800
Message-ID: <CAEExFWsiqr6QXAg0cg4N6b6JqRvvBVxF5=4maJbk5i5+uZOpwg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: nforce2: Remove meaningless return
To:     rafael@kernel.org
Cc:     rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 4:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 2:15 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > On Mon, Dec 3, 2018 at 5:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Nov 30, 2018 at 3:26 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > >
> > > > In a function whose return type is void, returning on the last line is
> > > > not required.So remove it.Also move the module declaration to the end.
> > >
> > > The last piece is not reflected by the subject.
> > >
> > > Also, why do you move the MODULE_ stuff around at all?
> > When writing a driver, in most cases MODULE_  are put to the end.
> > Why not modify this? it is more in line with the habits of most people.
>
> If you write a new driver, then yes.
>
> But why do you want to modify existing drivers this way?  What value
> do you see in those changes, exactly?
OK.I'll update this.

MBR,
Yangtao
