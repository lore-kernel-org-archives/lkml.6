Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F74C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F94208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfABAS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:18:29 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:34515 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfABAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:18:28 -0500
Received: by mail-vk1-f170.google.com with SMTP id y14so6300532vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 16:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bVP/VlkzopXdl2ZE8d3yFjIcd4AYzuqNHO3EiEZ5sI=;
        b=n2z8hYYtIHfjZBtqWGpU+Ar/l5nOShnM6ffyAk2CFdYuq1M3x2uZAAFd4Z1PKmVx8G
         xIe7ojezfojuns6BrnbIIKK95KGIq471K2Wq32KOcZXN0FbxyGh8DRI6XZHthMFbsEy8
         k3DkamGvMkFcpTjSy4rMjXG0nI07g6fPGdbvGBNI0csqaX0Z58+z6KLycp+Fhv+ajiet
         Kka0jbnMvlvfj9eLpNZ0/jdzg7l0Kd4OlGgW5NHXvjTBcFg40vPEeS6UZk7NFP7tWVes
         Tbbsy5rxc2QzjbXl8wnYqduGi5nZs8zD0AfoC17MHLqIV9wreefbDeSTQWH30NFGv+DT
         Gk5g==
X-Gm-Message-State: AJcUukeM278+B40Z9e3zUcIBNVNmQPD67izW6GhVoyEzrZPMliDYmg9m
        JAv2PsTsxlD1Ewy36zi0w99MjRadvtqLSxvrD3s=
X-Google-Smtp-Source: ALg8bN7NDIQillWZfrZ27NOUt3f+t1vqzPEz1SFMvRxgDnGCslanJ168I54d1UKTaWAwoUu2LHLQYgPOAGl9zc3iI6Q=
X-Received: by 2002:a1f:2acd:: with SMTP id q196mr1756488vkq.7.1546388307186;
 Tue, 01 Jan 2019 16:18:27 -0800 (PST)
MIME-Version: 1.0
References: <cb43e1cb-dffa-26d8-c938-49ca4b48d38a@nisi.nl> <CAKb7UvjMCGOdKybtUrV9DRY1vjiQvi+pkzf2FCHefdedqMGnig@mail.gmail.com>
 <bff355c8-286f-bf49-4056-02dd10fce222@nisi.nl>
In-Reply-To: <bff355c8-286f-bf49-4056-02dd10fce222@nisi.nl>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 1 Jan 2019 19:18:16 -0500
Message-ID: <CAKb7UviWGEWSzHeEd1rONqzEfY7S9U2Khw5d-gW_8RZyihwphw@mail.gmail.com>
Subject: Re: Nouveau module X server not starting on a NP900X5N Kaby Lake machine
To:     Jan Vlietland <j.vlietland@nisi.nl>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 5:30 PM Jan Vlietland <j.vlietland@nisi.nl> wrote:
>
> Hi Ilia, many thanks for answering my mail.
>
> Tonight I tried to see what happens if I generate a xorg.conf file and place it in /etc/X11/xorg.conf, as described here:
> https://askubuntu.com/questions/4662/where-is-the-x-org-config-file-how-do-i-configure-x-there
>
> When I do that X starts without the framebuffer error. X starts with a backtrace list in the shell and then stops with the error:
>
> 'Segmentation fault at address 0x0.
>
> Fatal sever error etc etc etc.

Unless you're an advanced user, you'll get the best results by not
supplying a manual xorg.conf. Generically, this indicates that you
messed something up. Without knowing precisely what the contents of
that file are, it would be difficult to say what exactly went wrong.
However I wouldn't advise this path without a good reason.

>
> Hope this helps!
>
> In fact the above is part of a much bigger issue I have with the
> machine. When I enable the i915 module (Kaby lake native video) my
> screen goed black after a while. The machine is totally stuck in that
> state. Even ssh connection is not possible. It shows no errors in the
> (saved) logs after restarting the machine.
>
> So I disabled the i915 module and try to get the nvidia card running.
> Without any luck.
>
> Thank you for inviting me for irc.freenode.net. What it the procss to
> get access?

It's an IRC network like any other. More info about the network
available at https://freenode.net/

It's open to anyone... #nouveau for nouveau, #intel-gfx for intel.

>
> I have included the full dmesg in zip format.
>
> For me it is a showstopper using the machine with Linux. I really do not
> understand that I am the only person on this planet that cannot run
> Linux on a plain vanilla Kaby lake machine.

I don't know the specifics of your laptop, but on many other GM108M
laptops, the displays are only attached to the Intel GPU. So running
without i915 is just not an option, if you want anything displayed.
You would be able to use the GM108M chip for 3D acceleration if you
chose, but nothing to do with actual display.

If your screen goes black with i915 loaded, I suspect that you'd be
better served reporting this issue to Intel.

From your logs, you also appear to have a variety of combinations of
nomodeset/<driver>.modeset=0 combinations -- these will just impede
the proper mode of operation. The i915 and nouveau drivers effectively
do nothing under those conditions.

Cheers,

  -ilia
