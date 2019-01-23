Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA9420870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4h02q/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAWMrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:47:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42662 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfAWMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:47:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so1757952otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEuV0IZGNPx4wPD5B0RND0eWY9Q7+l5E7gAXbSBWa8E=;
        b=Q4h02q/oWVaWJ9NgeMAz6sQ05FxemkRRnvs/ySScJl8lzevOv2OKwFomjeZdoqofgE
         qTMeRXxdjypmKbULek8aAlNgxTxrH+qdEUktvMvipLu7raZPEHoJVDgLaKxW+hfNfmko
         RS7RJhPrBDp32K7Qpi690oKHKvjyFXskcpW+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEuV0IZGNPx4wPD5B0RND0eWY9Q7+l5E7gAXbSBWa8E=;
        b=CDKiXCTii6JVvzwDpodZEApGH6tHIbyd18SEPhDttF6gDkzwdxdNBR7QC4UZ8Y0QNl
         DOJwgUe1ybKUnl0t8vSSDke34LfUdCSFo8yOV9hwihrr79O8kLAJG5mgP5Amw0NqJwq0
         kGE+F5iElOmLX32GXzD51BUxTxbke0iOZRWHbXjscXAyhp2rxdt3H7gqcagNiG18gENt
         VGKxJClE/sVjmyKw2iBvLYCCGfUBFNRESzcXHQCUAoVjaq1AKXBha1Q5SOyTnS+GdBPq
         IUfa+sQTRdmjazx7be9goH98JHK3FwyoVznWOm2gLybs5jHHBEIk2VfsKCsr2YRn5G8+
         OTuw==
X-Gm-Message-State: AJcUukfSD2JAiGouwFiyu77nYgqF35vw+YxNgxQHE6TToZTuNY3khwUx
        KBPK+39UY42EKQXzmsZao679rQ==
X-Google-Smtp-Source: ALg8bN5ucjiF2jJkwGMJA7j66T2ZCXy4oy/6HCIdVO4nLoF0K4a0j/nOT+XJsp/QlxP6WwJpMeiTBA==
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr1274768otq.353.1548247629246;
        Wed, 23 Jan 2019 04:47:09 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1118-108.members.linode.com. [45.79.19.108])
        by smtp.gmail.com with ESMTPSA id b128sm9193462oif.7.2019.01.23.04.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 04:47:08 -0800 (PST)
Date:   Wed, 23 Jan 2019 20:46:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, arnd@arndb.de, keescook@chromium.org,
        bgoswami@codeaurora.org, sr@denx.de, gustavo@embeddedor.com,
        philburk@google.com, willy@infradead.org,
        mchehab+samsung@kernel.org, sboyd@kernel.org, vkoul@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        daniel.thompson@linaro.org, mathieu.poirier@linaro.org,
        srinivas.kandagatla@linaro.org, anna-maria@linutronix.de,
        corbet@lwn.net, jmiller@neverware.com,
        ckeepax@opensource.wolfsonmicro.com, joe@perches.com,
        o-takashi@sakamocchi.jp, colyli@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
Message-ID: <20190123124658.GE15906@leoy-ThinkPad-X240s>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4l9z4mbo.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, Jan 23, 2019 at 12:58:51PM +0100, Takashi Iwai wrote:
> On Tue, 22 Jan 2019 21:25:35 +0100,
> Mark Brown wrote:
> > 
> > On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> > > Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> > 
> > > > It was the bit about adding more extended permission control that I was
> > > > worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> > > > bit sounds like it might also work from the base buffer sharing point of
> > > > view, I have to confess I'd not heard of that feature before (it didn't
> > > > come up in the discussion when Eric raised this in Prague).
> > 
> > > With permissions, I meant to make possible to restrict the file
> > > descriptor operations (ioctls) for the depending task (like access to
> > > the DMA buffer, synchronize it for the non-coherent platforms and maybe
> > > read/write the actual position, delay etc.). It should be relatively
> > > easy to implement using the snd_pcm_file structure.
> > 
> > Right, that's what I understood you to mean.  If you want to have a
> > policy saying "it's OK to export a PCM file descriptor if it's only got
> > permissions X and Y" the security module is going to need to know about
> > the mechanism for setting those permissions.  With dma_buf that's all a
> > bit easier as there's less new stuff, though I've no real idea how much
> > of a big deal that actually is.
> 
> There are many ways to implement such a thing, yeah.  If we'd need an
> implementation that is done solely in the sound driver layer, I can
> imagine to introduce either a new ioctl or an open flag (like O_EXCL)
> to specify the restricted sharing.  That is, a kind of master / slave
> model where only the master is allowed to manipulate the stream while
> the slave can mmap, read/write and get status.

I am lacking security related knowledge, especially for SELinux.
So only can give background information but not sure if it's really
helpful for discussion.

Android web page [1] give some information for this:

"The shared memory is referenced using a file descriptor that is
generated by the ALSA driver. If the file descriptor is directly
associated with a /dev/snd/ driver file, then it can be used by the
AAudio service in SHARED mode. But the descriptor cannot be passed to
the client code for EXCLUSIVE mode. The /dev/snd/ file descriptor
would provide too broad of access to the client, so it is blocked by
SELinux.

In order to support EXCLUSIVE mode, it is necessary to convert the
/dev/snd/ descriptor to an anon_inode:dmabuffer file descriptor.
SELinux allows that file descriptor to be passed to the client. It can
also be used by the AAudioService.

An anon_inode:dmabuffer file descriptor can be generated using the
Android Ion memory library."

So we work out dmabuf driver for audio buffer, the audio buffer will
be exported and attached by using dma-buf framework; then we can
return one file descriptor which is generated by dma-buf and this
file descriptor is bound with anon inode based on dma-buf core code.

If we directly use the device node /dev/snd/ as file descriptor, even
though we specify flag O_EXCL when open it, but it still is not an
anon inode file descriptor.  Thus this is not safe enough and will be
blocked by SELinux.  On the other hand, this patch wants to use
dma-buf framework to provide file descriptor for the audio buffer, and
this audio buffer can be one of mutiple audio buffers in the system
and it can be shared to any audio client program.

Again, I have no less knowledge for SELinux so sorry if I introduce any
noise at here.  And very appreciate any comments for this.

Thanks,
Leo Yan

[1] https://source.android.com/devices/audio/aaudio
