Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF79C20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIFhgxY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF79C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeIDTki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:40:38 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:32912 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIDTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:40:38 -0400
Received: by mail-vk0-f65.google.com with SMTP id m125-v6so1483673vka.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BXuwfKc0xT+2FptSsLXHy2rBURpTiayqGrCyrqoHOsY=;
        b=qIFhgxY607Iejv7B0zWJJWweUo09sORrgx/oflaQMW3VGataxNHdkGJw8+748iOpPJ
         H4mYNT6wAyYdq673w9u/zz3FeIwX93O70GRqlIUr2zlo91e2WL57BVv8pwtj8JyF7ZWI
         D01FMC7WfF5k0FyT0zfTb5zkEzGxiHOMKHj7UuqPXU3nNsYU8Jtc6+EBM5MPcZHIIfui
         KxiyWSmAcmUK99RvpgFI6E9gBNsp0F8sjWoYHGMcUKHc0GyGlyCc7l2MJ0SUiZh/jA7T
         ncha2iElGZ2KaYDSNoD7fcLS34rn7+GMs1b+8duSd0W7p004TCFkCYa7Dqt7uY1+j6Z9
         VCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BXuwfKc0xT+2FptSsLXHy2rBURpTiayqGrCyrqoHOsY=;
        b=BIY+HXztOJIoAu90KwKQguz6sMVvKe7ssD0fp5SBe+emIEA57QxiBHD8E5lIYz+kFM
         yqq5QQCd3q9fx5jBrsHD0FWEvbsVGHu6xLzvWqf8x3Sb9OOyNy6SA4MVlQ61iIOGdtxD
         3C6s/ZrsyyhFHGfJFQJpkMVt23ev3yOrdtKu983YNixiPfG8zRvloXHAD/XaeLwHmCX1
         fFjGGlBHAfCoWHHJThINxX5BtuMhAh6n57TOG6Kierx05PrR5QQLPgSPpRu0CM/cqOiN
         ngTGtNzS/WLJToGZ7x+4iBxqjI1xl11U6uPFcM2n3IA8GVwVf26So5rzAt+JNt2iT4gl
         kLGA==
X-Gm-Message-State: APzg51CpbHAy5jkONXKorAKu/Iis1HbXtSGbCxmPXI7HUhgCWYkDJ+8v
        oBP65RiHm8KFMUEAy1JZ4oqaam6owBjIUD1qBL0=
X-Google-Smtp-Source: ANB0VdYB5PWwnqr2WSR1wuUPlbLHH/o2jcwVkfkSQgWq+KLnXT9/Fn4hWohEaSmJsul41zoubHFNqUpjATh+l8Eypgc=
X-Received: by 2002:a1f:a2cc:: with SMTP id l195-v6mr16468437vke.95.1536074106188;
 Tue, 04 Sep 2018 08:15:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:26ca:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:15:05 -0700 (PDT)
In-Reply-To: <4262e9d1-75c9-1be3-08bd-1ef842a13f2f@daenzer.net>
References: <20180903105756.24912-1-kraxel@redhat.com> <20180903105756.24912-4-kraxel@redhat.com>
 <20180903164558.GL21634@phenom.ffwll.local> <CAKb7Uvh-UB6pR1r-D5sX0HwWwTExVzjxcdeAKNAmRWdqh=hKGw@mail.gmail.com>
 <8e8f8cf3-c4d4-6bfd-4e53-536d4d0c79ff@daenzer.net> <CAKb7UvicP594ASs4QutRH4oW1XZ2gTA5Fa=w8FPQzzKaSzDQuw@mail.gmail.com>
 <4262e9d1-75c9-1be3-08bd-1ef842a13f2f@daenzer.net>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 4 Sep 2018 11:15:05 -0400
X-Google-Sender-Auth: jz6YxX2y6JXmYh-wDhgbpE19yLM
Message-ID: <CAKb7UvhwQ3h8d2t+-Cqd675oJSffyQrBG4SB1UqMSX82SDXs1g@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
To:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 11:02 AM, Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
> On 2018-09-04 3:05 p.m., Ilia Mirkin wrote:
>> On Tue, Sep 4, 2018 at 4:00 AM, Michel D=C3=A4nzer <michel@daenzer.net> =
wrote:
>>> On 2018-09-03 7:07 p.m., Ilia Mirkin wrote:
>>>> On Mon, Sep 3, 2018 at 12:45 PM, Daniel Vetter <daniel@ffwll.ch> wrote=
:
>>>>> On Mon, Sep 03, 2018 at 12:57:54PM +0200, Gerd Hoffmann wrote:
>>>>>> Userspace on big endian machhines typically expects the ADDFB ioctl
>>>>>> returns a big endian framebuffer.  drm_mode_addfb() will call
>>>>>> drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
>>>>>> values though, which is wrong.  This patch fixes that.
>>>>>>
>>>>>> Drivers (both kernel and xorg) have quirks in place to deal with the
>>>>>> broken drm_mode_addfb() behavior.  Because of this we can't just cha=
nge
>>>>>> drm_mode_addfb() behavior for everybody without breaking things.  So=
 add
>>>>>> a new driver feature flag DRIVER_PREFER_HOST_BYTE_ORDER, so drivers =
can
>>>>>> opt-in.
>>>>>>
>>>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>>>> ---
>>>>>>  include/drm/drm_drv.h             |  1 +
>>>>>>  drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
>>>>>>  2 files changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>>>>>> index 46a8009784..9cf12596cd 100644
>>>>>> --- a/include/drm/drm_drv.h
>>>>>> +++ b/include/drm/drm_drv.h
>>>>>> @@ -57,6 +57,7 @@ struct drm_printer;
>>>>>>  #define DRIVER_KMS_LEGACY_CONTEXT    0x20000
>>>>>>  #define DRIVER_SYNCOBJ                  0x40000
>>>>>>  #define DRIVER_PREFER_XBGR_30BPP        0x80000
>>>>>> +#define DRIVER_PREFER_HOST_BYTE_ORDER   0x100000
>>>>>
>>>>> Hm, not a huge fan of using driver_flags for random little quirks. I =
think
>>>>> a boolean in sturct drm_mode_config would be much better. Bonus if yo=
u
>>>>> also move the 30bpp hack over to that. Something like
>>>>> mode_config.quirk_addfb_host_byte_order and
>>>>> mode_config.quirk_addfb_prefer_xbgr_30bpp or whatever. That has the u=
pside
>>>>> of giving us a really nice place to put a huge comment about what thi=
s is
>>>>> supposed to do.
>>>>>
>>>>> I think otherwise this looks overall rather reasonable. I think the o=
nly
>>>>> other driver that ever cared about big endian was radeon/amdgpu. Woul=
d be
>>>>> good to get at least an ack from amd folks, or a "meh, stopped caring=
".
>>>>
>>>> and nouveau.
>>>>
>>>> I do believe that ADDFB should be made to always prefer host byte
>>>> order -- this is how all of the existing implementations work in
>>>> practice. However e.g. nouveau wants DRM_FORMAT_XRGB8888. But it still
>>>> treats it as host byte order. This will become more important in a
>>>> world where ADDFB2 is more common.
>>>>
>>>> So, I think that this change should be applied, drivers (I suspect
>>>> just nouveau and radeon) fixed up to consume the "new" formats, [...]
>>>
>>> As explained before, that would break radeon userspace on big endian ho=
sts.
>>
>> We last discussed this about a year ago, so I hope you'll forgive my
>> lapse in memory...
>>
>> There's userspace that uses ADDFB2 with DRM_FORMAT_XRGB8888 but
>> expects it to be host-endian?
>
> ADDFB, not ADDFB2. The latter probably didn't even exist yet when this
> was made to work. :)

Right, but ADDFB doesn't know or care about DRM_FORMAT_*. That's what
I'm saying -- keep ADDFB working, and fix up the DRM_FORMAT_*
underneath it both in the conversion and in the driver. Gerd's patch
allows us to do this incrementally, eventually truing up the
DRM_FORMAT_* in the driver, enabling ADDFB2 to work as expected.

  -ilia
