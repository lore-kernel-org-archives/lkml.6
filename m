Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A0C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95017208EC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP4+AzZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95017208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965250AbeF2Txg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:53:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40492 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935467AbeF2Txe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:53:34 -0400
Received: by mail-pl0-f66.google.com with SMTP id t6-v6so4936936plo.7;
        Fri, 29 Jun 2018 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OX+gJoU/3f1bugbzEowr5sY8pTSFnmmAu4CwbTx7ZZA=;
        b=vP4+AzZA/RUCH5HTkX3T0D6or2u55BSNbXtFF46bJ3B3Gr1E/LkboulP3djA9ts40d
         BSoAPhvVFDna+LmlvhypGkDHa8alWhm15vKwss8jiZkuLSlMZdIUN1G7Wz/0+8aABVHm
         5CiROtRMJ2J3qh5zNcmfZ5+gv1M67Xccn+EU70DM18DnczmMoGhEHNt5Zj0JmllhUD3Y
         gpD51YxZAq0G0fDQdiBlqxISF9qV1fjH6GC0j1+tuaGAYLw7U10h0X7sz7iAN1KnrbEv
         Wh9UouPWTRdBXoLdIs+EUnOdwG4qKB7fGojbPfa1SBoy3SW1dihm5iQwMjRKwEPcCXBd
         sY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OX+gJoU/3f1bugbzEowr5sY8pTSFnmmAu4CwbTx7ZZA=;
        b=nK1MwomASZ+X8Uks55yNN18Q/lSN8KOn2z8MfUp6meufiTeXfWFoJB40c9FE3Whq+g
         yNb4I0anwiW63/rMsCKa6sivZ4UBRW90sWXUOltk4xofPgphyiSB5GHTILacudPv7lck
         1tHpFMW/Kw3YMIjPAoaSArjhqUc0o+ijKZk2RuVvDkL9GM0Xb2sN+bs3vsx9QX6U/x90
         QbrV+T07RYCDsBbDbuMdYsfQuAaw4T0pVzT/M2QWyQG83tW91XagGjXtJviQeDhaANqx
         TCu3EKPHCULL0C3DZ9zdbhWD2NRyjBBzjSQ4erkQiL4u/6V2A6Por91/sHVwe3BIohUs
         Psyg==
X-Gm-Message-State: APt69E21kbYAABnCN7Mvm+cpMz7tOyecE0/I4BqyHu6W9j3ppDaF7BIL
        92/Hm4cQCT9ckLJHlQMfJYt2lvTcsi2gRn8u6Y9NpZkK
X-Google-Smtp-Source: ADUXVKI7sK1HXdC3OC1yvkMzve6adHttJCk+H/1poM1rJLSmYRIL5pGRHMLEyOcgaJMV1ztJLTo0u+ZGTXxsQm3vTVY=
X-Received: by 2002:a17:902:14b:: with SMTP id 69-v6mr16330685plb.184.1530302013644;
 Fri, 29 Jun 2018 12:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
 <20180628225857.GB1231@thunk.org> <CAN05THStuq+RLzb_oNiD2TvN6MjMMnTdCxNiHuYWHRueQ46=_A@mail.gmail.com>
 <CAH2r5mui9WLBC6ne+iqVeYDGKEMKTabHPTf57STM9_aPGfM0sA@mail.gmail.com> <20180629044440.GK19934@dastard>
In-Reply-To: <20180629044440.GK19934@dastard>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 29 Jun 2018 14:53:22 -0500
Message-ID: <CAH2r5ms3zp8s48FcPYCPJRZCR9mq=XMc=qOUG8N85jNpL1VRwA@mail.gmail.com>
Subject: Re: config files and how to have persistent Linux kernel Driver/File
 System configuration info saved
To:     Dave Chinner <david@fromorbit.com>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 11:44 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Jun 28, 2018 at 06:24:59PM -0500, Steve French wrote:
> > On Thu, Jun 28, 2018 at 6:21 PM ronnie sahlberg
> > <ronniesahlberg@gmail.com> wrote:
> > >
> > > On Fri, Jun 29, 2018 at 8:58 AM, Theodore Y. Ts'o via samba-technical
> > > <samba-technical@lists.samba.org> wrote:
> > > > On Thu, Jun 28, 2018 at 05:37:15PM -0500, Steve French wrote:
> > > >> Ronnie brought up an interesting point about the problems consistently
> > > >> configuring file systems (or any Linux module for that matter) so that
> > > >> reboot doesn't wipe away security or performance tuning changes.
> > > >
> > > > In general it's considered best practice to make the file system
> > > > auto-tune itself as much as possible, because the sad fact is that
> > > > 99.9999% of the customers aren't going to bother to add any tuning
> > > > parameters.  So there hasn't been a push to try to create something
> > > > more complex, because it's generally not needed.
> > >
> > > True, but in these cases I think we are more looking at server or
> > > mountpoint specific options than
> > > actual fs tuning.
> > >
> > > For example nfsmount.conf can be used to say "only use NFSv4 when
> > > accessing server abc" etc.
> > > For the case of CIFS I could imagine that an administrator might want
> > > to set "disable smb1 protocol globally"
> >
> > Or perhaps
> >   "disable smb1 on " ... various public networks but allow it on
> > private networks
>
> The way the policy is configured depends on the mechanism used to
> configure the policy. If it's a sysctl or a mount option, then we've
> already got everything we need. If it's something dynamic in sysfs,
> then I think you're on your own.
>
> FYI, I have been looking at making sysctl be able to work on /sys
> rather than just /proc/sys (I have a 10 line hack to enable it) so
> we could re-use it with custom per-mount ...
<snip>
> So, really, I'm probably just going roll our own sysfs config file
> mechanism into xfs_spaceman (probably based on the new config file
> parser we have for mkfs.xfs) and hide the mess with a nice, simple
> xfs_admin interface for udev to call. i.e. roll our own :)

Since we don't really have a registry, or equivalent (unless Samba is
installed),
probably will have to do something like that for other file systems too :)
Am now thinking that we need an "smb3_admin" (or "cifs_admin") tool,
ala Samba's "net" (especially "net  conf setparm <section> <parameter> <value>")
because it makes it possible to configure the ultra-confusing /etc config files
and /proc and /sys config pseudo files more sanely and less error prone.



-- 
Thanks,

Steve
