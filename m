Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeCNLJI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:09:08 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:39393 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeCNLI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:08:56 -0400
X-Google-Smtp-Source: AG47ELvJdkseV46qaXOFE2iY5cym+jCbCG1GFmwkmE7J2CRnwE2YhYisqCJ4ghr2WBLiRQiVd/KDeRX8H/nZ0y2UsBM=
MIME-Version: 1.0
In-Reply-To: <20180303013431.1088-1-eric@anholt.net>
References: <20180303013431.1088-1-eric@anholt.net>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 14 Mar 2018 11:08:54 +0000
Message-ID: <CAPj87rNtcN0PDFViJB_NOVzUeLSWKe9smnQx7RSXwBR1+nm__w@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: Add support for SAND modifier.
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Eric,

On 3 March 2018 at 01:34, Eric Anholt <eric@anholt.net> wrote:
> Ccing a couple of folks who are likely to have opinions about
> drm_fourcc.h additions (Do we have enough docs?  Are the macros OK?),
> and Bootlin who are likely reviewers.
>
> The plan is to use these modifiers in VC4 GL imports as well, and for
> buffers coming from the v4l2 mmal camera driver.  You can find a demo
> using this in KMS planes at
> https://github.com/anholt/drm_mmal/commit/sand for now.

I had a dig through and this seems like the most sensible thing to do
if you have a reasonable variety of tile heights. If you only see a
couple of combinations in the wild, then hardcoding them as separate
modifiers might make things easier than hiving off 24 bits. If you do
keep the split though, and especially if you're envisioning future
flexible tile formats, maybe something like an 8 code / 48 params
split would make more sense.

Either way, those are just my opinions (you did ask), and I don't see
anything really objectionable, so if you think that's a good split
then this is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
