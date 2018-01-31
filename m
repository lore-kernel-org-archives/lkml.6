Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeAaINt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:13:49 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38525 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeAaINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:13:47 -0500
X-Google-Smtp-Source: AH8x224HjK/OKiwjikWUl6opoD/7CmmbkBuJ4xHzm77ljoTIDpqhTMjf8rUVCxO+DFIR9DYpR/eFuA==
Date: Wed, 31 Jan 2018 09:13:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Keith Packard <keithp@keithp.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Check for lessee in DROP_MASTER ioctl
Message-ID: <20180131081343.GY25930@phenom.ffwll.local>
Mail-Followup-To: Keith Packard <keithp@keithp.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <20180119015159.1606-1-keithp@keithp.com>
 <20180130093447.GG25930@phenom.ffwll.local>
 <87k1vz3ywa.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1vz3ywa.fsf@keithp.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:55:01AM -0800, Keith Packard wrote:
> Daniel Vetter <daniel@ffwll.ch> writes:
> 
> > On Thu, Jan 18, 2018 at 05:51:59PM -0800, Keith Packard wrote:
> >> Don't let a lessee control what the current DRM master is set to;
> >> that's the job of the "real" master. Otherwise, the lessee would
> >> disable all access to master operations for the owner and all lessees
> >> under it.
> >> 
> >> This matches the same check made in the SET_MASTER ioctl.
> >> 
> >> Signed-off-by: Keith Packard <keithp@keithp.com>
> >
> > Similar check for setmaster already exists, so looks all good. Do we have
> > an igt for all this? Iirc there was one floating around, but no idea
> > what's the status. Might also be good to resubmit them so i915 CI can run
> > the tests (now that the code has landed).
> 
> I've got IGT tests for leasing which have been posted to dri-devel but I
> don't think they've been reviewed. Looks like they could use some more
> test cases; I didn't catch this one until I was playing with my 'xlease'
> hack, which runs the X server on a leased FD.

Can you pls resubmit (preferrably with the new nasty tests added) to
igt-dev@lists.freedesktop.org (we have a new m-l for igt stuff)?

> > On the patch itself, minus lack of testcases:
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Thanks!

Realized I should better apply this, and done :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
