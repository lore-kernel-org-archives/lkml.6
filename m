Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00684C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9ABC20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="d2MUZ9QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ABC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeKZHrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:47:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33388 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKZHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:47:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so14055096oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSQj9caCqxRXDmsaARlRivxGvBnJwFh4FjTW2tcYsC0=;
        b=d2MUZ9QEgBJNKpoN1o/fAg4/5DGldNBMqGaWaphDf/DyKFKZzX/c+k0uY/XlR3p8Iy
         otfFKeiexQyRMKzFONhuVdJ9qQ1iK3mBie5cMyKHCUJTMOsQZVKqa6RC3ZCtyNXJ+mNH
         BxE1MUpD9yUwUEsgfPLCnizWOVEM1uWredKI/OYxGvTVbC+01f/ZQLOkLt1HdAc9cX9e
         tKwY85TZxHTkzyjj62lM4gbj+RRcPO1L+a5STucIynWVEWVk8NkWwHTqeGB79Wka76Oh
         3ppwLr1xA5zWdORWi4c7Zlflcbs0FNnIcKhVbZUzbZmHh+zB6Jk63VyRUmcf2vIFEDBE
         xCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSQj9caCqxRXDmsaARlRivxGvBnJwFh4FjTW2tcYsC0=;
        b=nsF9Gfmw6RcyQgnqzgfsTqSJQMveMsUkOtEMuYuqkunlmJHScwYt/Ff09sD1qZLbFj
         Fh0kuYgXErOo8XmL97qOyeTqCoVYEaI7ig9aL4TCF3/Z7ftmW4G776KN3v0A9U400h8z
         bousKOBeatbbW4MHlH5EHarF3eA03mFBqLTOjKy+I9UJ3bzsJIQbpsXqa2xw2Ung7MPL
         S/OYXVqtucPs/uVuqR77n+Xz9ydQK9swIGvK9YsYMwcQlW1IsQ8I0JY6vNDh0KRqOXyB
         S7pz3dL+4fet+YN7NGf5oepoRtyrVZuGTbtJesrlKteGACGQUnIjWCp5wjZzQb8Bpfgy
         ix0Q==
X-Gm-Message-State: AGRZ1gKRwdbZejQk8iqMp+loFDK9GNCKSdbxpBgWSx9rfnNBVFUyrgX4
        QG0wi6dFXQYgBQI9uE9bSw4cc9+DYGCsKlCRCOAVkg==
X-Google-Smtp-Source: AJdET5f3kbFkdeOyr+UI+wvTn5X+Qj7cwEon4qqfHiVit92k7RXaWW7wyZsYaiGp6azCRfEuzO3j22ERPNyW005Ui14=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr12933109oit.235.1543179356729;
 Sun, 25 Nov 2018 12:55:56 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181125105754.GB25471@amd>
In-Reply-To: <20181125105754.GB25471@amd>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 25 Nov 2018 12:55:45 -0800
Message-ID: <CAPcyv4jmTUJFUWL99OCxAofhD6=jfZk+SA02sceAaJ0Q9X_=jA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Maintainer Handbook: Subsystem Profile
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, zwisler@kernel.org,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, stfrench@microsoft.com,
        Olof Johansson <olof@lixom.net>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 2:58 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-11-14 20:53:13, Dan Williams wrote:
> > At a recently concluded session at the Linux Plumbers Conference I
> > proposed a "Subsystem Profile" as a document that a maintainer can
> > provide to set contributor expectations and provide fodder for a
> > discussion between maintainers about the merits of different maintainer
> > policies.
> >
> > For those that did not attend, the goal of the Subsystem Profile, and the
> > Maintainer Handbook more generally, is to provide a desk reference for
> > maintainers both new and experienced. The session introduction was:
> >
> >     The first rule of kernel maintenance is that there are no hard and
> >     fast rules. That state of affairs is both a blessing and a curse. It
> >     has served the community well to be adaptable to the different
> >     people and different problem spaces that inhabit the kernel
> >     community. However, that variability also leads to inconsistent
> >     experiences for contributors, little to no guidance for new
> >     contributors, and unnecessary stress on current maintainers. There
> >     are quite a few of people who have been around long enough to make
> >     enough mistakes that they have gained some hard earned proficiency.
> >     However if the kernel community expects to keep growing it needs to
> >     be able both scale the maintainers it has and ramp new ones without
> >     necessarily let them make a decades worth of mistakes to learn the
> >     ropes.
> >
> > To be clear, the proposed document does not impose or suggest new
> > rules. Instead it provides an outlet to document the unwritten rules
> > and policies in effect for each subsystem, and that each subsystem
> > might decide differently for whatever reason.
>
> Sounds like a new rules to me :-(, making submitting simple patches
> harder.

I'm missing how documenting how a subsystem generally handles patches
makes submitting simple patches harder?

> It would be good if the rules were similar / same accross the
> subsystems, documenting "it is okay to be different" is not really helpful.

It is not documenting "it is okay to be different", it is
acknowledging that processes are already different. The goals are to
allow comparing notes across subsystems with the hope of some
convergence down the road, provide a template for new maintainers to
copy rather than reinvent, and give submitters a resource to discover
subsystem local policy.
