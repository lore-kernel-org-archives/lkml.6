Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ABEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7116626FE4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7116626FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964786AbeF1HA6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:00:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37093 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933361AbeF1HA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:00:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so4493919edq.4;
        Thu, 28 Jun 2018 00:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=urXhfHTY3AsAltQuuau4lr0igcRK+phHSMvDsgjkTtA=;
        b=QweHOjV9Tc9N7uucxK11HPcEYtiQm2Ks5gnWYDs5bpIYomVwDj6b6pD8es44DmvXbk
         KML63CKm3jYutjz7cln/7iJaRwg7jXpikWAIn/N01/UamXJWa7ehJEyYo/XCjuyaaHF+
         a3ntE4wrlhDZixNmcEf6sKqzI0Ptycv4prcLWNeIZJJN4LrgHR2M6kHwdQZ7J7oIFkFS
         YGV5iBK53KL67US6sLOoPgarzJDHbh3WHqdITK6a02oP25gUtcyogb1K0ZjKM7VKoAaL
         kGwlC6N0IBIyztxNhojt+OOn98ii7ezmkll5zDMBuRm+/t/lmlOuY32Is4z99PBmQV5j
         r+pA==
X-Gm-Message-State: APt69E0+akfmUNqbn+RXYGEUeko7Sz6HUIjFC0+uHq9cZTfIljRpOIz7
        dzXRUk7zoiYqdgPQSpXKULQ6g38C
X-Google-Smtp-Source: AAOMgpex1eginINmz1oDSu9ej/Pzd16+OsyrlhqxvTK8tzNIPEn7yhHvf6G0VTjWNA+XQUBoV18z+g==
X-Received: by 2002:a50:9135:: with SMTP id e50-v6mr5260951eda.191.1530169254384;
        Thu, 28 Jun 2018 00:00:54 -0700 (PDT)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id o15-v6sm2747990edt.4.2018.06.28.00.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 00:00:53 -0700 (PDT)
Received: by mail-wm0-f53.google.com with SMTP id z13-v6so7787613wma.5;
        Thu, 28 Jun 2018 00:00:52 -0700 (PDT)
X-Received: by 2002:a1c:850c:: with SMTP id h12-v6mr6963261wmd.116.1530169252596;
 Thu, 28 Jun 2018 00:00:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 00:00:32
 -0700 (PDT)
In-Reply-To: <1669385.k4L9lni8DF@jernej-laptop>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-16-jernej.skrabec@siol.net> <CAGb2v66ytOrjMOK067URknens34jvYxJ1XoYmGMi4Ji0LYt9sQ@mail.gmail.com>
 <1669385.k4L9lni8DF@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 15:00:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v67iRZZTQuTH8inwmPC6S0BRecFgPEpKrxgThQbsYaZgmQ@mail.gmail.com>
Message-ID: <CAGb2v67iRZZTQuTH8inwmPC6S0BRecFgPEpKrxgThQbsYaZgmQ@mail.gmail.com>
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

On Thu, Jun 28, 2018 at 12:51 PM, Jernej Škrabec
<jernej.skrabec@siol.net> wrote:
> Dne četrtek, 28. junij 2018 ob 04:19:55 CEST je Chen-Yu Tsai napisal(a):
>> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > A64 HDMI PHY is similar to H3 HDMI PHY except it has two possible PLL
>> > clock parents. It is compatible to other HDMI PHYs, like that found in
>> > R40.
>> >
>> > Acked-by: Rob Herring <robh@kernel.org>
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > ---
>> >
>> >  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> > b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt index
>> > 84fe38dbb900..dc83f21ef188 100644
>> > --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> > @@ -101,6 +101,7 @@ DWC HDMI PHY
>> >
>> >  Required properties:
>> >    - compatible: value must be one of:
>> > +    * allwinner,sun50i-a64-hdmi-phy
>> >
>> >      * allwinner,sun8i-a83t-hdmi-phy
>> >      * allwinner,sun8i-h3-hdmi-phy
>>
>> Nit: the list is sorted by family first, then SoC name, so it should
>> be the last on the list.
>
> I went alphabetically, since "5" is before "8"...

I see. I think version sort applies here, given that sun50i is newer
than sun8i.

ChenYu

> Best regards,
> Jernej
>
>>
>> Otherwise,
>>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>>
>> >    - reg: base address and size of memory-mapped region
>> >
>> > @@ -111,8 +112,9 @@ Required properties:
>> >    - resets: phandle to the reset controller driving the PHY
>> >    - reset-names: must be "phy"
>> >
>> > -H3 HDMI PHY requires additional clock:
>> >
>> > +H3 and A64 HDMI PHY require additional clocks:
>> >    - pll-0: parent of phy clock
>> >
>> > +  - pll-1: second possible phy clock parent (A64 only)
>> >
>> >  TV Encoder
>> >  ----------
>> >
>> > --
>> > 2.18.0
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
