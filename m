Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B231C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF20121473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF20121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeK3TkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:40:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41224 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeK3TkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:40:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so4129912edi.8;
        Fri, 30 Nov 2018 00:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAwLI8BVj1J9LsaQ30t5cKZmbwB1RAtw/ugevLNd0Lk=;
        b=Wxn92bpNInKnVOm8yv3OoyfTqUBB18xtgZRu9GX1T9OwAgAaqINh9m3MFpJVs9l7/Q
         abF7CmecvQtYf7zUloIqB2bYEAIjCigIoqrHxcs0BSi2ck4S50jDrmudl6ijoTKzxqOs
         uceV7xUIjMdGb16KxhbzQtsEpiSeJL9o7fo3Ztr+k+tpJwNDeUQjZzANiXx3QiTFP3R6
         QOloSLpNfLAjfDxBi5A3atyfNvnZU08riWZRBowGf7o0xl0zyp/Vu5n1X48cK0R7dOxG
         76zSbwg4ThwKs1X1qiKwypATMZS7Muwi2QocqohnbHYUgrifaKi4ySGTOObN6NSEW5sr
         T+wA==
X-Gm-Message-State: AA+aEWY5BwzPU22Bco42fShflDGeS+qemNtbWpqkj5UWe5Eab72vP8TQ
        gPHyCc+9zHT9LtOlzqGnvWwozRgGtJ8=
X-Google-Smtp-Source: AFSGD/VsrYrH2PI2WGTH/+lrjVcmY39Fj7L9PAjoQweHq742PxzAcXro0UBxlZUf6FizZdTuUG4xVA==
X-Received: by 2002:a17:906:138d:: with SMTP id f13-v6mr3990264ejc.176.1543566700617;
        Fri, 30 Nov 2018 00:31:40 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id c23-v6sm706263ejb.62.2018.11.30.00.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:31:40 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id z18so4864529wmc.4;
        Fri, 30 Nov 2018 00:31:40 -0800 (PST)
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr4539936wmd.111.1543566699694;
 Fri, 30 Nov 2018 00:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20181120175211.3913-1-oskari@lemmela.net>
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 30 Nov 2018 16:31:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
Message-ID: <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, oskari@lemmela.net
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP813 AC power supply support with input current and
> voltage limiting support.
>
> AXP803 AC and battery power supply support.
>
> Changes in v6:
> * Collected tags
> * Rebase to master
> * Dropped AXP803 compatible patches
>
> Changes in v5:
> * Return correct input current limit for values 0x6 and 0x7
> * Add specific compatibles for AXP803
> * Change commit messages
> * Add Vasily Khoruzhick Pinebook DTS patch
>
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
>
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit
>
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c
>
>
> Oskari Lemmela (7):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
>
> Vasily Khoruzhick (1):
>   arm64: dts: allwinner: a64: pinebook: enable power supplies

Since this series has been fully reviewed, and the devices it
adds/enables aren't critical, i.e. won't cause the system to fail
if the drivers are missing, I've merged the dts patches for 4.21.

Hopefully Sebastian and Lee will get around to merging the driver
patches.

Thanks.
ChenYu
