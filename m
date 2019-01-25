Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD59C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C71218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZqQCptAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfAYJZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:25:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35584 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYJZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:25:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so7801594ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 01:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eIRXC8Qs0yBu6nECtDxUYfOGdY6bXoicNmJjLjCDWg=;
        b=ZqQCptAH/xUPXMub994PXuyKFy5Bm8TBfp39K+ZgK+ja7o54ENqmzMAoN/0oubUd/4
         XpGjTvWLsI8sFcaIusjgVPY+cHxHI/zgc2NAMSkW8ZxLzJbl0Qzt4cUuSpAHQezqrPh4
         xZooFyZ7SBWMHvkN98uP5X4526pOwKLPxxHoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eIRXC8Qs0yBu6nECtDxUYfOGdY6bXoicNmJjLjCDWg=;
        b=PwW+lZTGAEfIKdD7TtLAB09M4cJGi1ssBpdE25ntsg5zu/fzTAn1tNBge/5HBdvU4l
         8fQR+kFyKj5/vTGT9yYie6PCdIC2nQoPOuh/9o3GhpoIs+yBeAQo/INUnbXdNd3a3ZWh
         vTkDqjuMGAYkoiXO1z/ketEfHwcwDgU80wjvwGYHNg79KbGlflY09Ic3GKLA7YvuxMFB
         zjfUmZa1aw55OtMHZnYMWcQ+YMT4yKoQs9YLlqg6HcKnSiFtr/XrWuo0rLS5QLnAKt++
         B4uBmYnQa8Ciq7rIRX4vujmoeuf7aN8B9w08seNMlsubgIGbAGn4/tK+PmAQoX97nXC7
         5+zA==
X-Gm-Message-State: AJcUukdcgL2i5a+2N8gkq7q+E7qtka4l7nJF05ypV7SGI5H92577ZckC
        llhVh2JcteTHuGAdTPGUAhZK6Di5moclUBK/QoWjbQ==
X-Google-Smtp-Source: ALg8bN4LNbA9SAEUyRYhzljxzDHBq2CHweZXB7QqZ8zP1za8ZR3uGpdT83E3Ke0p+XhaoJnhgS0NxkhC6K3Vx7nVSdw=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr8337654ljj.9.1548408349294;
 Fri, 25 Jan 2019 01:25:49 -0800 (PST)
MIME-Version: 1.0
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz> <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de> <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz> <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de> <20190123124658.GE15906@leoy-ThinkPad-X240s> <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
In-Reply-To: <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 25 Jan 2019 17:25:37 +0800
Message-ID: <CAMz4kuK5JgfZF7uXa83xC3eVCrZ8+wkZRdKq2s71o_QjT=OhGg@mail.gmail.com>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Leo Yan <leo.yan@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, bgoswami@codeaurora.org,
        sr@denx.de, gustavo@embeddedor.com,
        Phil Burk <philburk@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        mchehab+samsung@kernel.org, sboyd@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        anna-maria@linutronix.de, Jon Corbet <corbet@lwn.net>,
        Jeffery Miller <jmiller@neverware.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        joe@perches.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        colyli@suse.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,
On Thu, 24 Jan 2019 at 21:43, Jaroslav Kysela <perex@perex.cz> wrote:
>
> Dne 23.1.2019 v 13:46 Leo Yan napsal(a):
> > Hi all,
> >
> > On Wed, Jan 23, 2019 at 12:58:51PM +0100, Takashi Iwai wrote:
> >> On Tue, 22 Jan 2019 21:25:35 +0100,
> >> Mark Brown wrote:
> >>>
> >>> On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> >>>> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> >>>
> >>>>> It was the bit about adding more extended permission control that I was
> >>>>> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> >>>>> bit sounds like it might also work from the base buffer sharing point of
> >>>>> view, I have to confess I'd not heard of that feature before (it didn't
> >>>>> come up in the discussion when Eric raised this in Prague).
> >>>
> >>>> With permissions, I meant to make possible to restrict the file
> >>>> descriptor operations (ioctls) for the depending task (like access to
> >>>> the DMA buffer, synchronize it for the non-coherent platforms and maybe
> >>>> read/write the actual position, delay etc.). It should be relatively
> >>>> easy to implement using the snd_pcm_file structure.
> >>>
> >>> Right, that's what I understood you to mean.  If you want to have a
> >>> policy saying "it's OK to export a PCM file descriptor if it's only got
> >>> permissions X and Y" the security module is going to need to know about
> >>> the mechanism for setting those permissions.  With dma_buf that's all a
> >>> bit easier as there's less new stuff, though I've no real idea how much
> >>> of a big deal that actually is.
> >>
> >> There are many ways to implement such a thing, yeah.  If we'd need an
> >> implementation that is done solely in the sound driver layer, I can
> >> imagine to introduce either a new ioctl or an open flag (like O_EXCL)
> >> to specify the restricted sharing.  That is, a kind of master / slave
> >> model where only the master is allowed to manipulate the stream while
> >> the slave can mmap, read/write and get status.
> >
> > In order to support EXCLUSIVE mode, it is necessary to convert the
> > /dev/snd/ descriptor to an anon_inode:dmabuffer file descriptor.
> > SELinux allows that file descriptor to be passed to the client. It can
> > also be used by the AAudioService.
>
> Okay, so this is probably the only point which we should resolve for the
> already available DMA buffer sharing in ALSA (the O_APPEND flag).
>
> I had another glance to your dma-buf implementation and I see many
> things which might cause problems:
>
> - allow to call dma-buf ioctls only when the audio device is in specific
> state (stream is not running)

Right. Will fix.

>
> - as Takashi mentioned, if we return another file-descriptor (dma-buf
> export) to the user space and the server closes the main pcm
> file-descriptor (the client does not) - the result will be a crash (dma
> buffer will be freed, but referenced through the dma-buf interface)

Yes, will fix.

>
> - the attach function calls dma_buf_get(fd), but what if fd points to
> another dma-buf allocation from a different driver? the unexpected
> private data will cause crash - there should be a type checking in the
> dma-buf interface

There is a validation (is_dma_buf_file() ) in dma_buf_get() function
before getting the dma buffer.

> If I look to the dma_buf_fd() implementation:
>
>   fd = get_unused_fd_flags(flags);
>   fd_install(fd, dmabuf->file);
>
> .. what if we just add one new ioctl to the ALSA's PCM API which will
> return a new anonymous inode descriptor with the restricted access to
> the main PCM device to satisfy the SELinux requirements / security
> policies? It might be more nice and simple solution than to implement
> the full dma-buf interface for the ALSA's PCM devices.

I will do some investigation for your suggestion and talk with the
security people if it can work. Thanks for your suggestion.

-- 
Baolin Wang
Best Regards
