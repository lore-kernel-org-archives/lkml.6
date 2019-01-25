Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E86C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE0021872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HbaMbqQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfAYEAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:00:06 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35681 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfAYEAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:00:05 -0500
Received: by mail-oi1-f176.google.com with SMTP id v6so6770069oif.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 20:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=frTA/JULdM/3750UTX6F39Mn273dFKrRMZ+7TZwryZU=;
        b=HbaMbqQ5R6bkwtLCmKGzSA+pYPmejfCk+d2lI5blP5cmXIfKqp4VZoKhh0Ap/Q5xX/
         ts3B7vAhwqQkn+Vj0bM6339W1waCdDjGfNYaSp7Lxm6mItun5w1dlsLqclhS/rbtyKiP
         BNhk5c7fexbdmXm4kzBOHr+k87GIiLGTctiJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=frTA/JULdM/3750UTX6F39Mn273dFKrRMZ+7TZwryZU=;
        b=pZIRXsEWjGXdxhOT4d4jKnhE90Ixo5nyMg6viNvoj7inzPFWHIb8WyUCMQo+1tX2FE
         YaI7UQBiVSp1P++PjJNKqvrKfdsEmmSX4U10NhhgGoMRX7afn3WwoZIsb03PZIZTLL/a
         55iv2LhdevINujtM+nIspsIVU9cO4yEMnPgD1vsYDMHg36bSKBFdxjFd/Acqw5wFMaLt
         Q1Xeok69uCSNdvENNb0UmtPleKmS6TFpK7SnpO3uhLlW3cy2KQL7pNEzHstN/+sAowXw
         ydF+4ffg0vc6KXghDEQhzbIn9J5d7IEsatmJHSqLM0k05ah+FJXgVWJXBw4rMdEzBymI
         d12g==
X-Gm-Message-State: AJcUukdZWDnQrKItYgRAvOhDxf0llVagsUrbjxiNhEuSjlm+uTWd4pJV
        Nwrnuc0+dsnu4Kvx8ArExYJCgi2L264KAw==
X-Google-Smtp-Source: ALg8bN6rzZNUDtLpVhjSDRX5M3N6sdlQIVjAVQeG1N01T5Bk57/wdODu5M8r64AM99fKvundulVQ4A==
X-Received: by 2002:aca:f103:: with SMTP id p3mr281927oih.94.1548388803891;
        Thu, 24 Jan 2019 20:00:03 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id q203sm841446oif.33.2019.01.24.20.00.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 20:00:02 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id r62so6789635oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 20:00:02 -0800 (PST)
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr280305oif.173.1548388801592;
 Thu, 24 Jan 2019 20:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20181022144901.113852-1-tfiga@chromium.org> <20181022144901.113852-3-tfiga@chromium.org>
 <4cd223f0-b09c-da07-f26c-3b3f7a8868d7@xs4all.nl> <CAAFQd5DthE3vL+gycEBgm+aF0YhRncrfBVBNLLF4g+oKhBHEWQ@mail.gmail.com>
 <75334288-69af-6680-fbe7-2dd5ef2462ea@xs4all.nl> <0452db20a894c1c4cce263b7e07ba274a58aa8fa.camel@ndufresne.ca>
In-Reply-To: <0452db20a894c1c4cce263b7e07ba274a58aa8fa.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 25 Jan 2019 12:59:49 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DGQvmdvV42Qz_yRVk1XCaYH6AMxWJgJ_PrECBM+U65uA@mail.gmail.com>
Message-ID: <CAAFQd5DGQvmdvV42Qz_yRVk1XCaYH6AMxWJgJ_PrECBM+U65uA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?UGF3ZcWCIE/Fm2NpYWs=?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:14 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 23 janvier 2019 =C3=A0 14:04 +0100, Hans Verkuil a =C3=A9crit=
 :
> > > > Does this return the same set of formats as in the 'Querying Capabi=
lities' phase?
> > > >
> > >
> > > It's actually an interesting question. At this point we wouldn't have
> > > the OUTPUT resolution set yet, so that would be the same set as in th=
e
> > > initial query. If we set the resolution (with some arbitrary
> > > pixelformat), it may become a subset...
> >
> > But doesn't setting the capture format also set the resolution?
> >
> > To quote from the text above:
> >
> > "The encoder will derive a new ``OUTPUT`` format from the ``CAPTURE`` f=
ormat
> >  being set, including resolution, colorimetry parameters, etc."
> >
> > So you set the capture format with a resolution (you know that), then
> > ENUM_FMT will return the subset for that codec and resolution.
> >
> > But see also the comment at the end of this email.
>
> I'm thinking that the fact that there is no "unset" value for pixel
> format creates a certain ambiguity. Maybe we could create a new pixel
> format, and all CODEC driver could have that set by default ? Then we
> can just fail STREAMON if that format is set.

The state on the CAPTURE queue is actually not "unset". The queue is
simply not ready (yet) and any operations on it will error out.

Once the application sets the coded resolution on the OUTPUT queue or
the decoder parses the stream information, the CAPTURE queue becomes
ready and one can do the ioctls on it.

>
> That being said, in GStreamer, I have split each elements per CODEC,
> and now only enumerate the information "per-codec". That makes me think
> this "global" enumeration was just a miss-use of the API / me learning
> to use it. Not having to implement this rather complex thing in the
> driver would be nice. Notably, the new Amlogic driver does not have
> this "Querying Capabilities" phase, and with latest GStreamer works
> just fine.

What do you mean by "doesn't have"? Does it lack an implementation of
VIDIOC_ENUM_FMT and VIDIOC_ENUM_FRAMESIZES?

Best regards,
Tomasz
