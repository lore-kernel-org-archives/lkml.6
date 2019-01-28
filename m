Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86CA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOMZGOrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfA1FrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 00:47:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36402 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1FrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 00:47:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so13126982ljk.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 21:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmxwacvV2X+2fLgrSijRmToeR3d9OeB5adggOzEQjec=;
        b=cOMZGOrKfmZP0BOBS2oJl0wX2GqtXXoP48n7X5+IoPjXefyz8+ERBbyfaTmSNMW2Oj
         VLL6Eu/0QzYgS9qRgCC0WJctHNakLS+GLiKTEZxdAinTIqQGivRMLoN/nrZnsPmlB1p3
         7O28f8I9ZH4MoOOoriNlns0hiQVIIVLXcOxkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmxwacvV2X+2fLgrSijRmToeR3d9OeB5adggOzEQjec=;
        b=e9LUZGMZHiHkTnaouN0j4wTtCZdjnAd0sPCxV8emYOgCkaQIGdOpluJHQeCBZ7DmTR
         mqwkbFdHcaJevUMBtk21n854E5r/a+BG/kNChZ1s8X9bfo01qZvTS/g4dX5HHDVIVIaQ
         sHigL/zkUo9Mn9XSq2xZ5MqbSGsKid+7d2CzJdAPki+7PexjGLk9RFVxbEU196FfmHXu
         +XQbsKSMsbl0WTqPZP0t/egASw5g8z+rRiqmsIrZfnqutBlsKOTfTNALAO0YZNTNJ75G
         2FoEkXd04Kn8YkgC51SDxeCAtA3YANx2dsJf+MDIcW7Hq/uwjQEGc5xm0Z08If1pKL4D
         uKiw==
X-Gm-Message-State: AJcUukcaWylh8IAvPbU7PyWOOALa2yde8I2pX9BDYNKEsHB6E8Ec2xHp
        zUxX5QywDNXQUZ0UDh/Iu6l8NIKcpZ7qFAI3At3TyA==
X-Google-Smtp-Source: ALg8bN7P4iyroEcKJUGStK18rXTetfJ2sHs0gyKGavB+UaHbaKo9/He6XrVOEsfw66cCYTC1Fr8wpldp5riu6Acypbo=
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr17461613ljg.151.1548654431916;
 Sun, 27 Jan 2019 21:47:11 -0800 (PST)
MIME-Version: 1.0
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz> <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de> <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz> <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de> <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz> <CAMz4kuK5JgfZF7uXa83xC3eVCrZ8+wkZRdKq2s71o_QjT=OhGg@mail.gmail.com>
 <s5h1s51120e.wl-tiwai@suse.de> <CAMz4ku+h0HM4zmdb_a83gkW5EfVo24z74d7NQBSD8u8zdzaRUQ@mail.gmail.com>
 <s5hlg38zy7d.wl-tiwai@suse.de>
In-Reply-To: <s5hlg38zy7d.wl-tiwai@suse.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 28 Jan 2019 13:47:00 +0800
Message-ID: <CAMz4kuJq27vC-9eTRst8sLwxLhsZ4n9eCsNtLiQOiwe2fZAtxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Leo Yan <leo.yan@linaro.org>,
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

On Fri, 25 Jan 2019 at 21:03, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Jan 2019 12:11:43 +0100,
> Baolin Wang wrote:
> >
> > Hi Takashi,
> > On Fri, 25 Jan 2019 at 18:10, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Fri, 25 Jan 2019 10:25:37 +0100,
> > > Baolin Wang wrote:
> > > >
> > > > Hi Jaroslav,
> > > > On Thu, 24 Jan 2019 at 21:43, Jaroslav Kysela <perex@perex.cz> wrote:
> > > > >
> > > > > Dne 23.1.2019 v 13:46 Leo Yan napsal(a):
> > > > > > Hi all,
> > > > > >
> > > > > > On Wed, Jan 23, 2019 at 12:58:51PM +0100, Takashi Iwai wrote:
> > > > > >> On Tue, 22 Jan 2019 21:25:35 +0100,
> > > > > >> Mark Brown wrote:
> > > > > >>>
> > > > > >>> On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> > > > > >>>> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> > > > > >>>
> > > > > >>>>> It was the bit about adding more extended permission control that I was
> > > > > >>>>> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> > > > > >>>>> bit sounds like it might also work from the base buffer sharing point of
> > > > > >>>>> view, I have to confess I'd not heard of that feature before (it didn't
> > > > > >>>>> come up in the discussion when Eric raised this in Prague).
> > > > > >>>
> > > > > >>>> With permissions, I meant to make possible to restrict the file
> > > > > >>>> descriptor operations (ioctls) for the depending task (like access to
> > > > > >>>> the DMA buffer, synchronize it for the non-coherent platforms and maybe
> > > > > >>>> read/write the actual position, delay etc.). It should be relatively
> > > > > >>>> easy to implement using the snd_pcm_file structure.
> > > > > >>>
> > > > > >>> Right, that's what I understood you to mean.  If you want to have a
> > > > > >>> policy saying "it's OK to export a PCM file descriptor if it's only got
> > > > > >>> permissions X and Y" the security module is going to need to know about
> > > > > >>> the mechanism for setting those permissions.  With dma_buf that's all a
> > > > > >>> bit easier as there's less new stuff, though I've no real idea how much
> > > > > >>> of a big deal that actually is.
> > > > > >>
> > > > > >> There are many ways to implement such a thing, yeah.  If we'd need an
> > > > > >> implementation that is done solely in the sound driver layer, I can
> > > > > >> imagine to introduce either a new ioctl or an open flag (like O_EXCL)
> > > > > >> to specify the restricted sharing.  That is, a kind of master / slave
> > > > > >> model where only the master is allowed to manipulate the stream while
> > > > > >> the slave can mmap, read/write and get status.
> > > > > >
> > > > > > In order to support EXCLUSIVE mode, it is necessary to convert the
> > > > > > /dev/snd/ descriptor to an anon_inode:dmabuffer file descriptor.
> > > > > > SELinux allows that file descriptor to be passed to the client. It can
> > > > > > also be used by the AAudioService.
> > > > >
> > > > > Okay, so this is probably the only point which we should resolve for the
> > > > > already available DMA buffer sharing in ALSA (the O_APPEND flag).
> > > > >
> > > > > I had another glance to your dma-buf implementation and I see many
> > > > > things which might cause problems:
> > > > >
> > > > > - allow to call dma-buf ioctls only when the audio device is in specific
> > > > > state (stream is not running)
> > > >
> > > > Right. Will fix.
> > > >
> > > > > - as Takashi mentioned, if we return another file-descriptor (dma-buf
> > > > > export) to the user space and the server closes the main pcm
> > > > > file-descriptor (the client does not) - the result will be a crash (dma
> > > > > buffer will be freed, but referenced through the dma-buf interface)
> > > >
> > > > Yes, will fix.
> > >
> > > There are a few more overlooked problems.  A part of them was already
> > > mentioned in my previous reply, but let me repeat:
> > >
> > > - The racy ioctls have to be considered; you can perform this export
> > >   ioctl concurrently, and both of them write and mix up the setup,
> > >   which is obviously broken.
> >
> > Yes, I think I missed the snd_pcm_stream_lock, and will add.
>
> Beware that it's not so trivial.  The stream lock is usually
> spinlock.

Right. Thanks for your reminding.

>
> In addition, we need to be careful about the PCM state, as Jaroslav
> mentioned.  Basically SNDRV_PCM_STATE_SETUP is already too late for
> attaching the buffer, since another buffer is already assigned to the
> stream.  Similarly, after detaching, the stream state must go to
> SNDRV_PCM_STATE_OPEN.

Make sense.

>
> > > - What happens to the PCM buffer that has been allocated before
> > >   attaching, if it's not the pre-allocated one?
> > >   It should be released properly beforehand, otherwise leaks.
> >
> > I am not sure I understood you correctly. If the PCM buffer has been
> > allocated, the platform driver should handle it? Since we always use
> > substream->dma_buffer.
>
> substream->dma_buffer is merely a pre-allocated buffer, and not every
> driver sets it up.  The actual PCM buffer is found in substream's
> runtime, and this implementation isn't always with the preallocated
> buffer.  It can even be a fixed IO-mapped buffer.

OK. Thanks for your explanation.

>
> > > - There is no validation of the attached dma-buf pages; most drivers
> > >   set coherent DMA mask, and they rely on it.  e.g. if a page over the
> > >   DMA mask is passed, it will break silently.
> >
> > Sorry maybe I did not get your point here. We have validate the
> > dma_map_sg_attr() funtion, in this fucntion it will validate the DMA
> > mask by dma_capable().
>
> OK, then this should be fine -- at least about DMA mask.  But, how
> about other setups, e.g. coherency?
>
> Imagine that a buffer allocated for chip A is exported to another chip
> B.  If chip B requires some special setup of the pages while A isn't,
> this won't work.  For example, some HD-audio chips require the
> non-cached pages while some HD-audio chips allow normal pages.

OK. That's one case need to validate. Thanks for your comments.

-- 
Baolin Wang
Best Regards
