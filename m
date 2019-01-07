Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F2C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFA20881
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EswmIADM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfAGIiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:38:07 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41598 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGIiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:38:06 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so34253469ioc.8;
        Mon, 07 Jan 2019 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVx1N3/1yZKes91LPFLzCoAaNamYHEmbi9lrJ9mdkOM=;
        b=EswmIADMoit8HAC/ONWLIUOs82xUyZZ7KMpmO9np6klXABsQU1QTRU18JTuiNxSRAO
         JqCEQgIK+qEXqqFcT232liEa7b5BoboTP1JaHua26Oxa3PU6ycJYqOje/YOsiHvTN8hu
         h72X/T2z8V4h4XkHJOprue2txZdkbRWgcW91+MtWEN19h2y984vSFt7LlQpQ8mSXiAZ0
         yFG3AunNP1aSP7HEefVBgpijQe27ZzmdODIBmHYBeyWeG5+vk3VBUqgd44hSWiEWf900
         HTYM6PegdJmyslG9PeWQE8bjwKTPXGS5giqesuBuGi+5zHfrIQ+1VE8C/UWcQXqXW2Za
         WaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVx1N3/1yZKes91LPFLzCoAaNamYHEmbi9lrJ9mdkOM=;
        b=XOwDDc/qgNrVPyeWFnrtbKSAjoyaxDbvP5PKs9aVJJZDEniaO3Le2yL503QsYVMZq+
         RPkUBiDdTSK2fVrL/zcEvbf7cjc21IlvAQ2K0xvJ8wMZpAtk7XME56n6oletfJIAZTLg
         VXLeYgASOdA01bfH8WjpXXN5zoQ+PLucbfbihvONOzbXWaCmSPBoyeD9PICn+NJ4EKkY
         xHscpmatXrVIeKc74zcfiTwh+DrK9ucQrigZ2pek1PthWhH1TFkMNWa0/4rHOKJGeFcE
         oF5WDeIl6PAULAkD+/5RVmxSaBcbNdgQK7wC630ARC8VF/fp5Jrp25eI1te0QE4eqDgj
         sSOg==
X-Gm-Message-State: AJcUukcjnhSpxbYluSsvohIpwOgUd3BaFWKl+9Lup2I/O0rAp0FxOZvN
        KCCC3IgPNuaLqCoXBRcqIrelYdKruBL6XilFlw==
X-Google-Smtp-Source: ALg8bN565vD9gCVSgZ0kouTj2emPGiwItjw1PmyzR2yMpnUaBIORex/wGD7CZ9/km0XWTaveGh3JDkr1kJL25ChZtV0=
X-Received: by 2002:a6b:3f06:: with SMTP id m6mr39444084ioa.117.1546850285729;
 Mon, 07 Jan 2019 00:38:05 -0800 (PST)
MIME-Version: 1.0
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-2-git-send-email-kernelfans@gmail.com> <20181231084018.GA28478@rapoport-lnx>
 <CAFgQCTvQnj7zReFvH_gmfVJdPXE325o+z4Xx76fupvsLR_7H2A@mail.gmail.com>
 <20190102092749.GA22664@rapoport-lnx> <20190102101804.GD1990@MiWiFi-R3L-srv>
 <20190102170537.GA3591@rapoport-lnx> <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20190103184706.GU2509588@devbig004.ftw2.facebook.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 7 Jan 2019 16:37:54 +0800
Message-ID: <CAFgQCTt2=6mwFid8HS+K5UsqkBv8y7N5WOoKpVxYzNxjwmV75A@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/memblock: extend the limit inferior of bottom-up
 after parsing hotplug attr
To:     Tejun Heo <tj@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I send out a series [RFC PATCH 0/4] x86_64/mm: remove bottom-up
allocation style by pushing forward the parsing of mem hotplug info (
https://lore.kernel.org/lkml/1546849485-27933-1-git-send-email-kernelfans@gmail.com/T/#t).
Please give comment if you are interested.

Thanks,
Pingfan

On Fri, Jan 4, 2019 at 2:47 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Jan 02, 2019 at 07:05:38PM +0200, Mike Rapoport wrote:
> > I agree that currently the bottom-up allocation after the kernel text has
> > issues with KASLR. But this issues are not necessarily related to the
> > memory hotplug. Even with a single memory node, a bottom-up allocation will
> > fail if KASLR would put the kernel near the end of node0.
> >
> > What I am trying to understand is whether there is a fundamental reason to
> > prevent allocations from [0, kernel_start)?
> >
> > Maybe Tejun can recall why he suggested to start bottom-up allocations from
> > kernel_end.
>
> That's from 79442ed189ac ("mm/memblock.c: introduce bottom-up
> allocation mode").  I wasn't involved in that patch, so no idea why
> the restrictions were added, but FWIW it doesn't seem necessary to me.
>
> Thanks.
>
> --
> tejun
