Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16EBC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3E2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSpkGHfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfBZDdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:33:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43951 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBZDdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:33:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so9206428oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5rOPCXVYhiYoHCNxhBvnBjYe0OD6bY/IhZavDc2Ft4=;
        b=PSpkGHfrD7ywUKhO5AnLdYc4Ix8MVH01bzHlkIVekyFM2i0Fy/Cz4LU4ylQPm3C8t7
         YnxJWl4GeSsJ6LSqGqO6gd3f4CVLcUDZMcxrRGq3PH78Cs8CSW7zqRHgVIETuHVWEBSY
         U0SQz7EXLNAnibQTlaIHhroiZxNKCF1ehJVgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5rOPCXVYhiYoHCNxhBvnBjYe0OD6bY/IhZavDc2Ft4=;
        b=erji+cq2AMjRyLLgd8quuQc8Nuft0E/tfLE2jInOQr1vM91EbTgucJFk9g9JA3+c13
         GHuf0yWqri6sYkIGNPEIbZ1b2eiUiz1RA50fxThqbr7AP8HCp4ZYGy0E8pTm4tGGQ6qQ
         kvVsfBjAHRV7ffKZa4RuRGYN/HjqlYX8uaDxoV9zqIhvxP++KOpwz1BXh3wfH4GcHfDV
         JVE7tsQXv08mBI4BkTlfAQNx7xXAue3tJyoU52KPNzdOOXh8DMyiwWtH42p4YtOy5CE8
         CZ2/MZB39ZPo+hq0DTy+UinOH8qx0vjQbYxbj8omb4Wix6aUCA9BPMpe+Td6FdhbDXJ7
         nYAw==
X-Gm-Message-State: AHQUAuYYj8/qprsUZyqEzHFLB/XMGgZDMznCsKZX6NipL+seE1VVooMy
        FLQEg2Kmfa16AcygZfFCJKzWZcnNo0o=
X-Google-Smtp-Source: AHgI3IbFnZq6+aDnQjNU5DvCv3yD++L2bsdr+1igjtCmLvm28dp6lCBByuHe2Romcv6ET50M480Ogw==
X-Received: by 2002:aca:3306:: with SMTP id z6mr1066962oiz.45.1551152011100;
        Mon, 25 Feb 2019 19:33:31 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id n187sm4935291oia.34.2019.02.25.19.33.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 19:33:25 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id g16so9242069oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 19:33:25 -0800 (PST)
X-Received: by 2002:aca:df45:: with SMTP id w66mr1025554oig.94.1551152005052;
 Mon, 25 Feb 2019 19:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20190213055317.192029-1-acourbot@chromium.org>
 <CAPBb6MUDK0s665wjSjvo3ZePtmFXFrs2WqpaywOSjnRxp08Ong@mail.gmail.com>
 <b24e3e67-9fb3-3602-8a90-826f8c51eadf@xs4all.nl> <3de0825971b91ea0b8fd349f4ecf8164de14254a.camel@bootlin.com>
 <7caf9381-e920-f5fc-e8f9-a54ac2733add@xs4all.nl> <e19f0821a831c45829c2921ab091b7c6ed80c8f5.camel@bootlin.com>
In-Reply-To: <e19f0821a831c45829c2921ab091b7c6ed80c8f5.camel@bootlin.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 26 Feb 2019 12:33:13 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW24uJ9dgw3_ME=8shh1NSOy7s2mCmq+vFxm=jM2iH9MQ@mail.gmail.com>
Message-ID: <CAPBb6MW24uJ9dgw3_ME=8shh1NSOy7s2mCmq+vFxm=jM2iH9MQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: docs-rst: Document m2m stateless video decoder interface
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for the delayed reply!

On Wed, Feb 13, 2019 at 8:04 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 2019-02-13 at 10:57 +0100, Hans Verkuil wrote:
> > On 2/13/19 10:20 AM, Paul Kocialkowski wrote:
> > > Hi,
> > >
> > > On Wed, 2019-02-13 at 09:59 +0100, Hans Verkuil wrote:
> > > > On 2/13/19 6:58 AM, Alexandre Courbot wrote:
> > > > > On Wed, Feb 13, 2019 at 2:53 PM Alexandre Courbot <acourbot@chromium.org> wrote:
> > > > > > [snip]
> > > > > > +Buffers used as reference frames can be queued back to the ``CAPTURE`` queue as
> > > > > > +soon as all the frames they are affecting have been queued to the ``OUTPUT``
> > > > > > +queue. The driver will refrain from using the reference buffer as a decoding
> > > > > > +target until all the frames depending on it are decoded.
> > > > >
> > > > > Just want to highlight this part in order to make sure that this is
> > > > > indeed what we agreed on. The recent changes to vb2_find_timestamp()
> > > > > suggest this, but maybe I misunderstood the intent. It makes the
> > > > > kernel responsible for tracking referenced buffers and not using them
> > > > > until all the dependent frames are decoded, something the client could
> > > > > also do.
> > > >
> > > > I don't think this is quite right. Once this patch https://patchwork.linuxtv.org/patch/54275/
> > > > is in the vb2 core will track when a buffer can no longer be used as a
> > > > reference buffer because the underlying memory might have disappeared.
> > > >
> > > > The core does not check if it makes sense to use a buffer as a reference
> > > > frame, just that it is valid memory.
> > > >
> > > > So the driver has to check that the timestamp refers to an existing
> > > > buffer, but userspace has to check that it queues everything in the
> > > > right order and that the reference buffer won't be overwritten
> > > > before the last output buffer using that reference buffer has been
> > > > decoded.
> > > >
> > > > So I would say that the second sentence in your paragraph is wrong.
> > > >
> > > > The first sentence isn't quite right either, but I am not really sure how
> > > > to phrase it. It is possible to queue a reference buffer even if
> > > > not all output buffers referring to it have been decoded, provided
> > > > that by the time the driver starts to use this buffer this actually
> > > > has happened.
> > >
> > > Is there a way we can guarantee this? Looking at the rest of the spec,
> > > it says that capture buffers "are returned in decode order" but that
> > > doesn't imply that they are picked up in the order they are queued.
> > >
> > > It seems quite troublesome for the core to check whether each queued
> > > capture buffer is used as a reference for one of the queued requests to
> > > decide whether to pick it up or not.
> >
> > The core only checks that the timestamp points to a valid buffer.
> >
> > It is not up to the core or the driver to do anything else. If userspace
> > gives a reference to a wrong buffer or one that is already overwritten,
> > then you just get bad decoded video, but nothing crashes.
>
> Yes, that makes sense. My concern was mainly about cases where the
> capture buffers could be consumed by the driver in a different order
> than they are queued by userspace (which could lead to the reference
> buffer being reused too early). But thinking about it twice, I don't
> see a reason why this could happen.

Do we have a guarantee that it won't happen though? AFAICT the
behavior that CAPTURE buffers must be processed in queue order is not
documented anywhere, and not guaranteed by VB2 (even though
implementation-wise it may currently be the case). So with the current
state of the specification, the only safe wording I can use is "do not
queue a reference buffer back until all the frames depending on it
have been dequeued".

However, as Hans mentioned it would be nice to be able to assume that
the capture queue is FIFO and let user-space rely in that fact to
queue buffers containing reference frames earlier.

>
> > > > But this is an optimization and theoretically it can depend on the
> > > > driver behavior. It is always safe to only queue a reference frame
> > > > when all frames depending on it have been decoded. So I am leaning
> > > > towards not complicating matters and keeping your first sentence
> > > > as-is.
> > >
> > > Yes, I believe it would be much simpler to require userspace to only
> > > queue capture buffers once they are no longer needed as references.
> >
> > I think that's what we should document, but in cases where you know
> > the hardware (i.e. an embedded system) it should be allowed to optimize
> > and have the application queue a capture buffer containing a reference
> > frame even if it is still in use by already queued output buffers.
> >
> > That way you can achieve optimal speed and memory usage.
> >
> > I think this is a desirable feature.
>
> Yes, definitely.

I guess the question comes down to "how can user-space know that the
hardware supports this"? Do we have a flag that we can return to
signal this behavior? Or can we just define the CAPTURE queue as being
FIFO for stateless codecs? The latter would make sense IMHO.

Cheers,
Alex.
