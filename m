Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A89E20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="autOzqPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A89E20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeICV2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:28:54 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43125 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbeICV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:28:54 -0400
Received: by mail-ua1-f67.google.com with SMTP id f4-v6so871724uao.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=55EDEKAgSLIisF9zDcpy4XHNQuoyOjZtklhxy7zTx60=;
        b=autOzqPjxGjSGSEUvcjc/AKWnfycKLPalbHzqjqyanWkSdzDi6RzL4PSuAjP0AVNOF
         VZsb3s32jBBlJU73xqdwNlOm0suHl6Z3TCN1LCVoksrAuNYpDyyuk2iArkD525CB+zY9
         4Qfkgd5Wn5ByfjG1tsUXu1o3e6gXLdp2hUj7A+x7c7Ci08/JkUOe2nQCWVSPy4esXdXo
         PGKhcStUjjuUegziVMHCwitC1FXaM3Z5lCMWXPJSb2i0psVWroLB3FTs4j5uctDkcZj7
         qc6di2MGGJn9TwKJABMNmAfC0rnW7jUiptxvv4uQJHB9V6pG+zip3pAmJFBu+eL2DLe7
         vDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=55EDEKAgSLIisF9zDcpy4XHNQuoyOjZtklhxy7zTx60=;
        b=ro3CJFYidXc1jwDNdl5FI85IKi5tJSB61qEqRmgDTOsmNcbPBl1zlHn8SazqARVgrr
         HjYvTdxgaLpOSski0wW0pytOV7oiUCVUSuCBCmVIdbgKv3NfLGlOvVg2AmEWNnbH4eS4
         wbu0AGZVksdVu0zkb2Faasdfmvhg5QvdfV0vMnYTvFLvjNzZyxFoNkZ7MWFQol5ReYoM
         0P0OjkBYD+siDKNkdJSSxRI5bbwLwj+IpXnzTASmc8T2S1rbLtdD6MEJ+YP1AQvyHxJ6
         /8H99Of8vTyRfve/iqmzTa2fcCuAPiToCq+kg+K5ojmZnX/P7oE9NJRUnA41q01zfBDx
         w3Rw==
X-Gm-Message-State: APzg51BXV79wuunu50PnqFnHtljr5ocurXrDE7RiY4Iwj8LtQV3HDfXo
        6rcnWnkWpSAxjC5r59b+xq+AmtJtj1fwy4tbFwk=
X-Google-Smtp-Source: ANB0VdbkjJ4CC8gU4hDDY110QwLL7+5hyPerIBrpddOqak5jUf7qKCdszYL+cAgzFaew3eM3rTeG5bBe/Ff4T7UUPOM=
X-Received: by 2002:a9f:3c46:: with SMTP id w6-v6mr16431671uah.185.1535994472817;
 Mon, 03 Sep 2018 10:07:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:26ca:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 10:07:52 -0700 (PDT)
In-Reply-To: <20180903164558.GL21634@phenom.ffwll.local>
References: <20180903105756.24912-1-kraxel@redhat.com> <20180903105756.24912-4-kraxel@redhat.com>
 <20180903164558.GL21634@phenom.ffwll.local>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 3 Sep 2018 13:07:52 -0400
X-Google-Sender-Auth: ogv0M08Mtx0sM1G8YDrJIKgPSSc
Message-ID: <CAKb7Uvh-UB6pR1r-D5sX0HwWwTExVzjxcdeAKNAmRWdqh=hKGw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
To:     Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 12:45 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, Sep 03, 2018 at 12:57:54PM +0200, Gerd Hoffmann wrote:
>> Userspace on big endian machhines typically expects the ADDFB ioctl
>> returns a big endian framebuffer.  drm_mode_addfb() will call
>> drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
>> values though, which is wrong.  This patch fixes that.
>>
>> Drivers (both kernel and xorg) have quirks in place to deal with the
>> broken drm_mode_addfb() behavior.  Because of this we can't just change
>> drm_mode_addfb() behavior for everybody without breaking things.  So add
>> a new driver feature flag DRIVER_PREFER_HOST_BYTE_ORDER, so drivers can
>> opt-in.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  include/drm/drm_drv.h             |  1 +
>>  drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>> index 46a8009784..9cf12596cd 100644
>> --- a/include/drm/drm_drv.h
>> +++ b/include/drm/drm_drv.h
>> @@ -57,6 +57,7 @@ struct drm_printer;
>>  #define DRIVER_KMS_LEGACY_CONTEXT    0x20000
>>  #define DRIVER_SYNCOBJ                  0x40000
>>  #define DRIVER_PREFER_XBGR_30BPP        0x80000
>> +#define DRIVER_PREFER_HOST_BYTE_ORDER   0x100000
>
> Hm, not a huge fan of using driver_flags for random little quirks. I think
> a boolean in sturct drm_mode_config would be much better. Bonus if you
> also move the 30bpp hack over to that. Something like
> mode_config.quirk_addfb_host_byte_order and
> mode_config.quirk_addfb_prefer_xbgr_30bpp or whatever. That has the upside
> of giving us a really nice place to put a huge comment about what this is
> supposed to do.
>
> I think otherwise this looks overall rather reasonable. I think the only
> other driver that ever cared about big endian was radeon/amdgpu. Would be
> good to get at least an ack from amd folks, or a "meh, stopped caring".

and nouveau.

I do believe that ADDFB should be made to always prefer host byte
order -- this is how all of the existing implementations work in
practice. However e.g. nouveau wants DRM_FORMAT_XRGB8888. But it still
treats it as host byte order. This will become more important in a
world where ADDFB2 is more common.

So, I think that this change should be applied, drivers (I suspect
just nouveau and radeon) fixed up to consume the "new" formats, and
then made to be the one-and-only way for ADDFB to function. That way
we'll no longer be lying about the DRM_FORMAT being used.

Cheers,

  -ilia
