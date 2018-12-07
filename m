Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBDFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24EE20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24EE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLGHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:45:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44859 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:45:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so2903868edd.11;
        Thu, 06 Dec 2018 23:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8xvOWkToXJw2n9tRNGsgGrpj0F2EZBHsviBiImVuNg=;
        b=bPM/EcCw4TIMcXa5LYnf3JqbcGG24tNjsgJBVNQDBeaDsty5Ff0aVSzFK0FmYkRSMc
         1eelu6m6djE0eC3NPHNjT8Q85uteTFA9POLeDoYIdUaPy0wRXOnaA16u4N4vYjVndR13
         DddfaqU8yXLyJq165Fhm9n9XEsV+NaZCnNpNEjcb+SR0CWW9tizM9te+Rv/LLUZpTZTE
         rztCjw1tJVuzldpOt4gX7F+3tjL3JSKrfqXRq1cdhz2FeBsZHmDehWdttlTJO5jp18Tg
         xOTfFAN4oXe6CpkKPLg3bxEBetP4h+hK6l3ArW833yk1xhBxIU2V2BmLfuaMPm7GE2HS
         v9uA==
X-Gm-Message-State: AA+aEWYp7LTpXaR1yFRdbwtq/Rt+2+pVRQeUqsidl7pGFyN/+K7KQmAo
        9h3kohe+XpeyOsXBMHjDJE73wR8uazU=
X-Google-Smtp-Source: AFSGD/XPP71YeqjpTJjIiuBsS3CtKpC65q+qroERBgnMcUGWcI4JrTYnYw/zdDioPRnNW1atbShmdQ==
X-Received: by 2002:a50:f4c3:: with SMTP id v3mr1305220edm.196.1544168745515;
        Thu, 06 Dec 2018 23:45:45 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id x47sm791180eda.91.2018.12.06.23.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 23:45:45 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id q26so3460787wmf.5;
        Thu, 06 Dec 2018 23:45:45 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr1298240wmc.116.1544168744826;
 Thu, 06 Dec 2018 23:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20181120175211.3913-1-oskari@lemmela.net> <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
 <20181205180042.fr5npvtwuvt2c6q3@earth.universe> <20181207072803.GG26661@dell>
In-Reply-To: <20181207072803.GG26661@dell>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 7 Dec 2018 15:45:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RMirgaRLD3Ctbxyx410FN5ushicDaRbJTO9sqc+38GA@mail.gmail.com>
Message-ID: <CAGb2v65RMirgaRLD3Ctbxyx410FN5ushicDaRbJTO9sqc+38GA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     sebastian.reichel@collabora.com, oskari@lemmela.net,
        Rob Herring <robh+dt@kernel.org>,
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

On Fri, Dec 7, 2018 at 3:28 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 05 Dec 2018, Sebastian Reichel wrote:
>
> > Hi,
> >
> > On Fri, Nov 30, 2018 at 04:31:28PM +0800, Chen-Yu Tsai wrote:
> > > On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
> > > >
> > > > AXP813 AC power supply support with input current and
> > > > voltage limiting support.
> > > >
> > > > AXP803 AC and battery power supply support.
> > > >
> > > > Changes in v6:
> > > > * Collected tags
> > > > * Rebase to master
> > > > * Dropped AXP803 compatible patches
> > > >
> > > > Changes in v5:
> > > > * Return correct input current limit for values 0x6 and 0x7
> > > > * Add specific compatibles for AXP803
> > > > * Change commit messages
> > > > * Add Vasily Khoruzhick Pinebook DTS patch
> > > >
> > > > Changes in v4:
> > > > * Change order of axp20x-gpio in axp20x.c
> > > > * Fix indentation and spaces to tabs in axp20x.c
> > > >
> > > > Changes in v3:
> > > > * Reorder ac_power_supply DT node
> > > > * Rename axp20x_ac_power_set_property function
> > > > * Split mfd commit
> > > >
> > > > Changes in v2:
> > > > * Reuse axp813 compatibles for axp803
> > > > * Refactor axp20x_ac_power.c
> > > >
> > > >
> > > > Oskari Lemmela (7):
> > > >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> > > >   ARM: dts: axp81x: add AC power supply subnode
> > > >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> > > >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> > > >   power: supply: add AC power supply driver for AXP813
> > > >   mfd: axp20x: Add AC power supply cell for AXP813
> > > >   mfd: axp20x: Add supported cells for AXP803
> > > >
> > > > Vasily Khoruzhick (1):
> > > >   arm64: dts: allwinner: a64: pinebook: enable power supplies
> > >
> > > Since this series has been fully reviewed, and the devices it
> > > adds/enables aren't critical, i.e. won't cause the system to fail
> > > if the drivers are missing, I've merged the dts patches for 4.21.
> > >
> > > Hopefully Sebastian and Lee will get around to merging the driver
> > > patches.
> >
> > I queued the power-supply driver changes and prepared a signed
> > immutable tag for Lee:
> >
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> >
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> >
> > are available in the Git repository at:
> >
> >   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/psy-mfd-axp813-immutable-for-v4.21-signed
> >
> > for you to fetch changes up to 7693b5643fd2d682de90733b67fc8032b9646911:
> >
> >   power: supply: add AC power supply driver for AXP813 (2018-12-05 18:49:32 +0100)
> >
> > ----------------------------------------------------------------
> > Immutable branch between mfd and power-supply for driver
> > changes related to axp813.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >
> > ----------------------------------------------------------------
> > Oskari Lemmela (2):
> >       dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> >       power: supply: add AC power supply driver for AXP813
> >
> >  .../bindings/power/supply/axp20x_ac_power.txt      |  3 +
> >  drivers/power/supply/axp20x_ac_power.c             | 94 ++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h                         |  1 +
> >  3 files changed, 98 insertions(+)
>
> What patches are left now?  Just 7 and 8?

That's right. If you could merge them, that'd be great.
Thanks Lee.

ChenYu
