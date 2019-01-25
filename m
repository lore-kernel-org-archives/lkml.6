Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377F4218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRUKIBTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfAYLL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:11:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41758 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYLL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:11:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so6648070lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4nZ8haCiD9aMxNe4xvhCOtfga74GqsGwEJe4KcLbLc=;
        b=MRUKIBTNlYGmNnfQUKmW24eHo/82D6eUWC3RNE3UP3W3BJMSO0gzq/2gp88GHL1W3p
         13I9UcxRMKiPeGSxNuh6GQr98j79TpUT6uitntzJ6x2PkVieeziBup52kIgcHDpA5CLP
         i4+z6YhGdpeMMB2mvqi74sElw6qu8YoP2wADE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4nZ8haCiD9aMxNe4xvhCOtfga74GqsGwEJe4KcLbLc=;
        b=ki5bMq2RUAsjV87FReo0b2p0ovk3qNweDGCMq4s4dpu/7Ol+yl8YXw2dPna7LFRBco
         z9LHhhXlj0mlhwulWJ7BeSrzIsAsOKxepa2x9yQdruI0E7ewQUibZ9rIzvJ9ujBQURIg
         Nt+/NZIyVmWwGY4gp8OL3sn7I3m06O8908Z2F4YSa1xViWWskwVmoTEoBf0nScwKHwF6
         n98Vd1Qs4mIB0Prhz073+cv8Em1shqTBoyVn3RDg0++qf7QDY/1+oIRYsJsQYhiwePJs
         oL1TB2U0PcuXlc+tai4zxvS3w+t6O1nl1M9XbQ69dyt0TCDca3bF9U2dtiKafrJhKUGX
         xIdw==
X-Gm-Message-State: AJcUukdYFnnm8Y6nilryIhkfLGzvwvvgwE33q0qGO8ybgl2zr2LSlVEQ
        QzJbEzEYzFD8IaeuJNLU5dndUbk2KSZ8hQkXWW7/2w==
X-Google-Smtp-Source: ALg8bN7d+YTmxmnVTOdWK3rHVl29fuWqO2e+J2z1kj816LXq5VTNnMkno3T8U3pBiKUqbqTEvn3iQJqo+M6Emoq5JKU=
X-Received: by 2002:a19:e601:: with SMTP id d1mr8780228lfh.71.1548414715826;
 Fri, 25 Jan 2019 03:11:55 -0800 (PST)
MIME-Version: 1.0
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz> <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de> <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz> <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de> <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz> <CAMz4kuK5JgfZF7uXa83xC3eVCrZ8+wkZRdKq2s71o_QjT=OhGg@mail.gmail.com>
 <s5h1s51120e.wl-tiwai@suse.de>
In-Reply-To: <s5h1s51120e.wl-tiwai@suse.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 25 Jan 2019 19:11:43 +0800
Message-ID: <CAMz4ku+h0HM4zmdb_a83gkW5EfVo24z74d7NQBSD8u8zdzaRUQ@mail.gmail.com>
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

Hi Takashi,
On Fri, 25 Jan 2019 at 18:10, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Jan 2019 10:25:37 +0100,
> Baolin Wang wrote:
> >
> > Hi Jaroslav,
> > On Thu, 24 Jan 2019 at 21:43, Jaroslav Kysela <perex@perex.cz> wrote:
> > >
> > > Dne 23.1.2019 v 13:46 Leo Yan napsal(a):
> > > > Hi all,
> > > >
> > > > On Wed, Jan 23, 2019 at 12:58:51PM +0100, Takashi Iwai wrote:
> > > >> On Tue, 22 Jan 2019 21:25:35 +0100,
> > > >> Mark Brown wrote:
> > > >>>
> > > >>> On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> > > >>>> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> > > >>>
> > > >>>>> It was the bit about adding more extended permission control that I was
> > > >>>>> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> > > >>>>> bit sounds like it might also work from the base buffer sharing point of
> > > >>>>> view, I have to confess I'd not heard of that feature before (it didn't
> > > >>>>> come up in the discussion when Eric raised this in Prague).
> > > >>>
> > > >>>> With permissions, I meant to make possible to restrict the file
> > > >>>> descriptor operations (ioctls) for the depending task (like access to
> > > >>>> the DMA buffer, synchronize it for the non-coherent platforms and maybe
> > > >>>> read/write the actual position, delay etc.). It should be relatively
> > > >>>> easy to implement using the snd_pcm_file structure.
> > > >>>
> > > >>> Right, that's what I understood you to mean.  If you want to have a
> > > >>> policy saying "it's OK to export a PCM file descriptor if it's only got
> > > >>> permissions X and Y" the security module is going to need to know about
> > > >>> the mechanism for setting those permissions.  With dma_buf that's all a
> > > >>> bit easier as there's less new stuff, though I've no real idea how much
> > > >>> of a big deal that actually is.
> > > >>
> > > >> There are many ways to implement such a thing, yeah.  If we'd need an
> > > >> implementation that is done solely in the sound driver layer, I can
> > > >> imagine to introduce either a new ioctl or an open flag (like O_EXCL)
> > > >> to specify the restricted sharing.  That is, a kind of master / slave
> > > >> model where only the master is allowed to manipulate the stream while
> > > >> the slave can mmap, read/write and get status.
> > > >
> > > > In order to support EXCLUSIVE mode, it is necessary to convert the
> > > > /dev/snd/ descriptor to an anon_inode:dmabuffer file descriptor.
> > > > SELinux allows that file descriptor to be passed to the client. It can
> > > > also be used by the AAudioService.
> > >
> > > Okay, so this is probably the only point which we should resolve for the
> > > already available DMA buffer sharing in ALSA (the O_APPEND flag).
> > >
> > > I had another glance to your dma-buf implementation and I see many
> > > things which might cause problems:
> > >
> > > - allow to call dma-buf ioctls only when the audio device is in specific
> > > state (stream is not running)
> >
> > Right. Will fix.
> >
> > > - as Takashi mentioned, if we return another file-descriptor (dma-buf
> > > export) to the user space and the server closes the main pcm
> > > file-descriptor (the client does not) - the result will be a crash (dma
> > > buffer will be freed, but referenced through the dma-buf interface)
> >
> > Yes, will fix.
>
> There are a few more overlooked problems.  A part of them was already
> mentioned in my previous reply, but let me repeat:
>
> - The racy ioctls have to be considered; you can perform this export
>   ioctl concurrently, and both of them write and mix up the setup,
>   which is obviously broken.

Yes, I think I missed the snd_pcm_stream_lock, and will add.

>
> - The PCM buffer can be re-allocated on the fly.  If the current
>   buffer is abandoned while exporting, it leads to the UAF.

So I need some validation to check if the buffer is available now when
exporting it.

>
> - Similarly, what if the PCM stream that is attached is closed without
>   detaching itself?  Or, what if the PCM stream attaches itself twice

We will detach it automatically in snd_pcm_free_stream()

>   without detaching?

Sure, need add validation for this case.

>
> - The driver may provide its own mmap method, and you can't hard-code
>   the mmap implementation as currently in snd_pcm_dmabuf_mmap().
>
>   I suppose you can drop of most of the code in snd_pcm_dmabuf_map(),
>   instead, assign PCM substream in obj, and call snd_pcm_mmap_data()
>   with the given VMA.  If this really works, it manages the mmap
>   refcount, so the previous two issues should be covered there.
>   But it needs more consideration...

Ah, I think I missed the snd_pcm_mmap_data() function. Yes, so I can
remove the implementation in snd_pcm_dmabuf_map().

>
> - What happens to the PCM buffer that has been allocated before
>   attaching, if it's not the pre-allocated one?
>   It should be released properly beforehand, otherwise leaks.

I am not sure I understood you correctly. If the PCM buffer has been
allocated, the platform driver should handle it? Since we always use
substream->dma_buffer.

>
> - There is no validation of the attached dma-buf pages; most drivers
>   set coherent DMA mask, and they rely on it.  e.g. if a page over the
>   DMA mask is passed, it will break silently.

Sorry maybe I did not get your point here. We have validate the
dma_map_sg_attr() funtion, in this fucntion it will validate the DMA
mask by dma_capable().

>
> - Some drivers don't use the standard memory pages but keep their own
>   hardware buffer (e.g. rme96 or rm32 driver).  This ioctl would be
>   completely broken on such hardware.
>   That is, we need some sanity check whether the PCM allows the
>   arbitrary dma-buf or not.

Make sense. Need add some validation to make sure if this PCM can export or not.

Very appreciated for your useful comments.

-- 
Baolin Wang
Best Regards
