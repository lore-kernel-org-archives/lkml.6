Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75112C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300E72229F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="coXgqy+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfBKTSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:18:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53990 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfBKTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:18:16 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so1022851ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSTr/tjYxhugjI24h+EFyggOUULYK7QZLv9YhVgvuW4=;
        b=coXgqy+APp+w5bv9xpYKNjR+eE2UyLD7erLpwrCg5l0OzTB4+1tFx3XCr4PVgPDGm3
         hf2F5auIOQ9uy2rdqx/1QSTFv+Ef0qrxrO+I0Bo73OIkki0MZrPZKmQNydT4z913dDnT
         wEAaL+0RbW+eGneFc7yn5Qulzw+0UfusfjebM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSTr/tjYxhugjI24h+EFyggOUULYK7QZLv9YhVgvuW4=;
        b=Ao6/r27qqMAFGNC0zzpLq9OLhedczZFQ8Zl5DdrV1S8BhrPiIVORX+HQq2cIMvJhSe
         sarJjSB1QD7koKzqc46kljQYzHdEFWjZmLf5Qw/ejo3tWZ3GZ9mNeWuQRtVNmg6f23nP
         v8yp930zN3OIsbL+WtAzMX5C3W6pe/o7uLPbvZjyLBtZMRDGMKa9lf0087La71CJMiFn
         go6G9Nl9rWqveAGo4IHXvMLM2rYM713OftSNb+/0PryMuX+2NiQkNnsSOK9egIGsTmri
         qKgQg0c0M9vCPQVw09pGO+Aa3oj8ea+kUWGQ/l5WCk5X5l1zldLk7dt2Sp8VkfSv0d2+
         1ZUw==
X-Gm-Message-State: AHQUAuaAgrVguyUPjU7zTtUqno2qwIBAc+pU14K4q1y2K3P5bo3ak68g
        RYDR3KrNeGyjzwWY0tthKQiJU3b5jqrHoRazgylKZg==
X-Google-Smtp-Source: AHgI3IZCrgCKLVyKjySfz4Q3v05NLWaYsTVZ+xuTb4c28LS5tf0c+y4TIl5OF1jjlZ5QSrxwcF1paXEhzed6F0/rxfU=
X-Received: by 2002:a5d:848d:: with SMTP id t13mr3345963iom.278.1549912695467;
 Mon, 11 Feb 2019 11:18:15 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
 <20190211182512.GA28363@ravnborg.org> <s5ho97idugs.wl-tiwai@suse.de>
In-Reply-To: <s5ho97idugs.wl-tiwai@suse.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 11 Feb 2019 20:18:04 +0100
Message-ID: <CAKMK7uGuJZiQZ2hSwod5VwT69FVhR6HeREc07Bx3QD=a3QQ=Gw@mail.gmail.com>
Subject: Re: [PULL] topic/component-typed
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        discussion and development DRM maintainer tools
         announcements <dim-tools@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:57 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 11 Feb 2019 19:25:12 +0100,
> Sam Ravnborg wrote:
> >
> > Hi Daniel.
> >
> > On Mon, Feb 11, 2019 at 06:15:20PM +0100, Daniel Vetter wrote:
> > > Hi all,
> > >
> > > Here's the typed component topic branch.
> > >
> > > drm-intel maintainers: Please pull, I need this for the mei hdcp work from Ram.
> > >
> > > drm-misc maintainers: Please pull, there's a drm doc patch follow-up
> > > that I want to stuff into drm-misc-next.
> > >
> > > Greg: The drm side missed our feature cutoff, so will only land in 5.2.
> >
> > With all the dependencies why not bend the rule a little and get this in now?
> > It is not like this is a huge patchset.
>
> Yeah, that's likely the most straightforward way.
>
> BTW, I tried to pull onto sound git tree for-next branch, and it
> worked without conflicts.  So I don't think it needs to be pulled onto
> mine.

Yeah right now it's all conflict free, I'm more worried about what's
going to happen the next 3 months. That's also why I think it'd be
good if Greg can pull this still.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
