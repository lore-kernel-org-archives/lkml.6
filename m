Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1870C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C3820869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRF/rdk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C3820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeKGD5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:57:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbeKGD5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:57:41 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A5F2086C;
        Tue,  6 Nov 2018 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529068;
        bh=O8HGTLHxMwBnGJHqGNMtl3vRThadpik+NrNzFVlddbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YRF/rdk7iqquGJmB5BEyP5lwynoskn2LjQvsU/2xqP8aHMhjdBd5AaykUWiLLvaNT
         oqQkueo0jSfNwe4DnAJrg98u4bm4bDJFrUISgiuZ31UZ1rSH0k30S7qkH34LSfOWIg
         NrnxfWMtL4BnxclRpnOfwDDK9iC2Ndox1TZiPuOc=
Received: by mail-qt1-f182.google.com with SMTP id r14so3773547qtp.1;
        Tue, 06 Nov 2018 10:31:08 -0800 (PST)
X-Gm-Message-State: AGRZ1gI/BGOKl4YaACWWZKYggh24Sn56tUaWE8QpSEMVFR79muDNeV7G
        gj7uRzsInLvFoGzyXNeBHR4X3vMEq9P8mi3ctA==
X-Google-Smtp-Source: AJdET5desWIZTpBvNA7JvPgAKkLftU98J5zrYQja/zYrW4saXG6Mdg8yGs5GaTlkN5/3ZrpjKSCFs7EmZCB2n7Rajn4=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr27262744qvl.77.1541529067228;
 Tue, 06 Nov 2018 10:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com> <20181105212049.GA320@bogus>
 <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com>
 <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com> <CAGngYiXczK6dsfyDGxe1ym-vQQfH5XS0jeEkuWW_og23JmTAZg@mail.gmail.com>
In-Reply-To: <CAGngYiXczK6dsfyDGxe1ym-vQQfH5XS0jeEkuWW_og23JmTAZg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Nov 2018 12:30:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YeW+BtVh=L8PBjXYLj9sp91BcUQrJJrwnmChRnXoK_w@mail.gmail.com>
Message-ID: <CAL_Jsq+YeW+BtVh=L8PBjXYLj9sp91BcUQrJJrwnmChRnXoK_w@mail.gmail.com>
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:46 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Tue, Nov 6, 2018 at 8:58 AM Rob Herring <robh@kernel.org> wrote:
>
> > It doesn't really sound like the host should be in DT. The bridge
> > should register itself as an anybus provider and that should in turn
> > enable the anybus host protocol.
>
> Very good point. Just to make sure we're on the same page, could you point
> me to a relevant example where something registers as a provider?

Not sure exactly. Perhaps I2C SMBus functions that implement the
register access protocol on top of I2C bus.

> v1 of this patch did not have the host in DT. The host just required platform
> data with a regmap and a reset (the interrupt was passed via resources):
>
> struct anybuss_host_pdata {
>     struct regmap *regmap;
>     void (*reset)(struct device *dev, bool reset);
> };
>
> But there were problems with this approach.

A block diagram would help. Something that shows the host SoC, your
CPLD, reset, irq, etc.

> The review feedback told me that my self-rolled reset callback should really
> be a reset controller. I looked for ways to pass a handle to a reset controller
> via platform data. This has recently been introduced via:

Maybe an overkill for 1 reset.

>
> reset_controller_add_lookup()
>
> This binds a client device to a reset controller, without using the devicetree,
> so the device can grab its controller via (devm_)reset_control_get*. Great!
> But... to make the binding, you have to specify the full device names of the
> controllers and client devices. See this example from psc-da850.c:
>
> static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
>     RESET_LOOKUP("da850-psc0", 15, "davinci-rproc.0", NULL),
> };
>
> I very quickly found myself in ida_simple_get() hell, trying to second-guess
> what the devices I was creating, would be called !
>
> So instead I put the host in DT, then I could easily connect the reset
> controller. This also greatly simplified the bridge driver, a lot of boilerplate
> would simply disappear.

If the host is not a h/w component, but just a s/w protocol then it
doesn't belong in DT. Perhaps it could be a library which the bridge
driver can call into.

What are the resets connected to? The slots? Maybe you should model
the slots in DT.

Rob
