Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C9FC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEA52064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X0eIJOvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEA52064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJISVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:21:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35536 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJISVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:21:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so1342486wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI2176wTydr9gQK6uMGzY7eFptfmtQQO88BpTrCjTQg=;
        b=X0eIJOvhAyQT1HXxPKnw1Z5RvgrB7Capm/KIbHsQ31MRpBwZuZ2VgviQ4gFgEYWnpN
         32KjZuqMCB5jytmt5Bnva0pKj0pey6NEjGJ6a4aFowBZUWQYGnlh3+nZtCkCYHweWz32
         Uv0LaNlMod3EzCeO/EIOHB9k9iStGntJQcDsXkiXf6Ygi5Bu7DHVzSdFXZCLNrYpzquJ
         wrGDhRvfppmFZe8moTPpdDbQ7frn+D7flhOPmhZn2utGw8DIF/Zjk3NnlGdLyK3c2wE3
         Iv25Pzj7TSWdsg4Ekr4Xm2JS1WwZB5hehZSnYLUkK5nly62bJSvuXICFTlF4LLrUJulb
         E29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI2176wTydr9gQK6uMGzY7eFptfmtQQO88BpTrCjTQg=;
        b=kKRug0VDK2p2JBdDKLakaOVpJZ8vc++P/Uaf1Rd8YcZwZH1EbTKWS9P/n5U9A5lBA5
         h+qNypqEi9z1anZC2CeOA8C2yOs6E2zqcZVrSd4nEXLgZWdC6lzEuS4PCHCtxuo4cRya
         KeUOZ6hmyMZ6dk4dTp7vqDZlHFWJZiSoWbTpMX67xTWrpiaYHKjzp55df4imyj5uwjdp
         kdDHNzkRbjtsFQPuuIzzT8KguO2cmp+V1tl0JAFXuYVDSkM8gclzO+WXM6h55V3q9ySB
         XgUwMIknZ6Zx1mOA7N9fIb8GH8IxSt0yKWbNGBnIk8b0s2vxptPJEYVhTLXvkeZxBR3W
         uc2g==
X-Gm-Message-State: ABuFfogkwyGzjJ1UeLOhWn3r8eSI1XbE2ZY8FnJKDMj1vYlVdakq1gAt
        jcZ9gVFANYMl6xrAEQstuPCXPwb7X/JzgGvCiigLEQ==
X-Google-Smtp-Source: ACcGV60AG4tLs7/u70kL3jU1/s9eHdR1iwcfdDJ9CCV3/rucTsJM4L4HhcFyaVsvXNeaDZCltsNGnW+8FQO+T2pN+JY=
X-Received: by 2002:adf:a547:: with SMTP id j7-v6mr21355118wrb.220.1539083083939;
 Tue, 09 Oct 2018 04:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181004133739.19086-1-mjourdan@baylibre.com> <CAAFQd5BTD6mwB1O4SVeKfKOho7cMMufuenu5xE0BjCAq1GuTag@mail.gmail.com>
In-Reply-To: <CAAFQd5BTD6mwB1O4SVeKfKOho7cMMufuenu5xE0BjCAq1GuTag@mail.gmail.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Tue, 9 Oct 2018 13:04:32 +0200
Message-ID: <CAMO6naz9tivLwmum1Fdq-fpsjG8tp1xThm65Ux_oJBPKL19i9A@mail.gmail.com>
Subject: Re: [PATCH] media: videodev2: add V4L2_FMT_FLAG_NO_SOURCE_CHANGE
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Tue, Oct 9, 2018 at 9:59 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Maxime,
>
> On Thu, Oct 4, 2018 at 10:38 PM Maxime Jourdan <mjourdan@baylibre.com> wrote:
> >
> > When a v4l2 driver exposes V4L2_EVENT_SOURCE_CHANGE, some (usually
> > OUTPUT) formats may not be able to trigger this event.
> >
> > Add a enum_fmt format flag to tag those specific formats.
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  Documentation/media/uapi/v4l/vidioc-enum-fmt.rst | 5 +++++
> >  include/uapi/linux/videodev2.h                   | 5 +++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> > index 019c513df217..e0040b36ac43 100644
> > --- a/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> > +++ b/Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
> > @@ -116,6 +116,11 @@ one until ``EINVAL`` is returned.
> >        - This format is not native to the device but emulated through
> >         software (usually libv4l2), where possible try to use a native
> >         format instead for better performance.
> > +    * - ``V4L2_FMT_FLAG_NO_SOURCE_CHANGE``
> > +      - 0x0004
> > +      - The event ``V4L2_EVENT_SOURCE_CHANGE`` is not supported
> > +       for this format.
> > +
> >
> >
> >  Return Value
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 3a65951ca51e..a28acee1cb52 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -723,8 +723,9 @@ struct v4l2_fmtdesc {
> >         __u32               reserved[4];
> >  };
> >
> > -#define V4L2_FMT_FLAG_COMPRESSED 0x0001
> > -#define V4L2_FMT_FLAG_EMULATED   0x0002
> > +#define V4L2_FMT_FLAG_COMPRESSED       0x0001
> > +#define V4L2_FMT_FLAG_EMULATED         0x0002
> > +#define V4L2_FMT_FLAG_NO_SOURCE_CHANGE 0x0004
>
> I think it indeed makes sense. I'd suggest submitting this patch
> together with the series that adds the affected driver, though, since
> we'd be otherwise just adding a dead API.
>
> Also, it would be good to refer to it from the Decoder Interface
> documentation. Depending on which one gets in earlier, you might
> either want to base on it or I'd add a note myself.
>
> Best regards,
> Tomasz

Agreed on both points. If your documentation makes it in before, I'll
update it within the patch. We'll have time to sync on that anyway in
the coming weeks.

Maxime
