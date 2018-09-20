Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5541EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB422152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="WPu3nxMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB422152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbeITSt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:49:26 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33565 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeITSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:49:26 -0400
Received: by mail-yb1-f193.google.com with SMTP id y9-v6so3877050ybh.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1yLkH/BQs0bGxqwuiWcCNpPzlRtF+IwClpfahBLmYe0=;
        b=WPu3nxMAzCy3m7IdNilCfcHKiSSBVAunWUgNOlr9bw+LEgJTdiXq8M7s2C4esy9h98
         0ORcnmIBcxwkzBuOvmzB5P2MyuWtWRv5JkujgW7l4tOKbDi0Nc6w/ZWegHKJgq47OO9K
         ABGQxms6cjjsQiKOc0mXpqviXCWYiRNkvN/o9CaxDaTjrktGG82zBKrge71lln5gi4aw
         aFeQTg6EcqxAuWl6BqXdp2TGdAFb2dFxZ2ZpQwvcDCg0WVQrR9An4J/VFeNvnsSnbCXb
         A6sIoWYah7ZN13bY5N5Go9QBcCGhqBqdWZLteATGhplah5FKku40xdlwpaS5DcrCBCHc
         frMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1yLkH/BQs0bGxqwuiWcCNpPzlRtF+IwClpfahBLmYe0=;
        b=p+reJC6cxQSHi27gxgtG23hvSFItMHVmhNYgoGhxbK7PrjdduWeEsBIoqYrMs7ECng
         e/OlOL5IM/SaL8BHnEq3+ZuLdskFprEj2QzqzASf8yaPxKJGQurTOWb8OTsczAigyleK
         31NcKvWXoAvEDiBEFbEJSEKdzAl+qHIqmMq9aurukq0g7lPuErqnpyY3JKMi1sy+nthw
         cpHG+Od0hM/rSduzw761DcEca6p5A2P85/OqeWT/GRk0s0i6i0NlfNRqNQZhHdcNn7gm
         /8qrB48DiMuF+8RgyjKlBJnkJqBHKAVzy5oWZpR+JwhYjG6hDfj/4Iti5UTKA2CRajOd
         NR5g==
X-Gm-Message-State: APzg51C5sS35iO5M5GnI8A1lLe6TvjU1AZ3iSv5jtyhhScmY0O1O9p53
        2vskB7Xj1Y8itZ7MzEwNAsOzuA==
X-Google-Smtp-Source: ANB0VdZFM5/Gqy9OrQMURxT5uTEwRRm3cxdGyyrwdUyLKglF7WuBfrIxzlUZs6JL5SstTGS9A6/4Zg==
X-Received: by 2002:a25:7e42:: with SMTP id z63-v6mr10682571ybc.396.1537448759588;
        Thu, 20 Sep 2018 06:05:59 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id m1-v6sm3755690ywf.96.2018.09.20.06.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 06:05:59 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:05:58 -0400
From:   Sean Paul <sean@poorly.run>
To:     David Airlie <airlied@redhat.com>
Cc:     sean@poorly.run, dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        seanpaul@chromium.org, airlied <airlied@linux.ie>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH 1/2] MAINTAINERS: Move udl drm driver to drm-misc tree
Message-ID: <20180920130558.GB188300@art_vandelay>
References: <20180919204026.3217-1-sean@poorly.run>
 <CAMwc25rA_yB3U=FnZ62-UeqO=5XFG2uZLgdqe9MXeyKDX365NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMwc25rA_yB3U=FnZ62-UeqO=5XFG2uZLgdqe9MXeyKDX365NA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 07:27:39AM +1000, David Airlie wrote:
> On Thu, Sep 20, 2018 at 6:40 AM Sean Paul <sean@poorly.run> wrote:
> >
> > From: Sean Paul <seanpaul@chromium.org>
> >
> > Move udl maintenance into drm-misc tree. I've also signed up to be a
> > reviewer, but have kept it at "Odd Fixes" level of support.
> >
> > Cc: Dave Airlie <airlied@redhat.com>
> 
> Acked-by: Dave Airlie <airlied@redhat.com>

Applied to -misc-next. Thanks!

Sean

> 
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d9068ed4ee5..ba1dbb8735b8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4720,8 +4720,11 @@ F:       drivers/gpu/drm/tdfx/
> >
> >  DRM DRIVER FOR USB DISPLAYLINK VIDEO ADAPTERS
> >  M:     Dave Airlie <airlied@redhat.com>
> > +R:     Sean Paul <sean@poorly.run>
> > +L:     dri-devel@lists.freedesktop.org
> >  S:     Odd Fixes
> >  F:     drivers/gpu/drm/udl/
> > +T:     git git://anongit.freedesktop.org/drm/drm-misc
> >
> >  DRM DRIVER FOR VMWARE VIRTUAL GPU
> >  M:     "VMware Graphics" <linux-graphics-maintainer@vmware.com>
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS
> >

-- 
Sean Paul, Software Engineer, Google / Chromium OS
