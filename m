Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B6FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F020866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeLSUfB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:35:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42703 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeLSUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:35:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so23744455qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 12:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kTuwbiY53tj1hvewf+jgHMk5a72ee9xWtWKCtgQkm40=;
        b=a3DtnQ4E7LYLJ46qEbCQNKxtMFrKo7YzufDelkr5UE0mCzTLD+GIX0R5Hk6tmDgR6I
         O9YzLeRo4DrZtlVIoXzXi5Jufv1bysbVlaH7Grbh7Ud/0wagcslwlp/WpC+YyaDzD8cL
         axOPAEt2HpWMAuQ+azQUCNyxICZ3KpKUgnMOQF39UZMcoO+sd+YcHCjpe1/rHII8z4RC
         8Pwef1vnSvvRI1dTvGSiwwzLT4sTFkr54YNeXgg5jWsRud4cgrF7Bdt6fe4mRHXtzlr1
         aeXQLfea/poH/iMbfVaLmTnZGAgHrBLl96KjLRaiGAvrxttN0eUsLFOPZNZg8mtoiWEK
         SsxQ==
X-Gm-Message-State: AA+aEWYGBa43tVB8NGiDKBE5JZ5TakHj4zvOfcAjwVLBvK3XNAYNmLSB
        OZ1jrw9Pmxbc4My9AQ8qMxxJMy0P29MQjIgaYUU8Uw==
X-Google-Smtp-Source: AFSGD/W/vewVo7ZyfdK4X5dHKSyqlE/D4egF94WW0hkEOZzYglfuQdiTtW01NcDvb7pFbNa7IZ7OoMWGM6JQXoIPgqU=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr23745951qti.184.1545251699593;
 Wed, 19 Dec 2018 12:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com> <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
In-Reply-To: <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 19 Dec 2018 21:34:48 +0100
Message-ID: <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc:     hcutts@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:57 AM Clément VUCHENER
<clement.vuchener@gmail.com> wrote:
>
> Le sam. 15 déc. 2018 à 15:45, Clément VUCHENER
> <clement.vuchener@gmail.com> a écrit :
> >
> > Le ven. 14 déc. 2018 à 19:37, Harry Cutts <hcutts@chromium.org> a écrit :
> > >
> > > Hi Clement,
> > >
> > > On Fri, 14 Dec 2018 at 05:47, Clément VUCHENER
> > > <clement.vuchener@gmail.com> wrote:
> > > > Hi, The G500s (and the G500 too, I think) does support the "scrolling
> > > > acceleration" bit. If I set it, I get around 8 events for each wheel
> > > > "click", this is what this driver expects, right? If I understood
> > > > correctly, I should try this patch with the
> > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > >
> > > Thanks for the info! Yes, that should work.
> >
> > Well, it is not that simple. I get "Device not connected" errors for
> > both interfaces of the mouse.
>
> I suspect the device is not responding because the hid device is not
> started. When is hid_hw_start supposed to be called? It is called
> early for HID_QUIRK_CLASS_G920 but later for other device. So the
> device is not started when hidpp_is_connected is called. Is this
> because most of the device in this driver are not real HID devices but
> DJ devices? How should non-DJ devices be treated?

Hi Clement,

I have a series I sent last September that allows to support non DJ
devices on logitech-hidpp
(https://patchwork.kernel.org/project/linux-input/list/?series=16359).

In its current form, with the latest upstream kernel, the series will
oops during the .event() callback, which is easy enough to fix.
However, I am currently trying to make it better as a second or third
reading made me realized that there was a bunch of non-sense in it and
a proper support would require slightly more work for the non unifying
receiver case.

I hope I'll be able to send out something by the end of the week.

Cheers,
Benjamin
