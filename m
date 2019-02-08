Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B2CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9DD2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eah2oOfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfBHP3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:29:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45924 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBHP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:29:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id t6so3050623edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYMyEi7yYvz1dJsk2dnsyi4Axq+WGCOtq6PFtPv8v+0=;
        b=eah2oOfBg4vUKxZ1FqFCDWZvkmASM9JVl2WxqY/V/GbQcitg/mpqCL8BaaeXq6BTz+
         Ph4e60J/HFFeR51NHwCr238dMmEP9vUbVMJZiHLM+AkBG4N/BSkIw3Bija8L8F7cFeMa
         CT+TzySsO/VX2zrQCb0YXxg0qiO18LsDxT7pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GYMyEi7yYvz1dJsk2dnsyi4Axq+WGCOtq6PFtPv8v+0=;
        b=h1itqGObBdEF8rfFpLSlW63uRo2uigvAoluEJBwWgJkMJgPx9XkV7zwio9lmsJysts
         vfR765Cvb6P0YTww4nK53bg//dhTfFNMrzIbYKQqO3YouSV5qzdDGxl9NhB55Z91I48k
         83F4cRSzdwCdl47SOK1Q0VX2NfA6N6ZKipYVTpWflTDtF82Fo2OxVZ4euLXtQ+6RWXAp
         HbvDTUcZwCTNrj2OsMN5Wp7qH6EgVs/NxqhPtTglLABcFLmPKTfABqDdZlGvBNrZ//1G
         ewjiQCJwtb5oe6pXIizam5QHygQQDrujd/WGJlttCrv/XUVrML8WqLoUhXvEzg9Iyu+k
         x4TA==
X-Gm-Message-State: AHQUAuYXuuNiMw0VM2jjp8r7MOPj1a/3rjMrVzKJ9sIcxf31tUe0mUJR
        xSr1BKn4OHHij1GUONMpZG562A==
X-Google-Smtp-Source: AHgI3Ia/sA2jyAFmdIYHdj6pZYb31ZRB2ksz/MNpS+nNfDVPWflL2wlLMYfZfEJ7BGW7j7IShL0wng==
X-Received: by 2002:a05:6402:788:: with SMTP id d8mr7355848edy.148.1549639755165;
        Fri, 08 Feb 2019 07:29:15 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x30sm688619edd.30.2019.02.08.07.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:29:14 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:29:11 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/4] component: Add documentation
Message-ID: <20190208152911.GM23159@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
 <20190208115123.GA19392@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208115123.GA19392@kroah.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:51:23PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 08, 2019 at 12:27:56AM +0100, Daniel Vetter wrote:
> > While typing these I think doing an s/component_master/aggregate/
> > would be useful:
> > - it's shorter :-)
> > - I think component/aggregate is much more meaningful naming than
> >   component/puppetmaster or something like that. At least to my
> >   English ear "aggregate" emphasizes much more the "assemble a pile of
> >   things into something bigger" aspect, and there's not really much
> >   of a control hierarchy between aggregate and constituing components.
> > 
> > But that's way more than a quick doc typing exercise ...
> > 
> > Thanks to Ram for commenting on an initial draft of these docs.
> > 
> > v2: Review from Rafael:
> > - git add Documenation/driver-api/component.rst
> > - lots of polish to the wording + spelling fixes.
> > 
> > v3: Review from Russell:
> > - s/framework/helper
> > - clarify the documentation for component_match_add functions.
> > 
> > v4: Remove a few superflous "This".
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: "C, Ramalingam" <ramalingam.c@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> Thanks for doing this!
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing (obviously includes Rafael and Russell too)!

For merging I see two options:
- All through drm-intel, but will only land in 5.2 because the feature
  cut-off has already happened for i915. So a bit awkward.
- Topic branch with the 2 component patches plus the snd-hda/drm-i915
  patch, so that you/Takashi/drm can pull it in as needed. The drm
  component doc patch (3/4 in this series) I can pull in later on.

Greg/Takashi, any preferences?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
