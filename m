Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BFEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D861E21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j50byg/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D861E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeKUUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:07:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33827 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeKUUHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:07:14 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so12294720itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mxnlkUYfZJm7QZ8F0jd7cR1UA18ijQ3Jo22Lq31THbs=;
        b=j50byg/Ng9oLHaS4x2jpSNOM1ZOiJq6RvbOZsHf6qwFbfrFYr6H/XmhM8ONV9zuvZo
         5CQlUjYZjEgOFx7eHNsGn54+ZyTL6kr1a8Y3+CRqGJogdD6w8evi1TkMyj0oK0wOP8dy
         HoJ5OzzDHPeJTD2++rKwTRaVpoVNoDqP0ibhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mxnlkUYfZJm7QZ8F0jd7cR1UA18ijQ3Jo22Lq31THbs=;
        b=J1KTzPAW93WFP+AQddHee8+B/nKyb3vKqKwTIn0qYJsilYm/hBi3VsvC4w65Zor0gp
         lGqlrDnbBCjE/MxsN1qLUi1hWbruIrKlum2UrEjecLre5noPWLMT8YK8Gql7oZR61urW
         aO8cWHquNm9Nb5sjifg5XUvXQ/of/I4JeK4uBIRYdO4JYVI/UsAic9WJCmmXVay2hSeR
         OKY0RtGtfDvMCihXHnnQqKv05BjQXN5carg6BG7enhE1CTfTfefeowe2mTj1m+9h2JcX
         VE2fEaYLl46sz/ep/m4EMLKzPP8K2YdStLxSQQUGQvhwLLWqQ1BfwhuxEtvXTYbuJ5WR
         CqOg==
X-Gm-Message-State: AA+aEWZ03XnRdkfkPOr/FoOZd+k0yxQEFJ1ctt50sde4XoPk5rrOrxep
        n7+auFNA4ktvbD1FbfLpLED6NAlfcTnm2We3aFhBfQ==
X-Google-Smtp-Source: AJdET5erw6Wu9/wkoTAiTHXAU3+5BmOgqY0nfv2mzDy8o4DEt4GlkDWTV9P7sKfe4ovL5MXH0Hj2rhob75gW7B4FME8=
X-Received: by 2002:a24:646:: with SMTP id 67-v6mr5024419itv.117.1542792810419;
 Wed, 21 Nov 2018 01:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20181113055223.79060-1-sashal@kernel.org> <20181113055223.79060-8-sashal@kernel.org>
 <20181121093126.GJ4266@phenom.ffwll.local>
In-Reply-To: <20181121093126.GJ4266@phenom.ffwll.local>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 21 Nov 2018 10:33:18 +0100
Message-ID: <CAKMK7uG=Z_GkNR3J2hdYbEfa9nr6UcMx-HanJ6j85jv1beJsVw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.9 08/17] drm/edid: Add 6 bpc quirk for BOE panel.
To:     sashal@kernel.org, stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shawn.c.lee@intel.com, Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>, cooper.chiou@intel.com,
        Lee@phenom.ffwll.local, dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Nov 13, 2018 at 12:52:14AM -0500, Sasha Levin wrote:
> > From: "Lee, Shawn C" <shawn.c.lee@intel.com>
> >
> > [ Upstream commit 922dceff8dc1fb4dafc9af78139ba65671408103 ]
> >
> > BOE panel (ID: 0x0771) that reports "DFP 1.x compliant TMDS".
> > But it's 6bpc panel only instead of 8 bpc.
> >
> > Add panel ID to edid quirk list and set 6 bpc as default to
> > work around this issue.
> >
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Cooper Chiou <cooper.chiou@intel.com>
> > Signed-off-by: Lee, Shawn C <shawn.c.lee@intel.com>>
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Link: https://patchwork.freedesktop.org/patch/msgid/1540792173-7288-1-git-send-email-shawn.c.lee@intel.com
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Given that I'm not a fan of AUTOSEL at all: This one here is correctly
> cherry-picked for stable, ack.

An idea that just crossed my mind: Could we integrate this into 0day
and suggest cc: stable before the patch even gets merged? Or is the
heuristics not good enough for that kind of automation?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
