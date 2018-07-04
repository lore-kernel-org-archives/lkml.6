Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DFDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C99246F9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C99246F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeGDEGJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:06:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45326 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeGDEGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:06:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id g15-v6so3017063edr.12;
        Tue, 03 Jul 2018 21:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OZ5r5ggY6HAP8Y80+J7WO7uNvbj/H8491IVK1+VY1dI=;
        b=Sbk27n5VmTU1P8WWMe+1GfpjM8ycA331xNg6Bvqkfm91u+9su02VQ9xSa65dczpBaE
         JFSK2qX2BnqGpz8Y4rW2d02lUhy/zmtYYmgsinaardGHZ/tQVAiZ6GvqLyCoMxLqsE+E
         6VlrWE43SnGFoKgB/shgWLm3bIN2xByC/NGADdJkkF/l9U9m/sKvPRwRqUK5RQ7J0Cq4
         QNtYkCX0Ytx+4ApfqxzvWN+mmEuBjDvSIgwVJzqX8d50NQVsz/C6fGCt1jTvhcNJKuuT
         GvdK1T6JKbFQIv9bTyRgRuLpn3BCOTz+FeVFpK3+slcghZP+9BDg/9hhp9pYHhbAbmIf
         DSuA==
X-Gm-Message-State: APt69E17k8y6rh9pAUdQreZ/Ibwb+gmE1M3b+mzgTjpONYk4pWhTClHj
        jDRqe2y/73bRWp182SY0Se+AWSW2
X-Google-Smtp-Source: AAOMgpcWzemdDuiHGP0D/59rblQndBjy4A/vds7Ibckfd23G0cz32hM6e69TCpVoJtf7iuBF824zYw==
X-Received: by 2002:aa7:d34d:: with SMTP id m13-v6mr802946edr.143.1530677165484;
        Tue, 03 Jul 2018 21:06:05 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id q6-v6sm1393675edk.67.2018.07.03.21.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 21:06:04 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id i139-v6so4227771wmf.4;
        Tue, 03 Jul 2018 21:06:04 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr395974wma.143.1530677164317;
 Tue, 03 Jul 2018 21:06:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 21:05:43 -0700 (PDT)
In-Reply-To: <1814959.07NGAI1aoU@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <1669385.k4L9lni8DF@jernej-laptop> <CAGb2v67iRZZTQuTH8inwmPC6S0BRecFgPEpKrxgThQbsYaZgmQ@mail.gmail.com>
 <1814959.07NGAI1aoU@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 4 Jul 2018 12:05:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RUiEFSKe9YO8=bROmtozHKRN4s76QHpY+38PJPLaG7w@mail.gmail.com>
Message-ID: <CAGb2v65RUiEFSKe9YO8=bROmtozHKRN4s76QHpY+38PJPLaG7w@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 15/24] dt-bindings: display:
 sun4i-drm: Add description of A64 HDMI PHY
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

On Sat, Jun 30, 2018 at 3:32 AM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Dne četrtek, 28. junij 2018 ob 09:00:32 CEST je Chen-Yu Tsai napisal(a):
>> On Thu, Jun 28, 2018 at 12:51 PM, Jernej Škrabec
>>
>> <jernej.skrabec@siol.net> wrote:
>> > Dne četrtek, 28. junij 2018 ob 04:19:55 CEST je Chen-Yu Tsai napisal(a):
>> >> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
>> >
>> > wrote:
>> >> > A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
>> >> > clock parents. It is compatible to other HDMI PHYs, like that found in
>> >> > R40.
>> >> >
>> >> > Acked-by: Rob Herring <robh@kernel.org>
>> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >> > ---
>> >> >
>> >> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
>> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git
>> >> > a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
>> >> > 84fe38dbb900..dc83f21ef188 100644
>> >> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> >> > @@ -101,6 +101,7 @@ DWC HDMI PHY
>> >> >
>> >> >  Required properties:
>> >> >    - compatible: value must be one of:
>> >> > +    * allwinner,sun50i-a64-hdmi-phy
>> >> >
>> >> >      * allwinner,sun8i-a83t-hdmi-phy
>> >> >      * allwinner,sun8i-h3-hdmi-phy
>> >>
>> >> Nit: the list is sorted by family first, then SoC name, so it should
>> >> be the last on the list.
>> >
>> > I went alphabetically, since "5" is before "8"...
>>
>> I see. I think version sort applies here, given that sun50i is newer
>> than sun8i.
>
> Should I make a patch for that?

Yes, please.
