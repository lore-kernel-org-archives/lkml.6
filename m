Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100ADC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187C21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MCpHEQuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeLTIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:30:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45466 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbeLTIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:30:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so954403edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 00:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fsyK6tJi7Zn1otu4H0Ftvh9o5wjLyD3PvrBh7rF8Fy8=;
        b=MCpHEQuRGdiAG6GRUYJGYp6tMFQ+GUWDLF4zIeBgrUmyWVXeUaY35RUQCixU8rT/P1
         rFwzySBteMj2ctDBooTtcI5dUmL9ySUoXzVe2E+ml+B7Gl5Xm2KbOM6bB4FPJH/rv5H2
         7P+rFeTUzn283JrrVPtUg25vHHkLXtErnEqIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fsyK6tJi7Zn1otu4H0Ftvh9o5wjLyD3PvrBh7rF8Fy8=;
        b=cHYQLpIofb9ItENt+Jy36zGBG4MNQcAhru6CZS9xXdS/6HVWeqwCfqEUYbhwwKcaZp
         k5vd8coL/SPLmMd/gyoJE1OsORRcOsP9A3gNdJbEYyyD5Jz2YEHyP0jfedX4k84mkNsz
         NHm9VY5L7jyjfFESKg98FTcxQdVVVxkUKJpFhEjx+vFfwJNXfcU1f17MxpzwWkFf39ag
         41uXdRrNxc8ZeAZuYavXqZPlZz6mQyKdBQwOUeu0nncBf1cTMJ0xaLNr2L5vEvNaon+v
         ryUgDS+z2c8JTdEcO2kZZGW5vIuom7xRG0PdX2z7tHUvbfOTmCl3sOPJSdQ/1EMJpYA0
         fU9Q==
X-Gm-Message-State: AA+aEWZLDJHd4YgbDa2zV6s/OJ9v1c2nq3Dv0bl9rfBvjEEXoHdfR/+x
        KiUM6lLJif1pE1IvRkirMObtbQ==
X-Google-Smtp-Source: AFSGD/Wj4ISvKrMk25nmGWR7DpBIWlcX8cSpXulHurNttqLB+hqzkcBHSjG93Q9rBHBqWAy023LHBQ==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr23088543edp.258.1545294630284;
        Thu, 20 Dec 2018 00:30:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z39sm6037553edb.81.2018.12.20.00.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 00:30:29 -0800 (PST)
Date:   Thu, 20 Dec 2018 09:30:27 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, andr2000@gmail.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] drm/bochs: add edid present check
Message-ID: <20181220083027.GF21184@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, andr2000@gmail.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20181220065001.9594-1-kraxel@redhat.com>
 <20181220082826.GE21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220082826.GE21184@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:28:26AM +0100, Daniel Vetter wrote:
> On Thu, Dec 20, 2018 at 07:50:01AM +0100, Gerd Hoffmann wrote:
> > Check first two header bytes before trying to read the edid blob,
> > to avoid the log being spammed in case qemu has no edid support (old
> > qemu or edid turned off).
> > 
> > Fixes: 01f23459cf drm/bochs: add edid support.
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> It's a bit a hack, but makes sense.

On 2nd thought, maybe make it less of a hack by reading all 8 bytes of the
header and checking it with drm_edit_is_valid().
-Daniel

> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/gpu/drm/bochs/bochs_hw.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> > index c90a0d492f..e1f8ffce00 100644
> > --- a/drivers/gpu/drm/bochs/bochs_hw.c
> > +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> > @@ -89,6 +89,14 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
> >  	if (!bochs->mmio)
> >  		return -1;
> >  
> > +	/*
> > +	 * Check first two EDID blob header bytes to figure whenever
> > +	 * edid support is enabled in qemu.
> > +	 */
> > +	if (readb(bochs->mmio + 0) != 0x00 ||
> > +	    readb(bochs->mmio + 1) != 0xff)
> > +		return -1;
> > +
> >  	kfree(bochs->edid);
> >  	bochs->edid = drm_do_get_edid(&bochs->connector,
> >  				      bochs_get_edid_block, bochs);
> > -- 
> > 2.9.3
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
