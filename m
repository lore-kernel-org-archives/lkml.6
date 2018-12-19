Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6160C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B2721850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfxQ8gM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeLSK5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:57:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46848 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeLSK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:57:17 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so15229151ios.13;
        Wed, 19 Dec 2018 02:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D8TIX6K1DvNn0TdyfgJH7m8Y9BK1ASgLkKSh7XWUBFw=;
        b=dfxQ8gM3B0HVbbYNCGC/v5JY6X7Qi+x8DXNEj79UfE/1AUped+inD9en+pEOBXw036
         8whdCnB8l/12Inx1KAhR70eXZ94K/m9NEhzY+IjSOgNF+JcGuJsudpISkkXcakOT1YA6
         3t3wPCl4QQ/VfcpMZjyn/I3epnyEmB8VZWNKBH1M2HyaEN0170C//l8UvQmNnOk20v6P
         pDQqV8F3OY+Y1ACMgrjGeJFGyIUjG33DPzSFRwez7JEOVQV7G1h80yFckOyOJVx0JWgR
         WTx1nj083LAM2+ffapmaexEhQaJ/1e8fCIHoN6rm2qlJcruaCo1K9cbz80G1csSun3gO
         vXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D8TIX6K1DvNn0TdyfgJH7m8Y9BK1ASgLkKSh7XWUBFw=;
        b=HZ3HqKA2Ej1Ie4aAPGaydzNK/nHxacPfdqZf9G4KKHz+RBHlRcJFZJGOe8jScOBU9F
         FL0/BfSf1d2ydyrlgs+eUiBTWk3JTKNOt8dKFv7OW1CY+O708JWKV5kcmkTKH6fEq+Cr
         WGvQyENTbBOwiI+yVOr88L8VmJMXTY670UeATLh4dxIwECX874Z3dLoge+bp6nbbC1Kr
         M+BsV8xOwDfpkJfTpIAaH2s8tVe8PyDznLb7lkKeJ8sgSkyxv3kqmIOaVdMk0vsRwx/+
         OVJyPC6OiVtz1UTfP8g1S/KD7DeHUitpzOLddo7XvB1VlAyZbGChwwSvse2+6jVPCeUu
         Af7A==
X-Gm-Message-State: AA+aEWbEmRIblGPc6Cs+dqGQE/4UDqcfZ39viVgRaTAODWpNMlSAHPIK
        i2zTz4ROimrBvJiiXtPfcpqseJo4apobEfAIJjw=
X-Google-Smtp-Source: AFSGD/UaEcef4DcAdkNTGgAtrAikFS/ZzDOJEwrwQF02xpa28BB1fwUOyd4dRMSDQqh1smcM6k9hMcEMJLN34cOQ3R4=
X-Received: by 2002:a6b:600b:: with SMTP id r11mr18717533iog.259.1545217036666;
 Wed, 19 Dec 2018 02:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com> <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
In-Reply-To: <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
From:   =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date:   Wed, 19 Dec 2018 11:57:05 +0100
Message-ID: <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     Harry Cutts <hcutts@chromium.org>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHENER
<clement.vuchener@gmail.com> a =C3=A9crit :
>
> Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcutts@chromium.org>=
 a =C3=A9crit :
> >
> > Hi Clement,
> >
> > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > <clement.vuchener@gmail.com> wrote:
> > > Hi, The G500s (and the G500 too, I think) does support the "scrolling
> > > acceleration" bit. If I set it, I get around 8 events for each wheel
> > > "click", this is what this driver expects, right? If I understood
> > > correctly, I should try this patch with the
> > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> >
> > Thanks for the info! Yes, that should work.
>
> Well, it is not that simple. I get "Device not connected" errors for
> both interfaces of the mouse.

I suspect the device is not responding because the hid device is not
started. When is hid_hw_start supposed to be called? It is called
early for HID_QUIRK_CLASS_G920 but later for other device. So the
device is not started when hidpp_is_connected is called. Is this
because most of the device in this driver are not real HID devices but
DJ devices? How should non-DJ devices be treated?
