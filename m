Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78E1204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="j1u1u0ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfAOPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:15:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32776 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:15:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so2857358eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/l09gqHc5VGCHfPCdSv2JMRWtjqm2E3cIGIsXc7YvY=;
        b=j1u1u0ZDmj7lYuG1RkdDtkAjYHv2GxhF6toQr+FouowHzBnZksk1rJZziWw0n6IWge
         AIccJgXVHxiazzmRF4loUVbhvIFcjJFvHz1QvInInCpbAHmJwrUEkYRhyG/PIMOqNaJZ
         GENfJGGpOnqW9KwShji/K/MTPjvk8QSauoKjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=o/l09gqHc5VGCHfPCdSv2JMRWtjqm2E3cIGIsXc7YvY=;
        b=GwRGMnWDj9oXhGdnDeDRZaRkoyBv6ImIyAKaG36MNdDRGYoxSQWg6+RrthsDfSclnh
         YEw5YVfVoTn9Rx5jp+eQS47wn0iuu7dtV0VMVZcJW1T8cxXVKZNFW+JqgFGAU39eXZyJ
         PM4phtMjw1BgZOloKHp8rdhNFPZQr1hZs49cnWtqoTvtn2Jcl57tUsHEbfmHsWJoWGra
         r+qRfSsFFKTTQRvgRQTeRhuqfO9IdTq59CZKqEPZr3Wu2wHL6QPECM5JaOjlikzf7MR+
         /P4lNjJsp5dw9PxiuKiL/keFz1w2TaEwM47BZhdZ/OihauFcxOarnu4xIn1G2x9JohQO
         /Dvw==
X-Gm-Message-State: AJcUukdKJbMENHTjEyfgE+uw1h/WZwTcpalOHwWGkBwmWDsCg+sW0Ie2
        ZC2eOHSp9SxNqTaGWfF29yuwFA==
X-Google-Smtp-Source: ALg8bN6lZhx4BTW7p9NqLqew1Po3TqjK/bOtWn6u3ewZPaGh6++l+v2engA2lcjxcQ4Bn6dsikVE8A==
X-Received: by 2002:a50:8eea:: with SMTP id x39mr3667661edx.177.1547565352809;
        Tue, 15 Jan 2019 07:15:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w24-v6sm2877856eja.71.2019.01.15.07.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 07:15:51 -0800 (PST)
Date:   Tue, 15 Jan 2019 16:15:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: Don't set
 FBINFO_MISC_ALWAYS_SETPAR
Message-ID: <20190115151549.GP10517@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
 <20190115103829.GC18959@kroah.com>
 <20190115121228.GO10517@phenom.ffwll.local>
 <20190115134553.GD30742@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115134553.GD30742@kroah.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:45:53PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 15, 2019 at 01:12:28PM +0100, Daniel Vetter wrote:
> > On Tue, Jan 15, 2019 at 11:38:29AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 15, 2019 at 11:27:54AM +0100, Daniel Vetter wrote:
> > > > It's a debug hack flag useful to work around driver bugs. That's not a
> > > > good idea for a new driver. Especially for a new drm driver.
> > > > 
> > > > Aside: the fbdev support should probably be converted over to the new
> > > > generic fbdev support.
> > > > 
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > > > ---
> > > >  drivers/staging/vboxvideo/vbox_fb.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > > 
> > > 
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Since Hans wants to destage vboxvideo this cycle probably best I merge
> > this through drm-misc? Just to make sure it's not lost.
> 
> Feel free to do so!

Applied, thanks for your review.

I think 2/2 is directly staging material for you (somehow
get_maintainers.pl didn't add you to the cc: list, not sure why ...).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
