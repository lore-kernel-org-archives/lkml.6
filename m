Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A9AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7BA20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPIafA8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7BA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeJ3WoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:44:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38674 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbeJ3WoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:44:19 -0400
Received: by mail-io1-f66.google.com with SMTP id q18-v6so7269736iod.5;
        Tue, 30 Oct 2018 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:references
         :in-reply-to:content-transfer-encoding;
        bh=AEGxIEJmeOgPgVc1e6OlXilnPSW3o+iTHbd+Ub79nhs=;
        b=lPIafA8SuXvlYCGYa+fkZwUuyXCPFhXoxDfvzViVSlQRr6JcsPFxwTwleIf/J6ZUZ5
         y9Die1D+yvF3zFjIYMp9WnEAuAovNzOv04cReRIubEdJRcSMGNjpYemtoyTSVobKQvm3
         3IXvP1wJG+2YsxoXH1Gk33y6/H3ibynmbKejtec5KBVDq2R1Hp29s/4/iXxhAjWh5zxH
         dUC6lVJv9QuJ31osVlkOhyyheOVmK3Re92mDaW4KnXWaJBkqPkt7wODvie9bFK/Nwvt/
         /54j+vY4A/2WRHUJBOf2YpU9bBvoSfU/iGemv44IHx3IljkpnGgxcAaSpevqF/PGkewm
         /3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :references:in-reply-to:content-transfer-encoding;
        bh=AEGxIEJmeOgPgVc1e6OlXilnPSW3o+iTHbd+Ub79nhs=;
        b=pGgPX5prozsOnemgaP7G2R2Vhr69Eid+GmAuRBvior7shdDU+S0JcU2YxNHBFDMwbS
         2Cex/2YNz1PBjGnp/s0VndD8GRLt/rIpb6x7CMU82Na7dt9L4x3BHUujP4bR2m4dvXBc
         XW54dxeYga/rv3vJeEWxwO3ttAEKhX56x/nDphuXADyjXxClrOmM5S+t/7ON1YeMqnlN
         wuXg9e05/l2ugXkCAvksuPzn7fhymQ35uKcl4llZ1llikzAoEf5EZKGaEUrJL9b6PUgI
         Uq9j2cFRoA3xxeY7yLEw0b75kgQlNlY8W/CR245GkTZtcWWB00iTLB73D8iJf0PgqmnH
         OiQg==
X-Gm-Message-State: AGRZ1gKpyjDpK875rW+DNnczEQySM5HLLj18NtgiBZY1gE8AEEo3ZBPS
        sZfy/mTVTKVGLTR0umW9NYU=
X-Google-Smtp-Source: AJdET5eMZgL1x0ydWC2dPLH45yQLnukTIVo5x/d3cKcOla7EwIfWWeGU/RoCad5e6z+t7zDBwgte0A==
X-Received: by 2002:a6b:6407:: with SMTP id t7-v6mr5040057iog.213.1540907444891;
        Tue, 30 Oct 2018 06:50:44 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id n1sm526206itk.22.2018.10.30.06.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 06:50:44 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 3/4] bus: support HMS Anybus-S bus.
Date:   Tue, 30 Oct 2018 09:50:41 -0400
Message-Id: <20181030135041.5593-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <CACRpkdYVN-s7shQmPkRjB9sxwi32TiKhmd_vKU+Jm--vGy2dSA@mail.gmail.com>
In-Reply-To: <CACRpkdYVN-s7shQmPkRjB9sxwi32TiKhmd_vKU+Jm--vGy2dSA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> struct anybus_s_host *cd = data;
>> drivers/bus/anybus-s-host.c
>> include/linux/anybus-s-client.h
>
> Hm I think this looks pretty neat actually. Anyways, in the overall
> architecture explain the three Anybus:es and why things pertaining
> to Anybus-s are named as they are.

Ok, so should I rename anybuss -> anybus[_|-]s ?
Or maybe wait until a future patch iteration?

> OK but you also have an atomic_set() going on and the struct completion
> already contains a waitqueue and I start to worry about overuse of
> primitives here. How does ps aux look on your system when running this?

ps -aux only lists a single kernel thread associated with this driver,
no other theads, as it should:

$ ps
...
   78 root     [anybuss-host.0.]
...

> It's just that when you do things like this:
> 
>    complete(&cd->card_boot);
>    wake_up(&cd->wq);
>
> I start asking: OK so why is that waitqueue not woken up from
> wherever you are doing wait_for_completion()? I hope it is not
> because you are waiting for the completion in the very same
> waitqueue. That would be really messy.

The two primitives are there because the irq handler is dual purpose, and that
is because the interrupt is dual purpose:
- complete card boot while in the initialization stage
- tell the driver that something has happened while running

You may have a point about the atomic_set(). I'll think about why it's there,
and move it out if unnecessary. Or document why we need it there.

> Nah one irq handler is fine, but you can have an optional
> bottom half:
>
> request_threaded_irq(irq, fastpath, slowpath...):

I don't think any of these abstractions fit :(
Let's wait for the v2 patch with the architecture doc, and you will see why I
believe that's the case. We can then take the discussion from there.

> OK I honestly don't know what is the best way. But what about
> calling that "task" a "state" instead so we know what is going
> on (i.e. you are switching between different states in process
> context).

Let's wait for the architecture docs in the v2 patch.

> Silly question but why does userspace need to know about
> this software interrupt? Can't you just hide that?
> Userspace ABIs should be minimal.

I agree, but in this case the "s/w interrupt" indicates to the user that
someone on the network changed the contents of the card's internal memory.

A client application using this driver will typically sit in a loop, running
poll()/select() on this driver's devnode, waking up when someone modifies
the internal memory.

Example, imagine the card's internal memory is 10 bytes in size.
The internal memory is exposed over the network, and anyone may read
or change it.

|T.h.e. .Q.u.i.c.k]	original contents
				read("/dev/profinet0", 10) => "The Quick"
				poll("/dev/profinet0", PRI|ERR) blocks
|T.h.X. .Q.u.i.c.k]	someone on the network changed position 2, interrupt !
				poll("/dev/profinet0", PRI|ERR) releases
				read("/dev/profinet0", 10) => "ThX Quick"	

Perhaps there is a better / clearer abstraction to accomplish this?

>> Wait... are you talking about
>> reset_controller_add_lookup() / devm_reset_control_get_exclusive() ?
>> That's new to me, and only used in a single driver right now. Would that work?
>
> Yeah I think so.

Good ! I'll put that mechanism in v2, which should be ready soon.

Yours,
Sven
