Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE821C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB267218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOyGvpgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfBKRWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:22:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38944 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBKRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:22:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id v12-v6so4750704ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vL4jmM0hS8F5hgHo7I/WUVtBsnV3MYPekobBSM1ix2U=;
        b=NOyGvpgJuOAKIjXHocjzholA6G9mp0scUfECvd1ld5eTRXNh5z04qwbabko5mBDcy6
         zk6Bpm4bF6gzzWmQ+zvawi0nxSHpdTMgzj4Mmm3PvufK2LNIR/qa5pmbJZIHujgNCuV/
         6KnF5pEoS9Dm/XR/4wKdd1HNaXCz9u0MxuA/ypLaVf3f1b0ORYr3x4D71aNHMJydecjh
         b8CfJNBtpwz5/ucu6ZCQxnrHnOFRfLzpJT6WvzSANdwOlKcl70UkOHqN2DSWHBiR4pWj
         vN4xbmgwOVrZnzL03fqlnPSl3k3yuO+sfC4JcWElAuh1jjoqyKUr+PxIFzWVpPQifvcL
         0Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vL4jmM0hS8F5hgHo7I/WUVtBsnV3MYPekobBSM1ix2U=;
        b=Y4X8NTDAdz0+7hbc6tHI0K/RYZ9v/71t7kGLjhCaD1mGn8ZwDD4jmWKNqJ2BkpGwch
         UyByVWVH7Ue8sBU7tfDmDwYELEh8Ju6bY24aiX4TJJ9BzDFh/YkmO8J/DDPCY3Ll+8gv
         /mnVfXx5NLch6GXMpZ0bVsmmkGHkNoqO8TJZozql21rDZGWk9rZmFo4RUC2quzWsPF4N
         XWqn7atr+TBvyxsb7oXL5ZRxmRvxlGBun/0f1j1GpdLdkFGiHOW4sGYH+smcmwQ9rYUt
         y6tn1Ub36RUgFDk0KT3lR6aROlBU/S/xToTo1DaXySjVylvM1XZ8Jf6dhab6XVZ4SzB+
         QoJg==
X-Gm-Message-State: AHQUAua0Q1iHp9FexAlPjmJb6yxiJ6pnKZFO0jOfQhkDMU6D9UYCvg2s
        mG8INdvdijw/OpviDxNB+5yXlGgRBmJNQygMwuW7QmFpL/Y=
X-Google-Smtp-Source: AHgI3IZuQcD2kenUXrjFa74H0PPrw6kP5/o3A8lKzETSeKLriC+Mtsw/tSrdRxTkx8kNPlwMxZHs8nappRdx+x1XO74=
X-Received: by 2002:a2e:750a:: with SMTP id q10-v6mr20113013ljc.39.1549905749193;
 Mon, 11 Feb 2019 09:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
 <20190211154044.GA16105@kroah.com> <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
 <20190211155734.GA18078@kroah.com> <CAFqt6zYTkUwU144+pzoLz7kcjQz=j9vQ-H2NLthA_3hOzCBfdw@mail.gmail.com>
 <20190211171130.GA13294@kroah.com>
In-Reply-To: <20190211171130.GA13294@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 11 Feb 2019 09:22:17 -0800
Message-ID: <CAHRSSEyjLkQvZjW83Vf3HqeEE1uKw2W1VDBg_78A07YzAFPjBA@mail.gmail.com>
Subject: Re: [PATCH] staging: android: vsoc: Remove VSOC_WAIT_FOR_INCOMING_INTERRUPT
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alistair Strachan <astrachan@google.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Alistair Strachan

On Mon, Feb 11, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 11, 2019 at 10:15:18PM +0530, Souptick Joarder wrote:
> > On Mon, Feb 11, 2019 at 9:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 09:21:19PM +0530, Souptick Joarder wrote:
> > > > On Mon, Feb 11, 2019 at 9:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> > > > > > As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> > > > > > ioctl. This functionality has been superseded by the futex and is
> > > > > > there for legacy reasons.
> > > > > >
> > > > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
> > > > > >  drivers/staging/android/vsoc.c          | 5 -----
> > > > > >  2 files changed, 12 deletions(-)
> > > > >
> > > > > So userspace is all fixed up now and this ioctl can be dropped?  Any
> > > > > pointers to the userspace commit that did this?
> > > >
> > > > I am not sure about user space part.
> > >
> > > Then we can not just delete the ioctl :)
> >
> > Agree, but where to verify the user space commit ?
> > Any pointer to the source code path ?
>
> Please work with the android developers to solve this.  It should be in
> AOSP "somewhere" :(
>
> good luck,
>
> greg k-h
