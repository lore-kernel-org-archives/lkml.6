Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 03:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AA02082A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 03:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AA02082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeKNN03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 08:26:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40268 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 08:26:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so11784271edx.7;
        Tue, 13 Nov 2018 19:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JA6m1eBDfTjSl52PzXe/thhnHCjOGYCNpyCBUrTusg=;
        b=S6KhmGJDWfKBhL/FqI62xYdGlUy5xLM+epplSGA50Qwie0TjI/0DI/lwxQFc3K1uAv
         +gtIHhCwwfFwyKhQT8Ph0t7+Wsa6oK9lDbfXgvB0nFnoIR+5BxFDm+46evN00h6JtNoW
         EfxDkd1LoBPNySfp7xC+kOv2dRgCH7Jcc0+JOMWtEqc7vLo+NbM9RSoKprYU4hlbzQJi
         2OOWfYbfWg2ZsPGITC42JDbhkYSuG/YbTL2RiXZ39+ZAf5l7th5QtByjaNk8yHVfmOL9
         Z6eIZ8oNKJfx9J9alD9lWCZPbBoPaDCLBnUWtmgamjtDa3jWEY160a1lOkJUIRNxinM0
         K/mg==
X-Gm-Message-State: AGRZ1gL1fpKYHOZRYt4/FTl4umpc7VT5flQG2aNnH3mdW01xnUEWbdP8
        eZ7ymAdcpth7NTcYvT9ncAZmeRgys6k=
X-Google-Smtp-Source: AJdET5eGAJzUFbKhDPZPN0MzOv0PJ+UicI83IzCtkecyBmkTPQDYkxhCxwCmOO087vMvWq8SVPvqrQ==
X-Received: by 2002:a17:906:3ed4:: with SMTP id d20-v6mr415069ejj.151.1542165909158;
        Tue, 13 Nov 2018 19:25:09 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id n34-v6sm6087801edc.34.2018.11.13.19.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 19:25:08 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id y3-v6so15571687wrh.10;
        Tue, 13 Nov 2018 19:25:08 -0800 (PST)
X-Received: by 2002:adf:ecc5:: with SMTP id s5-v6mr144885wro.208.1542165908230;
 Tue, 13 Nov 2018 19:25:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Nov 2018 11:24:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ygbcomUMkcv8qMCAs_qviFMPzpxj-F4=YBrpuLrdSUw@mail.gmail.com>
Message-ID: <CAGb2v66ygbcomUMkcv8qMCAs_qviFMPzpxj-F4=YBrpuLrdSUw@mail.gmail.com>
Subject: Re: [PATCH 0/5] media: Allwinner A10 CSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 4:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Here is a series introducing the support for the A10 (and SoCs of the same
> generation) CMOS Sensor Interface (called CSI, not to be confused with
> MIPI-CSI, which isn't support by that IP).
>
> That interface is pretty straightforward, but the driver has a few issues
> that I wanted to bring up:
>
>   * The only board I've been testing this with has an ov5640 sensor
>     attached, which doesn't work with the upstream driver. Copying the
>     Allwinner init sequence works though, and this is how it has been
>     tested. Testing with a second sensor would allow to see if it's an
>     issue on the CSI side or the sensor side.
>   * When starting a capture, the last buffer to capture will fail due to
>     double buffering being used, and we don't have a next buffer for the
>     last frame. I'm not sure how to deal with that though. It seems like
>     some drivers use a scratch buffer in such a case, some don't care, so
>     I'm not sure which solution should be preferred.
>   * We don't have support for the ISP at the moment, but this can be added
>     eventually.
>
>   * How to model the CSI module clock isn't really clear to me. It looks
>     like it goes through the CSI controller and then is muxed to one of the
>     CSI pin so that it can clock the sensor. I'm not quite sure how to
>     model it, if it should be a clock, the CSI driver being a clock
>     provider, or if the sensor should just use the module clock directly.

Which clock are you talking about? MCLK? This seems to be fed directly from
the CCU, as there doesn't seem to be controls for it within the CSI hardware
block, and the diagram doesn't list it either. IMO you don't have to model it.
The camera sensor device node would just take a reference to it directly. You
would probably enable the (separate) pinmux setting in the CSI controller node.


ChenYu
