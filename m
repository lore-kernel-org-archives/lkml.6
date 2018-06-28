Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576B5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CED426FA8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CED426FA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeF1GZC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:25:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38068 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeF1GY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:24:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id a5-v6so4443102edt.5;
        Wed, 27 Jun 2018 23:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X3OkbO/Q35JX4Y79YgTl6Z4Dmneb1+In5kS3RYNzFSg=;
        b=uFSf0V4d2ujaGhMNQzPtyTFy90umsIKURA8Qan/hPpIyYK9AEwZ2R+OzMwzKGXqRZM
         z2hwheWa4X3me7MKmAgnj/L8X8SWLiO3sXygM4H79mH/FZxn3GKFlTEuRVI4HUYgRAKJ
         mk5rSC+X2cHlkaXfrXM5IAUPkQIWJmwUPz98SCoe4dd+mf8cAa4L8Ck/sCy9VHnMnuiB
         COym6HagAjXTHAUGNe3yxNCmnLKRr0qnGU/4G2vvM8dI3hkztX/udszDLxiow59u/gz7
         jxHrXNDyzNRdzGw7I04p9Ernr8yboTQoOI7RUXUM1L5yEsIrga281/AH2A02+pL/dhUf
         /d1w==
X-Gm-Message-State: APt69E0Wx2mJ4vcLE35yrrMLCUbtMWdaPaMOmi1CPzMlrLba1ijOtuel
        ouc1ajQq9q4IogO9oZlzqN7EijzO
X-Google-Smtp-Source: AAOMgpcVKWo+z0JkI8F57L8x0P58y3ae3s7V6u/2UZudnmqyqbMR0iXqsDCfa7wzuQr5BPndKsFfxw==
X-Received: by 2002:a50:ae62:: with SMTP id c89-v6mr8091600edd.257.1530167098094;
        Wed, 27 Jun 2018 23:24:58 -0700 (PDT)
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id b20-v6sm2092641edr.26.2018.06.27.23.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 23:24:55 -0700 (PDT)
Received: by mail-wr0-f177.google.com with SMTP id e18-v6so4211309wrs.5;
        Wed, 27 Jun 2018 23:24:55 -0700 (PDT)
X-Received: by 2002:adf:a54d:: with SMTP id j13-v6mr7944274wrb.155.1530167095194;
 Wed, 27 Jun 2018 23:24:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 23:24:34
 -0700 (PDT)
In-Reply-To: <2676604.ZYCNkuCdbT@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-10-jernej.skrabec@siol.net> <CAGb2v64EkVK+AEngEuadBzAZagyU7eyOhHhBh0iFrxS+-BbCYQ@mail.gmail.com>
 <2676604.ZYCNkuCdbT@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 14:24:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v67kBRWkJpJogFR4GXgA66dsxVaMVWN8MDiP_wFTqxW-=g@mail.gmail.com>
Message-ID: <CAGb2v67kBRWkJpJogFR4GXgA66dsxVaMVWN8MDiP_wFTqxW-=g@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 09/24] drm/sun4i: Don't skip TCONs if
 they don't have channel 0
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:45 PM, Jernej Škrabec
<jernej.skrabec@siol.net> wrote:
> Dne četrtek, 28. junij 2018 ob 03:51:31 CEST je Chen-Yu Tsai napisal(a):
>> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > TV TCONs (channel 1 only) are always connected to TV or HDMI encoder.
>> > Because of that, all output endpoints on such TCON node will point to a
>> > encoder which is part of component framework.
>> >
>> > Correct current graph traversing algorithm in such way that it doesn't
>> > skip output enpoints with id 0 on TV TCONs.
>>
>> No. Our bindings say that endpoint 0 _is_ channel 0. For TCONs that don't
>> have channel 0, it must be skipped.
>
> I'm not sure where this is stated. I read TCON binding again. Can you please
> point me to it?

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt#L169

Our TCON driver still expects RGB or LVDS panel / bridges on endpoint 0.
So I guess this was sort of implied historically. It's no longer true.
This is something we should probably fix.

In practice our drivers don't look at it (yet), but rely on the downstream
encoder type to determine which channel to use.

But please add the "allwinner,tcon-channel" property as specified in
the binding.

> So on TV TCONs on R40 (without channel 0) TVE would be endpoint 1 and HDMI
> endpoint 2 (or the other way around)?

Which one goes first doesn't quite matter. IIRC there's also a mux for TVE?

ChenYu
