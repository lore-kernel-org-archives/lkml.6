Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A225C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C804F21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI4EeOSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C804F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJIBBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJIBBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:01:45 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C26214C2;
        Mon,  8 Oct 2018 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539020933;
        bh=hKGxC9mClSj0Q9VkNXekYZB/ApxJUfM7F+dIV5gSw54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uI4EeOSyyi2qnOL8ZWAyErxKum4YXGFoBkrM6+JB6IEdOZpwhhdXI5t9BXMMHPR5z
         /TXXLygw90TjTSLCkAchxxJOC3UfmxLRn3LG/lOYAnDOs9wjkWLrQTCut0OCHlTOX9
         zBu5O3pS7rdhb0uvY2oZi3/uszc+7qN5dl2ekphU=
Received: by mail-qt1-f173.google.com with SMTP id o17-v6so5925038qtr.1;
        Mon, 08 Oct 2018 10:48:53 -0700 (PDT)
X-Gm-Message-State: ABuFfohqBgk0X4np9iMDqnvkkEKK/beVRa57TtNDCi30nnY2A1JqPoZV
        DpsuwImLZKIbHyDjiqtRazrUeDZZ9UKiDUhiAA==
X-Google-Smtp-Source: ACcGV63p4ALi5/cdA4XikmKhZERkoOOYtEzI1u17ZXU9djdOntuJd3JLwME/JHCdmrdZ49rwhz1fkmOQIWDC5+JW1y4=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr19983763qtj.327.1539020932849;
 Mon, 08 Oct 2018 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181002132459.032960735@linuxfoundation.org> <af80bbc1-6753-01d2-1ecb-830720b38f48@roeck-us.net>
 <20181003162539.GA4653@kroah.com> <20181003172440.GA7955@roeck-us.net>
 <CAL_Jsq+GBDB21tSDTq7p39SvQEGq1R3ZPeH7Yx+9fHttx3v9Ew@mail.gmail.com>
 <20181003180847.GA15682@roeck-us.net> <20181007141808.GA14337@roeck-us.net>
In-Reply-To: <20181007141808.GA14337@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Oct 2018 12:48:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+0t+x4GSPUW-0Qhcsng1Z+0qn_72XpmX5At00FtT5V4g@mail.gmail.com>
Message-ID: <CAL_Jsq+0t+x4GSPUW-0Qhcsng1Z+0qn_72XpmX5At00FtT5V4g@mail.gmail.com>
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org,
        patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 9:19 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Oct 03, 2018 at 11:08:47AM -0700, Guenter Roeck wrote:
> > On Wed, Oct 03, 2018 at 12:53:11PM -0500, Rob Herring wrote:
> > > On Wed, Oct 3, 2018 at 12:24 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > On Wed, Oct 03, 2018 at 09:25:39AM -0700, Greg Kroah-Hartman wrote:
> > > > > On Wed, Oct 03, 2018 at 05:59:09AM -0700, Guenter Roeck wrote:
> > > > > > On 10/02/2018 06:21 AM, Greg Kroah-Hartman wrote:
> > > > > > > This is the start of the stable review cycle for the 4.18.12 release.
> > > > > > > There are 228 patches in this series, all will be posted as a response
> > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > let me know.
> > > > > > >
> > > > > > > Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> > > > > > > Anything received after that time might be too late.
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > Build results:
> > > > > >     total: 137 pass: 137 fail: 0
> > > > > > Qemu test results:
> > > > > >     total: 321 pass: 320 fail: 1
> > > > > > Failed tests:
> > > > > >     powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
> > > > >
> > > > > What is the status of that powerpc failure fix?  What's the odds it can
> > > > > get into mainline soon?
> > > > >
> > > >
> > > > The fix has been -next for about a week.
> > > >
> > > > da08d8cb8cfc of: unittest: Disable interrupt node tests for old world MAC systems
> > > >
> > > > You'll have to ask Rob (copied) if he plans to send a pull request before
> > > > the next commit window opens.
> > >
> > > I wasn't planning to as it's just for the unittest and has been that
> > > way for how long? Why's the unittest enabled for a defconfig anyways?
> > >
> >
> > I enabled it to improve test coverage for stable releases. This is how
> > I found the problem in the first place. Are you suggesting that I should
> > not run DT unit tests for stable release candidates ?
> >
> I have now disabled CONFIG_OF_UNITTEST in my tests.

Well no, that wasn't what I was suggesting. I'll send it to Greg this week.

Are there details on how you run qemu?

Rob

>
> Guenter
