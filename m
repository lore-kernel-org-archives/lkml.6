Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F5CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B1A218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZccyEPbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbeLTRYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:24:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40783 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeLTRYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:24:55 -0500
Received: by mail-io1-f65.google.com with SMTP id a11so668313ioq.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSA5gs/ZifaYC4ma/nfmRciTJmrE2PXhZpn0M4qEG3s=;
        b=ZccyEPbJCJ8z8RM1UJ4Gb1HiSb0QY1Kd4BZB2LpCo+ykbwcuBC4bOO3eUscfWDpfjP
         8w+OKISwii9GJi1f+c/jb9fEyGci6XfG6IXbuAap9a6jsmqlMUxY1iTU3D0JprZTk2vn
         SuuCP/Tz1t0GIwwb68U2oHBIGoOYYXGtee4WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSA5gs/ZifaYC4ma/nfmRciTJmrE2PXhZpn0M4qEG3s=;
        b=lQeIKZhTxpbDmOFNH932oxjbvgbvL9CNUwS/235UB/jcfwjYkfLtzrMF+KPMEqunbc
         cmTDt7GgMdgnCsjUvE5pdrR0kvdi9p6p0JECd9k3LadPjT1GWhE/oQ3wr6LLd1Ul2DTK
         xRvplsgy4BGGTBiXFTwE5/Ip9Q20ersZgCgz46r0LbEP83kL9G7hgDqYSSEFDJIMoiB/
         XgqFREGPlyEVdcpfSB72AKV+nB6DYP+ehJUomSUKZOi6HXN/s12g/hki5rru2CLQfHwJ
         ZsKYx7ylBl3MsKZR5i0aL4cXrvoZ+6y406Apee358Kg0dzkEE2IN4RjZNGy1SMR+9bHc
         6Lzw==
X-Gm-Message-State: AA+aEWZT4h2PtX3yjmM7UMouCELNTh0bLK1UopAnW60C4PN1Ekp7rjB0
        Dj18tHqGPb1tp9vPJDa9ovP/x8fzgMqHmfvoZZTQYg==
X-Google-Smtp-Source: AFSGD/VzqY5EM7GwsKAAFwkr6Sj+n2UYHGQcIH1YUEAsYT+WLLm5E2beM5rfEj9J1qURnmKURpucGlrbneQ+Sy2UzLo=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr23302153ioa.34.1545326694110;
 Thu, 20 Dec 2018 09:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com> <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com> <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
 <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
 <CADnq5_P9nsquCV95CSZC4NCr7YNJ76ZmCruJA=f1N8dLGYm=ow@mail.gmail.com>
 <CAKMK7uHu5XMQzr7ocVEcpDS9H6pQ-BHfHNE51_YK7rLkTQC_9g@mail.gmail.com>
 <CADnq5_P1smiGhYyoZQsEAJG0+jBx6f75HwEFAf2RkaoNp0HEiA@mail.gmail.com>
 <CAKMK7uGSiBv9H_xAj2fuk=XYocefQU4bFk+fPr=iWGsaPxOwhw@mail.gmail.com> <fb45217c-d9ad-b208-d55d-51299ead108b@daenzer.net>
In-Reply-To: <fb45217c-d9ad-b208-d55d-51299ead108b@daenzer.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Dec 2018 18:24:42 +0100
Message-ID: <CAKMK7uGd-108KqnmiT_KQPhjJdnegKAVZszBNpz2rcK14T4crg@mail.gmail.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Alex Deucher <alexdeucher@gmail.com>, dnicoara@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>, kernel@collabora.com,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 6:16 PM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
>
> On 2018-12-20 6:09 p.m., Daniel Vetter wrote:
> > On Thu, Dec 20, 2018 at 6:03 PM Alex Deucher <alexdeucher@gmail.com> wr=
ote:
> >> On Thu, Dec 20, 2018 at 11:54 AM Daniel Vetter <daniel@ffwll.ch> wrote=
:
> >
> >>> Not sure about the gamma thing since we had opposite bugs on i915
> >>> about gamma not being vsynced and tearing terribly. Cursor is special
> >>> since it tends to be too small to notice tearing.
> >>
> >> Our cursor hw (and possibly gamma as well Nicholas?  Harry?) is double
> >> buffered, so we can update it any time for the most part and the
> >> changes won't take affect until the next vupdate period.
> >
> > Hm, I guess we could make the gamma update optionally async, and let
> > drivers deal. The issue is that the current async helper stuff won't
> > cope with gamma updates (it's aimed at plane updates only, not at crtc
> > property updates). Or we get userspace to do proper atomic updates. Or
> > we do some faking in the kernel, e.g. waiting with the gamma update
> > until the next atomic update happens. But that kinda breaks
> > ->atomic_check.
>
> Would it be possible to merge gamma changes into a pending commit, if
> there is one, and create a new commit otherwise?
>
> Otherwise the atomic API just moves this same problem to be solved by
> userspace.

I guess possible, depending upon how much you want to type. The problem is:
- stopping the current commit before it gets too far
- without causing stutter in itself (we don't want a stream of cursor
updates to livelock pageflips)
- re-running atomic_check on the new combined commit (which I guess
means you somehow need a clean starting state again and apply both
updates, which currently isn't possible)
- push it out as a commit

Alternatively is some fudging in the backend like we do now have some
support for for async plane updates. We'd need the full trickery with
a dedicated async_update_check though, at least on i915 we need to (in
some cases) make sure the gamma ramp is monotonic and stuff like that.

Or we just give up on commone semantics on this and have legacy gamma
updates bypass atomic in dc somehow (which would be the unstructured
version of the above).
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
