Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD25A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L9CzlTwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfBUPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:17:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51812 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfBUPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:17:15 -0500
Received: by mail-it1-f194.google.com with SMTP id e24so9186884itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQSwTTk/jGiN8Jm5zLtM+Utj24Hp0+iZ+JLRuJwgLMA=;
        b=L9CzlTwgkMjOB7AZie/JuAqD5pRIm7PO7pTEe0kP0D+6LK/GegABBiId4Va4AJXEWN
         Mq3noMSU1nbV3ZuNndBU7atlXRV5L9xgvPgAQB/45RzSf61dQCfRQDxDxYMvTNZ9z4rQ
         xsgqo11EXJ2q2bf72QL+vkw2FJk2dTntLCqIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQSwTTk/jGiN8Jm5zLtM+Utj24Hp0+iZ+JLRuJwgLMA=;
        b=umKYGD2LInjHsf62vufr2a/ZeskE9Gd1qd8PY/+AoEZVLfn9WF+YsGduUTQ48ag900
         MO37L9wPOA7esQfEjvY3d8ToZ9lbkBvvQqskJ1D/V+JPRuiC5ECIzknkE05b8BJTmsPp
         Nvf0TVpI5IWx2dTqwtu1yugt+s9m5jYqw+0Lkoc15CrkYGn+yLBeTDJqYPGtuei1DTB7
         We2ysi9NDEWRHBdmnixmivWE6PN2cNcCDFyn7CSs9EAtBkhh0LO/G5roFrl/JjfIs6vH
         9TuKnQpoLWiSQcQcZsCWIEx7kR0yBNu6vMkssdxRblCbU9RDsb1cfoe8VNP2V0xZUrLG
         etqw==
X-Gm-Message-State: AHQUAuZbNGf2j2r2gCcHwMWYrJKf6q1OfwiOEw3x6DnvSDkIJfqhq/pP
        d+wX5ug2J9PJWdHvoMLPzpOj2G1sve/FkqnLcxnryg==
X-Google-Smtp-Source: AHgI3IY9+ycfkBeSJPKedSH0bfYSLyiidR7ELyZrlDi6VPtz9Ikd9mOjfOuFH06+meQpYKiKSa9mkwzpBYhPOaO5Qd8=
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr9199376itl.51.1550762234902;
 Thu, 21 Feb 2019 07:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20190221113534.20764-1-kraxel@redhat.com> <20190221113534.20764-3-kraxel@redhat.com>
 <20190221122011.GP2665@phenom.ffwll.local> <20190221151139.ul2ihzd2yi4m47tf@sirius.home.kraxel.org>
In-Reply-To: <20190221151139.ul2ihzd2yi4m47tf@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 21 Feb 2019 16:17:03 +0100
Message-ID: <CAKMK7uE+YzvBuaJVrNc0VzTQKmnDzNMoZDXohrh0M+PAfRFcBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/qxl: kick out vgacon
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 4:11 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > I was thinking of checking whether pdev is a VGA class device and whether
> > it decodes vga access, and in that case automatically calling
>
> How can I figure that?  Ok, class is easy, but decode?  pci.h offers
> functions to set vga decode but not to get that info ...

PCI_COMMAND_MEM and PCI_COMMAND_IO. There doesn't seem to be any
separate bits really. That's at least what I've gleaned from vgaarb.c.
The magic legacy vga decode bits only seem to exist on bridges, maybe
we can extract that logic from vgaarb.c (yes this is all a bit
spiralling out of control).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
