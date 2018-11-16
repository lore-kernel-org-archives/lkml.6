Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0987C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C692086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YkhGJCbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C692086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeKQJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:59:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40550 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeKQJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:59:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so22887025oth.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5TAbdRShoOt4pm1oPqDZ3F8NYuj7PYmtdpsXG4GSQU=;
        b=YkhGJCbzvc4VYrm/qlwIJD9zxCDxG578GWigzLbhvsdxrV9diqEB4UprZQ/RGGhZPu
         lHuAIS/fiRpYs/sbJCbesEFt1J5dVqx9mwxYwZD4zWvRDIWLu3iQ+z3DhUhJTrfxhVtw
         Mn9YZs/+TkRfiDzZTT/cW5Cz2vUkgaaWWDSSQ/1+77TdVyC0aObKEvLQdDoV0k1czxZ6
         M3G5ND4tiRcRJv9BmMgUUfH0hYs1Z46oI5MBLUFUgSSp7/GuUGr1DeSPcu+9JuV1l16N
         p3XbO8YMqortKEuOaN+CmVkGRsIKqJiclR710IxN0ufblNsmo8+dRqmI+R9faKrGpte1
         6Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5TAbdRShoOt4pm1oPqDZ3F8NYuj7PYmtdpsXG4GSQU=;
        b=SL/M3uWXZvJyrRBwpDD9zVffJZlTQPQRi/4chrVJuMU89J9fZYeyec0wduZJwGttfZ
         3TyPFQxyeoVHM/lRnycIgWWtEoh9efe09jSPWntKt/xEr8kg6xsReA9GjU2z37RrWZAE
         U0k7Gf6abtB+Z/HplHBQ1rYFK1id2RlLDJT0I0iUoOWKdjpjVDDXr9yaKMmgBnjZHrC4
         NqZAXx63hoY6yEsG+A0bq44Ojejt134aGiY4QJMTNWsIF5LJmjEHY4RDi4BdvoG6Xd7D
         SOQyIOBAMKzG29SwddMIyPRN4E5LKV390FY9pstYq435Pk1Dr5OeCg7S+NubECPpqa9S
         1vVQ==
X-Gm-Message-State: AGRZ1gIpOj6frnfdLCSgh9LdXMFcIrurp7CSdNIAaReGBTRCbN0uHe6+
        JYCGZzJwK3rkiRyAnYsPq9hUAUeP+Vn04/uLoCrIlA==
X-Google-Smtp-Source: AJdET5dOndf8+u0lWZ5VFZYxf4g/aNZGD1GnYS7WP3KB7MITIe0+k19FMLGFsiLpQhFHweP1XYcG3tS+KJuN0kEf6lA=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr7216574otl.32.1542411896452;
 Fri, 16 Nov 2018 15:44:56 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
 <20181115061036.1575223d@silica.lan> <20181115162008.GO3759@mtr-leonro.mtl.com>
 <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
In-Reply-To: <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Nov 2018 15:44:45 -0800
Message-ID: <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
To:     rodrigo.vivi@gmail.com
Cc:     Leon Romanovsky <leon@kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org, mchehab+samsung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:37 PM Rodrigo Vivi <rodrigo.vivi@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 8:38 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:
> > > Em Thu, 15 Nov 2018 09:03:11 +0100
> > > Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
> > >
> > > > Hi Dan,
> > > >
> > > > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > Document the basic policies of the libnvdimm subsystem and provide a
> > > > > first example of a Subsystem Profile for others to duplicate and edit.
> > > > >
> > > > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- /dev/null
> > > > > +++ b/Documentation/nvdimm/subsystem-profile.rst
> > > >
> > > > > +Trusted Reviewers
> > > > > +-----------------
> > > > > +Johannes Thumshirn
> > > > > +Toshi Kani
> > > > > +Jeff Moyer
> > > > > +Robert Elliott
> > > >
> > > > Don't you want to add email addresses?
> > > > Only the first one is listed in MAINTAINERS.
> > >
> > > IMO, it makes sense to have their e-mails here, in a way that it could
> > > easily be parsed by get_maintainers.pl.
> >
> > I personally think that list of "trusted reviewers" makes more harm than
> > good. It creates unneeded negative feelings to those who wanted to be in
> > this list, but for any reason they don't. Those reviewers will feel
> > "untrusted".
>
> I'd like to +1 on this concern here. Besides leaving all the other
> people demotivated.

Yes, that's a valid concern, I overlooked that unfortunate interpretation.

>
> A small group of trusted reviewers doesn't scale. People will get overloaded.
> Or you won't be able to enforce that all patches need to get Reviews.
>
> Reviews should be coming from everywhere and commiters and maintainers
> deciding on what to trust or re-review.
>
> Also the list is hard to maintain and keep the lists updated.

I understand the concern, and as I saw feedback come in I realized
there were more people that I would add to that reviewer list for
libnvdimm.

Stepping back the end goal is to have an initial list of recommended
people to follow up with directly to seek a second opinion, or help in
cases where a contributor otherwise needs some direction / engagement
that they are not readily receiving from the maintainer. Typically
someone just lurks on the mailing list for a few weeks to get a feel
for who the usual suspects are in the subsystem, but for a new
contributor identifying those individuals may be difficult.

One of the contributing factors of lack of response to a patchset is
that they are sent with the implicit expectation that the maintainer
will get to eventually, and typically other people feel content to sit
back and watch. If instead a contributor sent a direct mail to a
"trusted reviewer" saying, "Hey, Alice, Bob seems busy can you help me
out?" that seems more likely to rope in additional review help.
