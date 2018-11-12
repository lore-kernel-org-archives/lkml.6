Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE96C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937FF223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfH0VTiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937FF223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbeKMCRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:17:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46523 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeKMCRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:17:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so7754076otm.13;
        Mon, 12 Nov 2018 08:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gsH5q4dbtmMZSr/SQupUYZ6XmvyaJ4vVWSYmSe8Lhk=;
        b=VfH0VTiPVfhzoqrdEZeR5c35sBS8kfeWsYjs7IEbdlst2dj+xDoKJd9F/gYEVB5o27
         p4NFe8C/b8Xvk9sbe2Y/NAOvx5Fszr6l3sXgGok0afYG30GSfFfl3/tSls9Jl0+ATeRv
         kUE09q1LNRLUGkdKlLnOGWaQoxudNgTxPUkyNTOKUlg2NsUnLqLc6PZ08jpRbW4GIN/8
         dbpeF2bIXEjYdVt5Cp/2Y0NVdyvtzSz93Hb+SswOELGSt7Qsn3L5mjZgIqvw+/9aCIM6
         G3+QdPOFxYDKeOhona2CYoICsiDVa5OsnHSfW6UBnfKqdG22loSE0m1NU2E8KIKplrC2
         mkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gsH5q4dbtmMZSr/SQupUYZ6XmvyaJ4vVWSYmSe8Lhk=;
        b=Axj2FrU5TGuxKrjDg9KUCFX0JcmaS4uYrPAsq6dhxEscHZWIpiPgGhz/swhsw9cJ1y
         wbq7zpXJcAQC8F8PG101S+TI9ya+l6PledMHB8rF0oyYxT1cI0KqooMAywSI5oFZXY9f
         zzYVXw1WWpzqYROJlrQzUMFmmGZDZ8Pe+caI2Xhhg386AvcPXdR8MBXnPy0qbKkYp205
         CCFAJSe4fYzlI3bFSkKaWciM6lRej4e4k9n4SqBBCJ2F/ptEDnL3HW8d/UtFxndgDNid
         Ssf6OrG608TZVebaWdtkM0PzsBSoDN6WMLqx1Yx9ZwtS1Uh6VY2vI/j+BNR559/IZP1r
         7ElA==
X-Gm-Message-State: AGRZ1gJYnpXlFM1HfqVXeoTG3l0MCnZQDUcUjTCC3ltWxIiT3xPdzIPI
        fNtqnQkCC5JGpysW1xxDagA1W8n8po/PmLIwb4I=
X-Google-Smtp-Source: AJdET5fuhTQFSWwj3P+QCuUAUUwg2k3Mf10oyE1PlFBpMagMqJzdnF2pCq1XyVz0XbDLBv3Fve23WEbsiJbYvTCPq4Q=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr980252oti.245.1542039821379;
 Mon, 12 Nov 2018 08:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-5-TheSven73@googlemail.com> <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
In-Reply-To: <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 12 Nov 2018 11:23:30 -0500
Message-ID: <CAGngYiW0Xm5C=_zKgDPSJaeDwR1bHOzLkpL8pDg5otBawvGPGw@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 9:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>
> > +struct anybuss_host {
> > +       struct device *dev;
> > +       struct anybuss_client *client;
> > +       struct reset_control *reset;
> > +       struct regmap *regmap;
> > +       int irq;
> > +       struct task_struct *qthread;
> > +       wait_queue_head_t wq;
> > +       struct completion card_boot;
> > +       atomic_t ind_ab;
> > +       spinlock_t qlock;
> > +       struct kmem_cache *qcache;
> > +       struct kfifo qs[3];
> > +       struct kfifo *powerq;
> > +       struct kfifo *mboxq;
> > +       struct kfifo *areaq;
> > +       bool power_on;
> > +       bool softint_pending;
> > +       atomic_t dc_event;
> > +       wait_queue_head_t dc_wq;
> > +       atomic_t fieldbus_online;
> > +       struct kernfs_node *fieldbus_online_sd;
> > +};
>
> Similarly, should that anybuss_host sturcture maybe be based on
> a 'struct device' itself? What is the hierarchy of devices in sysfs?
>

The anybus host 'is-a' platform device. The dev member in struct anybuss_host is
actually &pdev->dev.

The host's platform device shows up in sysfs under
/sys/bus/platform/devices/anybuss-host.0.auto
where .0 is the first anybus slot on the bridge, .1 the second slot.
If there is more than one bridge, we'll see .2, .3 etc.

Here are the virtual files in that dir:

drwxr-xr-x    3 root     root             0 Nov 12 11:02
anybuss-host.0.auto.card0
lrwxrwxrwx    1 root     root             0 Nov 12 11:11 driver ->
../../../../../../../bus/platform/drivers/anybuss-host
-rw-r--r--    1 root     root          4096 Nov 12 11:11 driver_override
drwxr-xr-x    3 root     root             0 Nov 12 11:02 misc
-r--r--r--    1 root     root          4096 Nov 12 11:11 modalias
drwxr-xr-x    2 root     root             0 Nov 12 11:11 power
-r--r--r--    1 root     root          4096 Nov 12 11:11 state
lrwxrwxrwx    1 root     root             0 Nov 12 11:11 subsystem ->
../../../../../../../bus/platform
-rw-r--r--    1 root     root          4096 Nov 12 11:02 uevent

Where
anybuss-host.0.auto.card0 just points to the detected anybus card, if any.
Nothing to see there, it's just an artefact of the bus/device abstraction.
misc points to the detected anybus card driver (which is implemented as a
misc class device).

This sysfs hierarchy makes sense to me. Is there something I should be
doing (or not doing) ?
