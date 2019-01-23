Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CFAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110F2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7IPtJng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAWWpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:45:31 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33778 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfAWWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:45:30 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so4441287qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBN9+Vx9iCgfzbRy0Z/tbyKhcKMziGnnOqwny6ysS2w=;
        b=e7IPtJngFyfSnbcNOl4NO3GYiKjwAvffRWXCK8QAfXu7vXe2Iyh7cR97vjMCx++jkZ
         iNpFMbH+RkIdsgetmPY/u22MF/C+2SaoNBUTOhEPUVVD+LpBpVSgl9dzVYiGwy2EXuCy
         2uMmGbkeM/1ItqFZDRi+uVbNJfzEiA2LpBtOX6I/QLaBinPUea/C2dER3o8erj9rZgFX
         fJ1w9id0yV3H1bbGvAh6M8IIDOaOf+x0m3Sah/4f89mSxujDiGXcH6coUlqwEeNGJdcn
         vRgIUR8uuUl1KIMpGcLgAtg4G6U3lw3PeaWhgfe7zMvNI5xFdZQ+7PQf2W/cmDqkhuYw
         km1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBN9+Vx9iCgfzbRy0Z/tbyKhcKMziGnnOqwny6ysS2w=;
        b=lbiimtM98+exH3Aqcvisa8IOpDb5xCqkVBKoobh9c1SqGrjW4ntpN1+Gvg27/s3V3k
         tnqNUsL3smmZk+LiK6zv9SfZswOQLFKpYOYX1szIiJvNvbaH5dBOH1b9OBV9pixTliGX
         LuZkWviY0m0aq6FB6Mo0g8SD7FPnIdF9Lf9itQsbypy+S/QnfKPAXMm87qx1bzipEtw0
         Kmc+bWzF3jLMjYLsClJZZEQ7HdHD6V73gc5+4/R0GsL6Um3zWI8QZcGWtASzsxhZx936
         LwMESZmTdrPwuU7r55DZN0t1YYH292q38IfrOmBt8KB50YXvtXECUUVjtahHnpF3iZ/L
         zmsw==
X-Gm-Message-State: AJcUukfBgeJQeUHSrVu7k+sS84+ciSFRTX7KDnwrg3tC2Ph/19cMaZXD
        g+0a5243fMZ44SUX/KwXOFh3G6K7A8a8cPiJE6U=
X-Google-Smtp-Source: ALg8bN7Y6gFMgY97dqzo7HhILQdT/pp5M60ANyvMvYlqLUjAjIlTs6sJTk3+pQSI9l4VRoxKeua4/icskcL5/lcv9VU=
X-Received: by 2002:a0c:e84f:: with SMTP id l15mr3678454qvo.124.1548283529432;
 Wed, 23 Jan 2019 14:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com> <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
In-Reply-To: <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 24 Jan 2019 08:45:17 +1000
Message-ID: <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        andrew.donnellan@au1.ibm.com, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Adding Daniel as well.
> >
> > Dave.
> >
> > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > > Habana Labs since its inception two and a half years ago.
> > >
> > > Hey Oded,
> > >
> > > So this creates a driver with a userspace facing API via ioctls.
> > > Although this isn't a "GPU" driver we have a rule in the graphics
> > > drivers are for accelerators that we don't merge userspace API with an
> > > appropriate userspace user.
> > >
> > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > >
> > > I see nothing in these accelerator drivers that make me think we
> > > should be treating them different.
> > >
> > > Having large closed userspaces that we have no insight into means we
> > > get suboptimal locked for ever uAPIs. If someone in the future creates
> > > an open source userspace, we will end up in a place where they get
> > > suboptimal behaviour because they are locked into a uAPI that we can't
> > > change.
> > >
> > > Dave.
>
> Hi Dave,
> While I always appreciate your opinion and happy to hear it, I totally
> disagree with you on this point.
>
> First of all, as you said, this device is NOT a GPU. Hence, I wasn't
> aware that this rule might apply to this driver or to any other driver
> outside of drm. Has this rule been applied to all the current drivers
> in the kernel tree with userspace facing API via IOCTLs, which are not
> in the drm subsystem ?  I see the logic for GPUs as they drive the
> display of the entire machine, but this is an accelerator for a
> specific purpose, not something generic as GPU. I just don't see how
> one can treat them in the same way.

The logic isn't there for GPUs for those reason that we have an
established library or that GPUs are in laptops. They are just where
we learned the lessons of merging things whose primary reason for
being in the kernel is to execute stuff from misc userspace stacks,
where the uAPI has to remain stable indefinitely.

a) security - without knowledge of what the accelerator can do how can
we know if the API you expose isn't just a giant root hole?

b) uAPI stability. Without a userspace for this, there is no way for
anyone even if in possession of the hardware to validate the uAPI you
provide and are asking the kernel to commit to supporting indefinitely
is optimal or secure. If an open source userspace appears is it to be
limited to API the closed userspace has created. It limits the future
unnecessarily.

> There is no way that "someone" will create a userspace
> for our H/W without the intimate knowledge of the H/W or without the
> ISA of our programmable cores. Maybe for large companies this request
> is valid, but for startups complying to this request is not realistic.

So what benefit does the Linux kernel get from having support for this
feature upstream?

If users can't access the necessary code to use it, why does this
require to be maintained in the kernel.

> To conclude, I think this approach discourage other companies from
> open sourcing their drivers and is counter-productive. I'm not sure
> you are aware of how difficult it is to convince startup management to
> opensource the code...

Oh I am, but I'm also more aware how quickly startups go away and
leave the kernel holding a lot of code we don't know how to validate
or use.

I'm opening to being convinced but I think defining new userspace
facing APIs is a task that we should take a lot more seriously going
forward to avoid mistakes of the past.

Dave.
