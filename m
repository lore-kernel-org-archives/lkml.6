Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6EE217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dlO3BUdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfBEO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:57:27 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39166 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfBEO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:57:27 -0500
Received: by mail-vk1-f196.google.com with SMTP id f206so232316vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BjJu2Sz0WY0eSAV8ViA9jF1Xbm3uRhBsyGWH8UCJnk=;
        b=dlO3BUdkTZl1QOfKWj8GlYA0v8rG19oMTZHlYf6jc2eUTh2kD8nD8IZsN28CX3Sj9w
         rptHxvpS2deED1cEFipUPY3eyQAeA1RBcFNdiLRJmtXzcyPhjqY3TpisB3+ghelJBAtS
         YZJSoR1WdTWC9jxcNxZRjCj55oKP+DtGDh9HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BjJu2Sz0WY0eSAV8ViA9jF1Xbm3uRhBsyGWH8UCJnk=;
        b=V8rthczxTgRJlgQE9kppEdiGmuztZryIi2nz+c73vBdX2Jg27Zlf738kAbIWRhAsHt
         lhOUVE6I1WMsr8FeN34FGA2JXBfnvcKXa40qgVFr2VGOCRzJjZNXAIJwlDzqG6F4i11K
         iy2FUvrcC5xeke1BzlfSL9wC+KSqbQ1Y5tSrXPbJ7qx6GCwLaLVBZyWEo8i1J+ocuizW
         JTVfFj/vB2bPLpwnjH4x8kuiNTNtpH+21z/sRRdIY/8Bn76mpV5EebSJapUA9ugcx9LS
         LX63fva/oyetv69Ttqdb3ocAceXNILA9aJe7rGsuBMRKBW3Imet1kfOhdy0M0zLb7nze
         Dhbw==
X-Gm-Message-State: AHQUAub9tjaz5K8saD7sFZfJBps+w1DHWzGYDR8K26GLWT/94psCFQ5M
        K4cpebrPe+Adbx6fR3DxjBYEoHb0+Ng=
X-Google-Smtp-Source: AHgI3IZcMqRuXKlk28TAYIcjw7I6SNxGIH7SBdHigBGhq7bv7oE1e6KjMC85L3IeSeoBcWYPP6CJMQ==
X-Received: by 2002:a1f:a28a:: with SMTP id l132mr2108474vke.37.1549378645565;
        Tue, 05 Feb 2019 06:57:25 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id x132sm554052vsc.34.2019.02.05.06.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 06:57:24 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id d19so1183449uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 06:57:24 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr2052020uaa.10.1549378643954;
 Tue, 05 Feb 2019 06:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
In-Reply-To: <20190204220952.30761-1-TheSven73@googlemail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 5 Feb 2019 14:57:11 +0000
X-Gmail-Original-Message-ID: <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
Message-ID: <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 10:09 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> I think there _might_ be potential use-after-free issues on module unload.
>
> They are hard to trigger, but I think I've seen them bring the whole
> kernel down when they do occur. Can be triggered by doing an insmod of
> a vulnerable module, rapidly followed by an rmmod.
>
> Caused by drivers which schedule work / delayed_work, but do not clean it up
> properly on module unload. Which means the work function could run _after_
> the module has unloaded.
>
> A quick grep through the kernel sources brings up many instances.
> I leave it to people more knowledgeable than me to determine if this problem
> is likely to happen, and/or if it can be exploited to become a security risk.
>
> Perhaps developers can be 'nudged' into doing the right thing by using
> resource-managed versions of INIT_WORK() / INIT_DELAYED_WORK(), which may
> address the issue quite elegantly.

Can a Coccinelle script get written to find module-use of the non-devm
work init?

It seems like finding these in __init functions should be relatively
easy? (Or can we add runtime detection in the existing INIT_*WORK()
code to see if it is running from the wrong place?)

-Kees

>
> Attached is a proposal patch, followed by sample fixes for two vulnerable
> modules. As far as I can tell, many more modules are vulnerable.
>
> Sven Van Asbroeck (3):
>   workqueue: Add resource-managed version of INIT_[DELAYED_]WORK()
>   max17042_battery: fix potential user-after-free on module unload
>   cap11xx: fix potential user-after-free on module unload
>
>  drivers/input/keyboard/cap11xx.c        |  6 ++-
>  drivers/power/supply/max17042_battery.c |  5 ++-
>  include/linux/workqueue.h               |  7 ++++
>  kernel/workqueue.c                      | 54 +++++++++++++++++++++++++
>  4 files changed, 70 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>


-- 
Kees Cook
