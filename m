Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E80EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC072146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KywZbo6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC072146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeIRDPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:15:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37151 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeIRDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:15:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so276897wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=si9mQzR+wtfu0/5r6hUBAxdZUnNfo5vSMKmPD7leZy4=;
        b=KywZbo6MV9H9G9QRPbOPFKBA9TXLw7y3DaJKjg7uwJ0MZBLGIeCntgoUuTlvb+P9gh
         LkPHjSCXx0H1EpFEWL0cSsvOCEZdEQpuJnsn/2lhvwmbbztJeHBPqn1nmJidxJlCzg5U
         nSm+MHa5fYhQhm/Wy2pI3UJjSkzNCa2Ue4JuJPfM6dzP1nDKUNL4fD9HdeqXdJrFVUkK
         b7So6Vmpydx5wiR7DVp+6kAmMYIFIQXMoMTAghGuo4Sd0j04ZygIiqNdd1pbxNxKzJDe
         JDpY8zpIC2KyYgioRIVPTnenFNkl/swgKjdae+hOQv7SBqai+adidMd4obgUyInoMc4Q
         HoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=si9mQzR+wtfu0/5r6hUBAxdZUnNfo5vSMKmPD7leZy4=;
        b=aSGAkUanqEh2968sj4p2xZF3mh9kMe8Au1b5ToQ3O+5vpnRQESg1mIyInm393gg+O7
         ttEysFafCZNpO1ERRcDdSW7++4Qa3hLNog6yKnOc7ggornH1XEqHIx1x/ny4a2KSENHv
         M+WthILQcbeucZaMHzxSj90bSglDLa2sbmUEWoVjwehjhUtuBUWQ7Ff0ZgEeca8I8Xw2
         k5Rhibh9NxQkpmxDtvSFSZd/wak/jebSJv7KgNe5xhVSvJ/ryo/Ju2tVUNh9aOY1tS69
         nUFaF4Alb/yXx8XVwU63PAR6Wk09vkOWShJmuuisWTMzJNFSnt0QUG4D4eKS+uzgV7fQ
         lsuA==
X-Gm-Message-State: APzg51BSiNwXLAgLK2ZGIORGGzZC8ntjifZiMVNDHjFSNHkoZVOJHjvT
        1VsNgZ5vDAWnG2BvtmRJrHEPpf/1yqY5AruyOkQ=
X-Google-Smtp-Source: ANB0VdbxL4ChSnKTs2bYXzEZyNEwk9B931ZTXI9k4ckXINMTBDwuaeIN55Aem3ylJaLoURBkkM1UCoqvNsy69UHoSZM=
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr6771169wmh.20.1537220755072;
 Mon, 17 Sep 2018 14:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180412193333.4951-1-malat@debian.org> <20180413080437.GB10330@hr-amur2>
 <CA+7wUswLVHMeCMz-9-Xtxigu8CjNDS8745G8S7J8F_7U8YXteQ@mail.gmail.com>
In-Reply-To: <CA+7wUswLVHMeCMz-9-Xtxigu8CjNDS8745G8S7J8F_7U8YXteQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Sep 2018 17:45:42 -0400
Message-ID: <CADnq5_MU3KWu5y3NZxAVQHgktEHOGLcL-zyV-WHVodeDNWoNcA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: change function signature to pass full range
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Huang Rui <ray.huang@amd.com>, Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:29 PM Mathieu Malaterre <malat@debian.org> wrote:
>
>
>
> On Fri, Apr 13, 2018 at 9:59 AM Huang Rui <ray.huang@amd.com> wrote:
>>
>> On Thu, Apr 12, 2018 at 09:33:33PM +0200, Mathieu Malaterre wrote:
>> > In function =E2=80=98radeon_process_i2c_ch=E2=80=99 a comparison of a =
u8 value against
>> > 255 is done. Since it is always false, change the signature of this
>> > function to use an `int` instead, which match the type used in caller:
>> > `radeon_atom_hw_i2c_xfer`.
>> >
>> > Fix the following warning triggered with W=3D1:
>> >
>> >   CC [M]  drivers/gpu/drm/radeon/atombios_i2c.o
>> >   drivers/gpu/drm/radeon/atombios_i2c.c: In function =E2=80=98radeon_p=
rocess_i2c_ch=E2=80=99:
>> >   drivers/gpu/drm/radeon/atombios_i2c.c:71:11: warning: comparison is =
always false due to limited range of data type [-Wtype-limits]
>> >    if (num > ATOM_MAX_HW_I2C_READ) {
>> >            ^
>> >
>> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>
>> Reviewed-by: Huang Rui <ray.huang@amd.com>
>>
>
> Any chance to be included in the next pull request ? thanks

Applied.  thanks for the reminder.

Alex

>
>>
>> > ---
>> >  drivers/gpu/drm/radeon/atombios_i2c.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/r=
adeon/atombios_i2c.c
>> > index 4157780585a0..9022e9af11a0 100644
>> > --- a/drivers/gpu/drm/radeon/atombios_i2c.c
>> > +++ b/drivers/gpu/drm/radeon/atombios_i2c.c
>> > @@ -35,7 +35,7 @@
>> >
>> >  static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
>> >                                u8 slave_addr, u8 flags,
>> > -                              u8 *buf, u8 num)
>> > +                              u8 *buf, int num)
>> >  {
>> >       struct drm_device *dev =3D chan->dev;
>> >       struct radeon_device *rdev =3D dev->dev_private;
>> > --
>> > 2.11.0
>> >
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
