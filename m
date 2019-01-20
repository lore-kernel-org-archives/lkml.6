Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB62C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5B420861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l13ZQsCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfATSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:45:28 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45186 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfATSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:45:27 -0500
Received: by mail-ot1-f53.google.com with SMTP id 32so18724003ota.12;
        Sun, 20 Jan 2019 10:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSUeS8oJwQjTnGeOUAKOWFJv18+u1IPIuRY1G9vzS1w=;
        b=l13ZQsCzea9wSvIZHYQLeqbm72BTVgs1K2SY9AnhUeDkz6fBNJOTnpjMnx0dHnmNwU
         NQxa5bPW+fE28t/+tGCtsmokub0xsXnxXKjAc9/HMFW9UW1fq1fH1BtY97eqHAaU+7BF
         Qif3kNQ1h7zvZu1OIMK50NYnC3dYj6cHBS+YE5wsJzt2vpkbCUJ+CNz6zEK7sm8KaIWv
         oW02IGbD/nV0TkhLDDs89nw0nbDWK2mCUy8u0JHxDh0adfG69JnxpSt2k9SSIkNA0d6W
         hfOZa8AF+6oJrfQimXMWb1Lnsnxo+DZHV/OwOW2XqRN12z/R3syWoxt9FXoAqcLq2oGK
         yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSUeS8oJwQjTnGeOUAKOWFJv18+u1IPIuRY1G9vzS1w=;
        b=fpvkJldha7YkXZfehBqkpcGGSsu24RqHPT5M5IvGlH+iyWW7VVrukaHkgJU4CkuOe7
         Iz1qBKOV7QYFKIIgWI8wiEAg59jwoupdQp5ih88rTxQF42dBgYeYRqS59ggl4HlyvOB9
         GeryNHNCECzJlLC8fLMAqdA1PvFilcOqtolEkWylwB2UKlGuNDkH+vaUMu92rqsUZhPC
         sxicqEQTy8L3Q/I4+YEURJpQyrfaO9LA+du3AeetbZ/6i6MdA6mPpUBKuAZ49MX4ToF4
         Tw9FYX85Xyg7i9JKlX65nvlVGB5/k/s8smW6gkqA1f9J5LvDvYmW5cVxV1vbf7XxTwS+
         sfiw==
X-Gm-Message-State: AJcUukfAN0BwFgRsMvWHABtKFCi2ZKvvKRIhstYIYEZWKrZTNbSbgmm4
        pncMORWmqwDEUEpxW9F9ry2MmjcoAfkmRkQnCL5Ngg==
X-Google-Smtp-Source: ALg8bN5VVJQ5IoTk2HbOCwA1xPFl/1sDUL4/oJ7ISCh96jkCScPfADdj3ken4zq1ifaGzTirMh4hZJfF1j3yjhP64to=
X-Received: by 2002:a9d:42c:: with SMTP id 41mr18349078otc.41.1548009926889;
 Sun, 20 Jan 2019 10:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20190113153022.5040-1-linux.amoon@gmail.com> <7hy37j9ebi.fsf@baylibre.com>
In-Reply-To: <7hy37j9ebi.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Jan 2019 00:15:15 +0530
Message-ID: <CANAwSgRPkoos20wW9-avUGUP7LBD4=7uBKjO2CKyxnbLHxQzQw@mail.gmail.com>
Subject: Re: [PatchV2 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy
 regulator power failed warning
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin / Martin,

On Fri, 18 Jan 2019 at 02:44, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Hi Anand,
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Override the dr_mode from "host" to "peripheral" for dwc2
> > usb_phy0->usb0 initilization of OTG Micro-B type.
> > Changes fix the below warning for phy poweron failed --> -22
> >
> > Changes fix the initialization of c9000000.usb phy
> >
> > [    1.203900] phy phy-c0000000.phy.0: USB ID detect failed!
> > [    1.208048] phy phy-c0000000.phy.0: phy poweron failed --> -22
> > [    1.213877] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> > [    1.222953] Modules linked in:
> > [    1.225976] CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.0.0-rc1-xc2ml #3
> > [    1.232872] Hardware name: Hardkernel ODROID-C2 (DT)
> > [    1.237794] Workqueue: events deferred_probe_work_func
> > [    1.242878] pstate: 80000005 (Nzcv daif -PAN -UAO)
> > [    1.247623] pc : _regulator_put.part.11+0xf0/0xf8
> > [    1.252280] lr : regulator_put+0x34/0x48
> > [    1.256159] sp : ffff00001176bb00
> > [    1.259437] x29: ffff00001176bb00 x28: 0000000000000000
> > [    1.264698] x27: ffff80007f31beb8 x26: ffff000010eeb7e0
> > [    1.269959] x25: 0000000000000000 x24: 0000000000000009
> > [    1.275220] x23: ffff00001176bbc8 x22: ffff80007ed9d500
> > [    1.280482] x21: ffff0000111bd6c8 x20: ffff80007ed9d700
> > [    1.285743] x19: ffff80007ed9d700 x18: 000000000000006f
> > [    1.291004] x17: 0000000000000000 x16: 0000000000000000
> > [    1.296265] x15: 0000000000000400 x14: 0000000000000400
> > [    1.301527] x13: ff00000000000000 x12: ffffffffffffffff
> > [    1.306788] x11: 0000000000000038 x10: 0000000000000040
> > [    1.312049] x9 : ffff0000111d58b0 x8 : ffff0000111d58a8
> > [    1.317310] x7 : ffff80007ed9db00 x6 : ffff80007ec21b00
> > [    1.322571] x5 : ffff80007f400248 x4 : ffff80007fba9b00
> > [    1.327833] x3 : ffff0000112d9eb8 x2 : ffff80007ec21b00
> > [    1.333094] x1 : 0000000000000000 x0 : 0000000000000001
> > [    1.338356] Call trace:
> > [    1.340773]  _regulator_put.part.11+0xf0/0xf8
> > [    1.345085]  regulator_put+0x34/0x48
> > [    1.348621]  regulator_bulk_free+0x30/0x50
> > [    1.352675]  devm_regulator_bulk_release+0x18/0x20
> > [    1.357421]  release_nodes+0x1b0/0x220
> > [    1.361127]  devres_release_all+0x34/0x50
> > [    1.365094]  really_probe+0xec/0x290
> > [    1.368630]  driver_probe_device+0x54/0xe8
> > [    1.372684]  __device_attach_driver+0xb8/0xe8
> > [    1.376997]  bus_for_each_drv+0x78/0xc8
> > [    1.380792]  __device_attach+0xd4/0x130
> > [    1.384587]  device_initial_probe+0x10/0x18
> > [    1.388727]  bus_probe_device+0x90/0x98
> > [    1.392522]  deferred_probe_work_func+0x6c/0xa0
> > [    1.397010]  process_one_work+0x1e0/0x318
> > [    1.400975]  worker_thread+0x228/0x428
> > [    1.404684]  kthread+0x124/0x128
> > [    1.407876]  ret_from_fork+0x10/0x18
> > [    1.411410] ---[ end trace de5fd1b262c1f56a ]---
> > [    1.416055] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> > [    1.425123] Modules linked in:
> > [    1.428144] CPU: 1 PID: 44 Comm: kworker/1:1 Tainted: GW 5.0.0-rc1-xc2ml #3
> > [    1.436422] Hardware name: Hardkernel ODROID-C2 (DT)
> > [    1.441340] Workqueue: events deferred_probe_work_func
> >
> > Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
>
> Minor nit: the shortlog should be in double quotes.
>
> I fixed it up manually, so nothing you need to do, but just for future
> reference.
>
> This was found by some automated checking recently added to the
> linux-next tree.
>
> Kevin
>

Thanks: I will follow the protocol next time.

As pointed my Martin on Odroid C1+ my patch do not fix complete issue.

[0] https://patchwork.kernel.org/patch/10761371/
[1] https://patchwork.kernel.org/patch/10761375/

Both of my patch seem to be wrong and if possible please so drop them
from linux-next and your fix tagged.
I will try to find proper fix proper to the issue.

Quick phy driver and dts changes enable  *Bus 01.Port 1* and *Bus 02.Port 1*

[alarm@archl-c2m ~]$ lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 2: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 2: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 2: Dev 3, If 2, Class=Audio, Driver=, 480M
        |__ Port 2: Dev 3, If 3, Class=Audio, Driver=, 480M
        |__ Port 3: Dev 4, If 0, Class=Vendor Specific Class, Driver=, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M

Need to fix the vbus setting for both the bus ports, which I am looking into.

Best Regards


-Anand
