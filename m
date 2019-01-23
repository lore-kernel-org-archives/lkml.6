Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A670CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5E0217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548261467;
	bh=1VnJwqkZ2I2UYMQmR1pHs69siJ9v86CnX0e8IyvDt7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dKGkdZBU4BKbrYRPo/5g+Ytt+5RPRBzXAWjN5QQ5p1krW2qghMmrVDOiDijcUhoDT
	 Er9i9cy8K0VctmJU12GIcpzSM4E+3pZLfLlvILzCa8H2E2n82FsU5EjBDBIngGUAMo
	 szhza1NpAHntPmYkDNfh2+sYLQ72kK8XPcIh3gcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfAWQhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:37:45 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658AA21855
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548261464;
        bh=1VnJwqkZ2I2UYMQmR1pHs69siJ9v86CnX0e8IyvDt7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=er/9zmxQTMYWi3Vl6+q4EXXnH5n+dT2bxkkSlxlw2SssWwpRdXJbkCeOXeU3rYQPb
         l5dTmKMv59VkxHWfZ+/uzEcx4fohOMdu2b6gzbxNzeRSnpG2CKr/phk+EbHkaM4GsO
         a/XvxjCBrXjPGxpZ1ZWFCUYqOUl81MlqzDHL7w50=
Received: by mail-yb1-f176.google.com with SMTP id n78so1101121yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:37:44 -0800 (PST)
X-Gm-Message-State: AJcUukejxrlSomtH0hOTtHVzszyJQxIDtmqI6+8SvG3pmXoWGBY2G06C
        fMUIVPINF9JTChairRIn0Jism7gwqRasdV/N8cE=
X-Google-Smtp-Source: ALg8bN71mCKMEurrwC0gG7SesHC5j6swNxaU76j7A3/0Bvn95A1rglXV8/8RLSwoMcJL3EMOkKS8MGB4MuIbxSA/IpE=
X-Received: by 2002:a25:d7d1:: with SMTP id o200mr1431627ybg.222.1548261463597;
 Wed, 23 Jan 2019 08:37:43 -0800 (PST)
MIME-Version: 1.0
References: <1548258476-16821-1-git-send-email-richard.gong@linux.intel.com> <20190123160019.GB4764@kroah.com>
In-Reply-To: <20190123160019.GB4764@kroah.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 23 Jan 2019 10:37:07 -0600
X-Gmail-Original-Message-ID: <CANk1AXR2K5j6iU1y8GGn_8agOUY6ca8xKXPrFGT5Ht6_La7VrA@mail.gmail.com>
Message-ID: <CANk1AXR2K5j6iU1y8GGn_8agOUY6ca8xKXPrFGT5Ht6_La7VrA@mail.gmail.com>
Subject: Re: [PATCHv1] firmware: intel_stratix10_service: add hardware dependency
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Richard Gong <richard.gong@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        todd.riffel@intel.com, Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:

Hi Greg,

>
> On Wed, Jan 23, 2019 at 09:47:56AM -0600, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> >
> > Add a Kconfig dependency to ensure Intel Stratix10 service layer driver
> > can be built only on the platform that supports it.
> >
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > ---
> >  drivers/firmware/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index f754578..cac16c4 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
> >
> >  config INTEL_STRATIX10_SERVICE
> >       tristate "Intel Stratix10 Service Layer"
> > -     depends on HAVE_ARM_SMCCC
> > +     depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
>
> That's lame, what about building for testing?

Do you mean this instead?

depends on (ARCH_STRATIX10 && HAVE_ARM_SMCCC) || COMPILE_TEST

>
> And is this needed now, for 5.0-final, or can it wait for 5.1?

This change will reduce kernel size for most arm64.  It can go into
whichever kernel.  We can resubmit allowing for COMPILE_TEST.

> What
> changed to require this?

Nothing, we just didn't catch this.  We're used to having our own
defconfig.  Not used to having a single defconfig that is shared.

Thanks for the review comments,
Alan

>
> tahnks,
>
> greg k-h
