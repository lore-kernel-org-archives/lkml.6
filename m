Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5965C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B1020827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhIihwZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B1020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeKFAHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:07:15 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39076 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:07:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id e4so15047068qkh.6;
        Mon, 05 Nov 2018 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJCrd2ZI2MDJ7I0rSGqK7lK4chxD/7U3NIyzfpUqwFM=;
        b=qhIihwZvkNi0PGwO7Ki4mcRp7buSmZ/xP72lBL2MZ3FNfOKtCqy6KMNnZE1tlxNcAO
         S1ZtNpao+BXc+dTiT1opvxtxCCT++j7D5eebSXn2XuKt14kvb8iC+UE9/5b2DbxB2H4w
         NCtsseeI2FHvsE2FRo0KXGp828d3BeSKlObQLAQTrTLGt49arwvEjvY2XIlZ4awFxh1u
         cBiDvhn8KhBym/xUEZxfUIW8sLfX7pub/H6iSYGgfumrGJCefrA97/Xtl96ZHECuAZ9m
         5VP/HgDtgcmHicpaFkTwkEZL9/V06fii17xUMgIacDVtDgg+PzW67cnvbL7UUC9W+fx3
         vn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJCrd2ZI2MDJ7I0rSGqK7lK4chxD/7U3NIyzfpUqwFM=;
        b=hy8JNYQn5Cg3hM6FHbxq4vqo6Gr3QRdq6XVftYBEnLKldm5Q31zdYbwzvH0H07yQoN
         8KlpaT0xniOIWOWo4mFDs39c1fyIBkYtN0Se5krOHjcF5bs9NlyXHG4mS93cK+6O5cxE
         cP+1TJezcPUePJlmqvpEnGhx26wHoOkoy0qJo7ZxIo+1EM1zNKEKRoV9bAxj+zlUGcib
         DB1R8chLcNA0MOEaIISmtDmhP796qmSEICPQrqSWIJ2ZYobwkXtYcmKXa6NKReQAUXeM
         OhUHu+fljV67M3cABYB6H0gCQRd6winxcatQypvy1vAo+DpZVs8jpXElgL7pT5lWqycP
         6ZAA==
X-Gm-Message-State: AGRZ1gKPXXlDq3u8KRMwpGgRjaLF9o9+XOg2GDCVxldr1AHGpII6v4I3
        qKYE+RoEves3/p/JVm+EMwHV71Y7i4Ther6DZ+Y=
X-Google-Smtp-Source: AJdET5dqHikhAR18vPBY34XM1pwxOHDlVD/zs2wVDI3DgRy4keQzn/O32+rtzyaHeYwjCvLrOwLUY4GtB5us2j8u/Vc=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr19595757qkc.219.1541429230816;
 Mon, 05 Nov 2018 06:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
 <20181102041120.7603-4-ayman.bagabas@gmail.com> <CAHp75VcA5M4XNVr94OALo3=AW3LbWU+Pz-KTRgodBtSP_K9-wA@mail.gmail.com>
 <33dce911f9544c53a7989430a1ce848444cf4e3b.camel@gmail.com>
In-Reply-To: <33dce911f9544c53a7989430a1ce848444cf4e3b.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Nov 2018 16:46:59 +0200
Message-ID: <CAHp75VfFbv8Xu8TZ3O7QPxrNiBN6admdUSUzOG9KZXYYZJzjyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 1:21 AM <ayman.bagabas@gmail.com> wrote:
> On Fri, 2018-11-02 at 20:12 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 2, 2018 at 6:12 AM Ayman Bagabas <ayman.bagabas@gmail.com
> > > wrote:

Takashi explained me, that is the way sound driver are using the
external symbols, so, follow his suggestion.

> > > +static int (*huawei_wmi_micmute_led_set_func)(bool);
> >
> > Why is that?
>
> This is used with symbol_request and then in the update function to
> locate the function from the wmi device. But I guess you are right, we
> could use the function defined in the header file directly.

> > Takashi, is it a way how the rest sound drivers are written? B/c this
> > symbol_request(s) look to me a bit ugly.
> >
> > > +/* for alc_fixup_huawei_micmute_led */
> > > +#include "huawei_wmi_helper.c"
> >
> > Ditto.
> >
> > Include *.c?! Huh?
>
> Is that the wrong way? Should I define the functions directly into
> patch_realtek.c?


-- 
With Best Regards,
Andy Shevchenko
