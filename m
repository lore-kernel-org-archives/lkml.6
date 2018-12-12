Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DC6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5332086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QCwX+367"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5332086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeLLN26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:28:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46182 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLLN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:28:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so17653231wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHAv5R5QwRmJoCLzBKLZOXFUpzVxkJ8Y6vSdR8cBZGY=;
        b=QCwX+367wHog/EzWzZZz8NdRumFZVFfyfCBTkcBOHX0VCOIscisr10gLRbkkjExHwz
         gJNSn6mMGcwR0p9W57KOyOE7FlQ9bY8YBRWiYOY+twMmuQbAwnALnqx86m8pxqUzsBci
         GVyjbDtwHn6hAsAYMR7DKXx0EpNwmfIFTE3E0upXH7Oo3hOCYMRTuIVVaEOkGJwn2uxz
         IazBB1yLCLOvRfL0uZVkVsd8369dGPsnKAG9O6Jl/e2RDXi6Y2k6kc5UKL0tTlWlcqCm
         LsxgFQG1CnAXI+hZBtYZ3HKjLaxdxht603AMQgemdtF1rB/phow/GKH+rzuMpjlLa6/g
         aKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHAv5R5QwRmJoCLzBKLZOXFUpzVxkJ8Y6vSdR8cBZGY=;
        b=piHaUdTY4dTNQVRTsrKuBULhPhXAPid5/lbwt5PLQF8varSE/as/gxqsqDWMMApn2g
         fL5k4eXRD8t3tpcZ/ueFeA+D7hoKfFPwWv8/zPgD26MJL+yVSOJ/xDPdkOEAMd9l+Yd5
         vJ3AR3zrN1JEDwW9qJ3XZd78mgi/+ymm+5END5r3kF9rtIq38ozcEeAIVe3kxeYwCb0B
         tUho5GnZBASvONX4p19M2qciPXyFTSZBYlpEnoRzcqkxcaJiatqT5EPW+Gl4SIaXrCx1
         D9bZJok4cuaYdG6Ho3hbxJ1bJXnfkXrMDZ1cOrmlkfSDKdn1zvLWSB7ot/VYx7UzNMv7
         +JpQ==
X-Gm-Message-State: AA+aEWb43dREvAUaQuTZLvxPt0dYwq5nbRlu8TKLVm29626de8qqzcut
        itN0B5s9+h9ls8fsTRXXHes6pGA8ozuqBvs5OMO/Bg==
X-Google-Smtp-Source: AFSGD/VEVNo4hXgKkuJs4Sxb988az8kXAqw60vyKgmO3r+7u+/iD41jor3t1AmM5VxFCcDXJmKjw+arEkt3im1mDibo=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr17261677wro.29.1544621336425;
 Wed, 12 Dec 2018 05:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20181210090640.4495-1-mjourdan@baylibre.com> <434d1dc0-3c5e-5cb3-cc88-b565bfb74217@baylibre.com>
In-Reply-To: <434d1dc0-3c5e-5cb3-cc88-b565bfb74217@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 12 Dec 2018 14:28:45 +0100
Message-ID: <CAMO6nawq6XsmsucVHPDDc3nuYLEDa4U1QC_5v26jofNv+BKH1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
On Wed, Dec 12, 2018 at 10:54 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Maxime,
>
> On 10/12/2018 10:06, Maxime Jourdan wrote:
> > Similar to simple-framebuffer-sunxi, we support different display pipelines
> > that the firmware is free to choose from.
> >
> > This documents the "amlogic,simple-framebuffer" compatible and the
> > "amlogic,pipeline" extension.
> >
> > Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> > ---
> >  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> > new file mode 100644
> > index 000000000000..122a5c005cd9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> > @@ -0,0 +1,33 @@
> > +Meson specific Simple Framebuffer bindings
> > +
> > +This binding documents meson specific extensions to the simple-framebuffer
> > +bindings. The meson simplefb u-boot code relies on the devicetree containing
> > +pre-populated simplefb nodes.
> > +
> > +These extensions are intended so that u-boot can select the right node based
> > +on which pipeline is being used. As such they are solely intended for
> > +firmware / bootloader use, and the OS should ignore them.
> > +
> > +Required properties:
> > +- compatible: "amlogic,simple-framebuffer"
> > +- amlogic,pipeline, one of:
> > +  "vpu-cvbs"
> > +  "vpu-hdmi"
> > +
> > +Example:
> > +
> > +chosen {
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +     ranges;
> > +
> > +     framebuffer@0 {
> > +             compatible = "amlogic,simple-framebuffer",
> > +                          "simple-framebuffer";
> > +             amlogic,pipeline = "vpu-hdmi";
> > +             clocks = <&clkc CLKID_HDMI_PCLK>,
> > +                      <&clkc CLKID_CLK81>,
> > +                      <&clkc CLKID_GCLK_VENCI_INT0>;
> > +             power-domains = <&pwrc_vpu>;
> > +     };
> > +};
> >
>
> You should add a cover-letter for this patchset !
>
> Neil

Sorry about that, I completely forgot. Thanks for the reminder, will repost.

Maxime
