Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1573C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C36E2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RiXp5GlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C36E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeIGIwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:52:30 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51108 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIGIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:52:29 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so18985091ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 21:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3FuBBmMfuBFUgZminCEr1rX+M+yLV334kqa8g211MGg=;
        b=RiXp5GlNKybf4+EeDNRRzV6l1x9JlSvqg4UJmApcBZXmNkozAiRuWf1hkmpbyE+O2a
         y3dTe5gmhX0YYnKAVaas0Vy0lpVraAXFO+PKKcDTl574h5UesaaTwHyCLq3/F26zOfkN
         w2BJ4SJGByA/5QpGzgiLFEH0+PA9sMmU5rraY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3FuBBmMfuBFUgZminCEr1rX+M+yLV334kqa8g211MGg=;
        b=pel61f5OuXxurrxBhwIbxutPoYqTAB87SGEYcJ2oodFObCuVg2Y5TSWBhaMfec5nr/
         lYAEXi8ZjjGS6YyoUyMDn+BtDyOUpy9AmxZHnLLdSVN+tWkxkWXXNARSSALLA7wWEnIT
         yWMS/F9ntQsaIl6mnEx6sRinmsrm512DtMfah2wxLx9wIne2CPJGEmnGKgS2/QJPgSYy
         XOO3bB94x1YL0L35HvcmQGM/9Sya3FZ+PY4OmkQhpsR3xIDwmjedryFHUHSh4HAPjwYH
         IP5UScDil+svf72lcaXaN/HE9xYAHKHoAEdScAcftLwdsoM6zNs93CJk9p4bR1bwOUil
         QGlw==
X-Gm-Message-State: APzg51BAFTjAbfRtTLsf5/EWh21uAREReVInQW982nFFbc0eFXGLlK9C
        kI1SU/yPym6oNlWsplaWGwPm9DkuUTAljDpvReIm8w==
X-Google-Smtp-Source: ANB0VdZn2IBvGzpSn/9exJGM59tkoIdFZUDNWBK3hPfKdmVS05f7MV/fT/wYY17LSKEZXbR0qP/mYq6404vSk1niFds=
X-Received: by 2002:a24:670a:: with SMTP id u10-v6mr5121571itc.31.1536293610403;
 Thu, 06 Sep 2018 21:13:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 21:13:29 -0700 (PDT)
In-Reply-To: <20180905075056.tob7itg3judccooe@flea>
References: <20180904044053.15425-1-icenowy@aosc.io> <20180904044053.15425-9-icenowy@aosc.io>
 <20180905075056.tob7itg3judccooe@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 7 Sep 2018 09:43:29 +0530
Message-ID: <CAMty3ZBo+X5o22i1=HR9d1VjkEWQ7=DHHPL9RLtbzbyzCZLyFw@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] arm64: dts: allwinner: a64: Add display pipeline
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 1:20 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Sep 04, 2018 at 12:40:50PM +0800, Icenowy Zheng wrote:
>> +             hdmi_phy: hdmi-phy@1ef0000 {
>> +                     compatible = "allwinner,sun8i-h3-hdmi-phy";
>> +                     reg = <0x01ef0000 0x10000>;
>> +                     clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>> +                              <&ccu 7>;
>> +                     clock-names = "bus", "mod", "pll-0";
>> +                     resets = <&ccu RST_BUS_HDMI0>;
>> +                     reset-names = "phy";
>> +                     #phy-cells = <0>;
>> +             };
>
> This needs to use the bindings we have for that phy.

You mean allwinner,sun50i-a64-hdmi-phy ?
