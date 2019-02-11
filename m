Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BBDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2220421B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AjRLzuWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbfBKSud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:50:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39398 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfBKSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:50:32 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so784094itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZapxLI32VqhEKflGXevWywiAvo1ir7SljgRNwS7jPI=;
        b=AjRLzuWca5LpycTlRylxklTmrZ1UcCXX7morNM2jwrCwPDbbxytn0nJjH8VTsEhTEH
         9GRqnPVQCfeeVHtjEjvGzL9WejY7j/GSrzqKAV0wM0iYf/6IkYNVRofiRGXyWakLBuCj
         MhRsSheQs5Oe/Rxq8QsEiu3piYjtd9GEhH8eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZapxLI32VqhEKflGXevWywiAvo1ir7SljgRNwS7jPI=;
        b=MRtZqcGyocOA7y8DwI2zZyhD5zLCGfwtBivj2zvdkE7B/EIHQ/fAf1vRpdA9HRYqKL
         J3+VNEdEEJBcekXY3ixZHtvc6S5Mg2FCYS/fuiYwZzLbtIVRoFWrOraz9YehelfJ2MJH
         adD9A+sBIAw08On1kEVmN8WYwRKU9Mi5BuiWWVUw/ctOk0NoIDO+0+GaPyS7QqvXspS3
         Gk3rodzV3fIBuSf2H9asdnoQz32bKpgjojY7JbGmmMHcE8fsKpNnzWEsvMh/UWpbNeeS
         EX0u3saJJOtjxKuP4fvZMCzif1IojfSRHGSxY5Qlvo8/qgOh7EUOxKmirYXlzKF7gwiT
         2cng==
X-Gm-Message-State: AHQUAuaC71SzgjGhDMUgkzJqhq82dzc6FqspnPP9lrNgZFPwGqHImJU9
        fGy9W9gY1XsHvqz7Pz1gd0/N8XflRCGA/d+6U2mpRg==
X-Google-Smtp-Source: AHgI3IYyt389es4MTjSJj5nsOQKdJ2WCwhHq/87ZPFXunfbfoFUhI11Q0lcvdVGd7Yye4Sg+GFfDqQsxwsSHaQqYgNU=
X-Received: by 2002:a02:c943:: with SMTP id u3mr19551276jao.96.1549911032276;
 Mon, 11 Feb 2019 10:50:32 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
 <20190211182512.GA28363@ravnborg.org>
In-Reply-To: <20190211182512.GA28363@ravnborg.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 11 Feb 2019 19:50:21 +0100
Message-ID: <CAKMK7uENU2dc6eKqzTYwNs=4uAVhDv1GSA1KpuAEB8ZANCsS1A@mail.gmail.com>
Subject: Re: [PULL] topic/component-typed
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "DRM maintainer tools announcements, discussion, and development" 
        <dim-tools@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:25 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Daniel.
>
> On Mon, Feb 11, 2019 at 06:15:20PM +0100, Daniel Vetter wrote:
> > Hi all,
> >
> > Here's the typed component topic branch.
> >
> > drm-intel maintainers: Please pull, I need this for the mei hdcp work from Ram.
> >
> > drm-misc maintainers: Please pull, there's a drm doc patch follow-up
> > that I want to stuff into drm-misc-next.
> >
> > Greg: The drm side missed our feature cutoff, so will only land in 5.2.
>
> With all the dependencies why not bend the rule a little and get this in now?
> It is not like this is a huge patchset.

The feature that depends upon this is almost 40 patches. That's a bit
much for bending :-) Hence why I'm asking Greg to pull this, so it's
not stuck out of tree for 3 months for no good reason.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
