Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FB9219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB9DRQms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FB9219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeHFIYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:24:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45918 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFIYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:24:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so9590550ljh.12;
        Sun, 05 Aug 2018 23:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgcNRPZMTZ5mwhwdWdjzkBELdYO8uPAEjgD2RsUbo7Y=;
        b=GB9DRQmsdNuuZm7ZYnLC146fB0fMI+onDJX1yme8sTaJkIOKG0dgg46GwsfdPqCsQ6
         fs8QiiU6uqLx6QP6dlDtO61kZ8WeE7VSPS5ImBG72bak7ldvvG+Zj4C+em5Uwi4d7HvI
         CK/yOeFHFBiyB9X2YerhFvaZ8pGWVvJCz6R5MbdFvOlUwiXDNNDxebMzJrHydlyzrxD1
         WlKegY3aesAsTtRzRnaa6Pq0qGpVk8FEvUrPmeo2zqMP/Wb3yKe2xasef1er2H9fOCx3
         W5EDSJETPluLdMQDYz1p0CRhSw6z1Nv6TWGZpBcFOXlR8et5y1r9YvjEYxv1UTyLejPR
         G0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgcNRPZMTZ5mwhwdWdjzkBELdYO8uPAEjgD2RsUbo7Y=;
        b=ii0EtCO1ISiwXuzVZ65ZVCOGICdolr1tcAWbuHUXVxa8lSzofYqaHxf1fumnU6Qrot
         WDV3homJN3HTS2BpgRUnz6SzRA6sH2W4pfa0faBLqCogavmAiYYvG37Xh6x6Cu0MCtgT
         eYyX2aoMQuwFmRgAOG7htIViNkco90884UZYgIaLq0dxoXfPOhJ8zQA9zII0eeRILuob
         yr/AoRCQpNcYQsHn88vVN6tBei5ws0GRef1Ib8+jvvrrAPt3u4Y4mfOVtUVhQxTzQYLN
         n4oEZ5sQbToOHybBoMKQgs/bhfaOW8sPc5S+C8HolECouXWeJk3Vvmbyfxt5CprhPtCF
         D2aQ==
X-Gm-Message-State: AOUpUlF7UqHn3tzlmPguVrby+90vayuhwrAbHWO2umoHfOnrynJBOFCy
        uknfBEQxKwfIM/iZPcdObln07420XQurThU1gDA=
X-Google-Smtp-Source: AAOMgpfONiqkvDwmCQ4YAG0Vc1CqhrYrorXI1GdgupzyglHTthF1EBuZuTLDKONYfIUc1YKJrlXEbv75lV7x0DubDog=
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr12574800ljk.111.1533536226782;
 Sun, 05 Aug 2018 23:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
 <20180605224458.62692-1-ravisadineni@chromium.org> <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
 <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
 <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
 <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com> <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
In-Reply-To: <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sun, 5 Aug 2018 23:16:54 -0700
Message-ID: <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Todd Broch <tbroch@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 10:29 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Ravi,
>
> On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
> > Understood. I am trying to reproduce this issue locally. Wanted to
> > know the version of the kernel so I can give a try. Marek, can you
> > please confirm the kernel version.
> >
>
> Yes, sorry for the missing context, I was in hurry writing the report and
> I wanted to send it before leaving the office. I'm testing mainline on Snow
> with exynos_defconfig.
>
> Suspend/resume is partially broken already with mainline, but if you disable
> CPUfreq support, it works fine on Linux v4.17.
>
> I've posted CPUfreq related fixes here if you are interested:
> https://patchwork.kernel.org/patch/10554607/
> https://patchwork.kernel.org/patch/10554603/
>
> The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
> the first release with that patch.

Marek, this patch should only be in -next, I do not believe I sent it
to Linus just yet. If mainline is broken for you it can't be caused by
this patch.

> Linux -next from 20180803, which has a few
> more patches for cros_ec_keyb suffers from the same issue.

Just to confirm, if you revert only this patch from -next you get
suspend/resume back?

Thanks.

-- 
Dmitry
