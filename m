Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DCDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F3920663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTSakQJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfBXPZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:25:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfBXPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:25:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so5801607wmi.5;
        Sun, 24 Feb 2019 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/EUgNr/k/daE3cAolP/p1gAbhHHAZXCAp5AFoE+Ago=;
        b=qTSakQJcRztdiUJVW84wLwm2rI3CVdwYRWAXR3qy2TKl9bhAiqL9BiyjNBrlEmb4Kx
         HkZjMN0zvNIovWve1SOEyRd4UTzxeZfZFG6J1VQ8lyoRHLt00nRCSXUrKYkxAap2ZFKV
         TkGkhh9p0Nl5whxhAifYa1Fljfu3emZfmEmh8Nr8wT9vq5FE0c3riUWAEOQhdgE81C6f
         xzrjIOMy8WGeZ0AXllHppGDu/KPVUR8o8O0H0o8UjpWn0m2+pwxKrwia6AnTUivsu/1p
         fab/r453bwM61PZNOHWl6mum+1d9a6j+wlwlNoC6sFCmtNvI+gi7feuMTmZ1ohNP80wp
         5gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/EUgNr/k/daE3cAolP/p1gAbhHHAZXCAp5AFoE+Ago=;
        b=qiSK4dsdOeW88Ox1TjQOZfRbczo2hL+HEk1CzK7VguOqBBeKhrIdDfg2c4XKPrPkUO
         GXtia2Uur0nneClzCzPPNLOHGnhojtjLN/XEAkVV52qpzH3SVwl5Jfj1X7vn8sSRwiwU
         4KbKPRvUelfDuGtR2TvpD4loXBQIoHAFCPCgMxmBCZ6csEqM8zmdF02BVqaEOD16/ekt
         csMhFjm3RR18smvq2fINR3iz7KGCHIPEJw2KQApA7TOUZHBYGV+tzEkB/HSH3gKaXpSG
         minkixDj4peRYS8q3vGGZgfud+i9iUpX+pFFM5N7OXNL621SIurbadUUZMZhrISj+h0+
         9lgA==
X-Gm-Message-State: AHQUAubWNavpRCjMlSF0DqreK4y5ghy3gNevTeG1m1SfVsWHoyjdjCup
        OJMiUdzaDW7I4ooxx9lkdRamWdSdWF8YVaepiLzWK19jrG0=
X-Google-Smtp-Source: AHgI3IYXBHeOCB4NKR3V9YXHECmYCD3BvmuIf28YFr5CBFErzmXeI5ZHPDGK2/aLL0cf0yQaV4vR75ocv14Szr+mdyM=
X-Received: by 2002:a7b:c752:: with SMTP id w18mr8364866wmk.97.1551021944567;
 Sun, 24 Feb 2019 07:25:44 -0800 (PST)
MIME-Version: 1.0
References: <CAKcZhuWHU+udbAyL910JW8rhZsbpomz5TXs0z2FD4m5c5Sf8hw@mail.gmail.com>
 <20190224125318.GB10876@kroah.com>
In-Reply-To: <20190224125318.GB10876@kroah.com>
From:   Zenghui Yu <zenghuiyu96@gmail.com>
Date:   Sun, 24 Feb 2019 23:25:33 +0800
Message-ID: <CAKcZhuVq36qsiptFAuuK9j79ANdOkd4i4dQjwM-UZ8t_pkqd7Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation/process/howto: Update for 4.x -> 5.x versioning
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 8:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 24, 2019 at 04:43:20PM +0800, Zenghui Yu wrote:
> > As linux-5.0 is coming up soon, the howto.rst document can be
> > updated for the new kernel version. Change all 4.x references
> > to 5.x now.
> >
> > Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>
> > ---
> >  Documentation/process/howto.rst | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
>
> I think Jon already sent a patch for this last week, you might want to
> look in the archives.
>

Thanks for the reminder. After looking into the archives:

        https://marc.info/?l=linux-doc

I find something about the "4.x -> 5.x versioning" have already been fixed.
But Documentation/process/howto.rst seems to be missed.

Also, I realized I've sent my patch using Gmail WEB client... and now I find
some embarrassing format problems in it. So if still needed, I will send a V2.

Thanks,
Zenghui
