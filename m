Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448F8218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeLSRIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:08:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37119 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeLSRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:08:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so20283417qtt.4;
        Wed, 19 Dec 2018 09:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5qAZ/sdxxyCA3rCZEmacpvRnja2QzwTksZT1oxaWU0=;
        b=Q371rkj1zU2TP4LEx+NxrdHaXfZoYiiAy8psXUAzqByNhK+R4ClMS2xQbPnV9xJA6p
         LNSjx5ODa9CXZtLLKXQU2kxrnbnMsgTDgGfirW7nIRTF1U6kNlhov+GB1/4gq3KJbgag
         8gYZhe6U/Xg52pE8VACWqcFzXPIEsuo0DgdQgGUtGHxcd5v1CxV2e/W3vbySU2RPZdAe
         PhfDqSb5Ra1O5vmEmIO70tCbiYNON7wapVxW0xLOdtxf8+qimeCqGXrEFCoS/03cR/iU
         lmI5gVDA7O3dcRumUXRxtfWctToo1fA+qOCSIRKiIOodaYpw3uU8m83FaeX2kBNHQqPc
         9gLQ==
X-Gm-Message-State: AA+aEWZ0sn/vqNdTLpd8ggkUFYTb3kWTmciwreUyegrL+qVXPccPIABe
        R/h3kJMj368vxA63MyRVGS2LNwu5IrYSuaQOFEM=
X-Google-Smtp-Source: AFSGD/U4i+HPN/ofeJrTu58hym56WH67374gBp39IO3+N577jbx89VxuTQwIp7NE7rZ1s/xS+Mp0pt1ztUkYngIdt9k=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr22208186qtr.319.1545239310043;
 Wed, 19 Dec 2018 09:08:30 -0800 (PST)
MIME-Version: 1.0
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOngxbsYFSbK1Y0okuiTmjWEQ8Zcd4vQ0OezhXBgXH82DtA@mail.gmail.com> <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com>
In-Reply-To: <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Dec 2018 18:08:13 +0100
Message-ID: <CAK8P3a366UUWv8hXxWFQo9EQs++t5x4N+JmJ5abgD8BP99hECQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] alpha: system call table generation support
To:     Matt Turner <mattst88@gmail.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 4:59 PM Matt Turner <mattst88@gmail.com> wrote:
> On Fri, Dec 14, 2018 at 10:18 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Tue, 13 Nov 2018 at 15:02, Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > Could someone review this patch series and queue it for 4.21
> > through alpha tree would be great.
>
> Thank you! I'll take a look.

Hi Matt,

I see that you merged the changes a while ago into

git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha#for-linus

This all seems fine, but they never showed up in linux-next,
which his what had both Firoz and me confused.

Is that intentional, or should it be added there?

Added Stephen to Cc here in case you want it added.

       Arnd
