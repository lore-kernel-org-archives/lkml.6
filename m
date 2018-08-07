Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4904C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808E6216ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLpLeNmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808E6216ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbeHGTCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:02:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37070 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbeHGTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:02:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so8860689pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvjdyjZFysYghJFwZIyIQ9LDMH4n0lBwqwbJTUJTCBY=;
        b=mLpLeNmQ4EFaCigGlTjVRng1VJioQ1kyTzhHl6cEW9wrCBppl7KYfn6+fNDwD9MKid
         bGZtlzKD0xZ0AtJj9TgYiMZU/pKrS2UUc+MftRbHdjkJzwqjhd5NzPVfZp7A6exMjRyc
         wXxrQF8m/6j1p7zIRiIUfarycSR1FYIQqZ38K+iq6LRW1VmElyGkaeEt94K5cOA/k5NO
         pgyO0yQLTV7bsE2P8bSTMxpAtOs4ts+e2klopry2Rn+7PXHRoY2rUXE6n2kXB/UPcYI6
         uzdCFj1O6UhQiayXuOW1PGwoM5BK38vuEFygBNML1Ei4sxb2xhhX7Io0KvoQEwXJ0sF7
         y8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvjdyjZFysYghJFwZIyIQ9LDMH4n0lBwqwbJTUJTCBY=;
        b=isaW7apTbb52J6doFPWrYYo7/2mgdVxezYrYRxWJkqKXou1lPmFxeXGAZoFDjar1ig
         NUAMmJcRDKYqgsZmqHPyzOgRCCMLJCTKerMuzLnDx13bFtbj/gXySaoow3INWvROTYNe
         7HlE1tYg0Dzipu0tQH0AKnV+BVrFxD0ftZTx+27fJLGcrfa5tEUsfYY4jHifCt32BOWk
         Itr79FiSmk3nfPQV2+ZUrlN2NLAYPbyqNCX7oJkv6AeqDY/7drp+xhfFEoNub25qMplT
         z9vMd+4Fi8TGXIVm8Lto58i3q0+1JxjvCtXL5gpgPD5p22QYentxh5ArLstmLQS7gb6y
         X15g==
X-Gm-Message-State: AOUpUlGaopWd7zjeBNVWCRa1x9PHaxjiFzZ3F3cVB7boGI+A9krGDs8o
        81EJJunxJSp1M/H/Ey/i9QqZrQcIr2SDwW2QbNbFuw==
X-Google-Smtp-Source: AAOMgpdjaobo9pzHe+NBUnpZn2K7gnzFQ46BikPHiFTgYIdh3frgVf1+mLvET+dC/3IGO5FOOBT2wawNiPYNELCVYuY=
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr19500676pgh.10.1533660417971;
 Tue, 07 Aug 2018 09:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180803170550.164688-1-ndesaulniers@google.com>
 <tip-208cbb32558907f68b3b2a081ca2337ac3744794@git.kernel.org>
 <CAKwvOdmxaE7p-fgaaeCE17bbTf0iYmHQgWT2D6FM7U5fwUoN1Q@mail.gmail.com> <alpine.DEB.2.21.1808070924170.1788@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808070924170.1788@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Aug 2018 09:46:46 -0700
Message-ID: <CAKwvOdnXqw_ZXD2tnPYdVdRtdKqi4hK5mLZ7ELyXMhrbNzyWfw@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/irqflags: Provide a declaration for native_save_fl
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     hpa@zytor.com, david.laight@aculab.com,
        LKML <linux-kernel@vger.kernel.org>, jdelvare@suse.de,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org, sedat.dilek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 6 Aug 2018, Nick Desaulniers wrote:
> > On Sun, Aug 5, 2018 at 1:33 PM tip-bot for Nick Desaulniers
> > <tipbot@zytor.com> wrote:
> > > Cc: stable@vger.kernel.org
> >
> > Not sure if this was going to be cleaned up in an automated way, but
> > looks like this commit message drops the comment to stable as to how
> > far back it should go:
> >
> > # 4.17, 4.14, 4.9, 4.4
>
> The Fixes tag is enough. If the upstream commit was backported, then the
> tools of the stable folks will find it and know exactly how far it needs to
> go back.

Oh, cool.

> > also, there were tested by's reported:
> >
> > Tested-by: David Laight <david.laight@acuab.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> Which came in after I applied it....

I've seen other maintainers revise commit messages before sending pull
requests along, but I guess that's problematic as anyone else who has
pulled before the revision would then have a merge conflict.
-- 
Thanks,
~Nick Desaulniers
