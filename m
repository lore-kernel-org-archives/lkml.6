Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F94C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B9F21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTdqu5nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfBOAkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:40:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36798 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfBOAkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:40:41 -0500
Received: by mail-vs1-f66.google.com with SMTP id t13so4841908vsk.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 16:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yD1Hs9mc4zdS2J7n7uEwTwFBSr5HaFMiMXQ4H6igno=;
        b=NTdqu5nJAqJ+gCLuiWmQMaBgOl0+t7W+kkcWb9QWZNnjICdWNdw6neb9fNjhDMyH6i
         PNaloTyKxvOcJU1FWPmEndHEtv0FYe6mJcDjtEzDUcIK9iiZjOMCTw/p+Xelys84P3EQ
         78if6c1nVhGlsKKfNbVGTWuqnvbbnw4CSQ26M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yD1Hs9mc4zdS2J7n7uEwTwFBSr5HaFMiMXQ4H6igno=;
        b=sLcD1OZ41ZVI8VHoF3+TJD7n1EO63r9eHW3q+p3ywLcWn/ECQppdEzLfvhGfVTJdjY
         pQgpAseNiwRG/CONbPso/1B9z2FiWKo76Aj7RIfzp3Yh1icdwZ09A83U7Wp4DLwF368o
         f032Xx0QmXX9MIj6frrhHH1sSCy2S20ypUoBQ0YZrsu8nb5Ea0Dky7ZRaudvk3uawGKW
         r0J+bHpw4FLj/Xkci2AHq9woe2Tur/VN59W6UjP1mEimGHfJXUI6hevGVct9/jlAu1Ln
         G1k+tRXyvOnMUvIrwATZ456WhtfJaDVmr6rzrntRVV3MW1zbnL6SiXRI/iuQjeiV+bo3
         Fhpg==
X-Gm-Message-State: AHQUAuY3qESKxhdkyQWIVxTr5XqILs+sB3kt/7SHxqrvrj8xaWf2I9eH
        xsZbsmBLhNH6XYhFpZzKTPScbAAEOr0=
X-Google-Smtp-Source: AHgI3IYY4B4xyxrWGRmEzTPRZq/ByyuzeFPJFgcEne1KU2bwEgW3NDDndD02lKBgYcNzOL+Xh8fr8Q==
X-Received: by 2002:a67:8cc2:: with SMTP id o185mr3346516vsd.55.1550191239727;
        Thu, 14 Feb 2019 16:40:39 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id l187sm141587vsc.22.2019.02.14.16.40.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 16:40:38 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id z18so4828057vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 16:40:38 -0800 (PST)
X-Received: by 2002:a67:81c1:: with SMTP id c184mr3591450vsd.111.1550191237774;
 Thu, 14 Feb 2019 16:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20190214204433.155715-1-dianders@chromium.org> <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
In-Reply-To: <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Feb 2019 16:40:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
Message-ID: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 14, 2019 at 1:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Doug,
>
> On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> > Right now the only way to disable the iommu bypass for the ARM SMMU is
> > with the kernel command line parameter 'arm-smmu.disable_bypass'.
> >
> > In general kernel command line parameters make sense for things that
> > someone would like to tweak without rebuilding the kernel or for very
> > basic communication between the bootloader and the kernel, but are
> > awkward for other things.  Specifically:
> > * Human parsing of the kernel command line can be difficult since it's
> >    just a big runon space separated line of text.
> > * If every bit of the system was configured via the kernel command
> >    line the kernel command line would get very large and even more
> >    unwieldly.
> > * Typically there are not easy ways in build systems to adjust the
> >    kernel command line for config-like options.
> >
> > Let's introduce a new config option that allows us to disable the
> > iommu bypass without affecting the existing default nor the existing
> > ability to adjust the configuration via kernel command line.
>
> I say let's just flip the default - for a while now it's been one of
> those "oh yeah, we should probably do that" things that gets instantly
> forgotten again, so some 3rd-party demand is plenty to convince me :)
>
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones, so I'd be happy to shift the command-line burden over to the
> esoteric cases at this point, and consider the config option in future
> if anyone from that camp pops up and screams hard enough.

Sure, I can submit that patch if we want.  I presume I'll get lots of
screaming but I'm used to that.  ;-)

...specifically I found that when I turned on "disably bypass" on my
board (sdm845-cheza, which is not yet upstream) that a bunch of things
that used to work broke.  That's a good thing because all the things
that broke need to be fixed properly (by adding the IOMMUs) but
presumably my board is not special in relying on the old insecure
behavior.

I'm about to head on vacation for a week so I'm not sure I'll get to
re-post before then.  If not I'll post this sometime after I get back
unless someone beats me to it.

-Doug
