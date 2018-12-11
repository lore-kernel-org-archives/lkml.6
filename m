Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E73C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D6D20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="01WSNWk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLKX04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:26:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42856 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLKX04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:26:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so12096667lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzICyHmd0JEn5UWsVCk7go+fTmvEQXBnI3wfUaeZzo0=;
        b=01WSNWk8LJUMV7S71iFqrRfVJtWrveC8bt6ldAQ/nnO3M9iuzrFYXGTQ2mDpis9d1X
         2pQ+lJNra+KD5jgurk0n8IVjxxX6pBl/SNZinhYRjZL5swpmb0XlCeDo75+7451n86JB
         3y65h2W5Kp1Ctax6gnidPUfQCsUxD9zlLzoVH1i+kCLj2tdKVlbmJ0G4O1KTAfiPHDF+
         cVeVag/awxcFwyeSvrNVYjDlkyXtKJZ52fuyY7DHw4eNAdSGSaQU5iT0ib1tsYohIOVo
         ml6BBmeGp3OCBEMsUNoxlILLEGj5NbR664nRL1sPACm/NXR08spLPaPhyI6/jHDs7H24
         IlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzICyHmd0JEn5UWsVCk7go+fTmvEQXBnI3wfUaeZzo0=;
        b=RpR2Hv9V87d+d9pKo1P5g+CK2Hwmhk8ZOsxG2qG5xMnnu/m27IcIJwcossuzv7xwTR
         h22D6rxXI0X4o13zOrzQqTA2hRmCXPblwMjG+IcCvqUjyvHrAPW/uonI25vL9lSdLaRk
         gI6oEbT6jZmrGsetQwR+p8OMRf8T/qdJrHHGyb8AZGcpWjWmKicitNuiNKpgoUc620dL
         r+i9obCBvyH7TIc+h+kSNaAMZjcANlPKO0ir47MqHQXZ53jO+IGvmk4RCgHhBoPlxV9d
         XVm6frGwY4a9FmUgt3EK660ubsyJBz/O3iVlgJb5jgqhNjQtxjJsOKHsUdTY3m823Zh0
         W7aQ==
X-Gm-Message-State: AA+aEWa+Sm084Vel04298OX1Oe7NAhL5KLkbFBcqTB/A9aJoVba6BRF4
        BYyae6IqEdpDU1+cBaZCSUjuA9FEA8Vu1diucIoc
X-Google-Smtp-Source: AFSGD/VFrrs1mZDaWPFiePS1U6TxyutSdhbdsYIqi2zRu0pgPGRaQUbaF/wfO/tc35sQTOtXVKgsRxbT8g0UgQZOG5g=
X-Received: by 2002:a19:e601:: with SMTP id d1mr10839000lfh.71.1544570813365;
 Tue, 11 Dec 2018 15:26:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <CAHC9VhRqMt2k+pL7YF0MaZQfXZzttyHAXBJhHH56Mvswii4EKg@mail.gmail.com>
 <20181211224107.vdeksnc5bd5bb7mb@madcap2.tricolour.ca>
In-Reply-To: <20181211224107.vdeksnc5bd5bb7mb@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Dec 2018 18:26:42 -0500
Message-ID: <CAHC9VhSkKqdm=q5r4Y0-kEg2j84-AG5omo6frfORXVcJ_orUaw@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 0/4] audit: config_change normalizations and
 event record gathering
To:     rgb@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, viro@zeniv.linux.org.uk,
        sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 5:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-12-11 17:31, Paul Moore wrote:
> > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > > Richard Guy Briggs (4):
> > >   audit: give a clue what CONFIG_CHANGE op was involved
> > >   audit: add syscall information to CONFIG_CHANGE records
> > >   audit: hand taken context to audit_kill_trees for syscall logging
> > >   audit: extend config_change mark/watch/tree rule changes
> > >
> > >  kernel/audit.c          | 33 +++++++++++++++++++++++----------
> > >  kernel/audit.h          |  4 ++--
> > >  kernel/audit_fsnotify.c |  4 ++--
> > >  kernel/audit_tree.c     | 28 +++++++++++++++-------------
> > >  kernel/audit_watch.c    |  8 +++++---
> > >  kernel/auditfilter.c    |  2 +-
> > >  kernel/auditsc.c        | 12 ++++++------
> > >  7 files changed, 54 insertions(+), 37 deletions(-)
> >
> > In order to make sure expectations are set appropriately, as we are at
> > -rc6 right now this is not something that would go into audit/next now
> > (assuming everything looks okay on review), it would go into
> > audit/next *after* the upcoming merge window.
>
> I agree it is a bit late for this.  I wasn't expecting it to go in this
> one.  I'm filling the queue since I'm blocked on other review for
> ghak81(5.5wks), ghak90(5.5wks), ghak100(3.5wks).  ghak90 missed another
> merge window.

As discussed previously, GHAK81
(https://github.com/linux-audit/audit-kernel/issues/81) is something
that I consider part of the audit container ID work (GHAK90).  I
believe it's time to stop treating it as a separate issue.

The audit container ID work, GHAK90
(https://github.com/linux-audit/audit-kernel/issues/90), is where all
the dragon's lie.  That one takes a good deal of time to review, and
quite frankly I'm really the only one who seems to be looking at it
anymore, so it takes a bit longer.

Beside the fact that GHAK100
(https://github.com/linux-audit/audit-kernel/issues/100) was marked as
a RFC, I've been waiting to hear back from the VFS folks if they are
comfortable with it.  Miklos Szeredi in particular had some concerns
and it isn't clear to me from that thread that his concerns have been
resolved.

-- 
paul moore
www.paul-moore.com
