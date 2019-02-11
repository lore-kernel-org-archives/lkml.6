Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87260218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3aTLf/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfBKQU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:20:58 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38979 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBKQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:20:58 -0500
Received: by mail-vs1-f66.google.com with SMTP id e16so6592633vsq.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpoC6b089m3cHPWY6E0d/JIlPYC7gPZGxcGnMybyD6I=;
        b=A3aTLf/r6CWzQhbpbUQOsV3DXU5s5XVGyos7gQ7IcCSu/9ALQdQhuOSuQGWqIjhv9E
         rdruRJQ/0c9PXLYvCAQl5cbDrok1ZO7rBCNtS3UqL1fcn+fN7TJvgbgWZjpWKytrI/7T
         7RliajYd9lJWIqMeH7CplWopycSz5SMti0a7eCLFpgrkQJkuDt/isPQiVHtCyxlSXj3i
         /BtndvKBqcJ9PUU+yv80o/XapeoqdyiW+w1OQS1IYJR/yt0k7VUH9bU7WGoYtt+/iTOc
         PUyEhn8Ai5BAHFKGlJCzat4Gpu+6GjXWQylvKWQ38tjHQxvdH+QtpV1Wjj9vNPihlxeE
         4zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpoC6b089m3cHPWY6E0d/JIlPYC7gPZGxcGnMybyD6I=;
        b=RoEiYKejeFG2RcYH+ZUodSLKZsghujexjv31LrpCuVn5vZ4JrLNAupIa9N5BRx0zYc
         qOwy7GnSGrCJ+j2sJ7yAEJISl4FrdYOx1zNyHakXq289O+xMVXvu05uXDLtkbBl4oBqj
         LpRc+Inbt1zTY5osr/KCIwc6eNyfLTTxwKCZmDvZdKB5qbDMGD+0rk6vb6l61u7fpb0U
         NRed9/HudW0nHWuBS/78Ppat9rWFSY8VzzkDJqZcUBQyrjNh5Zaps/u7cj1TPvOISbPm
         0WdX7HNOMMvcsAh1d06OQEygQclv1YijWGyZuYyY9X0R3tqrGzc19uI9ZxtlpScOBT2b
         3cwQ==
X-Gm-Message-State: AHQUAubt4pslpuAVNIuhvJ8IFK73nkClASjj5u/7dKeu5RuFpDy0XZ3q
        BuiJSlpkdPKoJbpv8LkfoifvfAipjCb3kjsCY64vkg==
X-Google-Smtp-Source: AHgI3IalhMcTKGmsV4UyYAjLPQpl3Sya9HV6AUIw0JgCJJoKzQ8h2EXdZHRN/OlnpCjRmlL4gSPweviMDHbIrzV331E=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr15252838vsa.165.1549902056747;
 Mon, 11 Feb 2019 08:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20190206150935.12140-1-sudeep.holla@arm.com> <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
 <20190207103600.GA14464@e107155-lin> <CAPDyKFpkiaP0J_LJxP6tRUOyz3QKtDgA+PuhL-9vew7-RfKyNA@mail.gmail.com>
 <20190207150638.GB14464@e107155-lin> <CAPDyKFoenSDhYk_xNLFn6kB+rqvQQ+p71F27Mvevu-H9Nhxhuw@mail.gmail.com>
 <20190207152908.GC14464@e107155-lin>
In-Reply-To: <20190207152908.GC14464@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Feb 2019 17:20:20 +0100
Message-ID: <CAPDyKFrV7XpKK-Pds=BNgJm9EC50C0wB_f99DK-6N7+K8aZXZw@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jisheng Zhang <jszhang@marvell.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 16:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Feb 07, 2019 at 04:18:57PM +0100, Ulf Hansson wrote:
> > On Thu, 7 Feb 2019 at 16:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> [...]
>
> > > Indeed, I was ignoring knowing that it's harmless. But more people
> > > started to complain, and Rafael suggested this which I agree as we
> > > have several pseudo devices created in the kernel that we can bypass
> > > some of these pm handling knowing we won't need it.
> >
> > Okay, I see.
> >
> > Anyway, I will likely need to restore part of this change, via my
> > cluster idling series then. As from that point, the cpu device that
> > you call device_set_pm_not_required() for, starts to be used from both
> > PM core and runtime PM point of view. But I guess that's okay then.
> >
>
> Ah I see. I can drop for CPU devices then. Since I didn't see any use for
> them, I set the flag, but I can drop it now or you can do that as part
> of that series.

Well, I prefer if you drop it for CPU devices, as least for now.

> There are quite a few devices(especially the ones
> registered under system subsys can set this but I would take it separate
> once we settle on this). Also Rafael may have seen use for few more
> devices when he suggested this.

Yep, let's find another first user of this.

Additionally, it seems like we should drop the print in device_pm_add().

Kind regards
Uffe
