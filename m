Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB8E21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPeMbZpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfAILPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:15:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44148 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbfAILPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:15:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3159131pgr.11;
        Wed, 09 Jan 2019 03:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eacqgTZrpjzcqQzKQWY4B35kDdh5bBoqeUPPxbaU/l4=;
        b=hPeMbZpms10uyzfoVo1BusSjyvkih/jyrCP4qJRS/YC/X2dQetsPeArSVRt3eAeXMI
         uX4EQweYdm+VdBnVTKrzCjEPd2o81pTxhqf7bkmhr+RZSd4svATHWiTGM7CdU9NZBCUQ
         O+sB8GZfWUwVH2UcunB266bDGgosbY6OiqE1o1nKWNiIR2uzeEVxvxWv8WFOmxs89JCI
         AWr85cO6F5XXLj5VW96jvpi+dDSIwZ3pLx+F/s//X23AARy0vrI6NOHsybZmBJVXb/eq
         b4vxVK7gqt5dTyT3zk5s/DMZL/QqIaYR++opsmgFuKLo/TuPQJF1z4/+xXYc0JMJvbuN
         hIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eacqgTZrpjzcqQzKQWY4B35kDdh5bBoqeUPPxbaU/l4=;
        b=AICQPjxrR6rURe6zfSO7y30B2BmUG/J/LCKmpGSP4NkMz6wRXIZ1y7iNp3zPI6m7Dr
         SePRii88ulYxcagjQu63GsDl3SRy5XSzCqRZ3hipRlsSpAdxJCqy3NMzY85AmxLIYShd
         wFTbZyFLL82BI8SR0aUqGykN+T5tFoJCpN3+VirLUefa/QALx8wbZD7Gnmtc3bmPbAJV
         GFNNrLNJuabtfeBjHD7EhPAi0XBMP6Bfpg6KNYSYW9p2H1t41w78OO4iBAa/zSqM1n5n
         lwFh7hLTwwXW3KMJhvz2o9DL/RgPRnLzCxbqwYebXj5S60l1yC3rjsqxxrEel7JJz/IT
         CvOw==
X-Gm-Message-State: AJcUukcMUX/fImNerwPj4+kL+3xQIYPtyRlnk+Rt518cXxjvJMpePOSZ
        Lv4aiQES+FrOFVmhi8kx/68vWIjs/ygVZJWOUUA=
X-Google-Smtp-Source: ALg8bN6oovhhl339ABpM7OHWhdMHFk5MLvzh+EMmhdyuSeCossigT+8tGqoXGbXsV0ki3/ziUM/2neg7t+JUf1uN9Ms=
X-Received: by 2002:a63:f615:: with SMTP id m21mr5103263pgh.428.1547032546312;
 Wed, 09 Jan 2019 03:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20190108175818.705110-1-lkundrak@v3.sk>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Jan 2019 13:15:35 +0200
Message-ID: <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Hello!
>
> This is a fourth spin of the patch set that adds support for the
> Embedded Controller on an OLPC XO 1.75 machine.
>
> It hopefully incorporated all feedback received previously and also
> fixes the kbuild test bot failures. The failed builds were generally
> caused by configurations where the EC driver was built as module.
>
> It turned out that the patch that turned the OLPC EC common code into
> a module was not the brightest idea. I now dropped it and modified the
> 04/15 to not require it.
>
> Also, the 01/15 patch has been added to allow the module to provide a
> reboot handler. Patch 15/15 depends on it.

Isn't it a quite big distance between provider and consumer?
Especially taking into consideration concerns about patch 1 which
blocks the series.
Perhaps you may drop it as a patch 1 and do something on top of patch
15 as feature extension?


>
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
>
> [01/15] ARM: export arm_pm_restart()
> [02/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
> [03/15] Platform: OLPC: Remove an unused include
> [04/15] Platform: OLPC: Add XO-1.75 EC driver
> [05/15] Platform: OLPC: Avoid a warning if the EC didn't register yet
> [06/15] Platform: OLPC: Move EC-specific functionality out from x86
> [07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
> [08/15] Platform: OLPC: add a regulator for the DCON
> [09/15] dt-bindings: olpc_battery: Add XO-1.5 battery
> [10/15] x86, olpc: Use a correct version when making up a battery node
> [11/15] power: supply: olpc_battery: Use DT to get battery version
> [12/15] power: supply: olpc_battery: Move priv data to a struct
> [13/15] power: supply: olpc_battery: Use devm_power_supply_register()
> [14/15] power: supply: olpc_battery: Avoid using platform_info
> [15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support
>
> Lubo
>
>


-- 
With Best Regards,
Andy Shevchenko
