Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BDC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ACC27AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BnWSXRm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ACC27AB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936326AbeF2Ayr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:54:47 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34716 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbeF2Ayq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:54:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so5560936lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUplO1YDLPCIwiehlJJhVY8ZRKx4hS1xrtcVpKSstIA=;
        b=BnWSXRm/Wpw3ww0uXoziCNCMO92RxcY/mjn/pnK34Tnna5XsRVJLXb3EteZpwHmtjC
         R+g/HegiKrinHE6MDrIS56pDVED/+IZv1n8P48Eo51J/YxyUv80gNtZABhZmRol+YSoN
         iKYFv055egy0KdtPaaSjf0UR1qIRW/YUqTqAcczYhEPdNVfn65r+xxxMN/tJdQtXJqVM
         o53cjPG1rX0qXXvAZ3n4DX8s34cRDYq3FxK/kMu+iYoZ1O4+Ku9UZG+Zoj6Si0+DZbGc
         XdECA/5kVCjSuKT/LWWD0IiaQ6EoBD6KjWWkm/2YqwLL97Wt8aOQsUM46VKPmovHa0YL
         IRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUplO1YDLPCIwiehlJJhVY8ZRKx4hS1xrtcVpKSstIA=;
        b=E7vI8VeAaQJTvY3hmCzlddQ0xtFshRaAQRH5sSixA5T3G8O+/MSqfI4uDIHEtR7t0J
         clL0Mr3lhomW7wucJ5ff4/OCACAx5mG4CtP3H4eCd0e5hlensyDQHQ9+9HZMvznhPi4q
         THAIt9HRpLjKHj9zpKMoUzzOTp9Kg23zi6n/I4Sb3iB7RCZMRQqHtwmoLwKyHaO1BDKY
         OmJ20zDLwdOnsUgCVomAN0rb2mjapFcMxTI0sODEDdHZ0LWrGHXbFNcClkc3e60gteeD
         Y+yW8l2fF4X1z113F23NdgRxsDcBLdCim4s1tNqXj6kGAlCg2rDJZ0mrY9VmQ3FNBqC3
         POig==
X-Gm-Message-State: APt69E2OykJNh85KSKM/t1BrCu0+EihAmeC5e9b5LMUdpCHKG8V/kWga
        zNJg+KDMEvz3FQ6Z8wkZ94z69uzTUL6S4mba83xt
X-Google-Smtp-Source: AAOMgpfOPtigvLqkBJ4+4kaCYXxmXqJYYC5O4oyyskLkDG8qqNGRmij0WiRmrQS5JWFwdv8xpDRPVGOYmut4ZxihqfU=
X-Received: by 2002:a19:a892:: with SMTP id r140-v6mr8090750lfe.39.1530233684556;
 Thu, 28 Jun 2018 17:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com> <9d5d0cb7-5875-0814-835b-097db650b6a1@tycho.nsa.gov>
 <CAHC9VhQ7ep3HSw8iqWBsiW0hhZ-drVtk7bW1rA1uAyUrbm3PqA@mail.gmail.com> <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
In-Reply-To: <CAHC9VhTcncUn3CgAgG-FiXyyoNiq5DdHF1cSYJeWpu8PvRXucw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 20:54:33 -0400
Message-ID: <CAHC9VhQxOKk21i0MBMOKr-A7nf+vSbi0_Hxfa8dTDPDdbMyUGg@mail.gmail.com>
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
To:     jannh@google.com
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        security@kernel.org, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 8:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 28, 2018 at 8:23 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 26, 2018 at 8:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 06/25/2018 12:34 PM, Jann Horn wrote:
> > > > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > > > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > > > stall indefinitely, which can block fsi->mutex if it is held.
> > > >
> > > > For sel_read_policy(), remove the locking, since this method doesn't seem
> > > > to access anything that requires locking.
> > > >
> > > > For sel_read_bool(), move the user access below the locked region.
> > > >
> > > > For sel_write_bool() and sel_commit_bools_write(), move the user access
> > > > up above the locked region.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > >
> > > Only question I have is wrt the Fixes line, i.e. was this an issue until userfaultfd was introduced, and if not,
> > > do we need it to be back-ported any further than the commit which introduced it.
> >
> > Considering we are talking about v2.6.12 I have to wonder if anyone is
> > bothering with backports for kernels that old.  Even the RHEL-5.x
> > based systems are at least on v2.6.18.
> >
> > Regardless, I think this is fine to merge as-is; thanks everyone.
>
> FYI, I did have to remove the "fsi" variable from sel_read_policy() to
> keep the compiler happy.  Please double check to make sure your code
> compiles cleanly in the future.

I realize I didn't specify this above ... I merged this into
selinux/stable-4.18; I'm building a test kernel now and if everything
looks okay I'll send it to Linus tomorrow.

-- 
paul moore
www.paul-moore.com
