Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D6C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6621320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AuoL7glB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6621320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeLFAJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:09:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45342 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeLFAJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:09:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so20386821ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZbKQq33LQa1jXnV0z4okbGGEFzFL7NaKJ8F/xgnXnY=;
        b=AuoL7glBjalIdxpecp2wOrOvVnYhhgeDcJb5KQD2doaYaFDGU6T57C4n+BXa0db66g
         KF1kaRgmLjS+FJz5oSShNvvVjb7nouBZK8fBFkB0mncr5oB7bfWvxk1Af8bJ5i8S88wg
         GaF/CZJBABR9tjEYv/TyB3GW8La++MmrnCgvRRk7QXWiRkl1p2IsahRgZWAYw4T1AyDm
         aEjXlm6byj5DyiS70UHV5o2b7LAdMd8vBQWZGgYrbPDZKqqHkjUJaqATp4CCnh2qv0GH
         SL93CgBbg+DlzAeElRJtr27omALFjx0R6p4z4rXKa1pSIDAExp3rWRNTW3H0vzoQp6mN
         yGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZbKQq33LQa1jXnV0z4okbGGEFzFL7NaKJ8F/xgnXnY=;
        b=VJ8O7c0Jt1KwIcPuJ03TLuVjfyQJeDCUwdjHl2o3rebGID4WkG/QBuZe+eWtVACvmm
         YnzKozZdIsnlqChNbE6Rh72i+rAkJhmwxlBbE6NpHT5+oyODNpMaXI2gHALfamJmFZt0
         ZM82T7gRTPg3JylPgbXvrPXm+joxUK2woIgjxUelOeUtcMRcxpy+5P/rS44zxOf7bk7/
         VE9IbNRB3bsrtlzZVnlN3LbnFE6NhskZzQRgz5ZW/xrn6pASnNjoCPliv2dNUbffujuo
         06bTVQuh6I7znHS8vsKzctVVxNJc700M3sQbV28cGtxsHzKQqkw4U1ek8p4xdydxE3Z9
         SBRA==
X-Gm-Message-State: AA+aEWbunatKfqfbRgTUvCDIhLOJ4SUCx/aFo0iQCSYZh/olvALQbNck
        rWNla1IZTRCyPmXfjL/UdOk8wqGwfhyy2uz9OuZWWA==
X-Google-Smtp-Source: AFSGD/WIlTfPZZBj9FTrAJxWPgP5XNsZZ9cFO24imeH01opqP7xOGfk9pfuWsUfZLZc2jnc5MzckCCd073ct7d9burs=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr16415958otg.229.1544054940922;
 Wed, 05 Dec 2018 16:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20181205180756.GI3536@redhat.com> <e5c740fd-0256-8b70-cd06-6d6fee19806d@deltatee.com>
 <20181205183314.GJ3536@redhat.com> <0ddb2620-ecbd-4b7b-aeb7-3f4ae7746e83@deltatee.com>
 <20181205185550.GK3536@redhat.com> <7ab26ea6-d16d-8d71-78ca-4266a864f8d3@deltatee.com>
 <20181205225828.GL3536@redhat.com> <a0240f08-68ab-5167-c2c7-2f930aa0a54b@deltatee.com>
 <20181205232028.GO3536@redhat.com> <af781c8a-1990-c091-0471-5b2d873ee526@deltatee.com>
 <20181205232710.GP3536@redhat.com>
In-Reply-To: <20181205232710.GP3536@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Dec 2018 16:08:49 -0800
Message-ID: <CAPcyv4g2bb=GPErigvjWDdVn2vfLDawnr7-Q49TaJsD-6c-zMw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS) documentation
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>, balbirs@au1.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, Philip.Yang@amd.com,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 3:27 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Dec 05, 2018 at 04:23:42PM -0700, Logan Gunthorpe wrote:
> >
> >
> > On 2018-12-05 4:20 p.m., Jerome Glisse wrote:
> > > And my proposal is under /sys/bus and have symlink to all existing
> > > device it agregate in there.
> >
> > That's so not the point. Use the existing buses don't invent some
> > virtual tree. I don't know how many times I have to say this or in how
> > many ways. I'm not responding anymore.
>
> And how do i express interaction with different buses because i just
> do not see how to do that in the existing scheme. It would be like
> teaching to each bus about all the other bus versus having each bus
> register itself under a common framework and have all the interaction
> between bus mediated through that common framework avoiding code
> duplication accross buses.
>
> >
> > > So you agree with my proposal ? A sysfs directory in which all the
> > > bus and how they are connected to each other and what is connected
> > > to each of them (device, CPU, memory).
> >
> > I'm fine with the motivation. What I'm arguing against is the
> > implementation and the fact you have to create a whole grand new
> > userspace API and hierarchy to accomplish it.

Right, GPUs show up in /sys today. Don't register a whole new
hierarchy as an alias to what already exists, add a new attribute
scheme to the existing hierarchy. This is what the HMAT enabling is
doing, this is what p2pdma is doing.
