Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C581BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6E22184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548262953;
	bh=d8k5A5M+5hnFf377TYVMwEVSleiirFkpDaqCUda4nB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kBGHRxjDk63K1IAGVphWOa9Mm7pikM9qRNVavey5m5OMw6TxuRHHlCYHGta/JeiUN
	 552V75KRw1KhfV/Gb0u1IFF4r/EcLobnmjnBjxmM3U6dRpxJYGQEwsM1w3GLxq2//Z
	 Q6QnBBKBoQs+BGI4QSJU4qxGoybj/mJgbB/GnKTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfAWRCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAWRCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:02:31 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B99921873
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548262950;
        bh=d8k5A5M+5hnFf377TYVMwEVSleiirFkpDaqCUda4nB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DOJjpw8u+h0o3uqIN0oq9RsGlVDLoU/qCTW6IaMmYET3HzKPiMFvoQJY14ok5hN4q
         EGEVbzSYeRZER92ln1dZPnqdjOMKyTiQXNqwypkvyLmB5cWtnijU86LADmccdjUwC2
         XbwIk/ItcTNU29xOGCcIMqS8FlMbf98PZQMialL0=
Received: by mail-yb1-f173.google.com with SMTP id n78so1137590yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:02:30 -0800 (PST)
X-Gm-Message-State: AJcUukcJj8ILN83pc2T9n6ji48KzOYeZbnv/7oY7u9m3w6uohx3yAHRL
        vbd9l66HtaC2KbBGW802+arHPH3U01qizR+X77U=
X-Google-Smtp-Source: ALg8bN7xvcOPVRWn4+L0AUDQFa/iZNFQCjlfFUFyB9Fn/ryFCtqANUD8OZ2tLeWA/YQRE1Nru//TsrkJUj23N/MiRHU=
X-Received: by 2002:a25:2b0a:: with SMTP id r10mr2654675ybr.315.1548262949542;
 Wed, 23 Jan 2019 09:02:29 -0800 (PST)
MIME-Version: 1.0
References: <1548258476-16821-1-git-send-email-richard.gong@linux.intel.com>
 <20190123160019.GB4764@kroah.com> <CANk1AXR2K5j6iU1y8GGn_8agOUY6ca8xKXPrFGT5Ht6_La7VrA@mail.gmail.com>
 <e23f66a1-5cff-5620-7246-e894897b0d17@kernel.org>
In-Reply-To: <e23f66a1-5cff-5620-7246-e894897b0d17@kernel.org>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 23 Jan 2019 11:01:53 -0600
X-Gmail-Original-Message-ID: <CANk1AXS=jG5qG31rOwhNF=y1YowA97cvmsvBPr6JfRFEz8JEhQ@mail.gmail.com>
Message-ID: <CANk1AXS=jG5qG31rOwhNF=y1YowA97cvmsvBPr6JfRFEz8JEhQ@mail.gmail.com>
Subject: Re: [PATCHv1] firmware: intel_stratix10_service: add hardware dependency
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        todd.riffel@intel.com, Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:42 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 1/23/19 10:37 AM, Alan Tull wrote:
> > On Wed, Jan 23, 2019 at 10:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Hi Greg,
> >
> >>
> >> On Wed, Jan 23, 2019 at 09:47:56AM -0600, richard.gong@linux.intel.com wrote:
> >>> From: Richard Gong <richard.gong@intel.com>
> >>>
> >>> Add a Kconfig dependency to ensure Intel Stratix10 service layer driver
> >>> can be built only on the platform that supports it.
> >>>
> >>> Signed-off-by: Richard Gong <richard.gong@intel.com>
> >>> ---
> >>>  drivers/firmware/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> >>> index f754578..cac16c4 100644
> >>> --- a/drivers/firmware/Kconfig
> >>> +++ b/drivers/firmware/Kconfig
> >>> @@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
> >>>
> >>>  config INTEL_STRATIX10_SERVICE
> >>>       tristate "Intel Stratix10 Service Layer"
> >>> -     depends on HAVE_ARM_SMCCC
> >>> +     depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
> >>
> >> That's lame, what about building for testing?
> >
> > Do you mean this instead?
> >
> > depends on (ARCH_STRATIX10 && HAVE_ARM_SMCCC) || COMPILE_TEST
> >
> >>
> >> And is this needed now, for 5.0-final, or can it wait for 5.1?
> >
> > This change will reduce kernel size for most arm64.  It can go into
> > whichever kernel.  We can resubmit allowing for COMPILE_TEST.
> >
>
> I don't see how this is true? ARM64 has a single defconfig and
> ARCH_STRATIX10 is included in that defconfig. I don't see how adding
> this dependency will reduce the kernel size for most arm64?

Sorry, I wasn't clear.  By default it will be built in since there's
one arm64 defconfig.  But adding ARCH_STRATIX10 dependency here
supports users who turn off all the ARCH_* they don't care about in
their own defconfig that won't get upstreamed.

>
> Dinh
