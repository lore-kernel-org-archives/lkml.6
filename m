Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDBA2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDBA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKAPaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:30:55 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:15547 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727573AbeKAPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:30:55 -0400
X-IronPort-AV: E=Sophos;i="5.54,451,1534802400"; 
   d="scan'208";a="353738443"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 07:28:59 +0100
Date:   Thu, 1 Nov 2018 07:28:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] drm: Rename crtc_idr as object_idr
 to KMS cleanups
In-Reply-To: <20181031232915.rvni33tf6m2orbbx@smtp.gmail.com>
Message-ID: <alpine.DEB.2.21.1811010728140.2790@hadrien>
References: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com> <alpine.DEB.2.21.1810312200520.2391@hadrien> <20181031211935.p2pxr7fh26m5dc7v@smtp.gmail.com> <alpine.DEB.2.21.1810312229530.5416@hadrien> <20181031232915.rvni33tf6m2orbbx@smtp.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Oct 2018, Shayenne Moura wrote:

> On 10/31, Julia Lawall wrote:
> >
> >
> > On Wed, 31 Oct 2018, Shayenne Moura wrote:
> >
> > > On 10/31, Julia Lawall wrote:
> > > >
> > > >
> > > > On Wed, 31 Oct 2018, Shayenne da Luz Moura wrote:
> > > >
> > > > > Rename 'drm_mode_config.crtc_idr' as 'drm_mode_config.object_idr',
> > > > > as proposed in the task description in TODO list for KMS cleanups.
> > > >
> > > > Is object_idr a field that already exists?  If so, "Rename" is not the
> > > > best choice of words.  It should be something like "use the object_idr
> > > > field instead of the crtc_idr field" and then explain why.  "task
> > > > description in TODO list for KMS cleanups" isn't very helpful to
> > > > understand why the change should be made.
> > > >
> > > > julia
> > >
> > > Hi Julia,
> > >
> > > Thank you for your review!
> > >
> > > This patch is to solve this TODO task:
> > >  drm_mode_config.crtc_idr is misnamed, since it contains all KMS object.
> > >  Should be renamed to drm_mode_config.object_idr.
> > >
> > > Do you think I need to use this description in my commit message?
> >
> > That seems more helpful.
> >
> > But it seems that the name should actually be changed.  Which means that
> > the structure definition should be changed too.  Was that done?
> >
> > julia
>
> Yes, you are right. I did not add the header file.

Compilation should have given an error message.  If you thought you
compiled, then you don't have the right configuration to actually compile
the code that you changed.

julia
