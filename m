Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E5E218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4CizP3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfBKQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:41:10 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33621 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:41:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id q12so8305718lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5QXy8PbmdwL5FAP0B9HeCTlPcrfqBeaIAS+2Mbh+lk=;
        b=t4CizP3vk/tgF27U54YVxgsuem0vpOdlqL7qB/f71mUNKeyyI3tmFGZa34ZLuEvN4j
         RMI41weiQrCLaONohHQukDqDPFG/AZ4G/V1KhR2bfDjqAnISSs/FUWcYB/qnantP4mVr
         aE1xsPcQZFP97Qh51w9UwZ1IKZSYzDm1RCzdxxfFTtmGEtidTnKwTPNChJFHRfC/5NyN
         vMuhe9/mfaoLwuG1YpgUx7MktRh0iDrxk43QvffCng5DsSM0ctGepBIXNWusXnEZxZrb
         wCy/lKAEIRam1uFmTVGcQ9jEq2C1vL+zTMWk2P4HWv2cFjqdctzVFCkyZandS/5aR+Q2
         r6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5QXy8PbmdwL5FAP0B9HeCTlPcrfqBeaIAS+2Mbh+lk=;
        b=EMk0VYRL/8gHgx2BHwLEu/jfLwFA3btUHlEqSlNfTPnfJZ+tg3ShkXmminfan60EBy
         oQoW9Yz4lnhE51a8opL3TWXpkkzpv8maKSZ6Z7taZMGhPo8ELhLabhgbQOhu2kdJYUUG
         FOMeCMG/1tPS0a0YkDdqDN9v63Qc4Zy3yT10/tdXD0PgHxxJzvEZFF9V27MjfwdYyFZo
         1lBS9Gl0YzyfsotZmYGJmHLunJIoaxKUk4kuSq/HQgV2ZTfAPNozP6R2LmLQwYwheNtB
         K0yd/cwU5Png0r6iZH6UUdTWL3AkwMMwhQGxuRLNiJXQcfKWJ2TREL9+5uHlOHIlNWQ0
         2LBw==
X-Gm-Message-State: AHQUAuaztGl6MWw0+KS2g0kGzrUggFw6OvzjK/2LIQzlyxZEXvw5V5AC
        DMmum/cYwe3DqKx5U5WO1b/Myli3afkxf0ZCfVG+mQ==
X-Google-Smtp-Source: AHgI3IaNoqmFJKhiRygVVUN78T5v9TXLl6KZqAbJcX+9LYIFOvuxL2aTU0kfgLSoAsm1c4VeAg9Jj3HGrplJ7Lp9Rzk=
X-Received: by 2002:ac2:5496:: with SMTP id t22mr11465194lfk.31.1549903267990;
 Mon, 11 Feb 2019 08:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
 <20190211154044.GA16105@kroah.com> <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
 <20190211155734.GA18078@kroah.com>
In-Reply-To: <20190211155734.GA18078@kroah.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 11 Feb 2019 22:15:18 +0530
Message-ID: <CAFqt6zYTkUwU144+pzoLz7kcjQz=j9vQ-H2NLthA_3hOzCBfdw@mail.gmail.com>
Subject: Re: [PATCH] staging: android: vsoc: Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 9:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 11, 2019 at 09:21:19PM +0530, Souptick Joarder wrote:
> > On Mon, Feb 11, 2019 at 9:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> > > > As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> > > > ioctl. This functionality has been superseded by the futex and is
> > > > there for legacy reasons.
> > > >
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > ---
> > > >  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
> > > >  drivers/staging/android/vsoc.c          | 5 -----
> > > >  2 files changed, 12 deletions(-)
> > >
> > > So userspace is all fixed up now and this ioctl can be dropped?  Any
> > > pointers to the userspace commit that did this?
> >
> > I am not sure about user space part.
>
> Then we can not just delete the ioctl :)

Agree, but where to verify the user space commit ?
Any pointer to the source code path ?
