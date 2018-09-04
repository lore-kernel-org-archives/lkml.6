Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43432077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OblZKcqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43432077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:30:14 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34411 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIDRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:30:14 -0400
Received: by mail-ua1-f67.google.com with SMTP id r15-v6so2795215uao.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xMBlk1xhJfYmzpnhc9zhpbrRbwfMC3Ul99na0u209Zw=;
        b=OblZKcqTn1FxY7oTtJEOqxFyBe78DFeP5vXcQNdajNByizu16uTjRREXTL5hopgbW8
         us36HF1zFzZ3RibQlSfRnBARVjFkLyoqEd3BlF8Y2ftkfr020Y+hXB9UzWpSkc/8leJE
         TSFKw4Gc8Ga6geXLwr3QaLuJn27Gz/tC/gEhJUCS3L6KyLlT238sXxuAYAqLvOeU/cLA
         dwtd7AgEVsvK+Yazy2gL+QRNo3cfBjAD+iPe3BNkVE67ivvHwnY63PSPJaj4izsoxZwE
         2An1TARBCuSndCjsODU5IBx3D0YSvdCFoNc0gJc1pCbdE9q2GH2c82h8bZRseaPsrYd3
         QCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xMBlk1xhJfYmzpnhc9zhpbrRbwfMC3Ul99na0u209Zw=;
        b=FXkKUKfpig9O/2BtrxIJ48GXAtCiu5/rLp69q4WSS5yPXR2Mvto5u+Hsvb2CFb3rGb
         LdgFJsqaCYT7L4fUGTgBl7hO3GQEaGlv8LHTFWVEFVrYAZWoxWrxEwPwXhkLP3/LquSi
         zVFbdheKDMVt+3sFnN3jCM/r4zEhDdwWLihyz0dgPlheUm2LeQ9ZI7Sq+EJiChHPHO6j
         67u2i7N5cIcvVjhzVPsMznGE6ZLgyv8S8s9WIj/6SxdaC0Zly38kaOe/xaHQ9ov97m2D
         BzMl1FZ0e02YzOQfyqRptgNHdBtrhU802EYpiQ5vpzE+KvDswkuN0vByH7L9xFHrsq9h
         I8EQ==
X-Gm-Message-State: APzg51Bju4OP03ky+1RrGJyWBvS39UvJGkAb7ff4ApuHWCwI+vNtnlWg
        k9uMSXTd/3bcQANqtuQBCci41DuM5OzoAk7EA2I=
X-Google-Smtp-Source: ANB0VdbRCy+8aGKvMrJHBzHP38Hx4RCwtWFukLAD262dc0C9XMCNEetM+eUNC9ioVBdlodzNEJMPz+quNxmXnDKrtvA=
X-Received: by 2002:ab0:72ca:: with SMTP id g10-v6mr17936058uap.33.1536066310077;
 Tue, 04 Sep 2018 06:05:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:26ca:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 06:05:09 -0700 (PDT)
In-Reply-To: <8e8f8cf3-c4d4-6bfd-4e53-536d4d0c79ff@daenzer.net>
References: <20180903105756.24912-1-kraxel@redhat.com> <20180903105756.24912-4-kraxel@redhat.com>
 <20180903164558.GL21634@phenom.ffwll.local> <CAKb7Uvh-UB6pR1r-D5sX0HwWwTExVzjxcdeAKNAmRWdqh=hKGw@mail.gmail.com>
 <8e8f8cf3-c4d4-6bfd-4e53-536d4d0c79ff@daenzer.net>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 4 Sep 2018 09:05:09 -0400
X-Google-Sender-Auth: sbGG1ZK3auqlEu5x_2-VQG2gqNA
Message-ID: <CAKb7UvicP594ASs4QutRH4oW1XZ2gTA5Fa=w8FPQzzKaSzDQuw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 4:00 AM, Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
> On 2018-09-03 7:07 p.m., Ilia Mirkin wrote:
>> On Mon, Sep 3, 2018 at 12:45 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Mon, Sep 03, 2018 at 12:57:54PM +0200, Gerd Hoffmann wrote:
>>>> Userspace on big endian machhines typically expects the ADDFB ioctl
>>>> returns a big endian framebuffer.  drm_mode_addfb() will call
>>>> drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
>>>> values though, which is wrong.  This patch fixes that.
>>>>
>>>> Drivers (both kernel and xorg) have quirks in place to deal with the
>>>> broken drm_mode_addfb() behavior.  Because of this we can't just chang=
e
>>>> drm_mode_addfb() behavior for everybody without breaking things.  So a=
dd
>>>> a new driver feature flag DRIVER_PREFER_HOST_BYTE_ORDER, so drivers ca=
n
>>>> opt-in.
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>>  include/drm/drm_drv.h             |  1 +
>>>>  drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
>>>>  2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>>>> index 46a8009784..9cf12596cd 100644
>>>> --- a/include/drm/drm_drv.h
>>>> +++ b/include/drm/drm_drv.h
>>>> @@ -57,6 +57,7 @@ struct drm_printer;
>>>>  #define DRIVER_KMS_LEGACY_CONTEXT    0x20000
>>>>  #define DRIVER_SYNCOBJ                  0x40000
>>>>  #define DRIVER_PREFER_XBGR_30BPP        0x80000
>>>> +#define DRIVER_PREFER_HOST_BYTE_ORDER   0x100000
>>>
>>> Hm, not a huge fan of using driver_flags for random little quirks. I th=
ink
>>> a boolean in sturct drm_mode_config would be much better. Bonus if you
>>> also move the 30bpp hack over to that. Something like
>>> mode_config.quirk_addfb_host_byte_order and
>>> mode_config.quirk_addfb_prefer_xbgr_30bpp or whatever. That has the ups=
ide
>>> of giving us a really nice place to put a huge comment about what this =
is
>>> supposed to do.
>>>
>>> I think otherwise this looks overall rather reasonable. I think the onl=
y
>>> other driver that ever cared about big endian was radeon/amdgpu. Would =
be
>>> good to get at least an ack from amd folks, or a "meh, stopped caring".
>>
>> and nouveau.
>>
>> I do believe that ADDFB should be made to always prefer host byte
>> order -- this is how all of the existing implementations work in
>> practice. However e.g. nouveau wants DRM_FORMAT_XRGB8888. But it still
>> treats it as host byte order. This will become more important in a
>> world where ADDFB2 is more common.
>>
>> So, I think that this change should be applied, drivers (I suspect
>> just nouveau and radeon) fixed up to consume the "new" formats, [...]
>
> As explained before, that would break radeon userspace on big endian host=
s.

We last discussed this about a year ago, so I hope you'll forgive my
lapse in memory...

There's userspace that uses ADDFB2 with DRM_FORMAT_XRGB8888 but
expects it to be host-endian? If so, that'll be a problem for nouveau
as well...

  -ilia
