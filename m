Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A6EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A91C2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zo9dTUY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A91C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeKSDwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:52:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34504 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSDwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:52:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id h25so5162794oig.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:from:date:message-id:subject:to:cc;
        bh=ipP5bLFNn/m+NYOIEmQzikbcbBVpdYaPo4c3C4LafeU=;
        b=zo9dTUY0UrLW35KPmRdHaaVpvtXEY+uYJJ/LVI9sQ2su4UvGxuKUNz0n3g6z0c/f3K
         K5Zf7mJHtznO4FE67Xj6IL4+ZMiS7ll0H+SjbGM+gk3N+1eBSAW0kMrg1u7Ju4rCN+c1
         lSJIV9MGTDlZBvJS8S/DrSBR/IlcTGA2iGkGQXkS0gdwZyRc/m1Mfz2BcQJC8WKCWziw
         1CnS7hwgF4+bs6H+ah11yaorB8DhhFD3AA8OFTisNxzv0v37gE3r17ktcLZKVd2pXxyD
         sMCdqdg38HjfKRcS4S8cBgsi9WIKZfifNXJUrt0DFxFlZ1P3LhpDz8gBsbA/QDZNOd0C
         zFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc;
        bh=ipP5bLFNn/m+NYOIEmQzikbcbBVpdYaPo4c3C4LafeU=;
        b=UPFGssC1zS3J82qQk3F+X4W4vISaWxVDjC7wXZOTxSyNVIzUtRWEPOxZULfS6uZiIk
         lqIva5YPr/u5gtgwkmIvXOQ2ElmbSAar0vflBUixPdkTFlMroIOoxHndm7j4/+WXh3yO
         wwj3rtso1LIItqX+Ly+hICo0JZDbVlHXtajbdOH3ele9ZuhovVNEPmZk7/NVN4e3zkpV
         8E7WD1PcLH7JTKfdNCGN0/M/N1Q4f45q+d9zQSmKFECddodzTJwLes8L6WrinSPn032W
         Mxz/vqC1xTeByMnCPPUuCq9xKOmZ8alAMd1p9p+GosrSk5+pzG4IFKEdr+bFiKdidk9j
         T4zA==
X-Gm-Message-State: AGRZ1gKmiqlPhw+KqON8cR308goXLtFNMy+3EFfLFKJCkyYUJK1Q2wV6
        vYOcnD4mPzO5PmP9OPExJvDTSVb9vs1KlPZPTilJTQ==
X-Google-Smtp-Source: AJdET5flYSvvHkyDDbHYWl3SiS5BIoSvx7mUPCvgdYNfkGDScSeI+NJrC05vZ/DqIeo8Dtqh5wzU4Db3pta32EQmRcA=
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr5654889oig.0.1542562303305;
 Sun, 18 Nov 2018 09:31:43 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com> <20181116040442.3a5ee3b9@silica.lan>
 <CAPcyv4iw78jzLQmX6foUMpVUB4ZSE2ExYhjTd87X2xraaZrkPA@mail.gmail.com>
 <20181118105829.7388cc7d@coco.lan> <CAPcyv4hX_B5HZ8Cj8VmjeeteZVkn-Ax8avAcUwUQqzH6J67ryA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 18 Nov 2018 09:31:32 -0800
Message-ID: <CAPcyv4g0wKdLqDr9R3euzNrzNH5v18GJpBJeEGP4Pg+d8VMD2A@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, stfrench@microsoft.com,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
>
> On Sun, Nov 18, 2018 at 4:58 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
> >
> > Em Fri, 16 Nov 2018 10:57:14 -0800
> > Dan Williams <dan.j.williams@intel.com> escreveu:
> > > On Fri, Nov 16, 2018 at 4:04 AM Mauro Carvalho Chehab
> > > <mchehab@kernel.org> wrote:
> [..]
> > > Yes. Maybe a "Review Forum" section for subsystems that have
> > > transitioned from email to a web-based tool? There's also the
> > > exception of security disclosures, but the expectations for those
> > > patches are already documented.
> >
> > Maybe. I would postpone adding a section like that until some
> > subsystem maintainer that actually changed to Github/Gitlab
> > would submit his subsystem profile.
>
> Sure.
>
> > > > > > +Last -rc for new feature submissions
> [..]
> > > > This is a general ruleset that describes the usual behavior, telling the
> > > > developers the expected behavior. If the maintainers can do more on some
> > > > particular development cycle, it should be fine.
> > >
> > > Yes, and perhaps I should clarify that this is the point at which a
> > > maintainer will start to push back in the typical case, and indicate
> > > to a contributor that they are standing in exceptional territory.
> > > Similar to how later in the -rc series patches get increasing
> > > scrutiny.
> >
> > Makes sense. There's one issue, though.
> >
> > I don't expect developers to read the profile template, as this is a
> > material for the maintainer themselves. Developers should likely read
> > just the specific subsystem profile for the patches that will be submitted.
> >
> > So, either each subsystem profile should have a reference to the
> > profile template, or need to copy some "invariant" texts (with would be
> > really painful to maintain).
>
> Agree, a general link back to the handbook template for clarification on any of the sections seems sufficient.
>
> [..]
> > > > > > +Trusted Reviewers
> > > > > > +-----------------
> > > > > > +While a maintainer / maintainer-team is expected to be reviewer of last
> > > > > > +resort the review load is less onerous when distributed amongst
> > > > > > +contributors and or a trusted set of individuals.  This section is
> > > > > > +distinct from the R: tag (Designated Reviewer). Whereas R: identifies
> > > > > > +reviewers that should always be copied on a patch submission, the
> > > > > > +trusted reviewers here are individuals contributors can reach out to if
> > > > > > +a few 'Resubmit Cadence' intervals have gone by without maintainer
> > > > > > +action, or to otherwise consult for advice.
> > > > >
> > > > > This seems redundant with the MAINTAINERS reviewers list.  It seems like
> > > > > the role specified in this section is more of an ombudsman or developer
> > > > > advocate who can assist with the review and/or accept flow if the
> > > > > maintainer is being slow to respond.
> > > >
> > > > Well, on subsystems that have sub-maintainers, there's no way to point to
> > > > it at MAINTAINERS file.
> > > >
> > > > Also, not sure about others, but I usually avoid touching at existing
> > > > MAINTAINERS file entries. This is a file that everyone touches, so it
> > > > has higher chances of conflicts.
> > > >
> > > > Also, at least on media, we have 5 different API sets (digital TV, V4L2, CEC,
> > > > media controller, remote controller). Yet, all drivers are stored at the
> > > > same place (as a single driver may use multiple APIs).
> > > >
> > > > The reviewers for each API set are different. There isn't a good way
> > > > to explain that inside a MAINTANERS file.
> > >
> > > Would it be worthwhile to have separate Subsystem Profiles for those
> > > API reviewers? If they end up merging patches and sending them
> > > upstream might we need a hierarchy of profiles for each hop along the
> > > upstream merge path?
> >
> > I guess having hierarchical profiles will make it very confusing.
> > The point is: inside a subsystem, the same ruleset usually applies to
> > everything.
>
> Ok.
>
> > In the case of media, it is not uncommon to have patches that require
> > multiple APIs. Consider, for example, a SoC used on a TV box. The driver
> > itself should be placed at drivers/media/platform/, but it will end by
> > being a bunch of sub-drivers that together will add support for V4L,
> > Digital TV, remote controller, CEC and codecs, and need to be controlled
> > via the media controller API. It may even have camera sensors.
> >
> > On other words, all media APIs will be used (after having it fully
> > sent upstream).
> >
> > In practice, drivers for complex hardware like that is submitted in
> > parts. For example, one SoC vendor started sending us the remote
> > controller driver (as it would be the simplest one).
> >
> > The only part of the policy that changes, depending of what API
> > is involved, is the one that will do the review.
> >
> > As the driver itself will be at the same place, no matter what APIs
> > are used, get_maintainers.pl is not capable of identifying who are
> > the reviewers based "F:" tags[1].
> >
> > [1] It could be possible to teach get_maintainers to better hint it,
> > by making it look who are the reviewers for the headers that are
> > included.
> >
> > >
> > > > > > +Time Zone / Office Hours
> > > > > > +------------------------
> > > > > > +Let contributors know the time of day when one or more maintainers are
> > > > > > +usually actively monitoring the mailing list.
> > > > >
> > > > > I would strike "actively monitoring the mailing list".  To me, it should
> > > > > be what are the hours of the day that the maintainer might happen to poll
> > > > > (or might receive an interrupt) from the appropriate communications
> > > > > channels (could be IRC, could be email, etc).
> > >
> > > Yes, makes sense.
> > >
> > > > > For my area, I would want to say something like: I tend to be active
> > > > > between 17:00 UTC (18:00 UTC when daylight savings) and 25:00 (26:00),
> > > > > but often will check for urgent or brief items up until 07:00 (08:00).
> > > > > I interact with email via a poll model.  I interact with IRC via a
> > > > > pull model and often overlook IRC activity for multiple days).
> > > >
> > > > Frankly, for media, I don't think that working hours makes sense. Media
> > > > (sub-)maintainers are spread around the globe, on different time zones
> > > > (in US, Brazil and Europe). We also have several active developers in
> > > > Japan, so we may end by having some day reviewers/sub-maintainers from
> > > > there.
> > >
> > > For that case just say:
> > >
> > > "the sun never sets on the media subsystem" ;-)
> >
> > :-)
> >
> > >
> > > > At max, we can say that we won't warrant to patches on weekends or holidays.
> > >
> > > Yeah, maybe:
> > >
> > > "outside of weekends or holidays there's usually a maintainer or
> > > reviewer monitoring the mailing list"
> >
> > Well, 24/7, there is always patchwork monitoring the ML and picking
> > the patches. When the patch will be handled by someone is a different
> > question. As it is a high-traffic subsystem with an even higher ML
> > traffic, each sub-maintainer have its own policy about when they
> > review patches (usually one or twice per week - as most maintainers
> > are also active developers, and don't want to mix their development
> > time with reviewing time).
> >
> > I'm not quite sure about what you expect with this specific part of
> > the profile.
> >
> > I mean: why a submitter should care about office hours?
> >
> > Also, people may be OOT during some period of time, or working
> > remotely from some other office.
> >
> > Except if the idea would be to point to some site that would
> > dynamically track each maintainer's weekly maintainership
> > window (with would be a real pain to keep updated), I guess this
> > is useless.
>
> True, will remove. What's the point of stating daily active hours when we already have "Resubmit Cadence" (I think I'll rename it "Follow Cadence") measured in multiple days / weeks.
