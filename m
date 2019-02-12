Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA205C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967CD222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550003752;
	bh=xgjB4tBcTRaeShPv0xeqGqF5KleQWyPU2pH73C5XnY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RW35pRbSmGetr2XeCjtuZLgeyHGP4iCYt2UFmF1nsO3WzTQ0SEYpy1kXBr3PL5YQk
	 F9BJWhDoIpvwCoySCnD8L2p+//NiApz/GCjcAe/AIJNXdXRqJaxmP0yxMsEYQZD9EM
	 3Evgz6SUte+HOZZyGsx5hNrLKF7UistazQ2QTcrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfBLUfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfBLUfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:35:50 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916E3222BE;
        Tue, 12 Feb 2019 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550003750;
        bh=xgjB4tBcTRaeShPv0xeqGqF5KleQWyPU2pH73C5XnY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=skkl4+V5+/jDplhAwrIZqFuKe+YGrQakJWpR51wr/2VB39Xi/2g76+4/N8QEGm8Hk
         XjQeooV1l2v4HjUAi+8Gc50yQ5SfY+SlKmynCVLhg3x1DhT53eopK8UX2wMuat6BCO
         YQd33A0fg88psDvO/H7yswZ2G1oOrnx/WT2xZfyM=
Date:   Tue, 12 Feb 2019 20:35:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bgolaszewski@baylibre.com,
        Linus Walleij <linus.walleij@linaro.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: add GPIO support
Message-ID: <20190212203544.181b8c19@archlinux>
In-Reply-To: <CAJx26kXdap3oSBREDfakwaWMz4oKxy=oaagP1jo4grD=kqJ2hA@mail.gmail.com>
References: <1549653856-47409-1-git-send-email-justinpopo6@gmail.com>
        <20190209170042.69a78684@archlinux>
        <2e692086-4be5-10ea-34b0-4444995c4275@lechnology.com>
        <20190211200557.7648d447@archlinux>
        <CAJx26kXdap3oSBREDfakwaWMz4oKxy=oaagP1jo4grD=kqJ2hA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 12:17:37 -0800
Justin Chen <justinpopo6@gmail.com> wrote:

> On Mon, Feb 11, 2019 at 12:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 9 Feb 2019 12:56:11 -0600
> > David Lechner <david@lechnology.com> wrote:
> >  
> > > On 2/9/19 11:00 AM, Jonathan Cameron wrote:  
> > > > Nope.  This is a state lock used to protect against transitions between
> > > > different modes of the IIO device (buffered vs polled), it
> > > > isn't suitable for general use.
> > > >
> > > > The driver should be modified to handle that correctly.
> > > > We have iio_claim_direct_mode etc that deal with the case
> > > > where a device can't do certain operations whilst in buffered
> > > > mode.  Note it can fail and should.
> > > >
> > > > Seems there are more drivers still doing this than I thought.
> > > > If anyone is bored and wants to clean them out, that would be
> > > > most appreciated!
> > > >
> > > > If you need locking to protect a local buffer or the device
> > > > state, define a new lock to do it with clearly documented
> > > > scope.  
> > >
> > > Just as a reminder, there is a use case for this particular
> > > chip that requires buffered mode and direct mode at the same
> > > time.
> > >
> > > https://patchwork.kernel.org/patch/10539021/
> > > https://patchwork.kernel.org/patch/10527757/  
> >
> > Thanks, I had indeed forgotten that entirely.
> > So it should have a local lock and not take mlock explicitly at all.
> >  
> Thanks for all the feedback.
> So If I am understanding this correctly. I should create a local lock
> to synchronize three different type of transactions (buffered, direct,
> gpio).
> I do not want to use iio_claim_direct_mode because that doesn't allow
> simultaneous use of buffered mode and direct mode, which is necessary
> for this driver because of the above mentioned patch.
No, you should create a local lock to do just one thing. Protect
the buffers used in those transactions.  There is no need
to protect anything else explicitly.

On some devices there are multiple transaction writes, but I don't recall
that being the case here.

Jonathan

> 
> Justin
> > Jonathan  

