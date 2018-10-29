Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37682C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF13A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0SqV3rG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF13A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJ2U0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:26:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43175 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJ2U0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:26:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id q41-v6so8697606qtq.10;
        Mon, 29 Oct 2018 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrfYgcsI0Z9PLkqECFLdh9pZ12p98AP1NvZFiH9Mrv0=;
        b=I0SqV3rGHV7g5gSa8c/cNQUib6HOTOSdcT+MXqhJMIMvvNVcxCCM/gy7VbChNdJ6D0
         XQgjMeiqVMIA55FuGchn5hfIEsuLZcOeru38Pw27nxR8g/1Hus+USTtj93R6NOsq62Lv
         17Fbo4beCAY05v4JLOcIcuSSgeihYLO6KE2c2o7UitIfdR0rTzhXeuu4PQaLLGoGeezW
         ntiQ/PwwoN3g3QiPE1gmrDcOhfXHHLA1Xs0vaP8L8ObRbnmlz1YXXyvHgJiDwH77mU+y
         s2gXePvjf3GPvtFOX96Z8/d+ACXvrW9l9M3vPkY1n9zLgDgV5uTLWM3fxrlpsVih0kkE
         GoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrfYgcsI0Z9PLkqECFLdh9pZ12p98AP1NvZFiH9Mrv0=;
        b=GBl0ZEiVsbvi3aMrcMBTK+tlkgm/RtHw5XJvoq2XXOjaVcYtckBcL4BCw1qngLfLpp
         hbmuGuPM+BklU1433BgmyJ4qUk0UaFmyr1TW8QM6gx0bIxQDuRtqlOeKYQ6v1As5WScv
         5nUhKv4KurJSMpdOqMhmxAoNbuEl0IuwqcXhoZNe8w8p4UbIFWZ5ldhVRUCG9aZJBO87
         SKcZBgLRnNraQ7MjrTWwg0zFL0B8XYSRtIy9JNOJ5EvIrrdjGDAPBtK4JZjpkHpOCrzz
         IA1FEJTMWW+9KkpnW5sVcm280Qg7hYLfBOL7Y+0puEAShU3sr8NCTtzBqGh3Q13Ra04P
         zhhg==
X-Gm-Message-State: AGRZ1gILmviivq2O3C006QVo665/zgkYKl/MHB8Plu3rGTrHEN4bcqMy
        mI4b6rgxvhh9ORaQSWAhJTjnH7DGCnPRIMPm0Ng=
X-Google-Smtp-Source: AJdET5fvK8ZclxGZvR0uGsenGLJIrAi1HYtmhCEpxEv5MsUGwdEifcsGC3LGKujBV2iTKTOzPFaXesEpqKE5oGhfjHY=
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr1058088qvo.26.1540813085422;
 Mon, 29 Oct 2018 04:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ve19dcQ3FtRa4BS_Y381g9TDvb2G-M8BNegFuUWA6wzAQ@mail.gmail.com>
 <201810291843424704356@zte.com.cn>
In-Reply-To: <201810291843424704356@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 13:37:54 +0200
Message-ID: <CAHp75Vd1Fia3i7o1YX9y50EU7Se0vYH4OvUT7eO8cJnHk2mryw@mail.gmail.com>
Subject: Re: Re: [PATCH V3 1/5] pvpanic: move pvpanic to misc as common driver
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:43 PM <peng.hao2@zte.com.cn> wrote:
>
> >On Mon, Oct 29, 2018 at 5:22 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
> >>
> >> move pvpanic.c from drivers/platform/x86 to drivers/misc.
> >> following patches will use pvpanic device in arm64.
> >>
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> ---
> >>  drivers/misc/Kconfig           |   7 +++
> >>  drivers/misc/Makefile          |   1 +
> >>  drivers/misc/pvpanic.c         | 124 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/platform/Kconfig       |   3 +
> >>  drivers/platform/Makefile      |   1 +
> >>  drivers/platform/x86/Kconfig   |   8 ---
> >>  drivers/platform/x86/Makefile  |   1 -
> >>  drivers/platform/x86/pvpanic.c | 124 -----------------------------------------
> >
> >As I mentioned you better to use -C -M.
> >This is currently a bit hard to review.
>
> sorry, I don't understand what "-C -M" means.
> I should have asked you when you first mention it.

git format-patch -C -M ...

-- 
With Best Regards,
Andy Shevchenko
