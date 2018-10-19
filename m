Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD71C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE672087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODenqL5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE672087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJSIhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:37:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45391 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:37:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id e10-v6so36508952qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qDbS8wUV3QMrMoEKhzozPZquJCx127Y3LkBL0qqMKs=;
        b=ODenqL5jO8Wtpkebt5wALm+f6tRN+6xj9YpuEdMFBP0w5FVF4ZX0+BPOpwsMsdEHgo
         zmgkyCoMxc+uKrXoO7Q0zyHXde8YaYcRosElKjz9X7l1xerjW9DZAz8VRQoZtNAVHfvZ
         mfy4ICpnHSXGWbSi57HeBKCP1gZT87y4u9p8phWhYAJjbdMOum27AeSBLpt7wKWHPZKh
         ItjKhqXDhmsVy9d2a+ESotpdnmlysT2h+YYtjYvKMejqmtRWAa8/+mMnZvyhRCCxlY8P
         fftq8q4B+qj41aeYvImk5xQ2IE2XA9v587WKa10B8NzzOozYoxOH/ZAdz6Gly5V4zfRf
         9MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qDbS8wUV3QMrMoEKhzozPZquJCx127Y3LkBL0qqMKs=;
        b=CY6km0LIKcR6cqE7H9/rDKYMw85aX1YfNzJrXuEMx5fYaGkG53qlCWMyNUb2EHotaV
         V5LVuESwQB9oCIlHdff9xKgE4zDoOvZC7z5YJlQbwaEjUxCqLXy2t/QWG+pq9fa54D+6
         F9ENofS0vgiSE6KJQbtRr02ziO3j15750C4v9b0jVixLquddntM2q3Gy9hoLXPO8Xjy1
         KbA3F7Im4K4ZFpbA0vsjJ4jPXpcD83BX1/zGPLqvYzXM1oWQmHsSGjjwcye5rWL0IWrY
         x7bfUloM0YXCzfNhJyEgfgqVhSSzfJoc3mRRZZCl9wD7RzaYj0Za5I4d8y2JMWjtOHq4
         zhWQ==
X-Gm-Message-State: ABuFfojgGv+Iv3sazcv47LxjOUGHUTNe8Nm06ZV16w0UQMEJSuBlocvT
        XZPrUPEiulxQdpeZIVzJ60DmF+e4t43yvKC7iLvZlg==
X-Google-Smtp-Source: ACcGV61mHF5lvXnn550wazb3A4HtY6Kcwxpr14OKNBzlC2mJIB8fCpzv2PIVbfRd50b5QVrelAfsHm9et+Wg86OcTbM=
X-Received: by 2002:ac8:1739:: with SMTP id w54-v6mr30794617qtj.76.1539909208033;
 Thu, 18 Oct 2018 17:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181001103222.11924-1-kraxel@redhat.com> <20181001103222.11924-8-kraxel@redhat.com>
 <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
 <20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org> <CAPM=9tzwcPtOfNuoKdbSY0=EBsbsKgM04HZpzAazPEmDbQOXSw@mail.gmail.com>
 <20181018070004.mplea3ozamph6uzu@sirius.home.kraxel.org>
In-Reply-To: <20181018070004.mplea3ozamph6uzu@sirius.home.kraxel.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Oct 2018 10:33:15 +1000
Message-ID: <CAPM=9tw1piSdEWAyOzcymoaFWp_kDP0JEaqX_Bxuvx2gK+RsZQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach} calls.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 at 17:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > > This to me feels more like a bind/unbind operation rather than a
> > > > populate/unpopulate operation,
> > > >
> > > > bind is " Bind the backend pages into the aperture in the location"
> > > >
> > > > whereas populate is
> > > >
> > > > allocate pages for a ttm.
> > >
> > > I ran into that trap too ;)
> > >
> > > My first attempt was to map this to bind/unbind.  But this is not
> > > correct and therefore didn't work very well.
> > >
> > > virtio_gpu_object_attach() will send a scatter list of the pages
> > > allocated for the object to the host (so the host knows where to
> > > copy from/to when processing the transfer_from/to calls).  So IMO
> > > it should be done on population not when binding.
> >
> > Well bind on AGP is the same thing, we'd fill the AGP GART table on
> > bind, so that the AGP GPU could access the pages.
>
> > So I'm interested in why using bind/unbind failed if you have some more info?
>
> Need to try again to be sure, but IIRC I saw multiple bind/unbind calls
> for the same object.  ttm probably does it to not waste AGB GART address
> space for objects not in use.  But for virtio it is pointless overhead.
> But maybe it is just a matter of taking a reference and keeping it for
> the whole lifetime of the object to make the binding permanent ...

Hmm maybe for the bind/unbind, not sure what would cause unbind except
for the object being moved back out of the TT space and into system,
it might be worth confirming what happens here, as I really do feel
bind/unbind is the correct interface to use here.

Dave.
