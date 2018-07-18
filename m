Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC3CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08FB82075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af8V2x95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FB82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeGRW3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:29:00 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38339 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeGRW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:29:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so11678137oie.5;
        Wed, 18 Jul 2018 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JzP1GbmHmfs28MB5120US2zaMEU7Zv/tsNmwgXdd9Jk=;
        b=Af8V2x95MAexVbru4woFDQi++Mep11K67ceU+WXfWJtR3euOlbXue0wMZdD8dwn1bB
         4F+nJrZNAej2CDTieUCweuuYuA9lloe4CFfEHO9WzvDy82DQRenPoWD2g5z9PiYjrdIR
         KomV+4wXCncCTGD3yB3F4smFGwxsfPA+NpHiJt02C4UNVgEuHff9j237v/xkb4Xm2L+6
         kFzCBZreAIx1QsU6fvuNjjaRDSE6sx7/xhVglb5/kgd14o2ubFDHWcuOy0h6FwvSlIfU
         gdTm3S8F5GDnBDj3QCf5gkOn7USS34u0n5eR/hmV6Y43QcM9Mzy2CbXFj5djjcFyky9O
         zcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JzP1GbmHmfs28MB5120US2zaMEU7Zv/tsNmwgXdd9Jk=;
        b=RU6gmT5T9sPvkhaOzmL55lidDCezV+3IYmmoBPTwR+5QYCa8d/K3Swi9ulcM4D+THa
         8Pf4iAL/uvVBOkqHkLLuMZmX16df5THCJEgx5MiIg1aNEtPE57WoFoAnph6SxCPzJXQr
         n0kzzh3Hmoeliiz/FHlnf7y6X00IqsjPKPgQosWN4+cr1z0y1N0ZEvakW5NcdrbBhkGx
         NW8HJtJyZpa28mgveK20gSfXcXdPNRlkziTM0DDY8AtWGI4P+zmb78FqAw6WecgC5fUD
         LxpUurz/aOx4koClEpIHw/pjt+26qrTVxRBPWP/06wEGVLEVWDNK8bgvmr8LUuhXgL5M
         cHqw==
X-Gm-Message-State: AOUpUlFoVmWdChbvapy0g0buSH6ZcX//N1o6wwEIA453+ALu9KxMLCZQ
        RRYjCP1J4gaFKk5HGCTHEePjpH4UHS1kjCej8MI=
X-Google-Smtp-Source: AAOMgpcEplxCRHVhtcP8t6akSLAr+BWXXOCiiA5aQg/7+4yR9yZPjvMhaKhmtkesPfGCWSBMDrEz5eUvj//ZOkBRMgQ=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr7841912oig.282.1531950548555;
 Wed, 18 Jul 2018 14:49:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 14:49:07
 -0700 (PDT)
In-Reply-To: <2724dd5eee8a1e4e523e43915fa184ad5afe1c59.camel@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-2-lyude@redhat.com>
 <20180717071641.GA5411@wunner.de> <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
 <20180717182041.GA18363@wunner.de> <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
 <20180718082505.GB16072@wunner.de> <20180718083601.GC16072@wunner.de> <2724dd5eee8a1e4e523e43915fa184ad5afe1c59.camel@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jul 2018 23:49:07 +0200
X-Google-Sender-Auth: W0iAbFJy8vZW5rwuSHwhzbR0c0U
Message-ID: <CAJZ5v0jXNVMy04VuVV8JxseQ3NYyJkUBAAxUyyPiLq-W8DDr9w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback recursion
 in suspend/resume paths
To:     Lyude Paul <lyude@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:11 PM, Lyude Paul <lyude@redhat.com> wrote:
> On Wed, 2018-07-18 at 10:36 +0200, Lukas Wunner wrote:
>> On Wed, Jul 18, 2018 at 10:25:05AM +0200, Lukas Wunner wrote:
>> > The GPU contains an i2c subdevice for each connector with DDC lines.
>> > I believe those are modelled as children of the GPU's PCI device as
>> > they're accessed via mmio of the PCI device.
>> >
>> > The problem here is that when the GPU's PCI device runtime suspends,
>> > its i2c child device needs to be runtime active to suspend the MST
>> > topology.  Catch-22.
>> >
>> > I don't know whether or not it's necessary to suspend the MST topology.
>> > I'm not an expert on DisplayPort MultiStream transport.
>> >
>> > BTW Lyude, in patch 4 and 5 of this series, you're runtime resuming
>> > pad->i2c->subdev.device->dev.  Is this the PCI device or is it the i2c
>> > device?  I'm always confused by nouveau's structs.  In nvkm_i2c_bus_ctor()
>> > I can see that the device you're runtime resuming is the parent of the
>> > i2c_adapter:
>> >
>> >     struct nvkm_device *device = pad->i2c->subdev.device;
>> >     [...]
>> >     bus->i2c.dev.parent = device->dev;
>> >
>> > If the i2c_adapter is a child of the PCI device, it's sufficient
>> > to runtime resume the i2c_adapter, i.e. bus->i2c.dev, and this will
>> > implicitly runtime resume its parent.
>>
>> Actually, having written all this I just remembered that we have this
>> in the documentation:
>>
>>     8. "No-Callback" Devices
>>
>>     Some "devices" are only logical sub-devices of their parent and cannot
>> be
>>     power-managed on their own. [...]
>>
>>     Subsystems can tell the PM core about these devices by calling
>>     pm_runtime_no_callbacks().
>>
>> So it might actually be sufficient to just call pm_runtime_no_callbacks()
>
> I would have hoped so, but unfortunately it seems that
> pm_runtime_no_callbacks() is already called by default for i2c adapters in
> i2c_register_adapter(). Unfortunately this really can't fix the problem
> though, because it will still try to runtime resume the parent device of the
> i2c adapter, which still leads to deadlocking in the runtime suspend/resume
> path.

Well, there has to be a way to suspend all that thing without
recursion or similar.

If the adapter has no callbacks, then how is it possible for those
callbacks to invoke any runtime PM helpers for any other devices?

> Additionally; I did play around with ignore_children, but unfortunately this
> isn't good enough either as it just means that our i2c devices won't wake the
> GPU up on access.

So on the one hand you want them to stay active over a suspend of the
parent and on the other hand you want  the parent to resume before
them.  Are these requirements really consistent with each other?

> I'm pretty stumped here on trying to figure out any clean way to handle this
> in the PM core if recursive resume calls are off the table. The only possible
> solution I could see to this is if we could disable execution of runtime
> callbacks in the context of a certain task (while all other tasks have to
> honor the runtime PM callbacks), do what we need to do in suspend, then re-
> enable them
>> for the i2c devices...

This sounds completely broken to me, sorry.
