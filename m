Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55201C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1D20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1D20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeKRCT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:19:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38716 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRCT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:19:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id a2-v6so22034053edi.5;
        Sat, 17 Nov 2018 08:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpIkRnRmiocIkpvMFLv5HAS8OytT+QmzXxlV+eAuMyw=;
        b=QtHoxR9R5WrDR6InLdhPZPY1OsnlLd+b4ydPXb6P/Btmi2EPdJMjxHLX2CotBFylZD
         iGPYMQ5LVyAzz4UCa93JPpEIFoRDTQSl8MxqyPKQJXtrPlZtR+Yz7d93wsgbVViZotf9
         Yos9fAbeA+NzXf9ybXl0y/FUJaxEC96wAVw4Va29h8/e7qevRkkOCiluXQVLP5/KFBcH
         LWWXPr0ledOsCckoVLMfcvHzTV7y7qA4FBUSJ1VkLpzKxZtrm+2FUPq1R5UuGvjT6+eJ
         b5e8GOKrwrF8kPy7iRpKX6mZAdw14EIFg/5uF6QoInHDwqRMMqzdAGSWmiebFnHyLl7v
         BMpA==
X-Gm-Message-State: AGRZ1gKl9agCB7uRrIXScc1ajtuzdSYSpYjzqhJTVRVaBJz7GJttLyyb
        oFo2nPV4t+7kj8d3ELKNUCM0bjR2
X-Google-Smtp-Source: AJdET5eevGsb3Yqy6lgxpEqJovrWXpQ3++dxGPGl5XKuMNvGuJ30Ntg+z4HC4s3AMQ3zauEdxR2zeA==
X-Received: by 2002:a50:b284:: with SMTP id p4-v6mr6662811edd.60.1542470538347;
        Sat, 17 Nov 2018 08:02:18 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id i14-v6sm4827168ejy.40.2018.11.17.08.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 08:02:18 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 124-v6so1373209wmw.0;
        Sat, 17 Nov 2018 08:02:18 -0800 (PST)
X-Received: by 2002:a1c:2304:: with SMTP id j4mr1902419wmj.14.1542470537597;
 Sat, 17 Nov 2018 08:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-4-anarsoul@gmail.com>
 <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com> <CA+E=qVegv61NgF4peK=Bz2RDvjCUX+M_njrpC4Ph+Jv+r2KFgg@mail.gmail.com>
In-Reply-To: <CA+E=qVegv61NgF4peK=Bz2RDvjCUX+M_njrpC4Ph+Jv+r2KFgg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 18 Nov 2018 00:02:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65vDRTUDo894nXvOi8xEkMzeymbU=OQjdyY-Eh38T7F+A@mail.gmail.com>
Message-ID: <CAGb2v65vDRTUDo894nXvOi8xEkMzeymbU=OQjdyY-Eh38T7F+A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on Pinebook
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 1:48 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Wed, Nov 7, 2018 at 11:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > +
> > > +       speaker_amp: speaker_amp {
> > > +               compatible = "simple-audio-amplifier";
> > > +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> >
> > You might want to add a sound-name-prefix property. See
> >
> >     Documentation/devicetree/bindings/sound/name-prefix.txt
> >
> > Also this should have a reference to its power supply regulator.
>
> You're right, it should reference its power supply which should be a
> fixed regulator controlled via GPIO from AXP803.
>
> Unfortunately there's no AXP803 GPIO support yet and
> simple-audio-amplifier doesn't have regulator property.
>
> I have no time (and interest) to work on it in near future, so if
> anyone wants to pick it up - feel free to do so.

Understood. I can try to pick it up when I have some extra time.

On the other hand, I tried this series on my Pine64 and (with
the necessary device tree changes) on my Bananapi M64. While
audio played (did not stall), no audio was actually coming out
of the headphones I had plugged in. I made sure that all needed
mixer controls were enabled, and the DAPM graph read all green
from the DAI to the Headphone jack.

Any ideas?


Regards
ChenYu
